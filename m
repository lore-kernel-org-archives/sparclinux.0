From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 03 May 2014 22:52:22 +0000
Subject: [PATCH 17/34] sparc64: fix sparse warning in btext.c
Message-Id: <1399157559-19901-17-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warning:
btext.c:140:6: warning: symbol 'btext_drawchar' was not declared. Should it be static?

Define the function static as it is only used in this file.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/btext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/btext.c b/arch/sparc/kernel/btext.c
index 57073e5..987f7ec 100644
--- a/arch/sparc/kernel/btext.c
+++ b/arch/sparc/kernel/btext.c
@@ -137,7 +137,7 @@ static void scrollscreen(void)
 }
 #endif /* ndef NO_SCROLL */
 
-void btext_drawchar(char c)
+static void btext_drawchar(char c)
 {
 	int cline = 0;
 #ifdef NO_SCROLL
-- 
1.9.0

