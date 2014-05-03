From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 03 May 2014 22:52:38 +0000
Subject: [PATCH 33/34] sparc64: fix sparse warning in ftrace.c
Message-Id: <1399157559-19901-33-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warning:
ftrace.c:123:15: warning: symbol 'prepare_ftrace_return' was not declared. Should it be static?

Add prototype for asm/ftrace.h

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/ftrace.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/sparc/include/asm/ftrace.h b/arch/sparc/include/asm/ftrace.h
index a1f1650..9ec94ad 100644
--- a/arch/sparc/include/asm/ftrace.h
+++ b/arch/sparc/include/asm/ftrace.h
@@ -22,4 +22,8 @@ struct dyn_arch_ftrace {
 };
 #endif /*  CONFIG_DYNAMIC_FTRACE */
 
+unsigned long prepare_ftrace_return(unsigned long parent,
+				    unsigned long self_addr,
+				    unsigned long frame_pointer);
+
 #endif /* _ASM_SPARC64_FTRACE */
-- 
1.9.0

