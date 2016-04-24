From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 24 Apr 2016 13:34:27 +0000
Subject: [PATCH] openprom: fix uninitialized warnings
Message-Id: <20160424133427.GA14070@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 24 Apr 2016 15:24:33 +0200
Subject: [PATCH 1/1] openprom: fix warning

Fix following warnings:
openprom.c:510:2: warning: 'tmp' may be used uninitialized in this function [-Wmaybe-uninitialized]
openprom.c:503:3: warning: 'str' may be used uninitialized in this function [-Wmaybe-uninitialized]
openprom.c:459:8: warning: 'str' may be used uninitialized in this function [-Wmaybe-uninitialized]
openprom.c:422:7: warning: 'str' may be used uninitialized in this function [-Wmaybe-uninitialized]

Fixed by introducing PTR_ERR etc.
This simplified the code as a nice side effect.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/sbus/char/openprom.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

Build tested only!

	Sam


diff --git a/drivers/sbus/char/openprom.c b/drivers/sbus/char/openprom.c
index e077ebd..4612691 100644
--- a/drivers/sbus/char/openprom.c
+++ b/drivers/sbus/char/openprom.c
@@ -383,20 +383,12 @@ static struct device_node *get_node(phandle n, DATA *data)
 }
 
 /* Copy in a whole string from userspace into kernelspace. */
-static int copyin_string(char __user *user, size_t len, char **ptr)
+static char * copyin_string(char __user *user, size_t len)
 {
-	char *tmp;
-
 	if ((ssize_t)len < 0 || (ssize_t)(len + 1) < 0)
-		return -EINVAL;
-
-	tmp = memdup_user_nul(user, len);
-	if (IS_ERR(tmp))
-		return PTR_ERR(tmp);
+		return ERR_PTR(-EINVAL);
 
-	*ptr = tmp;
-
-	return 0;
+	return memdup_user_nul(user, len);
 }
 
 /*
@@ -415,9 +407,9 @@ static int opiocget(void __user *argp, DATA *data)
 
 	dp = get_node(op.op_nodeid, data);
 
-	err = copyin_string(op.op_name, op.op_namelen, &str);
-	if (err)
-		return err;
+	str = copyin_string(op.op_name, op.op_namelen);
+	if (IS_ERR(str))
+		return PTR_ERR(str);
 
 	pval = of_get_property(dp, str, &len);
 	err = 0;
@@ -440,7 +432,7 @@ static int opiocnextprop(void __user *argp, DATA *data)
 	struct device_node *dp;
 	struct property *prop;
 	char *str;
-	int err, len;
+	int len;
 
 	if (copy_from_user(&op, argp, sizeof(op)))
 		return -EFAULT;
@@ -449,9 +441,9 @@ static int opiocnextprop(void __user *argp, DATA *data)
 	if (!dp)
 		return -EINVAL;
 
-	err = copyin_string(op.op_name, op.op_namelen, &str);
-	if (err)
-		return err;
+	str = copyin_string(op.op_name, op.op_namelen);
+	if (IS_ERR(str))
+		return PTR_ERR(str);
 
 	if (str[0] = '\0') {
 		prop = dp->properties;
@@ -494,14 +486,14 @@ static int opiocset(void __user *argp, DATA *data)
 	if (!dp)
 		return -EINVAL;
 
-	err = copyin_string(op.op_name, op.op_namelen, &str);
-	if (err)
-		return err;
+	str = copyin_string(op.op_name, op.op_namelen);
+	if (IS_ERR(str))
+		return PTR_ERR(str);
 
-	err = copyin_string(op.op_buf, op.op_buflen, &tmp);
-	if (err) {
+	tmp = copyin_string(op.op_buf, op.op_buflen);
+	if (IS_ERR(tmp)) {
 		kfree(str);
-		return err;
+		return PTR_ERR(tmp);
 	}
 
 	err = of_set_property(dp, str, tmp, op.op_buflen);
-- 
1.8.3.1

