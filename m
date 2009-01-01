From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 01 Jan 2009 22:40:30 +0000
Subject: [PATCH 4/4] sparc: drop get_tbr() in traps.h
Message-Id: <1230849630-22482-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

get_tbr() has no users in the whole tree -drop it.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/traps.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/include/asm/traps.h b/arch/sparc/include/asm/traps.h
index 4becd66..3aa62dd 100644
--- a/arch/sparc/include/asm/traps.h
+++ b/arch/sparc/include/asm/traps.h
@@ -22,13 +22,6 @@ struct tt_entry {
 /* We set this to _start in system setup. */
 extern struct tt_entry *sparc_ttable;
 
-static inline unsigned long get_tbr(void)
-{
-	unsigned long tbr;
-
-	__asm__ __volatile__("rd %%tbr, %0\n\t" : "=r" (tbr));
-	return tbr;
-}
 #endif /* (__KERNEL__) */
 #endif /* !(__ASSEMBLY__) */
 
-- 
1.6.0.2.GIT

