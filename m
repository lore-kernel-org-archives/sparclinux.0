Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5C44A99B5;
	Tue, 15 Sep 2026 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472254; cv=none; b=Y/ZgMMHdTpFf/bbl3jp8HJxF58rdmRe1wcs1gBeukBUcRkQnhHBEgGbjoM9qWBw6Sx2V61IM8P7eSc0XP3wdV5ZooXKVaIVs6rqhrkOM41hEWvVtZWfEJk+TJ6sc036XYJzFVw16BBUSAWHb3B0ojESK8FFElzNHX7I9NgwKKSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472254; c=relaxed/simple;
	bh=cqNOp0aS6I05gELpjlHXd0owI5nLbJqswEU8UWMTx0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SGcqhBWfmQ/1jcl9pI1uzSoEXhjiksx6be7XdSbRQSJkNIX63Z3gVLVLwGW+vpFgkdFk3qHefNZSL8TJuFcvSMf8sCHIoQui2Q4TuOigiPRhrU+Sm8wdSATZg26DXepli8qOFN83ZpW4OWrAtl7hLK3FnhcJ7k/FMprvu4Cvc3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqnWgCCB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqnWgCCB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022161F000FF;
	Tue, 15 Sep 2026 11:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472253;
	bh=43PF/RCUOZQkJsOOgjTj3NZfqo5RZrpEBnO0+rNiFJE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KqnWgCCBBHbflkUyPO4GlX+NqrkQFoLbpdeV95+70PxGxWdRlCZK2hEFg7AKpGM8d
	 P+sDlo6n6p/oD4DHtw5k4ao1CCny987weMHVwVi57TIzGmedW26EG1RySUo7EUC3wL
	 govHdLEbUVf9mmDt8elYfT7Db4xTVjDVamv4EuP8wsrMfCbgWeOAVYswLv5gav0BOT
	 MlginGpeWoN48Ny0LTtfFlqXOFFO5u4nlES7nGcrAPFHjrQQttsk0uwSQM7UkTulFT
	 MHFUk3iByhyEoh4VP3/GmREzjD3XQ75V+DK8eWFkJXVQmcZAGfPHvBT+mosXjqMwpA
	 YKgxCV7My/uOw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:34 +0200
Subject: [PATCH RFC POC 48/50] misc: fastrpc: install the dma-buf
 descriptor when the ioctl returns
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-48-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
 Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, 
 io-uring@vger.kernel.org, netdev@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 bpf@vger.kernel.org, David Airlie <airlied@redhat.com>, 
 virtualization@lists.linux.dev, kvm@vger.kernel.org, 
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1831; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cqNOp0aS6I05gELpjlHXd0owI5nLbJqswEU8UWMTx0A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KkPYaw+MXnFd73DKesXPFlfMXNFNsPLRZf+RF2XY
 bp6P+0Kb0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBETGQYGSZ8vdT+NFe0bk0l
 +55pTDcfSvjMedPirtK/tvj3rIZKzuUM/8x33i1095DRM+a7Hu9qcGFp07anFQ2bOM4tOR05Zb0
 HOzMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/misc/fastrpc.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 90fd669636ec..24b84019bbd7 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -7,6 +7,7 @@
 #include <linux/dma-buf.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma-resv.h>
+#include <linux/file.h>
 #include <linux/idr.h>
 #include <linux/list.h>
 #include <linux/miscdevice.h>
@@ -1804,6 +1805,7 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 	struct fastrpc_buf *buf = NULL;
 	int err;
+	const struct fd_slot *fd;
 
 	if (copy_from_user(&bp, argp, sizeof(bp)))
 		return -EFAULT;
@@ -1822,23 +1824,16 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
 		return err;
 	}
 
-	bp.fd = dma_buf_fd(buf->dmabuf, O_ACCMODE);
-	if (bp.fd < 0) {
+	fd = fd_prepare(O_ACCMODE);
+	if (IS_ERR(fd)) {
 		dma_buf_put(buf->dmabuf);
 		return -EINVAL;
 	}
+	bp.fd = fd_stage(fd, buf->dmabuf->file);
 
-	if (copy_to_user(argp, &bp, sizeof(bp))) {
-		/*
-		 * The usercopy failed, but we can't do much about it, as
-		 * dma_buf_fd() already called fd_install() and made the
-		 * file descriptor accessible for the current process. It
-		 * might already be closed and dmabuf no longer valid when
-		 * we reach this point. Therefore "leak" the fd and rely on
-		 * the process exit path to do any required cleanup.
-		 */
+	/* The staged file is dropped with its descriptor if this faults. */
+	if (copy_to_user(argp, &bp, sizeof(bp)))
 		return -EFAULT;
-	}
 
 	return 0;
 }

-- 
2.53.0

