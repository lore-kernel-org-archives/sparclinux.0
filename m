From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 23 Dec 2013 19:43:26 +0000
Subject: [PATCH v2 04/11] tilo: replace sed with dirname in tilo.sh
Message-Id: <1387827813-8279-5-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Use dirname to figure out the path of maketilo.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 tilo/tilo.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tilo/tilo.sh b/tilo/tilo.sh
index f152e288d967..175dacf71f22 100755
--- a/tilo/tilo.sh
+++ b/tilo/tilo.sh
@@ -112,7 +112,7 @@ if [ -z "$sun4u" -a -z "$sun4c" ]; then
 	exit 1
 fi
 
-`echo $0 | sed 's/tilo$/maketilo/'` $tilo_args out=$output
+$(dirname $0)/maketilo $tilo_args out=$output
 
 rm -f $to_remove
 
-- 
1.8.5.1

