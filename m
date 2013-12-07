From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sat, 07 Dec 2013 23:26:53 +0000
Subject: [PATCH 04/10] tilo: fix typo in tilo.sh
Message-Id: <1386458819-6590-5-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The name of the script has .sh, so the sed script conversion fails.
Fix that.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 tilo/tilo.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tilo/tilo.sh b/tilo/tilo.sh
index f152e288d967..782a0305646b 100755
--- a/tilo/tilo.sh
+++ b/tilo/tilo.sh
@@ -112,7 +112,7 @@ if [ -z "$sun4u" -a -z "$sun4c" ]; then
 	exit 1
 fi
 
-`echo $0 | sed 's/tilo$/maketilo/'` $tilo_args out=$output
+`echo $0 | sed 's/tilo\.sh$/maketilo/'` $tilo_args out=$output
 
 rm -f $to_remove
 
-- 
1.8.4.4

