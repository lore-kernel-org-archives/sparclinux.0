From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 23:49:03 +0000
Subject: [PATCH 1/22] svga: Use proper VGA register name macros in
Message-Id: <20110111.154903.129760880.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Instead of magic register location constants.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 include/linux/svga.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/svga.h b/include/linux/svga.h
index c59a51a..3fc52cb 100644
--- a/include/linux/svga.h
+++ b/include/linux/svga.h
@@ -69,9 +69,9 @@ struct svga_pll {
 
 static inline void svga_wattr(u8 index, u8 data)
 {
-	inb(0x3DA);
-	outb(index, 0x3C0);
-	outb(data, 0x3C0);
+	inb(VGA_IS1_RC);
+	outb(index, VGA_ATT_IW);
+	outb(data, VGA_ATT_W);
 }
 
 /* Write a value to a sequence register with a mask */
-- 
1.7.3.4

