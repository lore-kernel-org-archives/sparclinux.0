From: David Miller <davem@davemloft.net>
Date: Mon, 12 May 2008 22:39:48 +0000
Subject: Re: [BUG] 2.6.26-rc1 lost half the RAM on UltraSPARC 5
Message-Id: <20080512.153948.193688062.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <18472.38209.615770.265421@alkaid.it.uu.se>
	<20080512.153143.48741227.davem@davemloft.net>
	<20080512.153628.193699676.davem@davemloft.net>
In-Reply-To: <20080512.153628.193699676.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Mon, 12 May 2008 15:36:28 -0700 (PDT)

> Nevermind I see why the messages don't show up.  Hold on for a second
> and I'll send an updated debugging patch.

Try this patch instead, thanks!

diff --git a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
index a9828d7..a628a99 100644
--- a/arch/sparc64/mm/init.c
+++ b/arch/sparc64/mm/init.c
@@ -1353,6 +1353,8 @@ static void __init bootmem_init_one_node(int nid)
 
 	numadbg("bootmem_init_one_node(%d)\n", nid);
 
+	lmb_dump_all();
+
 	p = NODE_DATA(nid);
 
 	if (p->node_spanned_pages) {
diff --git a/lib/lmb.c b/lib/lmb.c
index 83287d3..f294bbc 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -10,6 +10,8 @@
  *      2 of the License, or (at your option) any later version.
  */
 
+#define DEBUG
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/bitops.h>
@@ -29,7 +31,7 @@ void lmb_dump_all(void)
 	pr_debug("    memory.size		  = 0x%llx\n",
 	    (unsigned long long)lmb.memory.size);
 	for (i=0; i < lmb.memory.cnt ;i++) {
-		pr_debug("    memory.region[0x%x].base       = 0x%llx\n",
+		pr_debug("    memory.region[0x%lx].base       = 0x%llx\n",
 		    i, (unsigned long long)lmb.memory.region[i].base);
 		pr_debug("		      .size     = 0x%llx\n",
 		    (unsigned long long)lmb.memory.region[i].size);
@@ -38,7 +40,7 @@ void lmb_dump_all(void)
 	pr_debug("    reserved.cnt	  = 0x%lx\n", lmb.reserved.cnt);
 	pr_debug("    reserved.size	  = 0x%lx\n", lmb.reserved.size);
 	for (i=0; i < lmb.reserved.cnt ;i++) {
-		pr_debug("    reserved.region[0x%x].base       = 0x%llx\n",
+		pr_debug("    reserved.region[0x%lx].base       = 0x%llx\n",
 		    i, (unsigned long long)lmb.reserved.region[i].base);
 		pr_debug("		      .size     = 0x%llx\n",
 		    (unsigned long long)lmb.reserved.region[i].size);
