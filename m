From: Andreas Larsson <andreas@gaisler.com>
Date: Tue, 06 Nov 2012 10:12:03 +0000
Subject: [PATCH v3] of/address: sparc: Declare of_address_to_resource() as an extern function for sparc again
Message-Id: <1352196723-23157-1-git-send-email-andreas@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5097E55A.4090305@calxeda.com>
In-Reply-To: <5097E55A.4090305@calxeda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, Rob Herring <rob.herring@calxeda.com>
Cc: sparclinux@vger.kernel.org, software@gaisler.com, sam@ravnborg.org, Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org

This bug-fix makes sure that of_address_to_resource is defined extern for sparc
so that the sparc-specific implementation of of_address_to_resource() is once
again used when including include/linux/of_address.h in a sparc context. A
number of drivers in mainline relies on this function working for sparc.

The bug was introduced in a850a7554442f08d3e910c6eeb4ee216868dda1e, "of/address:
add empty static inlines for !CONFIG_OF". Contrary to that commit title, the
static inlines are added for !CONFIG_OF_ADDRESS, and CONFIG_OF_ADDRESS is never
defined for sparc. This is good behavior for the other functions in
include/linux/of_address.h, as the extern functions defined in
drivers/of/address.c only gets linked when OF_ADDRESS is configured. However,
for of_address_to_resource there exists a sparc-specific implementation in
arch/sparc/arch/sparc/kernel/of_device_common.c

Solution suggested by: Sam Ravnborg <sam@ravnborg.org>

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/sparc/include/asm/prom.h |    5 +++++
 include/linux/of_address.h    |    2 ++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/prom.h b/arch/sparc/include/asm/prom.h
index c287651..f930031 100644
--- a/arch/sparc/include/asm/prom.h
+++ b/arch/sparc/include/asm/prom.h
@@ -63,5 +63,10 @@ extern char *of_console_options;
 extern void irq_trans_init(struct device_node *dp);
 extern char *build_path_component(struct device_node *dp);
 
+/* SPARC has a local implementation */
+extern int of_address_to_resource(struct device_node *dev, int index,
+				  struct resource *r);
+#define of_address_to_resource of_address_to_resource
+
 #endif /* __KERNEL__ */
 #endif /* _SPARC_PROM_H */
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index a1984dd..e20e3af 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -28,11 +28,13 @@ static inline unsigned long pci_address_to_pio(phys_addr_t addr) { return -1; }
 #endif
 
 #else /* CONFIG_OF_ADDRESS */
+#ifndef of_address_to_resource
 static inline int of_address_to_resource(struct device_node *dev, int index,
 					 struct resource *r)
 {
 	return -EINVAL;
 }
+#endif
 static inline struct device_node *of_find_matching_node_by_address(
 					struct device_node *from,
 					const struct of_device_id *matches,
-- 
1.7.0.4

