From: Jag Raman <jag.raman@oracle.com>
Date: Tue, 15 Aug 2017 21:02:57 +0000
Subject: [PATCH v2 01/13] sparc64: vcc: Enable VCC module in linux
Message-Id: <99cb83ee3b1771b36bb2d03836450f19531a84d4.1502829972.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Enables the Virtual Console Concentrator (VCC) module
in linux kernel

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 MAINTAINERS                          |    1 +
 arch/sparc/configs/sparc64_defconfig |    1 +
 drivers/tty/Kconfig                  |    5 +++++
 drivers/tty/Makefile                 |    1 +
 drivers/tty/vcc.c                    |   18 ++++++++++++++++++
 5 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100644 drivers/tty/vcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 84d6a82..28c0b4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12294,6 +12294,7 @@ F:	drivers/tty/serial/sunsab.h
 F:	drivers/tty/serial/sunsu.c
 F:	drivers/tty/serial/sunzilog.c
 F:	drivers/tty/serial/sunzilog.h
+F:	drivers/tty/vcc.c
 
 SPARSE CHECKER
 M:	"Christopher Li" <sparse@chrisli.org>
diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index ca8609d..4d4e1cc 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -238,3 +238,4 @@ CONFIG_CRYPTO_TWOFISH=m
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRC16=m
 CONFIG_LIBCRC32C=m
+CONFIG_VCC=m
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 9510305..8643b55 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -455,4 +455,9 @@ config MIPS_EJTAG_FDC_KGDB_CHAN
 	help
 	  FDC channel number to use for KGDB.
 
+config VCC
+	tristate "Sun Virtual Console Concentrator"
+	depends on SUN_LDOMS
+	help
+	  Support for Sun logical domain consoles.
 endif # TTY
diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 8689279..16330a8 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -33,5 +33,6 @@ obj-$(CONFIG_PPC_EPAPR_HV_BYTECHAN) += ehv_bytechan.o
 obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
 obj-$(CONFIG_DA_TTY)		+= metag_da.o
 obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
+obj-$(CONFIG_VCC)		+= vcc.o
 
 obj-y += ipwireless/
diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
new file mode 100644
index 0000000..e1b8099
--- /dev/null
+++ b/drivers/tty/vcc.c
@@ -0,0 +1,18 @@
+/* vcc.c: sun4v virtual channel concentrator
+ *
+ * Copyright (C) 2017 Oracle. All rights reserved.
+ */
+
+#include <linux/module.h>
+
+static int __init vcc_init(void)
+{
+	return 0;
+}
+
+static void __exit vcc_exit(void)
+{
+}
+
+module_init(vcc_init);
+module_exit(vcc_exit);
-- 
1.7.1

