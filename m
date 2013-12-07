From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sat, 07 Dec 2013 23:26:52 +0000
Subject: [PATCH 03/10] tilo: support latest binutils
Message-Id: <1386458819-6590-4-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Latest versions of binutils mark _end with "B" instead of "A".
Support both of them.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 tilo/tilo.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tilo/tilo.sh b/tilo/tilo.sh
index ff60063200b2..f152e288d967 100755
--- a/tilo/tilo.sh
+++ b/tilo/tilo.sh
@@ -50,7 +50,7 @@ do_image () {
 	to_remove="$to_remove $KERNEL.gz"
 	PSIZE=`ls -l $KERNEL.gz | awk '{print$5}'`
 	SIZE=`ls -l $KERNEL.raw | awk '{print$5}'`
-	ROOTA=`nm $KERNEL | awk '/A _end$/{print$1}'`
+	ROOTA=`nm $KERNEL | awk '/[AB] _end$/{print$1}'`
 	rm $KERNEL.raw
 	echo "Sizes ($tag):"
 	echo "  raw size     = $SIZE"
-- 
1.8.4.4

