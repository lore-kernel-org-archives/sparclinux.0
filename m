Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EB64C4F76;
	Tue, 15 Sep 2026 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472090; cv=none; b=pWeB3nPdEpEyxX+wX8VI0eaN/70CO4wJ/SsJ68glcPe+TwkqyB5eW1/UJXopOOpFJZk+n3LGyxHO6O1tZvMe9OCNV6FlMxeqv3FUrhNfAr8yCY93hLwfMGT3S2VT23U3TJxn2Y8qxHDsF0iprub65hK4M2fkhV6a0MLrev/Z1rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472090; c=relaxed/simple;
	bh=Uhm5pGuH1u5xvAiYltqyiEc1yitYtbQkVnEw911bZpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mL/cRSHSberk093ha/o/WeCnvcIQa947mGMITRqCGnLgCBaa/ndj09HnvsiHcSqZKNQSmnh3X7SK5paC4KGYziuc/V0au9pI0HaZUqoSy/htruUkRSkYrF4HelO8EQtKtKVkpbY3ceNkqTYLLuqWIBsnR2iHilVIBjuDCgMN6PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Flsbpaaf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Flsbpaaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3EE1F0089A;
	Tue, 15 Sep 2026 11:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472087;
	bh=hTcFPD5nJ4+2LMtt0zaRlcDz8pb9ncWK9jLD+CuAEYQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FlsbpaafsIOIgMpG7HCaM1DGGB+32ZzKmdnN26bxlcjfIBYeSqjg7SV0fHdam08z6
	 UPHMCKlmukOmWEHllUecx7o++e5Lh3XRpN7AoTUW08gMYmF+pJlT/fJIqly9PGTq+Q
	 uS8J8PziF121Z3kDQMB072y+lW4FQwZm+xGXX0ts1HmNDiDLjcAfccLqn5D3mHANLN
	 CqNXVBrP5dfz3b/gqBl92UwVJ+JI45K95UWmPc4kdiJc8xu1YSfVfi7VzrYDrKL8fJ
	 epFtYGN9LUEdiCXHagpzqxt2EfM73ZpJkAjsDTURRWezAHawT/pR7B3JghREyKTwwX
	 W4GQ4hx051nWA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:13 +0200
Subject: [PATCH RFC POC 27/50] drm/amdkfd: stop collecting CRIU dma-buf
 descriptors for a final install
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-27-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5171; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Uhm5pGuH1u5xvAiYltqyiEc1yitYtbQkVnEw911bZpc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KnLvXpYsF3fqHGS4YdPk5Xs9qW0bU/n3sgcUJuWL
 yu8Wl+zo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLz5jIynODjjVis7j19ziS2
 AGmxAyL/v9W4StwoyMiZ+y5dYVWsNSPDvtpDpbc/Xihcun6Paoagrpdv5G6xV3U64XVmjU+13Lp
 ZAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 67 +++++++-------------------------
 1 file changed, 13 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 7fcfc150a7fc..158abe7e3da6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1988,11 +1988,10 @@ static uint32_t get_process_num_bos(struct kfd_process *p)
 	return num_of_bos;
 }
 
-static int criu_get_prime_handle(struct kgd_mem *mem,
-				 int flags, u32 *shared_fd,
-				 struct file **file)
+static int criu_get_prime_handle(struct kgd_mem *mem, int flags, u32 *shared_fd)
 {
 	struct dma_buf *dmabuf;
+	const struct fd_slot *fd;
 	int ret;
 
 	ret = amdgpu_amdkfd_gpuvm_export_dmabuf(mem, &dmabuf);
@@ -2001,38 +2000,17 @@ static int criu_get_prime_handle(struct kgd_mem *mem,
 		return ret;
 	}
 
-	ret = get_unused_fd_flags(flags);
-	if (ret < 0) {
+	fd = fd_prepare(flags);
+	if (IS_ERR(fd)) {
+		ret = PTR_ERR(fd);
 		pr_err("dmabuf create fd failed, ret:%d\n", ret);
-		goto out_free_dmabuf;
+		dma_buf_put(dmabuf);
+		return ret;
 	}
 
-	*shared_fd = ret;
-	*file = dmabuf->file;
+	/* Installed or dropped with the ioctl's result, nothing to put back. */
+	*shared_fd = fd_stage(fd, dmabuf->file);
 	return 0;
-
-out_free_dmabuf:
-	dma_buf_put(dmabuf);
-	return ret;
-}
-
-static void commit_files(struct file **files,
-			 struct kfd_criu_bo_bucket *bo_buckets,
-			 unsigned int count,
-			 int err)
-{
-	while (count--) {
-		struct file *file = files[count];
-
-		if (!file)
-			continue;
-		if (err) {
-			fput(file);
-			put_unused_fd(bo_buckets[count].dmabuf_fd);
-		} else {
-			fd_install(bo_buckets[count].dmabuf_fd, file);
-		}
-	}
 }
 
 static int criu_checkpoint_bos(struct kfd_process *p,
@@ -2043,7 +2021,6 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 {
 	struct kfd_criu_bo_bucket *bo_buckets;
 	struct kfd_criu_bo_priv_data *bo_privs;
-	struct file **files = NULL;
 	int ret = 0, pdd_index, bo_index = 0, id;
 	void *mem;
 
@@ -2057,12 +2034,6 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 		goto exit;
 	}
 
-	files = kvcalloc(num_bos, sizeof(struct file *), GFP_KERNEL);
-	if (!files) {
-		ret = -ENOMEM;
-		goto exit;
-	}
-
 	for (pdd_index = 0; pdd_index < p->n_pdds; pdd_index++) {
 		struct kfd_process_device *pdd = p->pdds[pdd_index];
 		struct amdgpu_bo *dumper_bo;
@@ -2105,7 +2076,7 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 				ret = criu_get_prime_handle(kgd_mem,
 						bo_bucket->alloc_flags &
 						KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ? DRM_RDWR : 0,
-						&bo_bucket->dmabuf_fd, &files[bo_index]);
+						&bo_bucket->dmabuf_fd);
 				if (ret)
 					goto exit;
 			} else {
@@ -2156,8 +2127,6 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 	*priv_offset += num_bos * sizeof(*bo_privs);
 
 exit:
-	commit_files(files, bo_buckets, bo_index, ret);
-	kvfree(files);
 	kvfree(bo_buckets);
 	kvfree(bo_privs);
 	return ret;
@@ -2504,8 +2473,7 @@ static int criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
 
 static int criu_restore_bo(struct kfd_process *p,
 			   struct kfd_criu_bo_bucket *bo_bucket,
-			   struct kfd_criu_bo_priv_data *bo_priv,
-			   struct file **file)
+			   struct kfd_criu_bo_priv_data *bo_priv)
 {
 	struct kfd_process_device *pdd;
 	struct kgd_mem *kgd_mem;
@@ -2557,7 +2525,7 @@ static int criu_restore_bo(struct kfd_process *p,
 	if (bo_bucket->alloc_flags
 	    & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT)) {
 		ret = criu_get_prime_handle(kgd_mem, DRM_RDWR,
-					    &bo_bucket->dmabuf_fd, file);
+					    &bo_bucket->dmabuf_fd);
 		if (ret)
 			return ret;
 	} else {
@@ -2574,7 +2542,6 @@ static int criu_restore_bos(struct kfd_process *p,
 {
 	struct kfd_criu_bo_bucket *bo_buckets = NULL;
 	struct kfd_criu_bo_priv_data *bo_privs = NULL;
-	struct file **files = NULL;
 	int ret = 0;
 	uint32_t i = 0;
 
@@ -2588,12 +2555,6 @@ static int criu_restore_bos(struct kfd_process *p,
 	if (!bo_buckets)
 		return -ENOMEM;
 
-	files = kvcalloc(args->num_bos, sizeof(struct file *), GFP_KERNEL);
-	if (!files) {
-		ret = -ENOMEM;
-		goto exit;
-	}
-
 	ret = copy_from_user(bo_buckets, (void __user *)args->bos,
 			     args->num_bos * sizeof(*bo_buckets));
 	if (ret) {
@@ -2619,7 +2580,7 @@ static int criu_restore_bos(struct kfd_process *p,
 
 	/* Create and map new BOs */
 	for (; i < args->num_bos; i++) {
-		ret = criu_restore_bo(p, &bo_buckets[i], &bo_privs[i], &files[i]);
+		ret = criu_restore_bo(p, &bo_buckets[i], &bo_privs[i]);
 		if (ret) {
 			pr_debug("Failed to restore BO[%d] ret%d\n", i, ret);
 			goto exit;
@@ -2634,8 +2595,6 @@ static int criu_restore_bos(struct kfd_process *p,
 		ret = -EFAULT;
 
 exit:
-	commit_files(files, bo_buckets, i, ret);
-	kvfree(files);
 	kvfree(bo_buckets);
 	kvfree(bo_privs);
 	return ret;

-- 
2.53.0

