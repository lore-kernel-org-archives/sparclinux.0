From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 07 Oct 2009 04:30:10 +0000
Subject: [RFC PATCH 01/12] of: Rework linux/of.h and asm/prom.h include
Message-Id: <20091007043002.16890.93443.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
In-Reply-To: <20091007041007.16890.62194.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, microblaze-uclinux

In preparation to prune things out of the Sparc, PowerPC and Microblaze
asm/prom.h files, change the #include statements to ensure that
even if asm/prom.h is included first, linux/of.h gets to determine the
order in which files are processed.

This patch adds a #include <linux/of.h> to each of the prom.h files
*above* the multi-include protection macros to ensure that linux/of.h
can define things before prom.h gets processed.

At the end of the merge the cross dependencies between the files should
be gone and a sane #include scheme can be restored.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/include/asm/prom.h |    8 ++------
 arch/powerpc/include/asm/prom.h    |    7 +------
 arch/sparc/include/asm/prom.h      |    7 +------
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
index 37e6f30..6636889 100644
--- a/arch/microblaze/include/asm/prom.h
+++ b/arch/microblaze/include/asm/prom.h
@@ -12,6 +12,8 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#include <linux/of.h>	/* linux/of.h gets to determine #include ordering */
+
 #ifndef _ASM_MICROBLAZE_PROM_H
 #define _ASM_MICROBLAZE_PROM_H
 #ifdef __KERNEL__
@@ -305,12 +307,6 @@ extern int of_irq_to_resource(struct device_node *dev, int index,
  */
 extern void __iomem *of_iomap(struct device_node *device, int index);
 
-/*
- * NB: This is here while we transition from using asm/prom.h
- * to linux/of.h
- */
-#include <linux/of.h>
-
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_MICROBLAZE_PROM_H */
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 6ff0418..b0a84ea 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -1,3 +1,4 @@
+#include <linux/of.h>	/* linux/of.h gets to determine #include ordering */
 #ifndef _POWERPC_PROM_H
 #define _POWERPC_PROM_H
 #ifdef __KERNEL__
@@ -349,11 +350,5 @@ extern int of_irq_to_resource(struct device_node *dev, int index,
  */
 extern void __iomem *of_iomap(struct device_node *device, int index);
 
-/*
- * NB:  This is here while we transition from using asm/prom.h
- * to linux/of.h
- */
-#include <linux/of.h>
-
 #endif /* __KERNEL__ */
 #endif /* _POWERPC_PROM_H */
diff --git a/arch/sparc/include/asm/prom.h b/arch/sparc/include/asm/prom.h
index 82a190d..0733170 100644
--- a/arch/sparc/include/asm/prom.h
+++ b/arch/sparc/include/asm/prom.h
@@ -1,3 +1,4 @@
+#include <linux/of.h>	/* linux/of.h gets to determine #include ordering */
 #ifndef _SPARC_PROM_H
 #define _SPARC_PROM_H
 #ifdef __KERNEL__
@@ -108,12 +109,6 @@ static inline void irq_dispose_mapping(unsigned int virq)
 {
 }
 
-/*
- * NB:  This is here while we transition from using asm/prom.h
- * to linux/of.h
- */
-#include <linux/of.h>
-
 extern struct device_node *of_console_device;
 extern char *of_console_path;
 extern char *of_console_options;

