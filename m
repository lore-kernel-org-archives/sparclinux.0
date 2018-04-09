From: Oliver O'Halloran <oohall@gmail.com>
Date: Mon, 09 Apr 2018 07:46:04 +0000
Subject: [PATCH] drivers/of: Introduce ARCH_HAS_OWN_OF_NUMA
Message-Id: <20180409074604.17671-1-oohall@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

Some OF platforms (pseries and some SPARC systems) has their own
implementations of NUMA affinity detection rather than using the generic
OF_NUMA driver, which mainly exists for arm64. For other platforms one
of two fallbacks provided by the base OF driver are used depending on
CONFIG_NUMA.

In the CONFIG_NUMA=n case the fallback is an inline function in of.h.
In the =y case the fallback is a real function which is defined as a
weak symbol so that it may be overwritten by the architecture if desired.

The problem with this arrangement is that the real implementations all
export of_node_to_nid(). Unfortunately it's not possible to export the
fallback since it would clash with the non-weak version. As a result
we get build failures when:

a) CONFIG_NUMA=y && CONFIG_OF=y, and
b) The platform doesn't implement of_node_to_nid(), and
c) A module uses of_node_to_nid()

Given b) will be true for most platforms this is fairly easy to hit
and has been observed on ia64 and x86.

This patch remedies the problem by introducing the ARCH_HAS_OWN_OF_NUMA
Kconfig option which is selected if an architecture provides an
implementation of of_node_to_nid(). If a platform does not use it's own,
or the generic OF_NUMA, then always use the inline fallback in of.h so
we don't need to futz around with exports.

Cc: devicetree@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Fixes: 298535c00a2c ("of, numa: Add NUMA of binding implementation.")
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/Kconfig | 1 +
 arch/sparc/Kconfig   | 1 +
 drivers/of/Kconfig   | 3 +++
 drivers/of/base.c    | 7 -------
 include/linux/of.h   | 2 +-
 5 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c32a181a7cbb..74ce5f3564ae 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -625,6 +625,7 @@ config NUMA
 	bool "NUMA support"
 	depends on PPC64
 	default y if SMP && PPC_PSERIES
+	select ARCH_HAS_OWN_OF_NUMA
 
 config NODES_SHIFT
 	int
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 8767e45f1b2b..f8071f1c3edb 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -299,6 +299,7 @@ config GENERIC_LOCKBREAK
 config NUMA
 	bool "NUMA support"
 	depends on SPARC64 && SMP
+	select ARCH_HAS_OWN_OF_NUMA
 
 config NODES_SHIFT
 	int "Maximum NUMA Nodes (as a power of 2)"
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index ad3fcad4d75b..01c62b747b25 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -103,4 +103,7 @@ config OF_OVERLAY
 config OF_NUMA
 	bool
 
+config ARCH_HAS_OWN_OF_NUMA
+	bool
+
 endif # OF
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 848f549164cd..82a9584bb0e2 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -84,13 +84,6 @@ int of_n_size_cells(struct device_node *np)
 }
 EXPORT_SYMBOL(of_n_size_cells);
 
-#ifdef CONFIG_NUMA
-int __weak of_node_to_nid(struct device_node *np)
-{
-	return NUMA_NO_NODE;
-}
-#endif
-
 static struct device_node **phandle_cache;
 static u32 phandle_cache_mask;
 
diff --git a/include/linux/of.h b/include/linux/of.h
index 4d25e4f952d9..9bb42dac5e65 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -942,7 +942,7 @@ static inline int of_cpu_node_to_id(struct device_node *np)
 #define of_node_cmp(s1, s2)		strcasecmp((s1), (s2))
 #endif
 
-#if defined(CONFIG_OF) && defined(CONFIG_NUMA)
+#if defined(CONFIG_OF_NUMA) || defined(CONFIG_ARCH_HAS_OWN_OF_NUMA)
 extern int of_node_to_nid(struct device_node *np);
 #else
 static inline int of_node_to_nid(struct device_node *device)
-- 
2.9.5

