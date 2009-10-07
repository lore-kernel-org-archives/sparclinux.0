From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 07 Oct 2009 04:30:22 +0000
Subject: [RFC PATCH 02/12] of: merge phandle, ihandle and struct property
Message-Id: <20091007043015.16890.5220.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
In-Reply-To: <20091007041007.16890.62194.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, Stephen Rothwell <sfr@canb.auug.org.au>, davem@davemloft.net, sparclinux@vger.kernel.org, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org

Merge of common code duplicated between Sparc, PowerPC and Microblaze

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/include/asm/prom.h |   10 ----------
 arch/powerpc/include/asm/prom.h    |   12 ------------
 arch/sparc/include/asm/prom.h      |   12 ------------
 include/linux/of.h                 |   12 ++++++++++++
 4 files changed, 12 insertions(+), 34 deletions(-)

diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
index 6636889..11cb484 100644
--- a/arch/microblaze/include/asm/prom.h
+++ b/arch/microblaze/include/asm/prom.h
@@ -73,16 +73,6 @@ struct boot_param_header {
 	u32	dt_struct_size; /* size of the DT structure block */
 };
 
-typedef u32 phandle;
-typedef u32 ihandle;
-
-struct property {
-	char	*name;
-	int	length;
-	void	*value;
-	struct property *next;
-};
-
 struct device_node {
 	const char *name;
 	const char *type;
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index b0a84ea..c236326 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -71,18 +71,6 @@ struct boot_param_header
 	u32	dt_struct_size;		/* size of the DT structure block */
 };
 
-
-
-typedef u32 phandle;
-typedef u32 ihandle;
-
-struct property {
-	char	*name;
-	int	length;
-	void	*value;
-	struct property *next;
-};
-
 struct device_node {
 	const char *name;
 	const char *type;
diff --git a/arch/sparc/include/asm/prom.h b/arch/sparc/include/asm/prom.h
index 0733170..b34f988 100644
--- a/arch/sparc/include/asm/prom.h
+++ b/arch/sparc/include/asm/prom.h
@@ -29,18 +29,6 @@
 #define of_prop_cmp(s1, s2)		strcasecmp((s1), (s2))
 #define of_node_cmp(s1, s2)		strcmp((s1), (s2))
 
-typedef u32 phandle;
-typedef u32 ihandle;
-
-struct property {
-	char	*name;
-	int	length;
-	void	*value;
-	struct property *next;
-	unsigned long _flags;
-	unsigned int unique_id;
-};
-
 struct of_irq_controller;
 struct device_node {
 	const char	*name;
diff --git a/include/linux/of.h b/include/linux/of.h
index 7be2d10..4668b29 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -19,6 +19,18 @@
 #include <linux/bitops.h>
 #include <linux/mod_devicetable.h>
 
+typedef u32 phandle;
+typedef u32 ihandle;
+
+struct property {
+	char	*name;
+	int	length;
+	void	*value;
+	struct property *next;
+	unsigned long _flags;
+	unsigned int unique_id;
+};
+
 #include <asm/prom.h>
 
 /* flag descriptions */

