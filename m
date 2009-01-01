From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 01 Jan 2009 22:40:29 +0000
Subject: [PATCH 3/4] sparc: fix warning in userspace header traps.h
Message-Id: <1230849630-22482-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warning:
traps.h:23: extern's make no sense in userspace

Add an ifdef __KERNEL__ block that cover the
extern definition and a few related things that neither
is for userspace.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/traps.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/traps.h b/arch/sparc/include/asm/traps.h
index bebdbf8..4becd66 100644
--- a/arch/sparc/include/asm/traps.h
+++ b/arch/sparc/include/asm/traps.h
@@ -10,7 +10,7 @@
 #define NUM_SPARC_TRAPS  255
 
 #ifndef __ASSEMBLY__
-
+#ifdef __KERNEL__
 /* This is for V8 compliant Sparc CPUS */
 struct tt_entry {
 	unsigned long inst_one;
@@ -29,7 +29,7 @@ static inline unsigned long get_tbr(void)
 	__asm__ __volatile__("rd %%tbr, %0\n\t" : "=r" (tbr));
 	return tbr;
 }
-
+#endif /* (__KERNEL__) */
 #endif /* !(__ASSEMBLY__) */
 
 /* For patching the trap table at boot time, we need to know how to
-- 
1.6.0.2.GIT

