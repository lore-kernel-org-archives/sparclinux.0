From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 12 Jun 2017 20:41:41 +0000
Subject: [v3 1/8] sparc64: remove trailing white spaces
Message-Id: <1497300108-158125-2-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

A few changes that were reported by checkpatch, removed all trailing white
spaces in these two files.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 arch/sparc/include/asm/setup.h |    2 +-
 arch/sparc/kernel/setup_64.c   |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/setup.h b/arch/sparc/include/asm/setup.h
index 3fae200..8b32538 100644
--- a/arch/sparc/include/asm/setup.h
+++ b/arch/sparc/include/asm/setup.h
@@ -1,5 +1,5 @@
 /*
- *	Just a place holder. 
+ *	Just a place holder.
  */
 #ifndef _SPARC_SETUP_H
 #define _SPARC_SETUP_H
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 422b178..4a85f92 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -95,7 +95,7 @@ struct screen_info screen_info = {
 	.index =	-1,
 };
 
-/* 
+/*
  * Process kernel command line switches that are specific to the
  * SPARC or that require special low-level processing.
  */
@@ -639,7 +639,7 @@ void __init setup_arch(char **cmdline_p)
 #ifdef CONFIG_BLK_DEV_RAM
 	rd_image_start = ram_flags & RAMDISK_IMAGE_START_MASK;
 	rd_prompt = ((ram_flags & RAMDISK_PROMPT_FLAG) != 0);
-	rd_doload = ((ram_flags & RAMDISK_LOAD_FLAG) != 0);	
+	rd_doload = ((ram_flags & RAMDISK_LOAD_FLAG) != 0);
 #endif
 
 	task_thread_info(&init_task)->kregs = &fake_swapper_regs;
@@ -648,7 +648,7 @@ void __init setup_arch(char **cmdline_p)
 	if (!ic_set_manually) {
 		phandle chosen = prom_finddevice("/chosen");
 		u32 cl, sv, gw;
-		
+
 		cl = prom_getintdefault (chosen, "client-ip", 0);
 		sv = prom_getintdefault (chosen, "server-ip", 0);
 		gw = prom_getintdefault (chosen, "gateway-ip", 0);
-- 
1.7.1

