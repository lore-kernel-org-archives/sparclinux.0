Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B10439F9E;
	Tue, 15 Sep 2026 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472052; cv=none; b=Hm5DMjVTkm6glDamsF1RPh342B6oAfJfKrZopEFmq1c3Fz2jJF9P0yNi79rLW1yGn7AkliTo6s+4tKolOMACg2SGY/LEE5f6M47WkejXRIPbU0xA1Lu6UqNAmsjRQUfKdBxHTt11tSntVbmR+u97KNZDoolLItU8qacVL86hzNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472052; c=relaxed/simple;
	bh=583XJCrzovkxIXuJOAwpVg9Fhe+TBNMNFPvPLgzJFv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hlGTYp7Dn7UX52FzBA6ee4Q1+YXMb+GSD2P/fboRT6QjKTh4cvSjwtYKJlXE2y1WngwykLCyXUcPwwrk5YNjFLVkznsP7iuB9zl/5DtqzwygoBXGRxqFa6KfOKgYmH8ReSJDv74xj9b08UN651HZBnQwfXDuvzfmZ0I/KRok6Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQ8C1Ifl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQ8C1Ifl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF091F000FF;
	Tue, 15 Sep 2026 11:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472049;
	bh=uhGO6+GlrO5bC4tNOgPf4pdo2kq7bPXcK+eEsTvolok=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nQ8C1Ifl5v/VEdveq9mGf3Z+FkWlXntXzUEHkSwQjH9wNm/+moILJ5obBzqitNP3N
	 IBlzTUeAC+qYwcosyjv/uN3SpN6wKH5b+F1BnYLAvwrpAYFxh7xAzh1A6p2Gwl1LgI
	 rWQJAgcOdwQd5Ylu5a8xK1NTioy4jbHj4ziLLIywDBw+W3mJ8po4oGdT92T3R2egH/
	 xuquAaax+7jMrr2xNPG/Odz/y7erbajpwwU+weBYntanMeYoJSnYyxmfhWaIp51P4L
	 YpHw70QLsguWOhvBKn1wooIGtRPB4vcJYrpctMzIq0N/zqf/HB3mTynt9TyjQ+rxp/
	 NpyMNYd5pEyIA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:08 +0200
Subject: [PATCH RFC POC 22/50] net: install SCM_RIGHTS descriptors when
 recvmsg() returns
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-22-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2042; i=brauner@kernel.org;
 h=from:subject:message-id; bh=583XJCrzovkxIXuJOAwpVg9Fhe+TBNMNFPvPLgzJFv0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Kl1Nz+WcexRzpkZ6+trd0+fFefIwcf4SebIg9qKf
 4ll/ixHO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbiMIGRYcr6Twc1Fn/48OzN
 Xc98Cd5J3cfYczNUrC7dCpOb1qzKdIzhf0T4fyfZE4nxKZbFy5ds7U6RenQkNmYPozvL9NMLPpv
 FswIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

scm_recv_one_fd() allocates a descriptor, writes the number into the
control message and installs the file right there, one descriptor at a
time. Everything that recvmsg() does after scm_detach_fds() can still
fail though. When it does the syscall returns -EFAULT while the received
descriptors are already in the table and the caller has no way to tell.

Reserve the descriptor with fd_prepare() and stage the file with
fd_stage(). The number is written to userspace as before, but the file
is only installed when recvmsg() returns success and dropped together
with the descriptor when it returns an error.

A control message that doesn't fit still gets only the descriptors it
can report and MSG_CTRUNC.

IORING_OP_RECVMSG reaches the same code from io-wq workers and the
SQPOLL thread. io_uring requests commit their reservations before the
completion is posted.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 net/core/scm.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/core/scm.c b/net/core/scm.c
index f0d44ecdb11f..f05931eef54d 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -355,6 +355,7 @@ int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flags,
 		    bool notrunc)
 {
 	int error;
+	const struct fd_slot *fd;
 
 	if (!ufd)
 		return -EFAULT;
@@ -363,16 +364,16 @@ int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flags,
 	if (error)
 		return notrunc ? put_user(error, ufd) : error;
 
-	FD_PREPARE(fdf, flags, get_file(f));
-	if (fdf.err)
-		return fdf.err;
+	fd = fd_prepare(flags);
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
 
-	error = put_user(fd_prepare_fd(fdf), ufd);
+	error = put_user(fd_prepare_fd(fd), ufd);
 	if (error)
 		return error;
 
-	__receive_sock(fd_prepare_file(fdf));
-	return fd_publish(fdf);
+	__receive_sock(f);
+	return fd_stage(fd, get_file(f));
 }
 
 void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool notrunc)

-- 
2.53.0

