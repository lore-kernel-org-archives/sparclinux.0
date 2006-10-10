From: David Miller <davem@davemloft.net>
Date: Tue, 10 Oct 2006 01:36:07 +0000
Subject: Re: [sparc64] 2.6.18 unaligned accesses in eth1394
Message-Id: <20061009.183607.63736982.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061005211543.GA18539@ele.uri.edu>
In-Reply-To: <20061005211543.GA18539@ele.uri.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: simoneau@ele.uri.edu
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Will Simoneau <simoneau@ele.uri.edu>
Date: Thu, 5 Oct 2006 17:15:44 -0400

> The first one I seem to be able to fix by adding a get_unaligned() at
> lines 1679-1680 of eth1394.c around eth->h_dest; the second one seems to
> be triggered by this code:

Right.

> (gdb) list *ether1394_data_handler+0x914
> 0xc94 is in ether1394_data_handler (drivers/ieee1394/eth1394.c:1264).
> 1259        priv->stats.rx_dropped++;
> 1260        dev_kfree_skb_any(skb);
> 1261        goto bad_proto;
> 1262     }
> 1263  
> 1264     if (netif_rx(skb) = NET_RX_DROP) {
> 1265        priv->stats.rx_errors++;
> 1266        priv->stats.rx_dropped++;
> 1267        goto bad_proto;
> 1268     }

Actually, I think this one is in eth1394_parse_encap().

Can you test this patch and tell me if it makes both unaligned
access problems go away?  Thanks.

diff --git a/drivers/ieee1394/eth1394.c b/drivers/ieee1394/eth1394.c
index 8a7b8fa..78abb9b 100644
--- a/drivers/ieee1394/eth1394.c
+++ b/drivers/ieee1394/eth1394.c
@@ -64,6 +64,7 @@ #include <linux/bitops.h>
 #include <linux/ethtool.h>
 #include <asm/uaccess.h>
 #include <asm/delay.h>
+#include <asm/unaligned.h>
 #include <net/arp.h>
 
 #include "config_roms.h"
@@ -894,6 +895,7 @@ static inline u16 ether1394_parse_encap(
 		u16 maxpayload;
 		struct eth1394_node_ref *node;
 		struct eth1394_node_info *node_info;
+		__be64 guid;
 
 		/* Sanity check. MacOSX seems to be sending us 131 in this
 		 * field (atleast on my Panther G5). Not sure why. */
@@ -902,8 +904,9 @@ static inline u16 ether1394_parse_encap(
 
 		maxpayload = min(eth1394_speedto_maxpayload[sspd], (u16)(1 << (max_rec + 1)));
 
+		guid = get_unaligned(&arp1394->s_uniq_id);
 		node = eth1394_find_node_guid(&priv->ip_node_list,
-					      be64_to_cpu(arp1394->s_uniq_id));
+					      be64_to_cpu(guid));
 		if (!node) {
 			return 0;
 		}
@@ -1675,8 +1678,9 @@ #endif
 		if (max_payload < dg_size + hdr_type_len[ETH1394_HDR_LF_UF])
 			priv->bc_dgl++;
 	} else {
+		__be64 guid = get_unaligned((u64 *)eth->h_dest);
 		node = eth1394_find_node_guid(&priv->ip_node_list,
-					      be64_to_cpu(*(u64*)eth->h_dest));
+					      be64_to_cpu(guid));
 		if (!node) {
 			ret = -EAGAIN;
 			goto fail;
