From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 15 Oct 2009 01:02:49 +0000
Subject: [PATCH 2/2] of: move struct property to asm/of.h
Message-Id: <20091015120249.cf84d941.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
	<20091015120007.3780c59b.sfr@canb.auug.org.au>
	<20091015120144.73ef384c.sfr@canb.auug.org.au>
In-Reply-To: <20091015120144.73ef384c.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: monstr@monstr.eu, devicetree-discuss@lists.ozlabs.org, microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

Also find all users of struct property and make sure that they include
linux/of.h.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/asm/of.h                |    7 +++++++
 arch/powerpc/include/asm/prom.h              |    7 +------
 arch/powerpc/kernel/machine_kexec_64.c       |    1 +
 arch/powerpc/kernel/prom.c                   |    1 +
 arch/powerpc/kernel/prom_parse.c             |    2 ++
 arch/powerpc/platforms/maple/pci.c           |    1 +
 arch/powerpc/platforms/powermac/pci.c        |    1 +
 arch/powerpc/platforms/powermac/pfunc_core.c |    1 +
 arch/powerpc/platforms/pseries/reconfig.c    |    1 +
 arch/powerpc/sysdev/qe_lib/qe.c              |    2 ++
 arch/sparc/include/asm/of.h                  |    9 +++++++++
 arch/sparc/include/asm/prom.h                |    9 +--------
 arch/sparc/kernel/pci_psycho.c               |    1 +
 arch/sparc/kernel/pci_schizo.c               |    1 +
 arch/sparc/kernel/pci_sun4v.c                |    1 +
 arch/sparc/kernel/prom_32.c                  |    1 +
 arch/sparc/kernel/prom_64.c                  |    1 +
 drivers/macintosh/smu.c                      |    1 +
 drivers/sbus/char/openprom.c                 |    2 ++
 fs/openpromfs/inode.c                        |    1 +
 fs/proc/proc_devtree.c                       |    2 ++
 21 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/of.h b/arch/powerpc/include/asm/of.h
index 1c1089a..383f48d 100644
--- a/arch/powerpc/include/asm/of.h
+++ b/arch/powerpc/include/asm/of.h
@@ -20,4 +20,11 @@
 #define of_prop_cmp(s1, s2)		strcmp((s1), (s2))
 #define of_node_cmp(s1, s2)		strcasecmp((s1), (s2))
 
+struct property {
+	char		*name;
+	int		length;
+	void		*value;
+	struct property *next;
+};
+
 #endif /* _POWERPC_OF_H */
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 07aef9f..97b24c9 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -68,12 +68,7 @@ struct boot_param_header
 typedef u32 phandle;
 typedef u32 ihandle;
 
-struct property {
-	char	*name;
-	int	length;
-	void	*value;
-	struct property *next;
-};
+struct property;
 
 struct device_node {
 	const char *name;
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 040bd1d..8ff5e00 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -15,6 +15,7 @@
 #include <linux/thread_info.h>
 #include <linux/init_task.h>
 #include <linux/errno.h>
+#include <linux/of.h>
 
 #include <asm/page.h>
 #include <asm/current.h>
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index d4405b9..c7c2655 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -32,6 +32,7 @@
 #include <linux/debugfs.h>
 #include <linux/irq.h>
 #include <linux/lmb.h>
+#include <linux/of.h>
 
 #include <asm/prom.h>
 #include <asm/rtas.h>
diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index 8362620..07698d4 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -6,6 +6,8 @@
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/etherdevice.h>
+#include <linux/of.h>
+
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 
diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index 04296ff..599c192 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/bootmem.h>
 #include <linux/irq.h>
+#include <linux/of.h>
 
 #include <asm/sections.h>
 #include <asm/io.h>
diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index e81403b..ac0ab8d 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/bootmem.h>
 #include <linux/irq.h>
+#include <linux/of.h>
 
 #include <asm/sections.h>
 #include <asm/io.h>
diff --git a/arch/powerpc/platforms/powermac/pfunc_core.c b/arch/powerpc/platforms/powermac/pfunc_core.c
index 96d5ce5..2eb9cde 100644
--- a/arch/powerpc/platforms/powermac/pfunc_core.c
+++ b/arch/powerpc/platforms/powermac/pfunc_core.c
@@ -11,6 +11,7 @@
 #include <linux/spinlock.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 
 #include <asm/prom.h>
 #include <asm/pmac_pfunc.h>
diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index 2e2bbe1..5d089d7 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -15,6 +15,7 @@
 #include <linux/kref.h>
 #include <linux/notifier.h>
 #include <linux/proc_fs.h>
+#include <linux/of.h>
 
 #include <asm/prom.h>
 #include <asm/machdep.h>
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index 464271b..8e690ca 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -27,6 +27,8 @@
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/crc32.h>
+#include <linux/of.h>
+
 #include <asm/irq.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
diff --git a/arch/sparc/include/asm/of.h b/arch/sparc/include/asm/of.h
index 57ab8f9..7aeb0c2 100644
--- a/arch/sparc/include/asm/of.h
+++ b/arch/sparc/include/asm/of.h
@@ -21,4 +21,13 @@
 #define of_prop_cmp(s1, s2)		strcasecmp((s1), (s2))
 #define of_node_cmp(s1, s2)		strcmp((s1), (s2))
 
+struct property {
+	char		*name;
+	int		length;
+	void		*value;
+	struct property *next;
+	unsigned long	 _flags;
+	unsigned int	 unique_id;
+};
+
 #endif /* _SPARC_OF_H */
diff --git a/arch/sparc/include/asm/prom.h b/arch/sparc/include/asm/prom.h
index 4b6ec43..03266c2 100644
--- a/arch/sparc/include/asm/prom.h
+++ b/arch/sparc/include/asm/prom.h
@@ -24,14 +24,7 @@
 typedef u32 phandle;
 typedef u32 ihandle;
 
-struct property {
-	char	*name;
-	int	length;
-	void	*value;
-	struct property *next;
-	unsigned long _flags;
-	unsigned int unique_id;
-};
+struct property;
 
 struct of_irq_controller;
 struct device_node {
diff --git a/arch/sparc/kernel/pci_psycho.c b/arch/sparc/kernel/pci_psycho.c
index 142b9d6..d9c8cde 100644
--- a/arch/sparc/kernel/pci_psycho.c
+++ b/arch/sparc/kernel/pci_psycho.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 
 #include <asm/iommu.h>
diff --git a/arch/sparc/kernel/pci_schizo.c b/arch/sparc/kernel/pci_schizo.c
index 2b5cdde..c923817 100644
--- a/arch/sparc/kernel/pci_schizo.c
+++ b/arch/sparc/kernel/pci_schizo.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 
 #include <asm/iommu.h>
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 23c33ff..322dfe0 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -13,6 +13,7 @@
 #include <linux/irq.h>
 #include <linux/msi.h>
 #include <linux/log2.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 
 #include <asm/iommu.h>
diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index 0a37e8c..61eafe0 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -21,6 +21,7 @@
 #include <linux/mm.h>
 #include <linux/bootmem.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 #include <asm/prom.h>
 #include <asm/oplib.h>
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index fb06ac2..f05ebdc 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -21,6 +21,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/lmb.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 
 #include <asm/prom.h>
diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index 96faa79..743e44a 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -36,6 +36,7 @@
 #include <linux/sysdev.h>
 #include <linux/poll.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 
diff --git a/drivers/sbus/char/openprom.c b/drivers/sbus/char/openprom.c
index 75ac19b..c67a9ab 100644
--- a/drivers/sbus/char/openprom.c
+++ b/drivers/sbus/char/openprom.c
@@ -38,6 +38,8 @@
 #include <linux/miscdevice.h>
 #include <linux/init.h>
 #include <linux/fs.h>
+#include <linux/of.h>
+
 #include <asm/oplib.h>
 #include <asm/prom.h>
 #include <asm/system.h>
diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index ffcd04f..b308cdf 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/seq_file.h>
 #include <linux/magic.h>
+#include <linux/of.h>
 
 #include <asm/openprom.h>
 #include <asm/oplib.h>
diff --git a/fs/proc/proc_devtree.c b/fs/proc/proc_devtree.c
index 7ba79a5..42121fc 100644
--- a/fs/proc/proc_devtree.c
+++ b/fs/proc/proc_devtree.c
@@ -9,6 +9,8 @@
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
 #include <linux/string.h>
+#include <linux/of.h>
+
 #include <asm/prom.h>
 #include <asm/uaccess.h>
 #include "internal.h"
-- 
1.6.4.3

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
