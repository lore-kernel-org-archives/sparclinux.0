From: Thomas Meyer <thomas@m3y3r.de>
Date: Thu, 17 Nov 2011 22:43:40 +0000
Subject: [PATCH] sparc: Use kmemdup rather than duplicating its
Message-Id: <1321569820.1624.274.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

The semantic patch that makes this change is available
in scripts/coccinelle/api/memdup.cocci.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
--- a/arch/sparc/kernel/ds.c 2011-11-07 19:37:36.613113011 +0100
+++ b/arch/sparc/kernel/ds.c 2011-11-08 11:00:49.874125928 +0100
@@ -1181,13 +1181,11 @@ static int __devinit ds_probe(struct vio
 
 	dp->rcv_buf_len = 4096;
 
-	dp->ds_states = kzalloc(sizeof(ds_states_template),
-				GFP_KERNEL);
+	dp->ds_states = kmemdup(ds_states_template,
+				sizeof(ds_states_template), GFP_KERNEL);
 	if (!dp->ds_states)
 		goto out_free_rcv_buf;
 
-	memcpy(dp->ds_states, ds_states_template,
-	       sizeof(ds_states_template));
 	dp->num_ds_states = ARRAY_SIZE(ds_states_template);
 
 	for (i = 0; i < dp->num_ds_states; i++)
diff -u -p a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_common.c
--- a/arch/sparc/kernel/prom_common.c 2011-11-07 19:39:05.191125118 +0100
+++ b/arch/sparc/kernel/prom_common.c 2011-11-08 11:00:52.007487860 +0100
@@ -58,12 +58,10 @@ int of_set_property(struct device_node *
 	void *new_val;
 	int err;
 
-	new_val = kmalloc(len, GFP_KERNEL);
+	new_val = kmemdup(val, len, GFP_KERNEL);
 	if (!new_val)
 		return -ENOMEM;
 
-	memcpy(new_val, val, len);
-
 	err = -ENODEV;
 
 	mutex_lock(&of_set_property_mutex);
