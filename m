From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sun, 24 Mar 2013 08:55:04 +0000
Subject: [PATCH 1/3] sparc: clear bitmap correctly in bit_map_init()
Message-Id: <1364115306-17716-1-git-send-email-akinobu.mita@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

In bit_map_init(), it attempts to clear all bits in the bitmap by memset(),
but if the size of bitmap is not a multiple of the sizeof(long), it can't
clear the trailing edge of bitmap properly on big-endian architecture.
So it should use bitmap_clear() instead of memset().

There are only two users of bit_map_init(), and both of them don't cause
the issue described above.  But it would be better to fix it now for
future changes.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/lib/bitext.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/sparc/lib/bitext.c b/arch/sparc/lib/bitext.c
index d516fda..04d8bad 100644
--- a/arch/sparc/lib/bitext.c
+++ b/arch/sparc/lib/bitext.c
@@ -111,11 +111,7 @@ void bit_map_clear(struct bit_map *t, int offset, int len)
 
 void bit_map_init(struct bit_map *t, unsigned long *map, int size)
 {
-
-	if ((size & 07) != 0)
-		BUG();
-	memset(map, 0, size>>3);
-
+	bitmap_zero(map, size);
 	memset(t, 0, sizeof *t);
 	spin_lock_init(&t->lock);
 	t->map = map;
-- 
1.8.1.4

