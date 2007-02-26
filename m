From: David Miller <davem@davemloft.net>
Date: Mon, 26 Feb 2007 18:33:41 +0000
Subject: Re: 2.6.20 unaligned accesses
Message-Id: <20070226.103341.115641947.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200702231155.25915.andrew@walrond.org>
In-Reply-To: <200702231155.25915.andrew@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Andrew Walrond <andrew@walrond.org>
Date: Mon, 26 Feb 2007 10:12:32 +0000

> I have discovered that these only appear when running a kernel with
> 
> 	CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> 
> Nevertheless, I guess it needs fixing.

Let me know if this fixes the bug for you:

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index bb022ed..8d17d8d 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -530,7 +530,7 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 	u16 aoemajor;
 
 	hin = (struct aoe_hdr *) skb->mac.raw;
-	aoemajor = be16_to_cpu(hin->major);
+	aoemajor = be16_to_cpu(get_unaligned(&hin->major));
 	d = aoedev_by_aoeaddr(aoemajor, hin->minor);
 	if (d = NULL) {
 		snprintf(ebuf, sizeof ebuf, "aoecmd_ata_rsp: ata response "
@@ -542,7 +542,7 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 
 	spin_lock_irqsave(&d->lock, flags);
 
-	n = be32_to_cpu(hin->tag);
+	n = be32_to_cpu(get_unaligned(&hin->tag));
 	f = getframe(d, n);
 	if (f = NULL) {
 		calc_rttavg(d, -tsince(n));
@@ -550,9 +550,9 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 		snprintf(ebuf, sizeof ebuf,
 			"%15s e%d.%d    tag=%08x@%08lx\n",
 			"unexpected rsp",
-			be16_to_cpu(hin->major),
+			be16_to_cpu(get_unaligned(&hin->major)),
 			hin->minor,
-			be32_to_cpu(hin->tag),
+			be32_to_cpu(get_unaligned(&hin->tag)),
 			jiffies);
 		aoechr_error(ebuf);
 		return;
@@ -631,7 +631,7 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 			printk(KERN_INFO
 				"aoe: unrecognized ata command %2.2Xh for %d.%d\n",
 				ahout->cmdstat,
-				be16_to_cpu(hin->major),
+				be16_to_cpu(get_unaligned(&hin->major)),
 				hin->minor);
 		}
 	}
@@ -733,7 +733,7 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
 	 * Enough people have their dip switches set backwards to
 	 * warrant a loud message for this special case.
 	 */
-	aoemajor = be16_to_cpu(h->major);
+	aoemajor = be16_to_cpu(get_unaligned(&h->major));
 	if (aoemajor = 0xfff) {
 		printk(KERN_ERR "aoe: Warning: shelf address is all ones.  "
 			"Check shelf dip switches.\n");
diff --git a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
index 9626e0f..5b85c0a 100644
--- a/drivers/block/aoe/aoenet.c
+++ b/drivers/block/aoe/aoenet.c
@@ -8,6 +8,7 @@
 #include <linux/blkdev.h>
 #include <linux/netdevice.h>
 #include <linux/moduleparam.h>
+#include <asm/unaligned.h>
 #include "aoe.h"
 
 #define NECODES 5
@@ -123,7 +124,7 @@ aoenet_rcv(struct sk_buff *skb, struct net_device *ifp, struct packet_type *pt,
 	skb_push(skb, ETH_HLEN);	/* (1) */
 
 	h = (struct aoe_hdr *) skb->mac.raw;
-	n = be32_to_cpu(h->tag);
+	n = be32_to_cpu(get_unaligned(&h->tag));
 	if ((h->verfl & AOEFL_RSP) = 0 || (n & 1<<31))
 		goto exit;
 
@@ -133,7 +134,7 @@ aoenet_rcv(struct sk_buff *skb, struct net_device *ifp, struct packet_type *pt,
 			n = 0;
 		if (net_ratelimit())
 			printk(KERN_ERR "aoe: error packet from %d.%d; ecode=%d '%s'\n",
-			       be16_to_cpu(h->major), h->minor, 
+			       be16_to_cpu(get_unaligned(&h->major)), h->minor, 
 			       h->err, aoe_errlist[n]);
 		goto exit;
 	}
