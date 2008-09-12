From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2008 21:48:02 +0000
Subject: [PATCH 4/16]: sysctl: Use header file for sysctl knob declarations
Message-Id: <20080912.144802.162470739.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sysctl: Use header file for sysctl knob declarations on sparc.

This also takes care of a sparse warning as scons_pwroff's definition
point.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/system_32.h |    1 +
 arch/sparc/include/asm/system_64.h |    1 +
 arch/sparc64/kernel/reboot.c       |    1 +
 kernel/sysctl.c                    |    4 +---
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/system_32.h b/arch/sparc/include/asm/system_32.h
index 4e18ef2..8623fc4 100644
--- a/arch/sparc/include/asm/system_32.h
+++ b/arch/sparc/include/asm/system_32.h
@@ -49,6 +49,7 @@ extern unsigned long empty_zero_page;
 extern void sun_do_break(void);
 extern int serial_console;
 extern int stop_a_enabled;
+extern int scons_pwroff;
 
 static inline int con_is_present(void)
 {
diff --git a/arch/sparc/include/asm/system_64.h b/arch/sparc/include/asm/system_64.h
index 98acb3b..8759f2a 100644
--- a/arch/sparc/include/asm/system_64.h
+++ b/arch/sparc/include/asm/system_64.h
@@ -117,6 +117,7 @@ do {	__asm__ __volatile__("ba,pt	%%xcc, 1f\n\t" \
 
 extern void sun_do_break(void);
 extern int stop_a_enabled;
+extern int scons_pwroff;
 
 extern void fault_in_user_windows(void);
 extern void synchronize_user_stack(void);
diff --git a/arch/sparc64/kernel/reboot.c b/arch/sparc64/kernel/reboot.c
index 11f2496..ef89d3d 100644
--- a/arch/sparc64/kernel/reboot.c
+++ b/arch/sparc64/kernel/reboot.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 
+#include <asm/system.h>
 #include <asm/oplib.h>
 #include <asm/prom.h>
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index eda6162..da51520 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -119,9 +119,7 @@ extern int sg_big_buff;
 #endif
 
 #ifdef CONFIG_SPARC
-extern char reboot_command [];
-extern int stop_a_enabled;
-extern int scons_pwroff;
+#include <asm/system.h>
 #endif
 
 #ifdef __hppa__
-- 
1.5.6.5.GIT

