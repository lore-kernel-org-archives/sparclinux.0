Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6D14C8C5B;
	Tue, 15 Sep 2026 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472118; cv=none; b=kN/49UC7yl8csOHlbGjCuig+C4UdykKOv5aC1ixk6eevxzG1zwh/jmnyJ96IkZ2mmuEUDHIWrVq0+tSmbSL29TETViJw7I87q42MoPgnB+6KRyBqTIAp2RUAr/UUygg8LRPttaLC0m3L0NWrEKHmSrtj3+kZGdKE0+lyLL6PLUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472118; c=relaxed/simple;
	bh=p0ASybizHVeWg3+K+2/U4eYr0FkEait3G8m6yrPnxug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YFtAGWidFsycrVnWBPn/vnBhjKbjpZm20SR1PXogokrZNLsDnWYwXA/1fHS9lJ/HzDNvdtwXkKHzBKbYJleEHD+kFZEj0sDFhuR7ddmOyVVlx7QIo0ulzvVg+5KLHpcs4QWebQrYT+AxF1X72+ZS8SuhH2YX7pRuaqIvL0vObkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KA44M0cm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KA44M0cm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C030B1F00898;
	Tue, 15 Sep 2026 11:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472103;
	bh=+Z7YvZoUhgCp4iTA46gJpRmnztUthrtoZVj66HfgwUY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KA44M0cmNF2mMlF/NDPOuyRWz4vVkHxzKiMxMZ4ISNNfo7H9BTar51IZgT37QoJX1
	 6srepTnNRPf2DDq8k0Xr2lGax/zEGP29xcg5Q8NVjuDbwOO/px017DffFztmjp8Ha+
	 BN9rxQ+ckzz66olSbf9AzLwaWhDMxhbiTnSee7sd06Ig+WHUQKBNw53tm8cd+iRMgv
	 H7ptnEs+6ym+zmmY2nGMKn3UT9nTIljKiF99YIGQvS2ezwjHF2FGWp1leEB/9nrbJj
	 zA9+UppFgEv9UDF+Tete4exU2H8M/NSppcn+lHJLgDsGhlGujiOkLCF8yydq5B/Mxi
	 RYtXu9Hi+fWsg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:15 +0200
Subject: [PATCH RFC POC 29/50] drm/virtio: install the out-fence descriptor
 when the ioctl returns
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-29-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3421; i=brauner@kernel.org;
 h=from:subject:message-id; bh=p0ASybizHVeWg3+K+2/U4eYr0FkEait3G8m6yrPnxug=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KlTnNOyTUQz0y+rQub5bi2Wdr3pRa+cWq6FHSt8z
 FPyLjOgo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLPhRgZzpcEpJcv22rRdtX7
 cKbUFkn/pfMZNuqxXquY3F4nrdInx/CH946PZqsxs8HCIweudkmFfO3eM+HpqaU/s9ffmbhJTXk
 XOwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_submit.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
index 32cb1e4aa425..51b224acb72b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_submit.c
+++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
@@ -39,7 +39,7 @@ struct virtio_gpu_submit {
 	struct virtio_gpu_device *vgdev;
 	struct sync_file *sync_file;
 	struct drm_file *file;
-	int out_fence_fd;
+	const struct fd_slot *out_fence_fd;
 	u64 fence_ctx;
 	u32 ring_idx;
 	void *buf;
@@ -340,14 +340,8 @@ static void virtio_gpu_cleanup_submit(struct virtio_gpu_submit *submit)
 	if (submit->buflist)
 		virtio_gpu_array_put_free(submit->buflist);
 
-	if (submit->out_fence_fd >= 0)
-		put_unused_fd(submit->out_fence_fd);
-
 	if (submit->out_fence)
 		dma_fence_put(&submit->out_fence->f);
-
-	if (submit->sync_file)
-		fput(submit->sync_file->file);
 }
 
 static void virtio_gpu_submit(struct virtio_gpu_submit *submit)
@@ -363,7 +357,7 @@ static void virtio_gpu_complete_submit(struct virtio_gpu_submit *submit)
 	submit->buf = NULL;
 	submit->buflist = NULL;
 	submit->sync_file = NULL;
-	submit->out_fence_fd = -1;
+	submit->out_fence_fd = NULL;
 }
 
 static int virtio_gpu_init_submit(struct virtio_gpu_submit *submit,
@@ -405,7 +399,7 @@ static int virtio_gpu_init_submit(struct virtio_gpu_submit *submit,
 	submit->out_fence = out_fence;
 	submit->fence_ctx = fence_ctx;
 	submit->ring_idx = ring_idx;
-	submit->out_fence_fd = -1;
+	submit->out_fence_fd = NULL;
 	submit->vfpriv = vfpriv;
 	submit->vgdev = vgdev;
 	submit->exbuf = exbuf;
@@ -420,15 +414,15 @@ static int virtio_gpu_init_submit(struct virtio_gpu_submit *submit,
 		return PTR_ERR(submit->buf);
 
 	if (exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_OUT) {
-		err = get_unused_fd_flags(O_CLOEXEC);
-		if (err < 0)
-			return err;
-
-		submit->out_fence_fd = err;
+		submit->out_fence_fd = fd_prepare(O_CLOEXEC);
+		if (IS_ERR(submit->out_fence_fd))
+			return PTR_ERR(submit->out_fence_fd);
 
 		submit->sync_file = sync_file_create(&out_fence->f);
 		if (!submit->sync_file)
 			return -ENOMEM;
+
+		fd_stage(submit->out_fence_fd, submit->sync_file->file);
 	}
 
 	return 0;
@@ -456,12 +450,10 @@ static int virtio_gpu_wait_in_fence(struct virtio_gpu_submit *submit)
 	return ret;
 }
 
-static void virtio_gpu_install_out_fence_fd(struct virtio_gpu_submit *submit)
+static void virtio_gpu_report_out_fence_fd(struct virtio_gpu_submit *submit)
 {
-	if (submit->sync_file) {
-		submit->exbuf->fence_fd = submit->out_fence_fd;
-		fd_install(submit->out_fence_fd, submit->sync_file->file);
-	}
+	if (submit->sync_file)
+		submit->exbuf->fence_fd = fd_prepare_fd(submit->out_fence_fd);
 }
 
 static int virtio_gpu_lock_buflist(struct virtio_gpu_submit *submit)
@@ -534,7 +526,7 @@ int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	 * Set up user-out data after submitting the job to optimize
 	 * the job submission path.
 	 */
-	virtio_gpu_install_out_fence_fd(&submit);
+	virtio_gpu_report_out_fence_fd(&submit);
 	virtio_gpu_process_post_deps(&submit);
 	virtio_gpu_complete_submit(&submit);
 cleanup:

-- 
2.53.0

