Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A294CC630;
	Tue, 15 Sep 2026 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472145; cv=none; b=IPJjvZk6Px2HF7lR93SW5DuDC/f4p78dsk1ZntKZ3ys8W5C2CKzB92izoGonj/BGUdeg14N0vpKTBDqow5sXHA1gif6RmoNYWw9vfqyP1MI8Svonktbz3mBdV2G5yxc4xY9Pz8sfWPhcJ96UCR0HVYtGCkIt3vnOBYhTWY9Q2wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472145; c=relaxed/simple;
	bh=g4cMNX/82jJQalDLSwX1Nity2yqjS0J0NiJHAB23CT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J62rKc/Wgx8GPRQPuPmTysNqbHy7hT9iy1uLojebyU0jsVb4jAXMCPfDsqCHeNEX2ii+fWVZgzZpqPG8K3gZwL0AF943iYhJcQShO3E8Pb2fTILo0l17NsI9DgVHP4K3xyll1UyBWSE8HaY7YJROatkwogyfUWk3pgxLC2hfmno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QShSpSCR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QShSpSCR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855EE1F000FF;
	Tue, 15 Sep 2026 11:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472135;
	bh=4cyWZY3NqovxpRDY6IE9b0iFSwFNHI0DbK45a85UipQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QShSpSCRD6Ol4MQvbWaGFCrC9D2hEvMMsqJVxbgperwaAzfDuHUwR651hhvjbuklD
	 V8TQMFUcMD9eSXSMuyAwgiWFzi0aqbkjT2ga+ukHQTd+ooSqbRR0w+8dklcQllx84s
	 J1vd1rrkg7W2xCcJFOtsGmjuUfysGb2g+4rZjFbqLWmyJ8Yf8Ww523QPYOM4gdlVYe
	 9qjw6VvRm1T5endGkraMKVYh3kIi8DvPoXM1B76VPl1ZetouR5ZWcWZs/UQmu4oEg/
	 QeIQWjAGAMnj1aiLn/FeAtI3+y0er7L+q8OA2u/+KtDir8seIk/RUJip7Wgf4oA2Ys
	 w5GYgWQdLMU4Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:19 +0200
Subject: [PATCH RFC POC 33/50] io_uring/zcrx: install the exported
 descriptor when the request returns
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-33-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1536; i=brauner@kernel.org;
 h=from:subject:message-id; bh=g4cMNX/82jJQalDLSwX1Nity2yqjS0J0NiJHAB23CT0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Kk73H60xLL/uL9c1Ubz66I7n/6tuiXcUVn6/cZhl
 7opP+8pdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk/weG/3mbVB0z75nsf+2g
 kJwuHDdbwrosi1P7+cq1bOytTdFl1gz/Y3eZWfw1evMxy/980nMezqvh6nqrq+2qsnZHrDSbM9O
 WEQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 io_uring/zcrx.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 1b3b11405dac..d458c614c765 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -795,8 +795,6 @@ static int zcrx_export(struct io_ring_ctx *ctx, struct io_zcrx_ifq *ifq,
 		       struct zcrx_ctrl *ctrl, void __user *arg)
 {
 	struct zcrx_ctrl_export *ce = &ctrl->zc_export;
-	struct file *file;
-	int fd;
 
 	if (!mem_is_zero(ce, sizeof(*ce)))
 		return -EINVAL;
@@ -804,27 +802,18 @@ static int zcrx_export(struct io_ring_ctx *ctx, struct io_zcrx_ifq *ifq,
 	refcount_inc(&ifq->refs);
 	refcount_inc(&ifq->user_refs);
 
-	file = anon_inode_create_getfile("[zcrx]", &zcrx_box_fops,
-					 ifq, O_CLOEXEC, NULL);
-	if (IS_ERR(file)) {
+	FD_PREPARE(fdf, O_CLOEXEC,
+		   anon_inode_create_getfile("[zcrx]", &zcrx_box_fops, ifq,
+					     O_CLOEXEC, NULL));
+	if (IS_ERR(fdf)) {
 		zcrx_unregister(ifq, NULL);
-		return PTR_ERR(file);
-	}
-
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0) {
-		fput(file);
-		return fd;
+		return PTR_ERR(fdf);
 	}
 
-	ce->zcrx_fd = fd;
-	if (copy_to_user(arg, ctrl, sizeof(*ctrl))) {
-		fput(file);
-		put_unused_fd(fd);
+	ce->zcrx_fd = fd_prepare_fd(fdf);
+	if (copy_to_user(arg, ctrl, sizeof(*ctrl)))
 		return -EFAULT;
-	}
 
-	fd_install(fd, file);
 	return 0;
 }
 

-- 
2.53.0

