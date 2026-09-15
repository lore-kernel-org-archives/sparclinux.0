Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3724F49EC5F;
	Tue, 15 Sep 2026 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472215; cv=none; b=boAFGXKGNjdI/bWxZ5eTozob2AkgB7uLj8hjwBCrGeAxOZW6SO22GtgZbw5C+tHhF5FmiBMq6QZtKtDbbRYuEmqqAgiDlW30EfQfoCGLgPz079SP1KnsNOlP9RsaeXJYK3oudbk6K1AgQKgb8q4DSiMokxFG+xx6yqlN4bIycQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472215; c=relaxed/simple;
	bh=ufNESbgGG96SdhrvZQNvdMYhyiyG0BhLW+Tl/xqdcT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XmgmejoPqSz3xbh+CNp2Kc7yigxvkqkXBXt1w/hme1gfuvQdgdsjA1ca4hvIP/Y0yYWnhFxcfr4osDf3UQwmUrrJLKl4WLJWgqY7JidwSlJVVE4LaTkjXMCtr8hbWv7BvnPxbymVe2HrdQTKZBxJziCNXxt1SrmNIQnqI1kGTD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXI8vF2M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXI8vF2M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730581F000FF;
	Tue, 15 Sep 2026 11:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472213;
	bh=6e1PB4CQNzedeHCycAL44Td/hQEl2CX/iFm1Iur71xE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EXI8vF2Mi2qQql8uoPNVMR9Vjgp88ee0ybxkHsj+i1EcfZwKRf7jQAqrx5XocwZ5u
	 bXuB/2sL89kC6PNZZE/dhnoh6Kr65fNehf5/WE+WzUeV5/pclzQoq/bonRzBcg9E7+
	 NfoFoguGthxJQGC332DYQsb5ljWYLD+kEUw/Pee+5M/7Dg2ZiE3sQd1cKKv890ucDD
	 /r0vRvig6oqwgwA6dJ/z5P48MPdRVZFrQKEwVGkp3Sgwz1v5wVDwGFDqx3GUFssAgt
	 DN89k/PZlDz7rh5/WFfNs5IypEAhalKV3Vwaa2jbU2stx2+1M+fSysP8b+juFLIlZq
	 jL2puXhM2BB9Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:29 +0200
Subject: [PATCH RFC POC 43/50] drm/amdgpu: stop unwinding the fence
 descriptor by hand
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-43-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1456; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ufNESbgGG96SdhrvZQNvdMYhyiyG0BhLW+Tl/xqdcT0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Kk/up3zrbpgwjWhoti6iGnTuBPttKJTrrTH/TR99
 na/1fRNHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMRM2D4n28sFLhN/8+GKPvC
 voCqx/oLuw/JH2VIEPq49KPjCV75pwz/41f1ZW/e/L95zZs5+aVvD0z0YZjxyGRy0d0flus809L
 W8wMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 03b41f803520..e5c0f7201cea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1581,7 +1581,8 @@ int amdgpu_cs_fence_to_handle_ioctl(struct drm_device *dev, void *data,
 	struct dma_fence *fence;
 	struct drm_syncobj *syncobj;
 	struct sync_file *sync_file;
-	int fd, r;
+	const struct fd_slot *fd;
+	int r;
 
 	fence = amdgpu_cs_get_fence(adev, filp, &info->in.fence);
 	if (IS_ERR(fence))
@@ -1610,21 +1611,18 @@ int amdgpu_cs_fence_to_handle_ioctl(struct drm_device *dev, void *data,
 		return r;
 
 	case AMDGPU_FENCE_TO_HANDLE_GET_SYNC_FILE_FD:
-		fd = get_unused_fd_flags(O_CLOEXEC);
-		if (fd < 0) {
+		fd = fd_prepare(O_CLOEXEC);
+		if (IS_ERR(fd)) {
 			dma_fence_put(fence);
-			return fd;
+			return PTR_ERR(fd);
 		}
 
 		sync_file = sync_file_create(fence);
 		dma_fence_put(fence);
-		if (!sync_file) {
-			put_unused_fd(fd);
+		if (!sync_file)
 			return -ENOMEM;
-		}
 
-		fd_install(fd, sync_file->file);
-		info->out.handle = fd;
+		info->out.handle = fd_stage(fd, sync_file->file);
 		return 0;
 
 	default:

-- 
2.53.0

