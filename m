From: David Miller <davem@davemloft.net>
Date: Tue, 18 Jul 2006 05:08:52 +0000
Subject: Re: sparc32 BUG_ON sparc_cpu_model
Message-Id: <20060717.220852.43218555.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.10.10607101933080.4657-200000@coalcreekmill.cm.com>
In-Reply-To: <Pine.LNX.4.10.10607101933080.4657-200000@coalcreekmill.cm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Raymond Burns <rayburns@comcast.net>
Date: Tue, 11 Jul 2006 13:53:12 -0700 (PDT)

> My mistake, without the changes to sun4d_smp.c the first post makes no
> sense, sorry. I attached the current changes (without debug stuff)
> that I have been using, summarized as minor modifications to the
> changes you made for the sun4m architecture.
> 
> I encourage the switch inleu of the "if nest". Accounting for each
> subarchitecture and providing a BUG rather then wandering through
> inapropriate code helped me find my way.

Raymond, I applied most of your work here as-is, except for
the devices.c change which I decided to implement somewhat
inline with what sparc64 does.  My version of the change is
below.

Thanks.

diff-tree c37067111d91b31501f16ee234850c9a32185746 (from 2ab88a4a40ed06d9454a1fcff2216b4ad67973e2)
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Mon Jul 17 21:49:58 2006 -0700

    [SPARC]: Simplify and correct __cpu_find_by()
    
    By using for_each_node_by_type().
    
    Also, correct a spurioud test in check_cpu_node() on sparc64.
    It is only called with nodes that have device_type "cpu".
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc/kernel/devices.c b/arch/sparc/kernel/devices.c
index adba9df..af90a5f 100644
--- a/arch/sparc/kernel/devices.c
+++ b/arch/sparc/kernel/devices.c
@@ -15,6 +15,7 @@
 
 #include <asm/page.h>
 #include <asm/oplib.h>
+#include <asm/prom.h>
 #include <asm/smp.h>
 #include <asm/system.h>
 #include <asm/cpudata.h>
@@ -34,12 +35,6 @@ static int check_cpu_node(int nd, int *c
 			  int (*compare)(int, int, void *), void *compare_arg,
 			  int *prom_node, int *mid)
 {
-	char node_str[128];
-
-	prom_getstring(nd, "device_type", node_str, sizeof(node_str));
-	if (strcmp(node_str, "cpu"))
-		return -ENODEV;
-	
 	if (!compare(nd, *cur_inst, compare_arg)) {
 		if (prom_node)
 			*prom_node = nd;
@@ -59,20 +54,14 @@ static int check_cpu_node(int nd, int *c
 static int __cpu_find_by(int (*compare)(int, int, void *), void *compare_arg,
 			 int *prom_node, int *mid)
 {
-	int nd, cur_inst, err;
+	struct device_node *dp;
+	int cur_inst;
 
-	nd = prom_root_node;
 	cur_inst = 0;
-
-	err = check_cpu_node(nd, &cur_inst, compare, compare_arg,
-			     prom_node, mid);
-	if (!err)
-		return 0;
-
-	nd = prom_getchild(nd);
-	while ((nd = prom_getsibling(nd)) != 0) {
-		err = check_cpu_node(nd, &cur_inst, compare, compare_arg,
-				     prom_node, mid);
+	for_each_node_by_type(dp, "cpu") {
+		int err = check_cpu_node(dp->node, &cur_inst,
+					 compare, compare_arg,
+					 prom_node, mid);
 		if (!err)
 			return 0;
 	}
diff --git a/arch/sparc64/kernel/devices.c b/arch/sparc64/kernel/devices.c
index f8ef2f2..ec10f7e 100644
--- a/arch/sparc64/kernel/devices.c
+++ b/arch/sparc64/kernel/devices.c
@@ -66,9 +66,6 @@ static int check_cpu_node(struct device_
 			  void *compare_arg,
 			  struct device_node **dev_node, int *mid)
 {
-	if (strcmp(dp->type, "cpu"))
-		return -ENODEV;
-
 	if (!compare(dp, *cur_inst, compare_arg)) {
 		if (dev_node)
 			*dev_node = dp;
