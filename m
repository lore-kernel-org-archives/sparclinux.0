Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468E74A4850;
	Tue, 15 Sep 2026 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472058; cv=none; b=lR1eyR5KElOQCRxP3WS7Yt1VXZIgrDdEUhT1Nj7OPwOuL/CjsfiFgJk1A2zul04MeuBxXStODUw6m/WREeiwNdPpfTBPU6zm4X6ham+vKbNPpomPHnBoz8Ychf4UWveosj96+Qy3TIssE4iAfld4Gwku0fUpzJ3/8Q85LDxVHlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472058; c=relaxed/simple;
	bh=9JAnV65R8KRKKJ6YuAvXjbfOJ9otGL1j9hOaIwPGraE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UQ5B/hJkKwc2JJCe8296ThymMTcRnheX0+dd/us6NF81q6S3IgF20LmlT/hVK9el59i7LrwnfdivfvYV1IjeJ/3ufPXs5v5lwJxuEGCDUC8uaMrrEJ73IslUe7/oS/FxrsNSGbBjDGE5YCMD1LRH/MkI2HxA0jYKQww2rdxi2/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOHGXy8c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOHGXy8c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2821F0089A;
	Tue, 15 Sep 2026 11:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472056;
	bh=bA4ynAEQWzLS8TLe1OyiMNmBCpxqZtxYswH6/3xEJn0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lOHGXy8cA8jMMGugeuqOHZsHNH9R6NCpiW1SGzSqk2TyhtRX4C5vLan9jF9Lg4sJM
	 A2A2QCI68wPGNuvnvsrzBxBe+YzlBhd/5q0D0YjdRbOCeZ4h8kXDe3U7+UuYQS9gSN
	 nEwgErx77J2ER2m1k0BupFTZUzEnThzBPGlrZZvpU1Un3NXwFxcQXOSeuFbFE3Jgku
	 eXAGNFsAkifaZ03d/z3uqPrGplip5My3/DUaiek0wZjCAPE/m4YXJ55H3MQW+eeCW6
	 5funLtKEK3ijtyLwLxFdU4Hr4SHgxA1Jfy6H6zqgczgxiU00tDcHkC1P9UYL1yAfe1
	 +SqeWUaLUrpuA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:09 +0200
Subject: [PATCH RFC POC 23/50] file: open-code receive_fd()'s immediate
 install
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-23-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1378; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9JAnV65R8KRKKJ6YuAvXjbfOJ9otGL1j9hOaIwPGraE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KllfvjTfp2zVVTgt9NTTlxN9shpKt3NzyD6qO520
 LPPTxYs7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI1CCG/yUL4597uxz9uSVv
 B5MCM+uUS19mlk6c3GQWOy8v+s8XQzOGv5ILE+KOSk0/EKpzUmdZprjQ2jqtG2qZb/98t1fIsHn
 zhgcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

receive_fd() cannot defer to syscall exit as SECCOMP_IOCTL_NOTIF_ADDFD
installs into the target task and hands the number to the supervisor
and IORING_OP_FIXED_FD_INSTALL runs from an io_uring op. Open-code the
get_unused_fd_flags() + fd_install() it did through FD_PREPARE().

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 2b041b45f225..1f06d0c846c2 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1607,25 +1607,27 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
  */
 int receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
 {
-	int error;
+	int fd, error;
 
 	error = security_file_receive(file);
 	if (error)
 		return error;
 
-	FD_PREPARE(fdf, o_flags, file);
-	if (fdf.err)
-		return fdf.err;
-	get_file(file);
+	fd = get_unused_fd_flags(o_flags);
+	if (fd < 0)
+		return fd;
 
 	if (ufd) {
-		error = put_user(fd_prepare_fd(fdf), ufd);
-		if (error)
+		error = put_user(fd, ufd);
+		if (error) {
+			put_unused_fd(fd);
 			return error;
+		}
 	}
 
-	__receive_sock(fd_prepare_file(fdf));
-	return fd_publish(fdf);
+	__receive_sock(file);
+	fd_install(fd, get_file(file));
+	return fd;
 }
 EXPORT_SYMBOL_GPL(receive_fd);
 

-- 
2.53.0

