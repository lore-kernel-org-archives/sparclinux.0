From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 05 Nov 2009 07:45:48 +0000
Subject: [PATCH 03/11] of/flattree: merge of_get_flat_dt_root
Message-Id: <20091105074540.10460.75479.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091105073728.10460.6061.stgit@angua>
In-Reply-To: <20091105073728.10460.6061.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, benh@kernel.crashing.org, sfr@canb.auug.org.au, davem@davemloft.net, sparclinux@vger.kernel.org, monstr@monstr.eu

Merge common code between PowerPC and MicroBlaze

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/kernel/prom.c |   12 ------------
 arch/powerpc/kernel/prom.c    |   12 ------------
 drivers/of/fdt.c              |   16 ++++++++++++++++
 3 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
index 0db8ee6..7eb6f8b 100644
--- a/arch/microblaze/kernel/prom.c
+++ b/arch/microblaze/kernel/prom.c
@@ -50,18 +50,6 @@ typedef u32 cell_t;
 /* export that to outside world */
 struct device_node *of_chosen;
 
-unsigned long __init of_get_flat_dt_root(void)
-{
-	unsigned long p = ((unsigned long)initial_boot_params) +
-		initial_boot_params->off_dt_struct;
-
-	while (*((u32 *)p) = OF_DT_NOP)
-		p += 4;
-	BUG_ON(*((u32 *)p) != OF_DT_BEGIN_NODE);
-	p += 4;
-	return _ALIGN(p + strlen((char *)p) + 1, 4);
-}
-
 /**
  * This function can be used within scan_flattened_dt callback to get
  * access to properties
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 14a07b9..b5d5f85 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -80,18 +80,6 @@ extern rwlock_t devtree_lock;	/* temporary while merging */
 /* export that to outside world */
 struct device_node *of_chosen;
 
-unsigned long __init of_get_flat_dt_root(void)
-{
-	unsigned long p = ((unsigned long)initial_boot_params) +
-		initial_boot_params->off_dt_struct;
-
-	while(*((u32 *)p) = OF_DT_NOP)
-		p += 4;
-	BUG_ON (*((u32 *)p) != OF_DT_BEGIN_NODE);
-	p += 4;
-	return _ALIGN(p + strlen((char *)p) + 1, 4);
-}
-
 /**
  * This  function can be used within scan_flattened_dt callback to get
  * access to properties
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 7c3c13c..a6e869e 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -84,3 +84,19 @@ int __init of_scan_flat_dt(int (*it)(unsigned long node,
 
 	return rc;
 }
+
+/**
+ * of_get_flat_dt_root - find the root node in the flat blob
+ */
+unsigned long __init of_get_flat_dt_root(void)
+{
+	unsigned long p = ((unsigned long)initial_boot_params) +
+		initial_boot_params->off_dt_struct;
+
+	while (*((u32 *)p) = OF_DT_NOP)
+		p += 4;
+	BUG_ON(*((u32 *)p) != OF_DT_BEGIN_NODE);
+	p += 4;
+	return _ALIGN(p + strlen((char *)p) + 1, 4);
+}
+

