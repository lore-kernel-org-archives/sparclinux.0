From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 14 Jun 2005 01:31:57 +0000
Subject: Re: ipt_recent && spamd (!?) && kernel panic
Message-Id: <20050613.183157.18303803.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <87oeahuwt3.fsf@pumba.bayour.com>
In-Reply-To: <87oeahuwt3.fsf@pumba.bayour.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


You're not the only person seeing this.

Here is a temp fix:

From: Juergen Kreileder <jk@blackdown.de>

I've had some ipt_recent rules acting strangely after an uptime of about 25
days.  The broken behavior is reproducible in the 5 minutes before the
first jiffies roll-over right after booting too.

The cause of the problem is the jiffies comparision which doesn't work like
intended if one of the last hits was more than LONG_MAX seconds ago or if
the table of last hits contains empty slots and jiffies is > LONG_MAX.

This patch fixes the problem by using get_seconds() instead of jiffies.  It
also fixes some 64-bit issues.

Signed-off-by: Juergen Kreileder <jk@blackdown.de>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/netfilter_ipv4/ipt_recent.h |    2 +-
 net/ipv4/netfilter/ipt_recent.c           |   21 +++++++++++----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff -puN include/linux/netfilter_ipv4/ipt_recent.h~ipt_recent-fixes include/linux/netfilter_ipv4/ipt_recent.h
--- 25/include/linux/netfilter_ipv4/ipt_recent.h~ipt_recent-fixes	2005-05-09 18:08:27.000000000 -0700
+++ 25-akpm/include/linux/netfilter_ipv4/ipt_recent.h	2005-05-09 18:08:27.000000000 -0700
@@ -2,7 +2,7 @@
 #define _IPT_RECENT_H
 
 #define RECENT_NAME	"ipt_recent"
-#define RECENT_VER	"v0.3.1"
+#define RECENT_VER	"v0.3.2"
 
 #define IPT_RECENT_CHECK  1
 #define IPT_RECENT_SET    2
diff -puN net/ipv4/netfilter/ipt_recent.c~ipt_recent-fixes net/ipv4/netfilter/ipt_recent.c
--- 25/net/ipv4/netfilter/ipt_recent.c~ipt_recent-fixes	2005-05-09 18:08:27.000000000 -0700
+++ 25-akpm/net/ipv4/netfilter/ipt_recent.c	2005-05-09 18:08:27.000000000 -0700
@@ -15,6 +15,7 @@
 #include <linux/ctype.h>
 #include <linux/ip.h>
 #include <linux/vmalloc.h>
+#include <linux/time.h>
 #include <linux/moduleparam.h>
 
 #include <linux/netfilter_ipv4/ip_tables.h>
@@ -64,7 +65,7 @@ struct recent_ip_list {
 
 struct time_info_list {
 	u_int32_t position;
-	u_int32_t time;
+	unsigned long time;
 };
 
 /* Structure of our linked list of tables of recent lists. */
@@ -223,7 +224,7 @@ static int ip_recent_ctrl(struct file *f
 			curr_table->table[count].last_seen = 0;
 			curr_table->table[count].addr = 0;
 			curr_table->table[count].ttl = 0;
-			memset(curr_table->table[count].last_pkts,0,ip_pkt_list_tot*sizeof(u_int32_t));
+			memset(curr_table->table[count].last_pkts,0,ip_pkt_list_tot*sizeof(unsigned long));
 			curr_table->table[count].oldest_pkt = 0;
 			curr_table->table[count].time_pos = 0;
 			curr_table->time_info[count].position = count;
@@ -418,8 +419,8 @@ match(const struct sk_buff *skb,
 	if(debug) printk(KERN_INFO RECENT_NAME ": match(): checking table, addr: %u, ttl: %u, orig_ttl: %u\n",addr,ttl,skb->nh.iph->ttl);
 #endif
 
-	/* Get jiffies now in case they changed while we were waiting for a lock */
-	now = jiffies;
+	/* Get time now in case it changed while we were waiting for a lock */
+	now = get_seconds();
 	hash_table = curr_table->hash_table;
 	time_info = curr_table->time_info;
 
@@ -502,7 +503,7 @@ match(const struct sk_buff *skb,
 		location = time_info[curr_table->time_pos].position;
 		hash_table[r_list[location].hash_entry] = -1;
 		hash_table[hash_result] = location;
-		memset(r_list[location].last_pkts,0,ip_pkt_list_tot*sizeof(u_int32_t));
+		memset(r_list[location].last_pkts,0,ip_pkt_list_tot*sizeof(unsigned long));
 		r_list[location].time_pos = curr_table->time_pos;
 		r_list[location].addr = addr;
 		r_list[location].ttl = ttl;
@@ -528,11 +529,11 @@ match(const struct sk_buff *skb,
 		if(info->check_set & IPT_RECENT_CHECK || info->check_set & IPT_RECENT_UPDATE) {
 			if(!info->seconds && !info->hit_count) ans = !info->invert; else ans = info->invert;
 			if(info->seconds && !info->hit_count) {
-				if(time_before_eq(now,r_list[location].last_seen+info->seconds*HZ)) ans = !info->invert; else ans = info->invert;
+				if(now <= r_list[location].last_seen+info->seconds) ans = !info->invert; else ans = info->invert;
 			}
 			if(info->seconds && info->hit_count) {
 				for(pkt_count = 0, hits_found = 0; pkt_count < ip_pkt_list_tot; pkt_count++) {
-					if(time_before_eq(now,r_list[location].last_pkts[pkt_count]+info->seconds*HZ)) hits_found++;
+					if(now <= r_list[location].last_pkts[pkt_count]+info->seconds) hits_found++;
 				}
 				if(hits_found >= info->hit_count) ans = !info->invert; else ans = info->invert;
 			}
@@ -631,7 +632,7 @@ match(const struct sk_buff *skb,
 			r_list[location].last_seen = 0;
 			r_list[location].addr = 0;
 			r_list[location].ttl = 0;
-			memset(r_list[location].last_pkts,0,ip_pkt_list_tot*sizeof(u_int32_t));
+			memset(r_list[location].last_pkts,0,ip_pkt_list_tot*sizeof(unsigned long));
 			r_list[location].oldest_pkt = 0;
 			ans = !info->invert;
 		}
@@ -734,10 +735,10 @@ checkentry(const char *tablename,
 	memset(curr_table->table,0,sizeof(struct recent_ip_list)*ip_list_tot);
 #ifdef DEBUG
 	if(debug) printk(KERN_INFO RECENT_NAME ": checkentry: Allocating %d for pkt_list.\n",
-			sizeof(u_int32_t)*ip_pkt_list_tot*ip_list_tot);
+			sizeof(unsigned long)*ip_pkt_list_tot*ip_list_tot);
 #endif
 
-	hold = vmalloc(sizeof(u_int32_t)*ip_pkt_list_tot*ip_list_tot);
+	hold = vmalloc(sizeof(unsigned long)*ip_pkt_list_tot*ip_list_tot);
 #ifdef DEBUG
 	if(debug) printk(KERN_INFO RECENT_NAME ": checkentry: After pkt_list allocation.\n");
 #endif
_
