From: Yoann Padioleau <padator@wanadoo.fr>
Date: Fri, 27 Jul 2007 09:45:50 +0000
Subject: [PATCH 17/68] 0 -> NULL, for arch/sparc64
Message-Id: <200707270945.LAA17362@ifs.emn.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org


When comparing a pointer, it's clearer to compare it to NULL than to 0.

Here is an excerpt of the semantic patch: 

@@
expression *E;
@@

  E =
- 0
+ NULL

@@
expression *E;
@@

  E !- 0
+ NULL

Signed-off-by: Yoann Padioleau <padator@wanadoo.fr>
Cc: davem@davemloft.net
Cc: sparclinux@vger.kernel.org
Cc: akpm@linux-foundation.org
---

 kernel/prom.c |    2 +-
 prom/tree.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc64/kernel/prom.c b/arch/sparc64/kernel/prom.c
index f4e0a9a..35d4eb5 100644
--- a/arch/sparc64/kernel/prom.c
+++ b/arch/sparc64/kernel/prom.c
@@ -38,7 +38,7 @@ struct device_node *of_find_node_by_phan
 {
 	struct device_node *np;
 
-	for (np = allnodes; np != 0; np = np->allnext)
+	for (np = allnodes; np != NULL; np = np->allnext)
 		if (np->node = handle)
 			break;
 
diff --git a/arch/sparc64/prom/tree.c b/arch/sparc64/prom/tree.c
index b2c5b12..33eacd0 100644
--- a/arch/sparc64/prom/tree.c
+++ b/arch/sparc64/prom/tree.c
@@ -264,7 +264,7 @@ prom_setprop(int node, const char *pname
 {
 	if (size = 0)
 		return 0;
-	if ((pname = 0) || (value = 0))
+	if ((pname = NULL) || (value = NULL))
 		return 0;
 	
 #ifdef CONFIG_SUN_LDOMS

