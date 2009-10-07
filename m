From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 07 Oct 2009 04:32:14 +0000
Subject: [RFC PATCH 11/12] of: merge other miscellaneous prototypes
Message-Id: <20091007043207.16890.89075.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
In-Reply-To: <20091007041007.16890.62194.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, Stephen Rothwell <sfr@canb.auug.org.au>, davem@davemloft.net, sparclinux@vger.kernel.org, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org

Merge common prototypes used by Microblaze and PowerPC

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/include/asm/prom.h |   12 ------------
 arch/powerpc/include/asm/prom.h    |   14 --------------
 include/linux/of_fdt.h             |   13 +++++++++++++
 3 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
index be4db2a..ef3ec1d 100644
--- a/arch/microblaze/include/asm/prom.h
+++ b/arch/microblaze/include/asm/prom.h
@@ -45,19 +45,7 @@ extern void of_attach_node(struct device_node *);
 extern void of_detach_node(struct device_node *);
 
 /* Other Prototypes */
-extern void finish_device_tree(void);
-extern void unflatten_device_tree(void);
 extern int early_uartlite_console(void);
-extern void early_init_devtree(void *);
-extern int machine_is_compatible(const char *compat);
-extern void print_properties(struct device_node *node);
-extern int prom_n_intr_cells(struct device_node *np);
-extern void prom_get_irq_senses(unsigned char *senses, int off, int max);
-extern int prom_add_property(struct device_node *np, struct property *prop);
-extern int prom_remove_property(struct device_node *np, struct property *prop);
-extern int prom_update_property(struct device_node *np,
-				struct property *newprop,
-				struct property *oldprop);
 
 extern struct resource *request_OF_resource(struct device_node *node,
 				int index, const char *name_postfix);
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index c8b5933..2ab9cbd 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -38,20 +38,6 @@ extern struct device_node *of_chosen;
 extern void of_attach_node(struct device_node *);
 extern void of_detach_node(struct device_node *);
 
-/* Other Prototypes */
-extern void finish_device_tree(void);
-extern void unflatten_device_tree(void);
-extern void early_init_devtree(void *);
-extern int machine_is_compatible(const char *compat);
-extern void print_properties(struct device_node *node);
-extern int prom_n_intr_cells(struct device_node* np);
-extern void prom_get_irq_senses(unsigned char *senses, int off, int max);
-extern int prom_add_property(struct device_node* np, struct property* prop);
-extern int prom_remove_property(struct device_node *np, struct property *prop);
-extern int prom_update_property(struct device_node *np,
-				struct property *newprop,
-				struct property *oldprop);
-
 #ifdef CONFIG_PPC32
 /*
  * PCI <-> OF matching functions
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index ac31d4f..b41bd18 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -71,4 +71,17 @@ extern int __init of_flat_dt_is_compatible(unsigned long node,
 					   const char *name);
 extern unsigned long __init of_get_flat_dt_root(void);
 
+/* Other Prototypes */
+extern void finish_device_tree(void);
+extern void unflatten_device_tree(void);
+extern void early_init_devtree(void *);
+extern int machine_is_compatible(const char *compat);
+extern void print_properties(struct device_node *node);
+extern int prom_n_intr_cells(struct device_node* np);
+extern void prom_get_irq_senses(unsigned char *senses, int off, int max);
+extern int prom_add_property(struct device_node* np, struct property* prop);
+extern int prom_remove_property(struct device_node *np, struct property *prop);
+extern int prom_update_property(struct device_node *np,
+				struct property *newprop,
+				struct property *oldprop);
 #endif /* _LINUX_OF_FDT_H */

