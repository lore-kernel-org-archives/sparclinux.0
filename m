From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sun, 07 May 2006 15:24:50 +0000
Subject: [PATCH] sparc: fix warning on prom_getproperty in openprom.c
Message-Id: <20060507152450.GA3426@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch resolves the following build warnings seen in 2.6.17-rc3:
drivers/sbus/char/openprom.c:395: warning: ignoring return value of `prom_getproperty', declared with attribute warn_unused_result

Please apply.
Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
---

--- 2.6.17-rc3/drivers/sbus/char/openprom.c.orig	2006-05-06 18:48:44.000000000 +0100
+++ 2.6.17-rc3/drivers/sbus/char/openprom.c	2006-05-06 18:59:40.000000000 +0100
@@ -392,12 +392,13 @@
 			return -ENOMEM;
 		}
 
-		prom_getproperty(op.op_nodeid, str, tmp, len);
+		error = prom_getproperty(op.op_nodeid, str, tmp, len);
 
 		tmp[len] = '\0';
 
-		if (__copy_to_user(argp, &op, sizeof(op)) != 0
-		    || copy_to_user(op.op_buf, tmp, len) != 0)
+		if ((error <= 0) ||
+		    __copy_to_user(argp, &op, sizeof(op)) != 0 ||
+		    copy_to_user(op.op_buf, tmp, len) != 0)
 			error = -EFAULT;
 
 		kfree(tmp);
