Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33354AA1C9;
	Tue, 15 Sep 2026 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472272; cv=none; b=Bmi1QF0kGmP9EWutiRQzW3rbXH0WkHqv4z0fW7v6QafB7vc3Q8ew9aq1DCz0hfqAkMBp+QOYw3S3Jv23pN0sVZNnLPk29TSwk2RMN51vZ1a4SDpHPQm96SV//xDM2k8AULAtQ53xJSIHRwdM4jH/biN0qDZb2rAQhA9V/ck8vkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472272; c=relaxed/simple;
	bh=SzeXPqGJtllJZEGwqHGcwxzZWYTunmeJfrbckytXGkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hAmzsmQHbiXSBSUSw4WoHKrV+SZJ/Tv1qNl6BFZpxOKMVuREZL0BU9W219DwbKcmjNFn4/yAOLd4FAS7M7vTeJ33mJZsSaqdtp4CFP2p8qd+iI5H5wd767bBpEomv6qRWhrqtJXDxQKqFepvelXGLbuoriS49Sc1DzQ+jMBtiLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIsDG6ms; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIsDG6ms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE2E1F00898;
	Tue, 15 Sep 2026 11:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472269;
	bh=GNDTkXQI7mGdcVaT7SDrw9M8MIqod2XUSoHG2zw3J2w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nIsDG6msZxm9ifdIIaNBb4DSvDwZjxBexDpBy0k5+c0EEQRfRNHCnvgHTIY4Q0gZ4
	 5Y4GAqy+82PffLbcvJlnpDdJKam2a1RZ/lmTtWzv5yc2Qa3CGs1EC2lgotUwdrCtPN
	 R+e8tN55H2q/lzjefH/7MqxCwUMd/aRzXVOqaq/JIPnIQz/fh1lk4mDieRcetKm0Vz
	 We6QD5SZZpeWs1skjtjC95uTXtri2f8p0027MOwC2PJ2AtBz1eyxEa8oFwDdJ/4IbQ
	 1oi4l5RBwZ4QhEmCd9i4/Ab6QCou55Lo2D/xSrTRR5npBOhYvLPf8mp8Z+7okOyPo6
	 hMky5BV0f8Xcg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:36 +0200
Subject: [PATCH RFC POC 50/50] Drivers: hv: mshv: stop putting descriptors
 back on failure
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-50-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3018; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SzeXPqGJtllJZEGwqHGcwxzZWYTunmeJfrbckytXGkI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KmPkjZIUeG9e+1R07epv8QvrSgMsrt/1D2tpUnF+
 Ty/n9jUjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlo3mb4Hx4+8+W/E5svyCgt
 bpvwatmUgujlCXflfc2DLyvdmH/HYCPDH44Jiw0OZie7VZtm8ZzaXLrdzmx2uNpNg59n94iEL7/
 iyAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/hv/mshv_root_main.c | 27 +++++++--------------------
 drivers/hv/mshv_vtl_main.c  | 20 +++++---------------
 2 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index cc2cfce2aefd..c95cee0bae85 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1072,8 +1072,6 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	struct mshv_vp *vp;
 	struct page *intercept_msg_page, *register_page, *ghcb_page;
 	struct hv_stats_page *stats_pages[2];
-	struct file *file;
-	int fd;
 	long ret;
 
 	if (copy_from_user(&args, arg, sizeof(args)))
@@ -1148,19 +1146,14 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	if (ret)
 		goto put_partition;
 
-	fd = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
-	if (fd < 0) {
-		ret = fd;
+	FD_PREPARE(fdf, O_RDWR | O_CLOEXEC,
+		   anon_inode_getfile("mshv_vp", &mshv_vp_fops, vp,
+				      O_RDWR | O_CLOEXEC));
+	if (IS_ERR(fdf)) {
+		ret = PTR_ERR(fdf);
 		goto remove_debugfs_vp;
 	}
 
-	file = anon_inode_getfile("mshv_vp", &mshv_vp_fops, vp,
-				  O_RDWR | O_CLOEXEC);
-	if (IS_ERR(file)) {
-		ret = PTR_ERR(file);
-		goto put_unused_vp_fd;
-	}
-
 	/* already exclusive with the partition mutex for all ioctls */
 	partition->pt_vp_count++;
 	/*
@@ -1171,17 +1164,11 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	 */
 	smp_store_release(&partition->pt_vp_array[args.vp_index], vp);
 
-	/*
-	 * fd_install() is the userspace-visibility commit point.  Must be the
-	 * last operation that can fail or be observed.
-	 */
-	fd_install(fd, file);
-	ret = fd;
+	/* The syscall exit installs the file; nothing after this can fail. */
+	ret = fd_prepare_fd(fdf);
 
 	goto out;
 
-put_unused_vp_fd:
-	put_unused_fd(fd);
 remove_debugfs_vp:
 	mshv_debugfs_vp_remove(vp);
 put_partition:
diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index 6e3c11c68171..f14203d76da1 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -114,29 +114,19 @@ static long
 mshv_ioctl_create_vtl(void __user *user_arg, struct device *module_dev)
 {
 	struct mshv_vtl *vtl;
-	struct file *file;
-	int fd;
 
 	vtl = kzalloc_obj(*vtl);
 	if (!vtl)
 		return -ENOMEM;
 
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0) {
-		kfree(vtl);
-		return fd;
-	}
-	file = anon_inode_getfile("mshv_vtl", &mshv_vtl_fops,
-				  vtl, O_RDWR);
-	if (IS_ERR(file)) {
-		put_unused_fd(fd);
+	FD_PREPARE(fdf, O_CLOEXEC,
+		   anon_inode_getfile("mshv_vtl", &mshv_vtl_fops, vtl, O_RDWR));
+	if (IS_ERR(fdf)) {
 		kfree(vtl);
-		return PTR_ERR(file);
+		return PTR_ERR(fdf);
 	}
 	vtl->module_dev = module_dev;
-	fd_install(fd, file);
-
-	return fd;
+	return fd_prepare_fd(fdf);
 }
 
 static long

-- 
2.53.0

