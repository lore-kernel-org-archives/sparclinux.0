From: Robert Reif <reif@earthlink.net>
Date: Fri, 11 May 2007 10:51:11 +0000
Subject: [PATCH] fix sparc32 kdebug changes
Message-Id: <46444A9F.6040407@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090100040705030903070008"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------090100040705030903070008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fix recent kdebug changes to compile on sparc32.

Compile tested only because recent smp.h changes also break sparc32.

Signed-off-by: Robert Reif <reif@earthlink.net>


--------------090100040705030903070008
Content-Type: text/x-diff;
 name="kdebug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kdebug.diff"

diff --git a/arch/sparc/kernel/head.S b/arch/sparc/kernel/head.S
index 97da13c..9a219e8 100644
--- a/arch/sparc/kernel/head.S
+++ b/arch/sparc/kernel/head.S
@@ -19,7 +19,7 @@ #include <asm/contregs.h>
 #include <asm/ptrace.h>
 #include <asm/psr.h>
 #include <asm/page.h>
-#include <linux/kdebug.h>
+#include <asm/kdebug.h>
 #include <asm/winmacro.h>
 #include <asm/thread_info.h>	/* TI_UWINMASK */
 #include <asm/errno.h>
diff --git a/include/asm-sparc/kdebug.h b/include/asm-sparc/kdebug.h
index 404d807..631f15f 100644
--- a/include/asm-sparc/kdebug.h
+++ b/include/asm-sparc/kdebug.h
@@ -58,6 +58,10 @@ #define SP_ENTER_DEBUGGER do { \
 	       sp_enter_debugger(); \
 		       } while(0)
 
+enum die_val {
+	DIE_UNUSED,
+};
+
 #endif /* !(__ASSEMBLY__) */
 
 /* Some nice offset defines for assembler code. */
@@ -66,8 +70,4 @@ #define KDEBUG_DUNNO_OFF    0x4
 #define KDEBUG_DUNNO2_OFF   0x8
 #define KDEBUG_TEACH_OFF    0xc
 
-enum die_val {
-	DIE_UNUSED,
-};
-
 #endif /* !(_SPARC_KDEBUG_H) */

--------------090100040705030903070008--

