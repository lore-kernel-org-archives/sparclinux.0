From: Harvey Harrison <harvey.harrison@gmail.com>
Date: Wed, 22 Oct 2008 18:50:24 +0000
Subject: [PATCH] sparc64: remove byteshifting from out* helpers
Message-Id: <1224701424.6823.2.camel@brick>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

__raw_write avoids the need to byteswap twice, as we are reading from a
host-endian (big) area, just deref the pointers directly, taking care
of alignment.

As before, outsw must still be called with a 2-byte aligned pointer.

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 arch/sparc64/lib/PeeCeeI.c |  138 +++++++++++++++----------------------------
 1 files changed, 48 insertions(+), 90 deletions(-)

diff --git a/arch/sparc64/lib/PeeCeeI.c b/arch/sparc64/lib/PeeCeeI.c
index 8b313f1..a4b6246 100644
--- a/arch/sparc64/lib/PeeCeeI.c
+++ b/arch/sparc64/lib/PeeCeeI.c
@@ -20,30 +20,9 @@ void outsw(unsigned long __addr, const void *src, unsigned long count)
 {
 	void __iomem *addr = (void __iomem *) __addr;
 
-	if (count) {
-		u16 *ps = (u16 *)src;
-		u32 *pi;
-
-		if (((u64)src) & 0x2) {
-			u16 val = le16_to_cpup(ps);
-			outw(val, addr);
-			ps++;
-			count--;
-		}
-		pi = (u32 *)ps;
-		while (count >= 2) {
-			u32 w = le32_to_cpup(pi);
-
-			pi++;
-			outw(w >> 0, addr);
-			outw(w >> 16, addr);
-			count -= 2;
-		}
-		ps = (u16 *)pi;
-		if (count) {
-			u16 val = le16_to_cpup(ps);
-			outw(val, addr);
-		}
+	while (count--) {
+		__raw_writew(*(u16 *)src, addr);
+		src += sizeof(u16);
 	}
 }
 
@@ -51,76 +30,55 @@ void outsl(unsigned long __addr, const void *src, unsigned long count)
 {
 	void __iomem *addr = (void __iomem *) __addr;
 
-	if (count) {
-		if ((((u64)src) & 0x3) = 0) {
-			u32 *p = (u32 *)src;
-			while (count--) {
-				u32 val = cpu_to_le32p(p);
-				outl(val, addr);
-				p++;
-			}
-		} else {
-			u8 *pb;
-			u16 *ps = (u16 *)src;
-			u32 l = 0, l2;
-			u32 *pi;
-
-			switch (((u64)src) & 0x3) {
-			case 0x2:
-				count -= 1;
-				l = cpu_to_le16p(ps) << 16;
-				ps++;
-				pi = (u32 *)ps;
-				while (count--) {
-					l2 = cpu_to_le32p(pi);
-					pi++;
-					outl(((l >> 16) | (l2 << 16)), addr);
-					l = l2;
-				}
-				ps = (u16 *)pi;
-				l2 = cpu_to_le16p(ps);
-				outl(((l >> 16) | (l2 << 16)), addr);
-				break;
-
-			case 0x1:
-				count -= 1;
-				pb = (u8 *)src;
-				l = (*pb++ << 8);
-				ps = (u16 *)pb;
-				l2 = cpu_to_le16p(ps);
-				ps++;
-				l |= (l2 << 16);
-				pi = (u32 *)ps;
-				while (count--) {
-					l2 = cpu_to_le32p(pi);
-					pi++;
-					outl(((l >> 8) | (l2 << 24)), addr);
-					l = l2;
-				}
-				pb = (u8 *)pi;
-				outl(((l >> 8) | (*pb << 24)), addr);
-				break;
+	if (!count)
+		return;
 
-			case 0x3:
-				count -= 1;
-				pb = (u8 *)src;
-				l = (*pb++ << 24);
-				pi = (u32 *)pb;
-				while (count--) {
-					l2 = cpu_to_le32p(pi);
-					pi++;
-					outl(((l >> 24) | (l2 << 8)), addr);
-					l = l2;
-				}
-				ps = (u16 *)pi;
-				l2 = cpu_to_le16p(ps);
-				ps++;
-				pb = (u8 *)ps;
-				l2 |= (*pb << 16);
-				outl(((l >> 24) | (l2 << 8)), addr);
-				break;
-			}
+	switch (((unsigned long)src) & 0x3) {
+	case 0x0:
+		/* src is naturally aligned */
+		while (count--) {
+			__raw_writel(*(u32 *)src, addr);
+			src += sizeof(u32);
+		}
+		break;
+	case 0x2:
+		/* 2-byte alignment */
+		while (count--) {
+			u32 l = (*(u16 *)src) << 16;
+			l |= *(u16 *)(src + sizeof(u16));
+			__raw_writel(l, addr);
+			src += sizeof(u32);
+		}
+		break;
+	case 0x1:
+		/* Hold three bytes in l each time, grab a byte from l2 */
+		u32 l, l2;
+
+		l = (*(u8 *)src) << 24;
+		l |= (*(u16 *)(src + sizeof(u8))) << 8;
+		src += sizeof(u8) + sizeof(u16);
+		while (count--) {
+			l2 = *(u32 *)src;
+			l |= (l2 >> 24);
+			__raw_writel(l, addr);
+			l = l2 << 8;
+			src += sizeof(u32);
+		}
+		break;
+	case 0x3:
+		/* Hold a byte in l each time, grab 3 bytes from l2 */
+		u32 l, l2;
+
+		l = (*(u8 *)src) << 24;
+		src += sizeof(u8);
+		while (count--) {
+			l2 = *(u32 *)src;
+			l |= (l2 >> 8);
+			__raw_writel(l, addr);
+			l = l2 << 24;
+			src += sizeof(u32);
 		}
+		break;
 	}
 }
 
-- 
1.6.0.2.824.geb4d2



