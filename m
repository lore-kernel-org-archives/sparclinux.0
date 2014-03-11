From: Kees Cook <keescook@chromium.org>
Date: Tue, 11 Mar 2014 20:24:46 +0000
Subject: [PATCH] sparc: use %s for unaligned panic
Message-Id: <20140311202446.GA24531@www.outflux.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Since unaligned_panic() takes a literal string, make sure it can never
accidentally be used as a format string.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/sparc/kernel/unaligned_32.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/unaligned_32.c b/arch/sparc/kernel/unaligned_32.c
index c0ec89786193..892e399414e0 100644
--- a/arch/sparc/kernel/unaligned_32.c
+++ b/arch/sparc/kernel/unaligned_32.c
@@ -162,7 +162,7 @@ unsigned long safe_compute_effective_address(struct pt_regs *regs,
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
