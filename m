From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 23 Jul 2010 20:09:01 +0000
Subject: [PATCH] of: Fix phandle endian issues
Message-Id: <20100723200901.19485.35303.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jonas@southpole.se, sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, sparclinux@vger.kernel.org, davem@davemloft.net

The flat tree code wasn't fixing the endianness on phandle values when
unflattening the tree, and the code in drivers/of wasn't always doing a
be32_to_cpu before trying to dereference the phandle values.  This patch
fixes them.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/of/base.c |   12 ++++++------
 drivers/of/fdt.c  |    4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index e3f7af8..aa80525 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -605,14 +605,14 @@ EXPORT_SYMBOL(of_find_node_by_phandle);
 struct device_node *
 of_parse_phandle(struct device_node *np, const char *phandle_name, int index)
 {
-	const phandle *phandle;
+	const __be32 *phandle;
 	int size;
 
 	phandle = of_get_property(np, phandle_name, &size);
 	if ((!phandle) || (size < sizeof(*phandle) * (index + 1)))
 		return NULL;
 
-	return of_find_node_by_phandle(phandle[index]);
+	return of_find_node_by_phandle(be32_to_cpup(phandle + index));
 }
 EXPORT_SYMBOL(of_parse_phandle);
 
@@ -668,16 +668,16 @@ int of_parse_phandles_with_args(struct device_node *np, const char *list_name,
 
 	while (list < list_end) {
 		const __be32 *cells;
-		const phandle *phandle;
+		phandle phandle;
 
-		phandle = list++;
+		phandle = be32_to_cpup(list++);
 		args = list;
 
 		/* one cell hole in the list = <>; */
-		if (!*phandle)
+		if (!phandle)
 			goto next;
 
-		node = of_find_node_by_phandle(*phandle);
+		node = of_find_node_by_phandle(phandle);
 		if (!node) {
 			pr_debug("%s: could not find phandle\n",
 				 np->full_name);
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index d61fda8..f3a7b4f 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -320,13 +320,13 @@ unsigned long __init unflatten_dt_node(unsigned long mem,
 			if ((strcmp(pname, "phandle") = 0) ||
 			    (strcmp(pname, "linux,phandle") = 0)) {
 				if (np->phandle = 0)
-					np->phandle = *((u32 *)*p);
+					np->phandle = be32_to_cpup((__be32*)*p);
 			}
 			/* And we process the "ibm,phandle" property
 			 * used in pSeries dynamic device tree
 			 * stuff */
 			if (strcmp(pname, "ibm,phandle") = 0)
-				np->phandle = *((u32 *)*p);
+				np->phandle = be32_to_cpup((__be32 *)*p);
 			pp->name = pname;
 			pp->length = sz;
 			pp->value = (void *)*p;

