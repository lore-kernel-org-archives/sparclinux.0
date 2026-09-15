Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B604A49B8;
	Tue, 15 Sep 2026 11:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472075; cv=none; b=bft1eQREhWaIbxbmF3/9LOthh6ILcMOQbI0Ii/KCtKAkOKnkv6YEQpMHMjS1ziq4b3qDLgTU4kcCymaQsrHqTxj85PtAtMc8lFqSVbrqF3Eep5BJxv7aFakpeSZzlrfHQXB7rl4MegdzttanAPtwsvnW2HBotuIuSgzZ+sQpHME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472075; c=relaxed/simple;
	bh=rCUeU1oxHG7aERgXlrzAeAZc9EA3kZL/Oa602pXoJ4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=evpOXmedOSl2pn+x4UgAZTY7LOD+ZxA7du64Fa699uOXxnUdu4B4tvjiW4Q3jL4XkGcUeVsoLrkDp2ot5CrUhlADLlZFtsIfqEexh78rjgWorDiNdjpwz4DePb3WoE3iWBk0y5H9Ru0gxa87Hk35clCIt42ytSWQWgaAaU7i8/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVRiMQZE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVRiMQZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7691F00898;
	Tue, 15 Sep 2026 11:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472072;
	bh=uJkokD3f+q1c9pnrp0lbI+TZpmNSabQpiHVaEMwkcXg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gVRiMQZEzNekHg2rAKAlmyX2NEVGR1ZCdc63CV4n6VKSSJvFtAwsA5Q5YnsSZ59aM
	 sBl/nTPM5nGVO9hMzw0QCgO4jZ7KgkQ+751oGBcqTAQwmEE+BmOo8Or9x37jbJLlCh
	 x/Xv21Njc47KpLMHcP+tDPWRQFwlmH/02z/eanZGCii9GABQHqkWDAmTvq/p32qex7
	 wQpF9HLh+wyLJP1m0SqfQBhNbHRllVb1MmJeWPYsSHYzQy73BXNmavRDVVJPgDQDkQ
	 f6iBo3mC/s+rHSITqIpBFUC/Dg1FHDuH2bG6srbP1O8UFhu9kscvBh1hLdHBSYyeXz
	 bds5RQBIfjqYg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:11 +0200
Subject: [PATCH RFC POC 25/50] file: reimplement FD_PREPARE() on the
 deferred fd_prepare() path
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-25-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=23000; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rCUeU1oxHG7aERgXlrzAeAZc9EA3kZL/Oa602pXoJ4E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Klde0duc6nl6/dOu1nuZniGhepapebMPXZY9VLZ7
 EtlOkdXdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzElI/hr4A/Z+IRwd5lR0r6
 NE0SsmwjWAqX81p8uuquoCKVXfz4ECPDnxqnG1panoku6+OTzvDej5lz2uXX7mNONmukt2oJH/7
 OBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The FD_PREPARE() cleanup class allocated and installed immediately and
required fd_publish() to be the last thing that could fail. Reimplement
it on the deferred path. FD_PREPARE() reserves a slot with fd_prepare()
and stages the file on it. The syscall exit installs on success and
drops on error. fd_prepare_fd() and fd_prepare_file() now read the slot.
fd_publish() is gone.

Convert every FD_PREPARE() user since fdf.err can now become a simple
IS_ERR(fdf).

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/powerpc/platforms/cell/spufs/inode.c |  12 +--
 drivers/gpio/gpiolib-cdev.c               |  18 ++--
 drivers/gpu/drm/msm/msm_perfcntr.c        |   6 +-
 drivers/media/mc/mc-request.c             |   6 +-
 drivers/misc/ntsync.c                     |   6 +-
 fs/eventfd.c                              |   6 +-
 fs/eventpoll.c                            |   6 +-
 fs/file.c                                 |  12 +--
 fs/namespace.c                            |  12 +--
 fs/nsfs.c                                 |   6 +-
 fs/xfs/xfs_handle.c                       |   6 +-
 include/linux/file.h                      | 143 ++++--------------------------
 io_uring/mock_file.c                      |   5 +-
 kernel/bpf/bpf_iter.c                     |   6 +-
 kernel/bpf/token.c                        |   6 +-
 mm/userfaultfd.c                          |   6 +-
 net/handshake/netlink.c                   |  20 +++--
 net/kcm/kcmsock.c                         |   5 +-
 18 files changed, 89 insertions(+), 198 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 2b54afb31529..b3e9204e7031 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -266,10 +266,10 @@ spufs_mkdir(struct inode *dir, struct dentry *dentry, unsigned int flags,
 static int spufs_context_open(const struct path *path)
 {
 	FD_PREPARE(fdf, 0, dentry_open(path, O_RDONLY, current_cred()));
-	if (fdf.err)
-		return fdf.err;
+	if (IS_ERR(fdf))
+		return PTR_ERR(fdf);
 	fd_prepare_file(fdf)->f_op = &spufs_context_fops;
-	return fd_publish(fdf);
+	return fd_prepare_fd(fdf);
 }
 
 static struct spu_context *
@@ -499,10 +499,10 @@ static int spufs_gang_open(const struct path *path)
 	 * in error path of *_open().
 	 */
 	FD_PREPARE(fdf, 0, dentry_open(path, O_RDONLY, current_cred()));
-	if (fdf.err)
-		return fdf.err;
+	if (IS_ERR(fdf))
+		return PTR_ERR(fdf);
 	fd_prepare_file(fdf)->f_op = &spufs_gang_fops;
-	return fd_publish(fdf);
+	return fd_prepare_fd(fdf);
 }
 
 static int spufs_create_gang(struct inode *inode,
diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 9f3b628d5793..4d138db25472 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -377,16 +377,14 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 	FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
 		   anon_inode_getfile("gpio-linehandle", &linehandle_fileops,
 				      lh, O_RDONLY | O_CLOEXEC));
-	if (fdf.err)
-		return fdf.err;
+	if (IS_ERR(fdf))
+		return PTR_ERR(fdf);
 	retain_and_null_ptr(lh);
 
 	handlereq.fd = fd_prepare_fd(fdf);
 	if (copy_to_user(ip, &handlereq, sizeof(handlereq)))
 		return -EFAULT;
 
-	fd_publish(fdf);
-
 	dev_dbg(&gdev->dev, "registered chardev handle for %d lines\n",
 		handlereq.lines);
 
@@ -1715,16 +1713,14 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 	FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
 		   anon_inode_getfile("gpio-line", &line_fileops, lr,
 				      O_RDONLY | O_CLOEXEC));
-	if (fdf.err)
-		return fdf.err;
+	if (IS_ERR(fdf))
+		return PTR_ERR(fdf);
 	retain_and_null_ptr(lr);
 
 	ulr.fd = fd_prepare_fd(fdf);
 	if (copy_to_user(ip, &ulr, sizeof(ulr)))
 		return -EFAULT;
 
-	fd_publish(fdf);
-
 	dev_dbg(&gdev->dev, "registered chardev handle for %d lines\n",
 		ulr.num_lines);
 
@@ -2115,16 +2111,14 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
 		   anon_inode_getfile("gpio-event", &lineevent_fileops, le,
 				      O_RDONLY | O_CLOEXEC));
-	if (fdf.err)
-		return fdf.err;
+	if (IS_ERR(fdf))
+		return PTR_ERR(fdf);
 	retain_and_null_ptr(le);
 
 	eventreq.fd = fd_prepare_fd(fdf);
 	if (copy_to_user(ip, &eventreq, sizeof(eventreq)))
 		return -EFAULT;
 
-	fd_publish(fdf);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/msm_perfcntr.c b/drivers/gpu/drm/msm/msm_perfcntr.c
index ce65b1160955..65c067d39ca0 100644
--- a/drivers/gpu/drm/msm/msm_perfcntr.c
+++ b/drivers/gpu/drm/msm/msm_perfcntr.c
@@ -543,8 +543,8 @@ msm_ioctl_perfcntr_config(struct drm_device *dev, void *data, struct drm_file *f
 
 		FD_PREPARE(fdf, O_CLOEXEC,
 			   anon_inode_getfile("[msm_perfcntrs]", &stream_fops, stream, 0));
-		if (fdf.err)
-			return fdf.err;
+		if (IS_ERR(fdf))
+			return PTR_ERR(fdf);
 
 		INIT_WORK(&stream->sel_work, sel_worker);
 		kthread_init_work(&stream->sample_work, sample_worker);
@@ -564,7 +564,7 @@ msm_ioctl_perfcntr_config(struct drm_device *dev, void *data, struct drm_file *f
 
 		msm_perfcntr_resume_locked(perfcntrs->stream);
 
-		stream_fd = fd_publish(fdf);
+		stream_fd = fd_prepare_fd(fdf);
 	} else {
 		kfree(ctx->perfctx);
 		ctx->perfctx = no_free_ptr(perfctx);
diff --git a/drivers/media/mc/mc-request.c b/drivers/media/mc/mc-request.c
index 13e77648807c..c9296bdbee27 100644
--- a/drivers/media/mc/mc-request.c
+++ b/drivers/media/mc/mc-request.c
@@ -316,8 +316,8 @@ int media_request_alloc(struct media_device *mdev, int *alloc_fd)
 	FD_PREPARE(fdf, O_CLOEXEC,
 		   anon_inode_getfile("request", &request_fops, NULL,
 				      O_CLOEXEC));
-	if (fdf.err) {
-		ret = fdf.err;
+	if (IS_ERR(fdf)) {
+		ret = PTR_ERR(fdf);
 		goto err_free_req;
 	}
 
@@ -328,7 +328,7 @@ int media_request_alloc(struct media_device *mdev, int *alloc_fd)
 	atomic_inc(&mdev->num_requests);
 	dev_dbg(mdev->dev, "request: allocated %s\n", req->debug_str);
 
-	*alloc_fd = fd_publish(fdf);
+	*alloc_fd = fd_prepare_fd(fdf);
 
 	return 0;
 
diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 4a805919bb0c..721b0d9f0e1f 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -724,10 +724,10 @@ static int ntsync_obj_get_fd(struct ntsync_obj *obj)
 {
 	FD_PREPARE(fdf, O_CLOEXEC,
 		   anon_inode_getfile("ntsync", &ntsync_obj_fops, obj, O_RDWR));
-	if (fdf.err)
-		return fdf.err;
+	if (IS_ERR(fdf))
+		return PTR_ERR(fdf);
 	obj->file = fd_prepare_file(fdf);
-	return fd_publish(fdf);
+	return fd_prepare_fd(fdf);
 }
 
 static int ntsync_create_sem(struct ntsync_device *dev, void __user *argp)
diff --git a/fs/eventfd.c b/fs/eventfd.c
index 9d33a02757d5..a00fea879f9a 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -403,12 +403,12 @@ static int do_eventfd(unsigned int count, int flags)
 	FD_PREPARE(fdf, flags,
 		   anon_inode_getfile_fmode("[eventfd]", &eventfd_fops, ctx,
 					    flags, FMODE_NOWAIT));
-	if (fdf.err)
-		return fdf.err;
+	if (IS_ERR(fdf))
+		return PTR_ERR(fdf);
 
 	ctx->id = ida_alloc(&eventfd_ida, GFP_KERNEL);
 	retain_and_null_ptr(ctx);
-	return fd_publish(fdf);
+	return fd_prepare_fd(fdf);
 }
 
 SYSCALL_DEFINE2(eventfd2, unsigned int, count, int, flags)
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index e0c4bf88a838..81857725f810 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2514,12 +2514,12 @@ static int do_epoll_create(int flags)
 	FD_PREPARE(fdf, O_RDWR | (flags & O_CLOEXEC),
 		   anon_inode_getfile("[eventpoll]", &eventpoll_fops, ep,
 				      O_RDWR | (flags & O_CLOEXEC)));
-	if (fdf.err) {
+	if (IS_ERR(fdf)) {
 		ep_clear_and_put(ep);
-		return fdf.err;
+		return PTR_ERR(fdf);
 	}
 	ep->file = fd_prepare_file(fdf);
-	return fd_publish(fdf);
+	return fd_prepare_fd(fdf);
 }
 
 SYSCALL_DEFINE1(epoll_create1, int, flags)
diff --git a/fs/file.c b/fs/file.c
index 1f06d0c846c2..7c05246a5129 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -761,26 +761,26 @@ int fd_stage(const struct fd_slot *slot, struct file *file)
 EXPORT_SYMBOL(fd_stage);
 
 /**
- * __fd_slot_fd - the descriptor number of a prepared slot
+ * fd_prepare_fd - the descriptor number of a prepared slot
  * @slot: slot from fd_prepare()
  */
-int __fd_slot_fd(const struct fd_slot *slot)
+int fd_prepare_fd(const struct fd_slot *slot)
 {
 	return ACCESS_PRIVATE(slot, fd);
 }
-EXPORT_SYMBOL(__fd_slot_fd);
+EXPORT_SYMBOL(fd_prepare_fd);
 
 /**
- * __fd_slot_file - the file staged into a slot, to configure before install
+ * fd_prepare_file - the file staged into a slot, to configure before install
  * @slot: slot from fd_prepare()
  *
  * Returns the file handed to fd_stage(), or NULL before one is staged.
  */
-struct file *__fd_slot_file(const struct fd_slot *slot)
+struct file *fd_prepare_file(const struct fd_slot *slot)
 {
 	return ACCESS_PRIVATE(slot, file);
 }
-EXPORT_SYMBOL(__fd_slot_file);
+EXPORT_SYMBOL(fd_prepare_file);
 
 /* Install every staged file, release the slots that never got one. */
 static void fd_slots_install(struct fd_slots *slots)
diff --git a/fs/namespace.c b/fs/namespace.c
index 1ecd96c918b3..fba29bcc0164 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4544,9 +4544,9 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 
 	FD_PREPARE(fdf, (flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC : 0,
 		   dentry_open(&new_path, O_PATH, fc->cred));
-	if (fdf.err) {
+	if (IS_ERR(fdf)) {
 		dissolve_on_fput(new_path.mnt);
-		return fdf.err;
+		return PTR_ERR(fdf);
 	}
 
 	/*
@@ -4554,7 +4554,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 	 * need to unmount it, not just simply put it.
 	 */
 	fd_prepare_file(fdf)->f_mode |= FMODE_NEED_UNMOUNT;
-	return fd_publish(fdf);
+	return fd_prepare_fd(fdf);
 }
 
 static inline int vfs_move_mount(const struct path *from_path,
@@ -5198,8 +5198,8 @@ SYSCALL_DEFINE5(open_tree_attr, int, dfd, const char __user *, filename,
 		return -EINVAL;
 
 	FD_PREPARE(fdf, flags, vfs_open_tree(dfd, filename, flags));
-	if (fdf.err)
-		return fdf.err;
+	if (IS_ERR(fdf))
+		return PTR_ERR(fdf);
 
 	if (uattr) {
 		struct mount_kattr kattr = {};
@@ -5220,7 +5220,7 @@ SYSCALL_DEFINE5(open_tree_attr, int, dfd, const char __user *, filename,
 			return ret;
 	}
 
-	return fd_publish(fdf);
+	return fd_prepare_fd(fdf);
 }
 
 int show_path(struct seq_file *m, struct dentry *root)
diff --git a/fs/nsfs.c b/fs/nsfs.c
index c3b6ae76594a..da021c8b49b2 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -348,8 +348,8 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 			return ret;
 
 		FD_PREPARE(fdf, O_CLOEXEC, dentry_open(&path, O_RDONLY, current_cred()));
-		if (fdf.err)
-			return fdf.err;
+		if (IS_ERR(fdf))
+			return PTR_ERR(fdf);
 		/*
 		 * If @uinfo is passed return all information about the
 		 * mount namespace as well.
@@ -357,7 +357,7 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 		ret = copy_ns_info_to_user(to_mnt_ns(ns), uinfo, usize, &kinfo);
 		if (ret)
 			return ret;
-		ret = fd_publish(fdf);
+		ret = fd_prepare_fd(fdf);
 		break;
 	}
 	default:
diff --git a/fs/xfs/xfs_handle.c b/fs/xfs/xfs_handle.c
index 0689cade8f74..174aa3c8260f 100644
--- a/fs/xfs/xfs_handle.c
+++ b/fs/xfs/xfs_handle.c
@@ -272,8 +272,8 @@ xfs_open_by_handle(
 	path.mnt = mntget(parfilp->f_path.mnt);
 
 	FD_PREPARE(fdf, 0, dentry_open(&path, hreq->oflags, cred));
-	if (fdf.err)
-		return fdf.err;
+	if (IS_ERR(fdf))
+		return PTR_ERR(fdf);
 
 	if (S_ISREG(inode->i_mode)) {
 		struct file *filp = fd_prepare_file(fdf);
@@ -282,7 +282,7 @@ xfs_open_by_handle(
 		filp->f_mode |= FMODE_NOCMTIME;
 	}
 
-	return fd_publish(fdf);
+	return fd_prepare_fd(fdf);
 }
 
 int
diff --git a/include/linux/file.h b/include/linux/file.h
index 1ee7f058a882..45d68e097c05 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -125,8 +125,8 @@ extern void fd_install(unsigned int fd, struct file *file);
 struct fd_slot;
 const struct fd_slot *fd_prepare(unsigned flags);
 int fd_stage(const struct fd_slot *slot, struct file *file);
-int __fd_slot_fd(const struct fd_slot *slot);
-struct file *__fd_slot_file(const struct fd_slot *slot);
+int fd_prepare_fd(const struct fd_slot *slot);
+struct file *fd_prepare_file(const struct fd_slot *slot);
 
 int receive_fd(struct file *file, int __user *ufd, unsigned int o_flags);
 
@@ -137,128 +137,6 @@ extern void __fput_sync(struct file *);
 
 extern unsigned int sysctl_nr_open_min, sysctl_nr_open_max;
 
-/*
- * fd_prepare: Combined fd + file allocation cleanup class.
- * @err: Error code to indicate if allocation succeeded.
- * @__fd: Allocated fd (may not be accessed directly)
- * @__file: Allocated struct file pointer (may not be accessed directly)
- *
- * Allocates an fd and a file together. On error paths, automatically cleans
- * up whichever resource was successfully allocated. Allows flexible file
- * allocation with different functions per usage.
- *
- * Do not use directly.
- */
-struct fd_prepare {
-	s32 err;
-	s32 __fd; /* do not access directly */
-	struct file *__file; /* do not access directly */
-};
-
-/* Typedef for fd_prepare cleanup guards. */
-typedef struct fd_prepare class_fd_prepare_t;
-
-/* Do not use directly. */
-static inline int __fd_prepare_fd_old(struct fd_prepare fdf)
-{
-	return fdf.__fd;
-}
-
-/* Do not use directly. */
-static inline struct file *__fd_prepare_file_old(struct fd_prepare fdf)
-{
-	return fdf.__file;
-}
-
-/*
- * Accessors for a prepared descriptor. _Generic() bridges struct fd_prepare
- * (the cleanup class below) and struct fd_slot (fd_prepare()) while callers are
- * converted; the struct fd_prepare arm goes away with FD_PREPARE().
- */
-#define fd_prepare_fd(_x) _Generic((_x),				\
-	struct fd_prepare:	__fd_prepare_fd_old,			\
-	struct fd_slot *:	__fd_slot_fd,				\
-	const struct fd_slot *:	__fd_slot_fd)(_x)
-
-#define fd_prepare_file(_x) _Generic((_x),				\
-	struct fd_prepare:	__fd_prepare_file_old,			\
-	struct fd_slot *:	__fd_slot_file,				\
-	const struct fd_slot *:	__fd_slot_file)(_x)
-
-/* Do not use directly. */
-static inline void class_fd_prepare_destructor(const struct fd_prepare *fdf)
-{
-	if (unlikely(fdf->__fd >= 0))
-		put_unused_fd(fdf->__fd);
-	if (unlikely(!IS_ERR_OR_NULL(fdf->__file)))
-		fput(fdf->__file);
-}
-
-/* Do not use directly. */
-static inline int class_fd_prepare_lock_err(const struct fd_prepare *fdf)
-{
-	if (unlikely(fdf->err))
-		return fdf->err;
-	if (unlikely(fdf->__fd < 0))
-		return fdf->__fd;
-	if (unlikely(IS_ERR(fdf->__file)))
-		return PTR_ERR(fdf->__file);
-	if (unlikely(!fdf->__file))
-		return -ENOMEM;
-	return 0;
-}
-
-/*
- * __FD_PREPARE_INIT - Helper to initialize fd_prepare class.
- * @_fd_flags: flags for get_unused_fd_flags()
- * @_file_owned: expression that returns struct file *
- *
- * Returns a struct fd_prepare with fd, file, and err set.
- * If fd allocation fails, fd will be negative and err will be set. If
- * fd succeeds but file_init_expr fails, file will be ERR_PTR and err
- * will be set. The err field is the single source of truth for error
- * checking.
- */
-#define __FD_PREPARE_INIT(_fd_flags, _file_owned)                 \
-	({                                                        \
-		struct fd_prepare fdf = {                         \
-			.__fd = get_unused_fd_flags((_fd_flags)), \
-		};                                                \
-		if (likely(fdf.__fd >= 0))                        \
-			fdf.__file = (_file_owned);               \
-		fdf.err = ACQUIRE_ERR(fd_prepare, &fdf);          \
-		fdf;                                              \
-	})
-
-/*
- * FD_PREPARE - Macro to declare and initialize an fd_prepare variable.
- *
- * Declares and initializes an fd_prepare variable with automatic
- * cleanup. No separate scope required - cleanup happens when variable
- * goes out of scope.
- *
- * @_fdf: name of struct fd_prepare variable to define
- * @_fd_flags: flags for get_unused_fd_flags()
- * @_file_owned: struct file to take ownership of (can be expression)
- */
-#define FD_PREPARE(_fdf, _fd_flags, _file_owned) \
-	CLASS_INIT(fd_prepare, _fdf, __FD_PREPARE_INIT(_fd_flags, _file_owned))
-
-/*
- * fd_publish - Publish prepared fd and file to the fd table.
- * @_fdf: struct fd_prepare variable
- */
-#define fd_publish(_fdf)                                       \
-	({                                                     \
-		struct fd_prepare *fdp = &(_fdf);              \
-		VFS_WARN_ON_ONCE(fdp->err);                    \
-		VFS_WARN_ON_ONCE(fdp->__fd < 0);               \
-		VFS_WARN_ON_ONCE(IS_ERR_OR_NULL(fdp->__file)); \
-		fd_install(fdp->__fd, fdp->__file);            \
-		retain_and_null_ptr(fdp->__file);              \
-		take_fd(fdp->__fd);                            \
-	})
-
 /*
  * FD_ADD - allocate a descriptor, build the file and install it in one step.
  * @_fd_flags: flags for get_unused_fd_flags()
@@ -285,4 +163,21 @@ static inline int class_fd_prepare_lock_err(const struct fd_prepare *fdf)
 	__fd;								\
 })
 
+/*
+ * FD_PREPARE - reserve a descriptor and stage @_file_owned on it for the
+ * install at syscall exit; declares @_fdf, an fd_prepare() slot.
+ * @_fdf: name of the const struct fd_slot * to declare
+ * @_fd_flags: flags for get_unused_fd_flags()
+ * @_file_owned: struct file to take ownership of (can be an expression)
+ */
+#define FD_PREPARE(_fdf, _fd_flags, _file_owned)			\
+	const struct fd_slot *_fdf = fd_prepare(_fd_flags);		\
+	if (!IS_ERR(_fdf)) {						\
+		struct file *__file = (_file_owned);			\
+		if (unlikely(IS_ERR_OR_NULL(__file)))			\
+			_fdf = __file ? ERR_CAST(__file) : ERR_PTR(-ENOMEM); \
+		else							\
+			fd_stage(_fdf, __file);				\
+	}
+
 #endif /* __LINUX_FILE_H */
diff --git a/io_uring/mock_file.c b/io_uring/mock_file.c
index b318ed697998..67164c28ed65 100644
--- a/io_uring/mock_file.c
+++ b/io_uring/mock_file.c
@@ -257,8 +257,8 @@ static int io_create_mock_file(struct io_uring_cmd *cmd, unsigned int issue_flag
 	FD_PREPARE(fdf, O_RDWR | O_CLOEXEC,
 		   anon_inode_create_getfile("[io_uring_mock]", fops, mf,
 					     O_RDWR | O_CLOEXEC, NULL));
-	if (fdf.err)
-		return fdf.err;
+	if (IS_ERR(fdf))
+		return PTR_ERR(fdf);
 
 	retain_and_null_ptr(mf);
 	file = fd_prepare_file(fdf);
@@ -271,7 +271,6 @@ static int io_create_mock_file(struct io_uring_cmd *cmd, unsigned int issue_flag
 	if (copy_to_user(uarg, &mc, uarg_size))
 		return -EFAULT;
 
-	fd_publish(fdf);
 	return 0;
 }
 
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 14a5fdfa0421..00edc394101b 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -643,15 +643,15 @@ int bpf_iter_new_fd(struct bpf_link *link)
 	flags = O_RDONLY | O_CLOEXEC;
 
 	FD_PREPARE(fdf, flags, anon_inode_getfile("bpf_iter", &bpf_iter_fops, NULL, flags));
-	if (fdf.err)
-		return fdf.err;
+	if (IS_ERR(fdf))
+		return PTR_ERR(fdf);
 
 	iter_link = container_of(link, struct bpf_iter_link, link);
 	err = prepare_seq_file(fd_prepare_file(fdf), iter_link);
 	if (err)
 		return err; /* Automatic cleanup handles fput */
 
-	return fd_publish(fdf);
+	return fd_prepare_fd(fdf);
 }
 
 struct bpf_prog *bpf_iter_get_info(struct bpf_iter_meta *meta, bool in_stop)
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index e85a179523f0..5cac7fc5694b 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -169,8 +169,8 @@ int bpf_token_create(union bpf_attr *attr)
 	FD_PREPARE(fdf, O_CLOEXEC,
 		   alloc_file_pseudo(inode, path.mnt, BPF_TOKEN_INODE_NAME,
 				     O_RDWR, &bpf_token_fops));
-	if (fdf.err)
-		return fdf.err;
+	if (IS_ERR(fdf))
+		return PTR_ERR(fdf);
 
 	token = kzalloc_obj(*token, GFP_USER);
 	if (!token)
@@ -191,7 +191,7 @@ int bpf_token_create(union bpf_attr *attr)
 
 	get_user_ns(token->userns);
 	fd_prepare_file(fdf)->private_data = no_free_ptr(token);
-	return fd_publish(fdf);
+	return fd_prepare_fd(fdf);
 }
 
 int bpf_token_get_info_by_fd(struct bpf_token *token,
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 23fb68fce000..b5131fc597e6 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -4809,14 +4809,14 @@ static int new_userfaultfd(int flags)
 		   anon_inode_create_getfile("[userfaultfd]", &userfaultfd_fops, ctx,
 					     O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS),
 					     NULL));
-	if (fdf.err)
-		return fdf.err;
+	if (IS_ERR(fdf))
+		return PTR_ERR(fdf);
 
 	/* prevent the mm struct to be freed */
 	mmgrab(ctx->mm);
 	fd_prepare_file(fdf)->f_mode |= FMODE_NOWAIT;
 	retain_and_null_ptr(ctx);
-	return fd_publish(fdf);
+	return fd_prepare_fd(fdf);
 }
 
 static inline bool userfaultfd_syscall_allowed(int flags)
diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 3fd4fef9bab1..98d4266e700e 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -106,19 +106,23 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 	err = -EAGAIN;
 	req = handshake_req_next(hn, class);
 	if (req) {
-		FD_PREPARE(fdf, O_CLOEXEC, req->hr_file);
-		if (fdf.err) {
+		/* The ack carries the error, sendmsg() succeeds: stage last. */
+		const struct fd_slot *fd = fd_prepare(O_CLOEXEC);
+
+		if (IS_ERR(fd)) {
 			fput(req->hr_file); /* drop ref from handshake_req_next() */
-			err = fdf.err;
+			err = PTR_ERR(fd);
 			goto out_complete;
 		}
 
-		err = req->hr_proto->hp_accept(req, info, fd_prepare_fd(fdf));
-		if (err)
-			goto out_complete; /* Automatic cleanup handles fput */
+		err = req->hr_proto->hp_accept(req, info, fd_prepare_fd(fd));
+		if (err) {
+			fput(req->hr_file); /* not staged, drop it by hand */
+			goto out_complete;
+		}
 
-		trace_handshake_cmd_accept(net, req, req->hr_sk, fd_prepare_fd(fdf));
-		fd_publish(fdf);
+		fd_stage(fd, req->hr_file);
+		trace_handshake_cmd_accept(net, req, req->hr_sk, fd_prepare_fd(fd));
 		return 0;
 	}
 
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 71af69d442f2..2d744ee3d340 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1580,14 +1580,13 @@ static int kcm_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		struct kcm_clone info;
 
 		FD_PREPARE(fdf, 0, kcm_clone(sock));
-		if (fdf.err)
-			return fdf.err;
+		if (IS_ERR(fdf))
+			return PTR_ERR(fdf);
 
 		info.fd = fd_prepare_fd(fdf);
 		if (copy_to_user((void __user *)arg, &info, sizeof(info)))
 			return -EFAULT;
 
-		fd_publish(fdf);
 		err = 0;
 		break;
 	}

-- 
2.53.0

