From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Tue, 09 May 2006 21:05:26 +0000
Subject: Re: [PATCH] sparc: fix warning on prom_getproperty in openprom.c
Message-Id: <20060509210526.GA11017@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <20060507152450.GA3426@palantir8>
In-Reply-To: <20060507152450.GA3426@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, May 07, 2006 at 11:03:32PM -0700, David S. Miller wrote:
> From: Martin Habets <errandir_news@mph.eclipse.co.uk>
> Date: Sun, 7 May 2006 16:24:50 +0100
> 
> > This patch resolves the following build warnings seen in 2.6.17-rc3:
> > drivers/sbus/char/openprom.c:395: warning: ignoring return value of `prom_getproperty', declared with attribute warn_unused_result
> > 
> > Please apply.
> > Martin
> > 
> > 	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
> 
> The intention is correct but if we get an error from
> prom_getproperty() then -EFAULT is not likely the appropiate thing to
> return.  Perhaps -EINVAL or something like that.

Seems like a hypothetical case to me, since the code just did a prom_getproplen()
a few lines before. It makes the patch a bit bigger.

-- 
Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

--- 2.6.17-rc3/drivers/sbus/char/openprom.c.orig	2006-05-06 18:48:44.000000000 +0100
+++ 2.6.17-rc3/drivers/sbus/char/openprom.c	2006-05-09 21:52:14.000000000 +0100
@@ -392,13 +392,16 @@
 			return -ENOMEM;
 		}
 
-		prom_getproperty(op.op_nodeid, str, tmp, len);
-
-		tmp[len] = '\0';
+		cnt = prom_getproperty(op.op_nodeid, str, tmp, len);
+		if (cnt <= 0) {
+			error = -EINVAL;
+		} else {
+			tmp[len] = '\0';
 
-		if (__copy_to_user(argp, &op, sizeof(op)) != 0
-		    || copy_to_user(op.op_buf, tmp, len) != 0)
-			error = -EFAULT;
+			if (__copy_to_user(argp, &op, sizeof(op)) != 0 ||
+			    copy_to_user(op.op_buf, tmp, len) != 0)
+				error = -EFAULT;
+		}
 
 		kfree(tmp);
 		kfree(str);
