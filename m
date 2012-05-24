From: David Miller <davem@davemloft.net>
Date: Thu, 24 May 2012 02:29:31 +0000
Subject: [PATCH] sparc: Optimize strncpy_from_user() zero byte search.
Message-Id: <20120523.222931.1149714100124942458.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Compute a mask that will only have 0x80 in the bytes which
had a zero in them.  The formula is:

	~(((x & 0x7f7f7f7f) + 0x7f7f7f7f) | x | 0x7f7f7f7f)

In the inner word iteration, we have to compute the "x | 0x7f7f7f7f"
part, so we can reuse that in the above calculation.

Once we have this mask, we perform divide and conquer to find the
highest 0x80 location.

Signed-off-by: David S. Miller <davem@davemloft.net>
---

On linux-arch we're talking about making this code I wrote
for sparc suitable for other platforms to use since it's
reasonably portable already.

As part of that Linus wanted me to make an effort to improve
the code GCC generates for the final zero byte discovery code
and this is what I came up with.

 arch/sparc/lib/usercopy.c |   50 +++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/arch/sparc/lib/usercopy.c b/arch/sparc/lib/usercopy.c
index 851cb75..87f9645 100644
--- a/arch/sparc/lib/usercopy.c
+++ b/arch/sparc/lib/usercopy.c
@@ -11,35 +11,20 @@ EXPORT_SYMBOL(copy_from_user_overflow);
 
 #define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
 
-/* Return the high bit set in the first byte that is a zero */
-static inline unsigned long has_zero(unsigned long a)
-{
-	return ((a - REPEAT_BYTE(0x01)) & ~a) & REPEAT_BYTE(0x80);
-}
-
-static inline long find_zero(unsigned long c)
+static inline long find_zero(unsigned long mask)
 {
+	long byte = 0;
 #ifdef CONFIG_64BIT
-	if (!(c & 0xff00000000000000UL))
-		return 0;
-	if (!(c & 0x00ff000000000000UL))
-		return 1;
-	if (!(c & 0x0000ff0000000000UL))
-		return 2;
-	if (!(c & 0x000000ff00000000UL))
-		return 3;
-#define __OFF 4
-#else
-#define __OFF 0
+	if (mask >> 32)
+		mask >>= 32;
+	else
+		byte = 4;
 #endif
-	if (!(c & 0xff000000))
-		return __OFF + 0;
-	if (!(c & 0x00ff0000))
-		return __OFF + 1;
-	if (!(c & 0x0000ff00))
-		return __OFF + 2;
-	return __OFF + 3;
-#undef __OFF
+	if (mask >> 16)
+		mask >>= 16;
+	else
+		byte += 2;
+	return (mask >> 8) ? byte : byte + 1;
 }
 
 /*
@@ -50,6 +35,8 @@ static inline long find_zero(unsigned long c)
  */
 static inline long do_strncpy_from_user(char *dst, const char __user *src, long count, unsigned long max)
 {
+	const unsigned long high_bits = REPEAT_BYTE(0xfe) + 1;
+	const unsigned long low_bits = REPEAT_BYTE(0x7f);
 	long res = 0;
 
 	/*
@@ -63,14 +50,19 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src, long
 		goto byte_at_a_time;
 
 	while (max >= sizeof(unsigned long)) {
-		unsigned long c;
+		unsigned long c, v, rhs;
 
 		/* Fall back to byte-at-a-time if we get a page fault */
 		if (unlikely(__get_user(c,(unsigned long __user *)(src+res))))
 			break;
+		rhs = c | low_bits;
+		v = (c + high_bits) & ~rhs;
 		*(unsigned long *)(dst+res) = c;
-		if (has_zero(c))
-			return res + find_zero(c);
+		if (v) {
+			v = (c & low_bits) + low_bits;;
+			v = ~(v | rhs);
+			return res + find_zero(v);
+		}
 		res += sizeof(unsigned long);
 		max -= sizeof(unsigned long);
 	}
-- 
1.7.10

