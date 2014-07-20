From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 Jul 2014 11:38:59 +0000
Subject: [PATCH 2/6] sparc64: update IO access functions in PeeCeeI
Message-Id: <1405856343-3762-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The PeeCeeI.c code used in*() + out*() for IO access.
But these are in little endian and the native (big) endian
result was required which resulted in some bit-shifting.
Shift the code over to use the __raw_*() variants all over.

This simplifies the code as we can drop the calls
to le16_to_cpu() and le32_to_cpu().
And it should be a little faster too.

With this change we now uses the same type of IO access functions
in all of the file.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/lib/PeeCeeI.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/lib/PeeCeeI.c b/arch/sparc/lib/PeeCeeI.c
index 6529f86..e6d1836 100644
--- a/arch/sparc/lib/PeeCeeI.c
+++ b/arch/sparc/lib/PeeCeeI.c
@@ -15,7 +15,7 @@ void outsb(unsigned long __addr, const void *src, unsigned long count)
 	const u8 *p = src;
 
 	while (count--)
-		outb(*p++, addr);
+		__raw_writeb(*p++, addr);
 }
 EXPORT_SYMBOL(outsb);
 
@@ -93,21 +93,21 @@ void insb(unsigned long __addr, void *dst, unsigned long count)
 		u8 *pb = dst;
 
 		while ((((unsigned long)pb) & 0x3) && count--)
-			*pb++ = inb(addr);
+			*pb++ = __raw_readb(addr);
 		pi = (u32 *)pb;
 		while (count >= 4) {
 			u32 w;
 
-			w  = (inb(addr) << 24);
-			w |= (inb(addr) << 16);
-			w |= (inb(addr) << 8);
-			w |= (inb(addr) << 0);
+			w  = (__raw_readb(addr) << 24);
+			w |= (__raw_readb(addr) << 16);
+			w |= (__raw_readb(addr) << 8);
+			w |= (__raw_readb(addr) << 0);
 			*pi++ = w;
 			count -= 4;
 		}
 		pb = (u8 *)pi;
 		while (count--)
-			*pb++ = inb(addr);
+			*pb++ = __raw_readb(addr);
 	}
 }
 EXPORT_SYMBOL(insb);
@@ -121,21 +121,21 @@ void insw(unsigned long __addr, void *dst, unsigned long count)
 		u32 *pi;
 
 		if (((unsigned long)ps) & 0x2) {
-			*ps++ = le16_to_cpu(inw(addr));
+			*ps++ = __raw_readw(addr);
 			count--;
 		}
 		pi = (u32 *)ps;
 		while (count >= 2) {
 			u32 w;
 
-			w  = (le16_to_cpu(inw(addr)) << 16);
-			w |= (le16_to_cpu(inw(addr)) << 0);
+			w  = __raw_readw(addr) << 16;
+			w |= __raw_readw(addr) << 0;
 			*pi++ = w;
 			count -= 2;
 		}
 		ps = (u16 *)pi;
 		if (count)
-			*ps = le16_to_cpu(inw(addr));
+			*ps = __raw_readw(addr);
 	}
 }
 EXPORT_SYMBOL(insw);
@@ -148,7 +148,7 @@ void insl(unsigned long __addr, void *dst, unsigned long count)
 		if ((((unsigned long)dst) & 0x3) = 0) {
 			u32 *pi = dst;
 			while (count--)
-				*pi++ = le32_to_cpu(inl(addr));
+				*pi++ = __raw_readl(addr);
 		} else {
 			u32 l = 0, l2, *pi;
 			u16 *ps;
@@ -158,11 +158,11 @@ void insl(unsigned long __addr, void *dst, unsigned long count)
 			case 0x2:
 				ps = dst;
 				count -= 1;
-				l = le32_to_cpu(inl(addr));
+				l = __raw_readl(addr);
 				*ps++ = l;
 				pi = (u32 *)ps;
 				while (count--) {
-					l2 = le32_to_cpu(inl(addr));
+					l2 = __raw_readl(addr);
 					*pi++ = (l << 16) | (l2 >> 16);
 					l = l2;
 				}
@@ -173,13 +173,13 @@ void insl(unsigned long __addr, void *dst, unsigned long count)
 			case 0x1:
 				pb = dst;
 				count -= 1;
-				l = le32_to_cpu(inl(addr));
+				l = __raw_readl(addr);
 				*pb++ = l >> 24;
 				ps = (u16 *)pb;
 				*ps++ = ((l >> 8) & 0xffff);
 				pi = (u32 *)ps;
 				while (count--) {
-					l2 = le32_to_cpu(inl(addr));
+					l2 = __raw_readl(addr);
 					*pi++ = (l << 24) | (l2 >> 8);
 					l = l2;
 				}
@@ -190,11 +190,11 @@ void insl(unsigned long __addr, void *dst, unsigned long count)
 			case 0x3:
 				pb = (u8 *)dst;
 				count -= 1;
-				l = le32_to_cpu(inl(addr));
+				l = __raw_readl(addr);
 				*pb++ = l >> 24;
 				pi = (u32 *)pb;
 				while (count--) {
-					l2 = le32_to_cpu(inl(addr));
+					l2 = __raw_readl(addr);
 					*pi++ = (l << 8) | (l2 >> 24);
 					l = l2;
 				}
-- 
1.9.3

