From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 06 Dec 2008 21:39:27 +0000
Subject: [PATCH 2/2] sparc: unify kernel/idprom.c
Message-Id: <20081206213927.GC28686@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

o in sparc32 variant removed prom_halt in warning situations
o ifdef out sparc32 specific code

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/Makefile                  |    2 +-
 arch/sparc/kernel/{idprom_32.c => idprom.c} |   16 ++++----
 arch/sparc/kernel/idprom_64.c               |   49 ---------------------------
 3 files changed, 9 insertions(+), 58 deletions(-)
 rename arch/sparc/kernel/{idprom_32.c => idprom.c} (95%)
 delete mode 100644 arch/sparc/kernel/idprom_64.c

diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 0ba314b..59aab6a 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -22,7 +22,7 @@ obj-y                   += process_$(BITS).o
 obj-y                   += signal_$(BITS).o
 obj-$(CONFIG_SPARC32)   += ioport.o
 obj-y                   += setup_$(BITS).o
-obj-y                   += idprom_$(BITS).o
+obj-y                   += idprom.o
 obj-y                   += sys_sparc_$(BITS).o
 obj-$(CONFIG_SPARC32)   += systbls_32.o
 obj-y                   += time_$(BITS).o
diff --git a/arch/sparc/kernel/idprom_32.c b/arch/sparc/kernel/idprom.c
similarity index 95%
rename from arch/sparc/kernel/idprom_32.c
rename to arch/sparc/kernel/idprom.c
index 3e2fe09..1b0bd91 100644
--- a/arch/sparc/kernel/idprom_32.c
+++ b/arch/sparc/kernel/idprom.c
@@ -15,6 +15,7 @@
 struct idprom *idprom;
 static struct idprom idprom_buffer;
 
+#ifdef CONFIG_SPARC32
 #include <asm/machines.h>  /* Fun with Sun released architectures. */
 
 /* Here is the master table of Sun machines which use some implementation
@@ -61,9 +62,12 @@ static void __init display_system_type(unsigned char machtype)
 	}
 
 	prom_printf("IDPROM: Warning, bogus id_machtype value, 0x%x\n", machtype);
-	prom_halt();
 }
-
+#else
+static void __init display_system_type(unsigned char machtype)
+{
+}
+#endif
 /* Calculate the IDPROM checksum (xor of the data bytes). */
 static unsigned char __init calc_idprom_cksum(struct idprom *idprom)
 {
@@ -82,16 +86,12 @@ void __init idprom_init(void)
 
 	idprom = &idprom_buffer;
 
-	if (idprom->id_format != 0x01) {
+	if (idprom->id_format != 0x01)
 		prom_printf("IDPROM: Warning, unknown format type!\n");
-		prom_halt();
-	}
 
-	if (idprom->id_cksum != calc_idprom_cksum(idprom)) {
+	if (idprom->id_cksum != calc_idprom_cksum(idprom))
 		prom_printf("IDPROM: Warning, checksum failure (nvram=%x, calc=%x)!\n",
 			    idprom->id_cksum, calc_idprom_cksum(idprom));
-		prom_halt();
-	}
 
 	display_system_type(idprom->id_machtype);
 
diff --git a/arch/sparc/kernel/idprom_64.c b/arch/sparc/kernel/idprom_64.c
deleted file mode 100644
index 5b45a80..0000000
--- a/arch/sparc/kernel/idprom_64.c
+++ /dev/null
@@ -1,49 +0,0 @@
-/*
- * idprom.c: Routines to load the idprom into kernel addresses and
- *           interpret the data contained within.
- *
- * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
- */
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/init.h>
-
-#include <asm/oplib.h>
-#include <asm/idprom.h>
-
-struct idprom *idprom;
-static struct idprom idprom_buffer;
-
-/* Calculate the IDPROM checksum (xor of the data bytes). */
-static unsigned char __init calc_idprom_cksum(struct idprom *idprom)
-{
-	unsigned char cksum, i, *ptr = (unsigned char *)idprom;
-
-	for (i = cksum = 0; i <= 0x0E; i++)
-		cksum ^= *ptr++;
-
-	return cksum;
-}
-
-/* Create a local IDPROM copy and verify integrity. */
-void __init idprom_init(void)
-{
-	prom_get_idprom((char *) &idprom_buffer, sizeof(idprom_buffer));
-
-	idprom = &idprom_buffer;
-
-	if (idprom->id_format != 0x01)  {
-		prom_printf("IDPROM: Warning, unknown format type!\n");
-	}
-
-	if (idprom->id_cksum != calc_idprom_cksum(idprom)) {
-		prom_printf("IDPROM: Warning, checksum failure (nvram=%x, calc=%x)!\n",
-			    idprom->id_cksum, calc_idprom_cksum(idprom));
-	}
-
-	printk("Ethernet address: %02x:%02x:%02x:%02x:%02x:%02x\n",
-	       idprom->id_ethaddr[0], idprom->id_ethaddr[1],
-	       idprom->id_ethaddr[2], idprom->id_ethaddr[3],
-	       idprom->id_ethaddr[4], idprom->id_ethaddr[5]);
-}
-- 
1.5.6.GIT

