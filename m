From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 23 Dec 2013 19:43:25 +0000
Subject: [PATCH v2 03/11] tilo: support latest binutils
Message-Id: <1387827813-8279-4-git-send-email-aaro.koskinen@iki.fi>
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
1.8.5.1

