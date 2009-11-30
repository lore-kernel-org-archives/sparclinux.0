From: Mikulas Patocka <mpatocka@redhat.com>
Date: Mon, 30 Nov 2009 15:07:56 +0000
Subject: [PATCH] fix dma warning in Sun HME
Message-Id: <Pine.LNX.4.64.0911301003080.2339@hs20-bc2-1.build.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi

This patches fixed warnings with CONFIG_HAVE_DMA_API_DEBUG

Mikulas

---

Fix dma-api-checking warnings in Sun HME

Sun HME driver is mapping the first fragment with dma_map_single and subsequent
fragments with dma_map_page. It is unmapping all fragments with dma_unmap_single
and that produces the warning.

This patch changes it so that it unmaps only the first fragment with
dma_unmap_single and subsequent fragments are unmapped with dma_unmap_page.

WARNING: at lib/dma-debug.c:816 check_unmap+0x3ac/0x780()
hme 0000:01:01.1: DMA-API: device driver frees DMA memory with wrong function [device address=0x00000000c1082000] [size2 bytes] [mapped as page] [unmapped as single]
Modules linked in: nbd sunhme openpromfs sermouse unix
Call Trace:
 [0000000000456910] warn_slowpath_common+0x50/0xa0
 [0000000000571f4c] check_unmap+0x3ac/0x780
 [0000000000572570] debug_dma_unmap_page+0x50/0x60
 [000000001002f5fc] happy_meal_tx+0x11c/0x260 [sunhme]
 [000000001002fc4c] happy_meal_interrupt+0xcc/0xe0 [sunhme]
 [0000000000492d94] handle_fasteoi_irq+0x74/0x100
 [000000000042ac0c] handler_irq+0xcc/0x100
 [0000000000426a54] valid_addr_bitmap_patch+0x14/0x1c0
 [0000000000665de0] _spin_unlock_irqrestore+0x40/0x60
 [0000000000462bb8] mod_timer+0x118/0x1a0
 [00000000005ec254] sk_reset_timer+0x14/0x40
 [0000000000635e4c] tcp_event_new_data_sent+0x8c/0xc0
 [0000000000639374] __tcp_push_pending_frames+0x34/0xc0
---[ end trace 73d5c42c1e9f11c4 ]---
Mapped at:
 [<000000001002f148>] happy_meal_start_xmit+0x308/0x480 [sunhme]
 [<00000000005fc858>] dev_hard_start_xmit+0x318/0x3c0
 [<000000000060fec4>] sch_direct_xmit+0x1a4/0x200
 [<00000000005fced0>] dev_queue_xmit+0x410/0x560
 [<0000000000604a1c>] neigh_resolve_output+0xfc/0x300

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/net/sunhme.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

Index: linux-2.6.32-rc8-devel/drivers/net/sunhme.c
=================================--- linux-2.6.32-rc8-devel.orig/drivers/net/sunhme.c	2009-11-30 14:04:58.000000000 +0100
+++ linux-2.6.32-rc8-devel/drivers/net/sunhme.c	2009-11-30 14:08:51.000000000 +0100
@@ -1226,10 +1226,16 @@ static void happy_meal_clean_rings(struc
 			for (frag = 0; frag <= skb_shinfo(skb)->nr_frags; frag++) {
 				txd = &hp->happy_block->happy_meal_txd[i];
 				dma_addr = hme_read_desc32(hp, &txd->tx_addr);
-				dma_unmap_single(hp->dma_dev, dma_addr,
-						 (hme_read_desc32(hp, &txd->tx_flags)
-						  & TXFLAG_SIZE),
-						 DMA_TO_DEVICE);
+				if (!frag)
+					dma_unmap_single(hp->dma_dev, dma_addr,
+							 (hme_read_desc32(hp, &txd->tx_flags)
+							  & TXFLAG_SIZE),
+							 DMA_TO_DEVICE);
+				else
+					dma_unmap_page(hp->dma_dev, dma_addr,
+							 (hme_read_desc32(hp, &txd->tx_flags)
+							  & TXFLAG_SIZE),
+							 DMA_TO_DEVICE);
 
 				if (frag != skb_shinfo(skb)->nr_frags)
 					i++;
@@ -1953,7 +1959,10 @@ static void happy_meal_tx(struct happy_m
 			dma_len = hme_read_desc32(hp, &this->tx_flags);
 
 			dma_len &= TXFLAG_SIZE;
-			dma_unmap_single(hp->dma_dev, dma_addr, dma_len, DMA_TO_DEVICE);
+			if (!frag)
+				dma_unmap_single(hp->dma_dev, dma_addr, dma_len, DMA_TO_DEVICE);
+			else
+				dma_unmap_page(hp->dma_dev, dma_addr, dma_len, DMA_TO_DEVICE);
 
 			elem = NEXT_TX(elem);
 			this = &txbase[elem];
