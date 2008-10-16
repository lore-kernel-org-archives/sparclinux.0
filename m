From: Harvey Harrison <harvey.harrison@gmail.com>
Date: Thu, 16 Oct 2008 00:15:19 +0000
Subject: [PATCH] sparc64: Annotate pointers in PeeCeeI.c
Message-Id: <1224116119.5815.11.camel@brick>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux <sparclinux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

This has no functional changes, but annotates the code to make
the endianness more clear.  In addition, removes some of the only
users of cpu_to_le[16|32]p in the kernel.

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 arch/sparc64/lib/PeeCeeI.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/sparc64/lib/PeeCeeI.c b/arch/sparc64/lib/PeeCeeI.c
index 8b313f1..e609b65 100644
--- a/arch/sparc64/lib/PeeCeeI.c
+++ b/arch/sparc64/lib/PeeCeeI.c
@@ -53,32 +53,32 @@ void outsl(unsigned long __addr, const void *src, unsigned long count)
 
 	if (count) {
 		if ((((u64)src) & 0x3) = 0) {
-			u32 *p = (u32 *)src;
+			__le32 *p = (__le32 *)src;
 			while (count--) {
-				u32 val = cpu_to_le32p(p);
+				u32 val = le32_to_cpup(p);
 				outl(val, addr);
 				p++;
 			}
 		} else {
 			u8 *pb;
-			u16 *ps = (u16 *)src;
+			__le16 *ps = (__le16 *)src;
 			u32 l = 0, l2;
-			u32 *pi;
+			__le32 *pi;
 
 			switch (((u64)src) & 0x3) {
 			case 0x2:
 				count -= 1;
-				l = cpu_to_le16p(ps) << 16;
+				l = le16_to_cpup(ps) << 16;
 				ps++;
-				pi = (u32 *)ps;
+				pi = (__le32 *)ps;
 				while (count--) {
-					l2 = cpu_to_le32p(pi);
+					l2 = le32_to_cpup(pi);
 					pi++;
 					outl(((l >> 16) | (l2 << 16)), addr);
 					l = l2;
 				}
-				ps = (u16 *)pi;
-				l2 = cpu_to_le16p(ps);
+				ps = (__le16 *)pi;
+				l2 = le16_to_cpup(ps);
 				outl(((l >> 16) | (l2 << 16)), addr);
 				break;
 
@@ -86,13 +86,13 @@ void outsl(unsigned long __addr, const void *src, unsigned long count)
 				count -= 1;
 				pb = (u8 *)src;
 				l = (*pb++ << 8);
-				ps = (u16 *)pb;
-				l2 = cpu_to_le16p(ps);
+				ps = (__le16 *)pb;
+				l2 = le16p_to_cpup(ps);
 				ps++;
 				l |= (l2 << 16);
-				pi = (u32 *)ps;
+				pi = (__le32 *)ps;
 				while (count--) {
-					l2 = cpu_to_le32p(pi);
+					l2 = le32_to_cpup(pi);
 					pi++;
 					outl(((l >> 8) | (l2 << 24)), addr);
 					l = l2;
@@ -105,15 +105,15 @@ void outsl(unsigned long __addr, const void *src, unsigned long count)
 				count -= 1;
 				pb = (u8 *)src;
 				l = (*pb++ << 24);
-				pi = (u32 *)pb;
+				pi = (__le32 *)pb;
 				while (count--) {
-					l2 = cpu_to_le32p(pi);
+					l2 = le32_to_cpup(pi);
 					pi++;
 					outl(((l >> 24) | (l2 << 8)), addr);
 					l = l2;
 				}
-				ps = (u16 *)pi;
-				l2 = cpu_to_le16p(ps);
+				ps = (__le16 *)pi;
+				l2 = le16_to_cpup(ps);
 				ps++;
 				pb = (u8 *)ps;
 				l2 |= (*pb << 16);
-- 
1.6.0.2.711.gf1ba4



