From: David Miller <davem@davemloft.net>
Date: Sun, 20 May 2012 04:47:06 +0000
Subject: [PATCH] sparc32: Kill boot_cpu_id4
Message-Id: <20120520.004706.242023960289192640.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


It is written, but never actually read.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/setup.h |    1 -
 arch/sparc/kernel/head_32.S    |    5 +----
 arch/sparc/kernel/setup_32.c   |    1 -
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/setup.h b/arch/sparc/include/asm/setup.h
index 00497ab..84a8a49 100644
--- a/arch/sparc/include/asm/setup.h
+++ b/arch/sparc/include/asm/setup.h
@@ -20,7 +20,6 @@ extern char reboot_command[];
  * Only sun4d + leon may have boot_cpu_id != 0
  */
 extern unsigned char boot_cpu_id;
-extern unsigned char boot_cpu_id4;
 
 extern unsigned long empty_bad_page;
 extern unsigned long empty_bad_page_table;
diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 69645ca..a0ec4ad 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -819,10 +819,7 @@ continue_boot:
 		mov	%g0, %g3
 		stub	%g3, [%g2 + %lo(boot_cpu_id)]
 
-1:		/* boot_cpu_id set. calculate boot_cpu_id4 = boot_cpu_id*4 */
-		sll	%g3, 2, %g3
-		sethi	%hi(boot_cpu_id4), %g2
-		stub	%g3, [%g2 + %lo(boot_cpu_id4)]
+1:		sll	%g3, 2, %g3
 
 		/* Initialize the uwinmask value for init task just in case.
 		 * But first make current_set[boot_cpu_id] point to something useful.
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 2f7cfb5..635df5c 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -105,7 +105,6 @@ unsigned long cmdline_memory_size __initdata = 0;
 
 /* which CPU booted us (0xff = not set) */
 unsigned char boot_cpu_id = 0xff; /* 0xff will make it into DATA section... */
-unsigned char boot_cpu_id4; /* boot_cpu_id << 2 */
 
 static void
 prom_console_write(struct console *con, const char *s, unsigned n)
-- 
1.7.10

