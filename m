Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27E34A5C34;
	Tue, 15 Sep 2026 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472120; cv=none; b=liJdvFz3nHfe71EDB+6WoG2djUJz+6kEoPCgxTls45N+gufxe6c2jEfbCUodovetY9aevG2VJSln59RZ5PCZYk7l2+a5qTbQz1xeW5VWJ7p6IVsJz3twXC080x2fFa+N70Rw+tHfKROPZcAqO89tJSIkERKDpSDf41WDfJhyG/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472120; c=relaxed/simple;
	bh=tFtZ4cL0NphK82dRD7+3sjxv1Q+YPE/6KXVfeTbJao0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DR+67JcV5mQXvb8OkSKGGiHFlfprBs3R8u7y0ir83hmQ6E1ruy60btDuYF8FZmxKm77uHkveczjG2IVi3+ZbCRTQFVNoxxipqRoMAYsmve+jX84OLm0N27PiI2e6spOIk1pGVdbmTafRI0xukCrh8ANLXU3fN9kpG8imktS3dpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dekb8smf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dekb8smf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11231F00899;
	Tue, 15 Sep 2026 11:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472111;
	bh=BaiQKOdzM8NM+WnZnsY02ffmMIwkfiUXQItc1CF3f8Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Dekb8smfKI2n5yGWIpNEMN0jdgTr4spZdVK3MdD/TCKNKco8XRVA1TQl+GxXP21IR
	 mQ1bfkZDLmhKqxrPetlmFnyIp76FwXgaVFoceDbmku29MuUZSQS/RfIncrnkMTBqkg
	 IsK8+0mFLEiKooNi0Ql2Y8fw+QKMPZyQpJ0DxXA6DHNh5fdea9CSHRxHeWPOu0c9b3
	 eXo0ja9rpUrTYduFglwTe8Jute8IZc768Hl3Jb0QwhrUuoIFCwPR0au4hj53ko0ecq
	 gFl4P7NPfeiu/9IfvP8VqLsljSKHoYKJSA97s2sEcmTCisygMQvKIWdbiZ4j2ejXUG
	 CzttZl/23iXnQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:16 +0200
Subject: [PATCH RFC POC 30/50] drm/vmwgfx: install the out-fence descriptor
 when the ioctl returns
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-30-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2552; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tFtZ4cL0NphK82dRD7+3sjxv1Q+YPE/6KXVfeTbJao0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KmT96hOWNmU/qLa/h57o09DBu/EH9cY+lcu13eXn
 l+3V9iuo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLKcQz/Mxl6ebeze05NNe4M
 0FAtDVBmvSBeuO2BBu/r/juTJPP5GP7wZvx9JTPBIYjfMCaNkc/2ZcaSF9xnJPsurtiQL5V+QZc
 FAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index a9136a6523cb..9daa74a13485 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -4109,15 +4109,17 @@ int vmw_execbuf_process(struct drm_file *file_priv,
 	uint32_t handle = 0;
 	int ret;
 	int32_t out_fence_fd = -1;
+	const struct fd_slot *out_fd = NULL;
 	struct sync_file *sync_file = NULL;
 	DECLARE_VAL_CONTEXT(val_ctx, sw_context, 1);
 
 	if (flags & DRM_VMW_EXECBUF_FLAG_EXPORT_FENCE_FD) {
-		out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
-		if (out_fence_fd < 0) {
+		out_fd = fd_prepare(O_CLOEXEC);
+		if (IS_ERR(out_fd)) {
 			VMW_DEBUG_USER("Failed to get a fence fd.\n");
-			return out_fence_fd;
+			return PTR_ERR(out_fd);
 		}
+		out_fence_fd = fd_prepare_fd(out_fd);
 	}
 
 	if (throttle_us) {
@@ -4256,28 +4258,21 @@ int vmw_execbuf_process(struct drm_file *file_priv,
 		sync_file = sync_file_create(&fence->base);
 		if (!sync_file) {
 			VMW_DEBUG_USER("Sync file create failed for fence\n");
-			put_unused_fd(out_fence_fd);
+			/* The reserved descriptor is released on return. */
 			out_fence_fd = -1;
 
 			(void) vmw_fence_obj_wait(fence, false, false,
 						  VMW_FENCE_WAIT_TIMEOUT);
+		} else {
+			/* Link the fence with the FD created earlier */
+			fd_stage(out_fd, sync_file->file);
 		}
 	}
 
+	/* A staged sync file is dropped with the ioctl on error. */
 	ret = vmw_execbuf_copy_fence_user(dev_priv, vmw_fpriv(file_priv), ret,
 				    user_fence_rep, fence, handle, out_fence_fd);
 
-	if (sync_file) {
-		if (ret) {
-			/* usercopy of fence failed, put the file object */
-			fput(sync_file->file);
-			put_unused_fd(out_fence_fd);
-		} else {
-			/* Link the fence with the FD created earlier */
-			fd_install(out_fence_fd, sync_file->file);
-		}
-	}
-
 	/* Don't unreference when handing fence out */
 	if (unlikely(out_fence != NULL)) {
 		*out_fence = fence;
@@ -4323,9 +4318,7 @@ int vmw_execbuf_process(struct drm_file *file_priv,
 	if (header)
 		vmw_cmdbuf_header_free(header);
 out_free_fence_fd:
-	if (out_fence_fd >= 0)
-		put_unused_fd(out_fence_fd);
-
+	/* A reserved descriptor is released on return. */
 	return ret;
 }
 

-- 
2.53.0

