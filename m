From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 07 Oct 2009 04:31:37 +0000
Subject: [RFC PATCH 08/12] of: merge of_read_number() an of_read_ulong()
Message-Id: <20091007043129.16890.85758.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
In-Reply-To: <20091007041007.16890.62194.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, Stephen Rothwell <sfr@canb.auug.org.au>, davem@davemloft.net, sparclinux@vger.kernel.org, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org

Merge common code between Microblaze and PowerPC

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/include/asm/prom.h |   12 ------------
 arch/powerpc/include/asm/prom.h    |   20 --------------------
 include/linux/of.h                 |   23 +++++++++++++++++++++++
 3 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
index 180d844..d4f57ff 100644
--- a/arch/microblaze/include/asm/prom.h
+++ b/arch/microblaze/include/asm/prom.h
@@ -82,18 +82,6 @@ extern int release_OF_resource(struct device_node *node, int index);
  * OF address retreival & translation
  */
 
-/* Helper to read a big number; size is in cells (not bytes) */
-static inline u64 of_read_number(const u32 *cell, int size)
-{
-	u64 r = 0;
-	while (size--)
-		r = (r << 32) | *(cell++);
-	return r;
-}
-
-/* Like of_read_number, but we want an unsigned long result */
-#define of_read_ulong(cell, size)	of_read_number(cell, size)
-
 /* Translate an OF address block into a CPU physical address
  */
 extern u64 of_translate_address(struct device_node *np, const u32 *addr);
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 2cfd432..d8c0525 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -89,26 +89,6 @@ extern int release_OF_resource(struct device_node* node, int index);
  * OF address retreival & translation
  */
 
-
-/* Helper to read a big number; size is in cells (not bytes) */
-static inline u64 of_read_number(const u32 *cell, int size)
-{
-	u64 r = 0;
-	while (size--)
-		r = (r << 32) | *(cell++);
-	return r;
-}
-
-/* Like of_read_number, but we want an unsigned long result */
-#ifdef CONFIG_PPC32
-static inline unsigned long of_read_ulong(const u32 *cell, int size)
-{
-	return cell[size-1];
-}
-#else
-#define of_read_ulong(cell, size)	of_read_number(cell, size)
-#endif
-
 /* Translate an OF address block into a CPU physical address
  */
 extern u64 of_translate_address(struct device_node *np, const u32 *addr);
diff --git a/include/linux/of.h b/include/linux/of.h
index d5f6662..18e4379 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -79,6 +79,29 @@ set_node_proc_entry(struct device_node *dn, struct proc_dir_entry *de)
 	dn->pde = de;
 }
 
+/*
+ * OF address retreival & translation
+ */
+
+/* Helper to read a big number; size is in cells (not bytes) */
+static inline u64 of_read_number(const u32 *cell, int size)
+{
+	u64 r = 0;
+	while (size--)
+		r = (r << 32) | *(cell++);
+	return r;
+}
+
+/* Like of_read_number, but we want an unsigned long result */
+#ifdef CONFIG_PPC32
+static inline unsigned long of_read_ulong(const u32 *cell, int size)
+{
+	return cell[size-1];
+}
+#else
+#define of_read_ulong(cell, size)	of_read_number(cell, size)
+#endif
+
 #include <asm/prom.h>
 
 /* flag descriptions */

