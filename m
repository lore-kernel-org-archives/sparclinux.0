From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 05 Nov 2009 07:46:01 +0000
Subject: [PATCH 04/11] of/flattree: remove __init annotations from the header
Message-Id: <20091105074553.10460.2893.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091105073728.10460.6061.stgit@angua>
In-Reply-To: <20091105073728.10460.6061.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, benh@kernel.crashing.org, sfr@canb.auug.org.au, davem@davemloft.net, sparclinux@vger.kernel.org, monstr@monstr.eu

__init annotation belongs in the .c file, not the header.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 include/linux/of_fdt.h |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index d1a79f3..81231e0 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -62,15 +62,13 @@ extern struct boot_param_header *initial_boot_params;
 
 /* For scanning the flat device-tree at boot time */
 extern char *find_flat_dt_string(u32 offset);
-extern int __init of_scan_flat_dt(int (*it)(unsigned long node,
-					    const char *uname, int depth,
-					    void *data),
-				  void *data);
-extern void __init *of_get_flat_dt_prop(unsigned long node, const char *name,
-					unsigned long *size);
-extern int __init of_flat_dt_is_compatible(unsigned long node,
-					   const char *name);
-extern unsigned long __init of_get_flat_dt_root(void);
+extern int of_scan_flat_dt(int (*it)(unsigned long node, const char *uname,
+				     int depth, void *data),
+			   void *data);
+extern void *of_get_flat_dt_prop(unsigned long node, const char *name,
+				 unsigned long *size);
+extern int of_flat_dt_is_compatible(unsigned long node, const char *name);
+extern unsigned long of_get_flat_dt_root(void);
 
 /* Other Prototypes */
 extern void finish_device_tree(void);

