From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 08 Feb 2011 14:59:49 +0000
Subject: [PATCH] sparc: use bitmap_set()
Message-Id: <1297177190-1423-1-git-send-email-akinobu.mita@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Use bitmap_set() instead of calling __set_bit() each bit.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/lib/bitext.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/lib/bitext.c b/arch/sparc/lib/bitext.c
index 764b3eb..48d00e7 100644
--- a/arch/sparc/lib/bitext.c
+++ b/arch/sparc/lib/bitext.c
@@ -10,7 +10,7 @@
  */
 
 #include <linux/string.h>
-#include <linux/bitops.h>
+#include <linux/bitmap.h>
 
 #include <asm/bitext.h>
 
@@ -80,8 +80,7 @@ int bit_map_string_get(struct bit_map *t, int len, int align)
 		while (test_bit(offset + i, t->map) = 0) {
 			i++;
 			if (i = len) {
-				for (i = 0; i < len; i++)
-					__set_bit(offset + i, t->map);
+				bitmap_set(t->map, offset, len);
 				if (offset = t->first_free)
 					t->first_free = find_next_zero_bit
 							(t->map, t->size,
-- 
1.7.4

