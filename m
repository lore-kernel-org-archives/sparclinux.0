From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 17:12:23 +0000
Subject: [PATCH 11/24] sparc32: fix sparse warning in devices.c
Message-Id: <1398100356-19794-11-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warning:
devices.c:114:13: warning: symbol 'device_scan' was not declared. Should it be static?

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/setup.h | 3 +++
 arch/sparc/kernel/devices.c    | 1 +
 arch/sparc/mm/init_32.c        | 2 --
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/setup.h b/arch/sparc/include/asm/setup.h
index c7cd435..622145b 100644
--- a/arch/sparc/include/asm/setup.h
+++ b/arch/sparc/include/asm/setup.h
@@ -39,6 +39,9 @@ int sparc_floppy_request_irq(unsigned int irq, irq_handler_t irq_handler);
 /* setup_32.c */
 extern unsigned long cmdline_memory_size;
 
+/* devices.c */
+void __init device_scan(void);
+
 #endif
 
 extern void sun_do_break(void);
diff --git a/arch/sparc/kernel/devices.c b/arch/sparc/kernel/devices.c
index 3d465e8..b9e9d8c 100644
--- a/arch/sparc/kernel/devices.c
+++ b/arch/sparc/kernel/devices.c
@@ -19,6 +19,7 @@
 #include <asm/smp.h>
 #include <asm/cpudata.h>
 #include <asm/cpu_type.h>
+#include <asm/setup.h>
 
 extern void clock_stop_probe(void); /* tadpole.c */
 
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index d0c7327..eb82871 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -248,8 +248,6 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
  * init routine based upon the Sun model type on the Sparc.
  *
  */
-extern void device_scan(void);
-
 void __init paging_init(void)
 {
 	srmmu_paging_init();
-- 
1.8.3.1

