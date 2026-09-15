Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C104A9D5C;
	Tue, 15 Sep 2026 11:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472223; cv=none; b=sZ8jWEn6YX7E+c/toL/J4VwmTQa8rZMbTpk9wQHxYYebJhDXIpmk0u9EzGCoNw9c5aWlMz6s+U6iM7gjC2+1afJB3C9/vPpw2gM1wgo/ZmnOCItkpGVqteoqZh+6ird9si/7nHEZCamsNB5Cocp4kqYuTrB6IftP8zXOcW9ZThk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472223; c=relaxed/simple;
	bh=WG8U461FL48WyesDf7+OQN8njA3nXiC/HvwYW8sZuPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=it/f+AX6b6T2EFPwC7dEtyM3801iOT+3yGeIw3i5hUz8HteknTVgmpN0W2J/Bnb0YaMj3WzV4xF2m3sLnplY/C34gXG02BROXLHtGc2FoNGrrNrh3TVElfrSqAtfzSEga0UZ6sDSOe1lj8UvKaiyRzIl9ZKtr8+QtzGR40O7dok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJcbb+ve; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJcbb+ve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C811F00893;
	Tue, 15 Sep 2026 11:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472221;
	bh=vNAyMtfXPrvlDMBwu/W4OdplmCeF+Bx8YXtsYm6LQAM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hJcbb+ve+d0nQ+lyOtzlz+UYbr/gC7seiGRVtM9hr3qhRy0SP4rtTxf+61fJV6HZZ
	 LW8RS1sK7opxRgNB4vdONobXBpXD+8GA3HqD2ByRAw16fqkTwu9j8tnAJddGmb7PLP
	 uAm06SirtIHb9CCSMDYGUJRVhcFsQ8v4/IdM2Y5J83ZMffAgWUfRu60wVT+I3rLxob
	 Mi3XVumaSCaqqvXwhpB/3c9gXctwqH2urcLOWEF/YPHWIZ1DoeXtnc71XLjr6mUjdh
	 GfPZGsugN7/T7eQDGipHgpsCZ2aT0QgMaxK1TaXJWBPrJ+seh1rFblIFb7+Y//Ecs/
	 SAX3DixdA32jQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:30 +0200
Subject: [PATCH RFC POC 44/50] drm/etnaviv: install the out-fence
 descriptor when the ioctl returns
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-44-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1875; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WG8U461FL48WyesDf7+OQN8njA3nXiC/HvwYW8sZuPs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Km/q3LcYfWGcx8fpJwoLZDaNd0oa+00ldguK1cb6
 asTWTUPdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyEn5Hhf8CmHl/lhwWpt/aY
 /5Pr3xCoq1J+5FT33kNKDsks7ZtPZjMy7JT6oyr93P+B4L/VWRcU9j8zmrNg9ut3r3TNptlZWIi
 5MgAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
index 1a77a09b3377..174f1d66d9ad 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
@@ -420,7 +420,7 @@ int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
 	struct etnaviv_gpu *gpu;
 	struct sync_file *sync_file = NULL;
 	struct ww_acquire_ctx ticket;
-	int out_fence_fd = -1;
+	const struct fd_slot *out_fence_fd = NULL;
 	struct pid *pid = get_pid(task_pid(current));
 	void *stream;
 	int ret;
@@ -504,9 +504,9 @@ int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
 	}
 
 	if (args->flags & ETNA_SUBMIT_FENCE_FD_OUT) {
-		out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
-		if (out_fence_fd < 0) {
-			ret = out_fence_fd;
+		out_fence_fd = fd_prepare(O_CLOEXEC);
+		if (IS_ERR(out_fence_fd)) {
+			ret = PTR_ERR(out_fence_fd);
 			goto err_submit_cmds;
 		}
 	}
@@ -607,10 +607,10 @@ int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
 			 */
 			goto err_submit_put;
 		}
-		fd_install(out_fence_fd, sync_file->file);
+		fd_stage(out_fence_fd, sync_file->file);
 	}
 
-	args->fence_fd = out_fence_fd;
+	args->fence_fd = out_fence_fd ? fd_prepare_fd(out_fence_fd) : -1;
 	args->fence = submit->out_fence_id;
 
 err_submit_job:
@@ -623,8 +623,6 @@ int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
 	ww_acquire_fini(&ticket);
 
 err_submit_cmds:
-	if (ret && (out_fence_fd >= 0))
-		put_unused_fd(out_fence_fd);
 	kvfree(stream);
 	kvfree(bos);
 	kvfree(relocs);

-- 
2.53.0

