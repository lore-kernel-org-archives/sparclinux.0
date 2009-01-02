From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 02 Jan 2009 08:36:48 +0000
Subject: [PATCH] sparc: remove NO_PROC_ID - it is no longer used
Message-Id: <20090102083648.GA2863@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
This patch was inspired by the TODO list dave has here:

    http://vger.kernel.org/~davem/sparc64_todo.html

This was sufficiently simple :-)

	Sam

 arch/sparc/include/asm/smp_32.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/smp_32.h b/arch/sparc/include/asm/smp_32.h
index a8180e5..29c5acf 100644
--- a/arch/sparc/include/asm/smp_32.h
+++ b/arch/sparc/include/asm/smp_32.h
@@ -172,7 +172,4 @@ void smp_setup_cpu_possible_map(void);
 #define smp_setup_cpu_possible_map() do { } while (0)
 
 #endif /* !(SMP) */
-
-#define NO_PROC_ID            0xFF
-
 #endif /* !(_SPARC_SMP_H) */
-- 
1.6.0.2.GIT

