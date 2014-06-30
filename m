From: Kees Cook <keescook@chromium.org>
Date: Mon, 30 Jun 2014 20:37:59 +0000
Subject: [RESEND][PATCH] sparc: use %s for unaligned panic
Message-Id: <20140630203759.GA4764@www.outflux.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org

Since unaligned_panic() takes a literal string, make sure it can never
accidentally be used as a format string.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/sparc/kernel/unaligned_32.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/unaligned_32.c b/arch/sparc/kernel/unaligned_32.c
index c5c61b3c6b56..32b61d1b6379 100644
--- a/arch/sparc/kernel/unaligned_32.c
+++ b/arch/sparc/kernel/unaligned_32.c
@@ -166,7 +166,7 @@ unsigned long safe_compute_effective_address(struct pt_regs *regs,
 /* This is just to make gcc think panic does return... */
 static void unaligned_panic(char *str)
 {
-	panic(str);
+	panic("%s", str);
 }
 
 /* una_asm.S */
-- 
1.7.9.5


-- 
Kees Cook
Chrome OS Security
