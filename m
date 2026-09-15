Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFAA4BFE8D;
	Tue, 15 Sep 2026 11:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472081; cv=none; b=TnW9k8I4elIfamziNMXeAZVV1rfVQnSJjc/jN5hyvbLQtKFpnvYLS8uTZk5RluPfJ7rf0QUZOt6hAhvZop8n64BWYTASNi7azOdd26UfGcrx5jvxEpXtdS5+MeN+kP0vTA+JWTg+SefC00hWfVt+9nbotEZNHv4+5l0taVLXteE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472081; c=relaxed/simple;
	bh=WVbD0pO6d4mjiUvlOLIjL57eEEjsBq56vpsfDeJomcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i5n+hWkgw5sR+znWKq2eg0fIQh06IJa4wmEpCfQtkP6uHHdvDHnFevE3sJMNcGG8oKHaC6Q6FIYzrsw4FByd0vRZsZrb9w40E5zYUrtXeu3gzQlLhRGa6Nm9XH3GbaU+lwz7eSkR55IQxMPRhpYqXUCp64zD+H92hBMaxb0K/ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLbpzRry; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLbpzRry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FDC1F00893;
	Tue, 15 Sep 2026 11:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472079;
	bh=cDPO1Tppu7zGiZS0wqcZiTuTwlavGuE/rjDjnQsBE8E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NLbpzRryDp6dFPNq2d5OJvruDzyZONEFg64LrDUeM5ugsoft5S7pBeG/pH66NE5IL
	 3K1p9eHLYNaeeDaMavKCpdAseqox6l5EnfcT+KopXRUVpAGLpJ9yfjtXkfsEViD35p
	 ADMqHomqefTxla65WmYonAYRk046Vz0TUnURPnhxUASNKqUUkNdFTTmZNpEDsrmsBU
	 6GsRHd/hVex1t+bazl57XSA3/fWSISHGQVrMQ+hQ7z2QElRmXKMZdLoquUEY4uZ9o0
	 wbzzdJN3unzzMqJSYGFB8PGFSj10gPRo7LK7HDW022JXae9+9AS0j5tXO3J4dwtg5G
	 rF8s/BzuCbuwQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:12 +0200
Subject: [PATCH RFC POC 26/50] dma-buf: stop unwinding sync file
 descriptors by hand
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-26-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5768; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WVbD0pO6d4mjiUvlOLIjL57eEEjsBq56vpsfDeJomcY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Klbx7fSV2vzb4mztp+e+U8pjOoJ5RRLmcKaIWU0y
 e1svXhCRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQM9zMyHNVclB75UIUtlMkq
 +oqP/KHwKflt//9e3LImMGbio3sWXQz/448uNWN/83aF2Gujxje/v7ndnOYetv30l/bU9fpNKqo
 7eQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/dma-buf/dma-buf.c   | 33 ++++++++++------------------
 drivers/dma-buf/sw_sync.c   | 40 +++++++++++-----------------------
 drivers/dma-buf/sync_file.c | 52 +++++++++++++--------------------------------
 3 files changed, 38 insertions(+), 87 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index d504c636dc29..f0d581fad7ae 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -440,7 +440,8 @@ static long dma_buf_export_sync_file(struct dma_buf *dmabuf,
 	enum dma_resv_usage usage;
 	struct dma_fence *fence = NULL;
 	struct sync_file *sync_file;
-	int fd, ret;
+	int ret;
+	const struct fd_slot *fd;
 
 	if (copy_from_user(&arg, user_data, sizeof(arg)))
 		return -EFAULT;
@@ -451,14 +452,14 @@ static long dma_buf_export_sync_file(struct dma_buf *dmabuf,
 	if ((arg.flags & DMA_BUF_SYNC_RW) == 0)
 		return -EINVAL;
 
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0)
-		return fd;
+	fd = fd_prepare(O_CLOEXEC);
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
 
 	usage = dma_resv_usage_rw(arg.flags & DMA_BUF_SYNC_WRITE);
 	ret = dma_resv_get_singleton(dmabuf->resv, usage, &fence);
 	if (ret)
-		goto err_put_fd;
+		return ret;
 
 	if (!fence)
 		fence = dma_fence_get_stub();
@@ -467,26 +468,14 @@ static long dma_buf_export_sync_file(struct dma_buf *dmabuf,
 
 	dma_fence_put(fence);
 
-	if (!sync_file) {
-		ret = -ENOMEM;
-		goto err_put_fd;
-	}
-
-	arg.fd = fd;
-	if (copy_to_user(user_data, &arg, sizeof(arg))) {
-		ret = -EFAULT;
-		goto err_put_file;
-	}
+	if (!sync_file)
+		return -ENOMEM;
 
-	fd_install(fd, sync_file->file);
+	arg.fd = fd_stage(fd, sync_file->file);
+	if (copy_to_user(user_data, &arg, sizeof(arg)))
+		return -EFAULT;
 
 	return 0;
-
-err_put_file:
-	fput(sync_file->file);
-err_put_fd:
-	put_unused_fd(fd);
-	return ret;
 }
 
 static long dma_buf_import_sync_file(struct dma_buf *dmabuf,
diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
index 8df20b0218a9..90852950e4e3 100644
--- a/drivers/dma-buf/sw_sync.c
+++ b/drivers/dma-buf/sw_sync.c
@@ -344,8 +344,7 @@ static int sw_sync_debugfs_release(struct inode *inode, struct file *file)
 static long sw_sync_ioctl_create_fence(struct sync_timeline *obj,
 				       unsigned long arg)
 {
-	int fd = get_unused_fd_flags(O_CLOEXEC);
-	int err;
+	const struct fd_slot *fd = fd_prepare(O_CLOEXEC);
 	struct sync_pt *pt;
 	struct sync_file *sync_file;
 	struct sw_sync_create_fence_data data;
@@ -353,41 +352,26 @@ static long sw_sync_ioctl_create_fence(struct sync_timeline *obj,
 	/* SW sync fence are inherently unsafe and can deadlock the kernel */
 	add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
 
-	if (fd < 0)
-		return fd;
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
 
-	if (copy_from_user(&data, (void __user *)arg, sizeof(data))) {
-		err = -EFAULT;
-		goto err;
-	}
+	if (copy_from_user(&data, (void __user *)arg, sizeof(data)))
+		return -EFAULT;
 
 	pt = sync_pt_create(obj, data.value);
-	if (!pt) {
-		err = -ENOMEM;
-		goto err;
-	}
+	if (!pt)
+		return -ENOMEM;
 
 	sync_file = sync_file_create(&pt->base);
 	dma_fence_put(&pt->base);
-	if (!sync_file) {
-		err = -ENOMEM;
-		goto err;
-	}
-
-	data.fence = fd;
-	if (copy_to_user((void __user *)arg, &data, sizeof(data))) {
-		fput(sync_file->file);
-		err = -EFAULT;
-		goto err;
-	}
+	if (!sync_file)
+		return -ENOMEM;
 
-	fd_install(fd, sync_file->file);
+	data.fence = fd_stage(fd, sync_file->file);
+	if (copy_to_user((void __user *)arg, &data, sizeof(data)))
+		return -EFAULT;
 
 	return 0;
-
-err:
-	put_unused_fd(fd);
-	return err;
 }
 
 static long sw_sync_ioctl_inc(struct sync_timeline *obj, unsigned long arg)
diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
index 2166bbdf7e4a..316fffc4067e 100644
--- a/drivers/dma-buf/sync_file.c
+++ b/drivers/dma-buf/sync_file.c
@@ -213,56 +213,34 @@ static __poll_t sync_file_poll(struct file *file, poll_table *wait)
 static long sync_file_ioctl_merge(struct sync_file *sync_file,
 				  unsigned long arg)
 {
-	int fd = get_unused_fd_flags(O_CLOEXEC);
-	int err;
+	const struct fd_slot *fd = fd_prepare(O_CLOEXEC);
 	struct sync_file *fence2, *fence3;
 	struct sync_merge_data data;
 
-	if (fd < 0)
-		return fd;
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
 
-	if (copy_from_user(&data, (void __user *)arg, sizeof(data))) {
-		err = -EFAULT;
-		goto err_put_fd;
-	}
+	if (copy_from_user(&data, (void __user *)arg, sizeof(data)))
+		return -EFAULT;
 
-	if (data.flags || data.pad) {
-		err = -EINVAL;
-		goto err_put_fd;
-	}
+	if (data.flags || data.pad)
+		return -EINVAL;
 
 	fence2 = sync_file_fdget(data.fd2);
-	if (!fence2) {
-		err = -ENOENT;
-		goto err_put_fd;
-	}
+	if (!fence2)
+		return -ENOENT;
 
 	data.name[sizeof(data.name) - 1] = '\0';
 	fence3 = sync_file_merge(data.name, sync_file, fence2);
-	if (!fence3) {
-		err = -ENOMEM;
-		goto err_put_fence2;
-	}
-
-	data.fence = fd;
-	if (copy_to_user((void __user *)arg, &data, sizeof(data))) {
-		err = -EFAULT;
-		goto err_put_fence3;
-	}
-
-	fd_install(fd, fence3->file);
 	fput(fence2->file);
-	return 0;
-
-err_put_fence3:
-	fput(fence3->file);
+	if (!fence3)
+		return -ENOMEM;
 
-err_put_fence2:
-	fput(fence2->file);
+	data.fence = fd_stage(fd, fence3->file);
+	if (copy_to_user((void __user *)arg, &data, sizeof(data)))
+		return -EFAULT;
 
-err_put_fd:
-	put_unused_fd(fd);
-	return err;
+	return 0;
 }
 
 static int sync_fill_fence_info(struct dma_fence *fence,

-- 
2.53.0

