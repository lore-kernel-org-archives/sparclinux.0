Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8972146AA94;
	Tue, 15 Sep 2026 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472209; cv=none; b=PgpVdkSKTccTXs+GgOARI5XljZm3CMZr7T7BmSHLW7FQ+k+bPoGvjgxfx3kl4gsV7MUuQGjwwD8UDb1Wbi9cubWZjt3h3AbIjRnxz0d4AsGOQCZKBvgoGMocYKQVl5WzTMrSdpUHoKoRBwDD01VqjD3h6n+bAWTDc5p0AUXHTDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472209; c=relaxed/simple;
	bh=KjXekIWfPavjYonIGQ+ziJSd2VL98XtdFHe2kliVlr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ofV6sZcpTLXiYnehRtG91nKReBh/kU9QzvndkIUldrb6zO6hSy54y3ELc+2qaBaAaX4qrh7ZSTB3s+IBEphBA7RXcpO6g5EXcl7rLs+jQd15EI8Q5f45Lv5cGIcE2lrr8rtboDLLKiADLEzC3sNyhaxcKiH9xFYK2hvSzvQDDzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0B0nnun; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0B0nnun"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA9E1F0089A;
	Tue, 15 Sep 2026 11:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472206;
	bh=Ja/detmDRdqJionOE2YxTutvZMYrfmHVqKWhc7op5z8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=k0B0nnunmsO4k0FOMQGSFMJINyyKujE8uhdGQkypzo+/7wAuYosHeieRrqGX896SE
	 jv0+jbulb9ltALO0OmQ+EsdlJ6gIA3nXbRVbRqClon2eDQSEkEs0SGUl1pccz2t0gn
	 Ex/7MGoP0rovVhh+JefOEeLJ+Zg+ArPzBOp7WhZLTZcsHHkAtRMmn/t7nzcxeX6A71
	 wPF3zcOYfiVH5XAccqGogPi1JWYEwXqpaR4pa24KyQ3/325SMh3HSC93eSuO+sogfB
	 azvVwpsOVoq7c+CuSQTvf0zUpuwC034v8JGqti42vDt/NRF7mUFTkRmt14V+qwNO3P
	 E+iZSoWuXbX/A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:28 +0200
Subject: [PATCH RFC POC 42/50] drm: stop unwinding descriptors by hand
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-42-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5076; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KjXekIWfPavjYonIGQ+ziJSd2VL98XtdFHe2kliVlr0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KnXXtVVltWkLiD/9M6kwpRagVX3n83QkfpTd8T79
 sbDSqcedJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkpAYjw8uMrzI/Gn0vNR6b
 r3KTrUSUt6VhVQNj8CEPxi8OCwpPBTAy7OGWebTYilF9c4qm0KsLrb/vrOaMmT1nzfvnFkpaHbe
 TeQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/gpu/drm/drm_lease.c   | 20 +++++++++-----------
 drivers/gpu/drm/drm_prime.c   | 13 +++++--------
 drivers/gpu/drm/drm_syncobj.c | 44 +++++++++++++------------------------------
 3 files changed, 27 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index 5d2cf724cbd7..b95747cf79a7 100644
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -484,7 +484,7 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 	struct file *lessee_file = NULL;
 	struct file *lessor_file = lessor_priv->filp;
 	struct drm_file *lessee_priv;
-	int fd = -1;
+	const struct fd_slot *fd;
 	uint32_t *object_ids;
 
 	/* Can't lease without MODESET */
@@ -529,10 +529,10 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 	}
 
 	/* Allocate a file descriptor for the lease */
-	fd = get_unused_fd_flags(cl->flags & (O_CLOEXEC | O_NONBLOCK));
-	if (fd < 0) {
+	fd = fd_prepare(cl->flags & (O_CLOEXEC | O_NONBLOCK));
+	if (IS_ERR(fd)) {
 		idr_destroy(&leases);
-		ret = fd;
+		ret = PTR_ERR(fd);
 		goto out_lessor;
 	}
 
@@ -543,7 +543,7 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 	if (IS_ERR(lessee)) {
 		ret = PTR_ERR(lessee);
 		idr_destroy(&leases);
-		goto out_leases;
+		goto out_lessor;
 	}
 
 	/* Clone the lessor file to create a new file for us */
@@ -562,12 +562,13 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 	lessee_priv->authenticated = 1;
 
 	/* Pass fd back to userspace */
-	drm_dbg_lease(dev, "Returning fd %d id %d\n", fd, lessee->lessee_id);
-	cl->fd = fd;
+	drm_dbg_lease(dev, "Returning fd %d id %d\n", fd_prepare_fd(fd),
+		      lessee->lessee_id);
+	cl->fd = fd_prepare_fd(fd);
 	cl->lessee_id = lessee->lessee_id;
 
 	/* Hook up the fd */
-	fd_install(fd, lessee_file);
+	fd_stage(fd, lessee_file);
 
 	drm_master_put(&lessor);
 	drm_dbg_lease(dev, "drm_mode_create_lease_ioctl succeeded\n");
@@ -576,9 +577,6 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 out_lessee:
 	drm_master_put(&lessee);
 
-out_leases:
-	put_unused_fd(fd);
-
 out_lessor:
 	drm_master_put(&lessor);
 	drm_dbg_lease(dev, "drm_mode_create_lease_ioctl failed: %d\n", ret);
diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 9b44c78cd77f..e33d84ac7256 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -513,19 +513,16 @@ int drm_gem_prime_handle_to_fd(struct drm_device *dev,
 			       int *prime_fd)
 {
 	struct dma_buf *dmabuf;
-	int fd = get_unused_fd_flags(flags);
+	const struct fd_slot *fd = fd_prepare(flags);
 
-	if (fd < 0)
-		return fd;
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
 
 	dmabuf = drm_gem_prime_handle_to_dmabuf(dev, file_priv, handle, flags);
-	if (IS_ERR(dmabuf)) {
-		put_unused_fd(fd);
+	if (IS_ERR(dmabuf))
 		return PTR_ERR(dmabuf);
-	}
 
-	fd_install(fd, dmabuf->file);
-	*prime_fd = fd;
+	*prime_fd = fd_stage(fd, dmabuf->file);
 	return 0;
 }
 EXPORT_SYMBOL(drm_gem_prime_handle_to_fd);
diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 2fa170a29a62..621858b6ac43 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -663,25 +663,14 @@ static const struct file_operations drm_syncobj_file_fops = {
  */
 int drm_syncobj_get_fd(struct drm_syncobj *syncobj, int *p_fd)
 {
-	struct file *file;
-	int fd;
-
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-
-	file = anon_inode_getfile("syncobj_file",
-				  &drm_syncobj_file_fops,
-				  syncobj, 0);
-	if (IS_ERR(file)) {
-		put_unused_fd(fd);
-		return PTR_ERR(file);
-	}
+	FD_PREPARE(fdf, O_CLOEXEC,
+		   anon_inode_getfile("syncobj_file", &drm_syncobj_file_fops,
+				      syncobj, 0));
+	if (IS_ERR(fdf))
+		return PTR_ERR(fdf);
 
 	drm_syncobj_get(syncobj);
-	fd_install(fd, file);
-
-	*p_fd = fd;
+	*p_fd = fd_prepare_fd(fdf);
 	return 0;
 }
 EXPORT_SYMBOL(drm_syncobj_get_fd);
@@ -762,31 +751,24 @@ static int drm_syncobj_export_sync_file(struct drm_file *file_private,
 	int ret;
 	struct dma_fence *fence;
 	struct sync_file *sync_file;
-	int fd = get_unused_fd_flags(O_CLOEXEC);
+	const struct fd_slot *fd = fd_prepare(O_CLOEXEC);
 
-	if (fd < 0)
-		return fd;
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
 
 	ret = drm_syncobj_find_fence(file_private, handle, point, 0, &fence);
 	if (ret)
-		goto err_put_fd;
+		return ret;
 
 	sync_file = sync_file_create(fence);
 
 	dma_fence_put(fence);
 
-	if (!sync_file) {
-		ret = -EINVAL;
-		goto err_put_fd;
-	}
-
-	fd_install(fd, sync_file->file);
+	if (!sync_file)
+		return -EINVAL;
 
-	*p_fd = fd;
+	*p_fd = fd_stage(fd, sync_file->file);
 	return 0;
-err_put_fd:
-	put_unused_fd(fd);
-	return ret;
 }
 /**
  * drm_syncobj_open - initializes syncobj file-private structures at devnode open time

-- 
2.53.0

