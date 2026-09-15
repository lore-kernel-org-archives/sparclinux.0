Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E59C47D931;
	Tue, 15 Sep 2026 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472133; cv=none; b=G0HqPjuHPq33y7VorTzMRCBzulrC5jFOUJTc/ukrj4nhM5RepPNTGFeT0brOAWiXA+L4qOEjigxxxLaYGHV67dVsaH3zNm8VK9sqqAufRPcpOAptILxqQDCjW0yU5oGl7CoT3jMuy9sJHQqLSb1FBmYCUZvIj+4+FMc5JN1gM8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472133; c=relaxed/simple;
	bh=B2yzY8WVH9I+iLi4OuPEJenUrd90D6GAB5zasGpbfEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KIMbHbRHWZHj+Hvua4fGWG+6lIojmT8vR24jmTPiiqhHuv4cpvXmXyDpDMMHziFpkdMOUmBWKrM9ZJ92LEzYsH4GInMahEaZXJ7kG4iNnk/Ut+EuGC8cfz3XqE1BARnPbqyEmSEYHP2uz6I3HukuJ6rLk7qbwyydMuH090ekFcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqYmNccj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqYmNccj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863231F00893;
	Tue, 15 Sep 2026 11:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472127;
	bh=SiDQySP8IWTYUOdB117br7TNLcvsxWg+xpN5r3cQq6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XqYmNccjTCHTgLZfaFkSBqBDFVVBpN4V7uWmro0nlZYhYXdIOR3pUJm31rdV5qmY+
	 IvkQ+yJ07iMIJdVfTfCU/X+J1F85+bUe/IC+GzOLdoIsjHzzI0cRTRkin0A6HJ4e9A
	 wjbY7EF1qh+Lal3EYMMKlHTRwBv+A5nykmakJD+8D67Z72hDwiPvXhqDAFfL92TuNh
	 lR+9tIh+dTMh59L9wRnctKfZHIAF9NgyjZ0E3adVhwso4Hs5jlLy1+Oyk4a8gR0BJY
	 rzlOT3+qL2yuGXywSlb/k0KzE8CbI8Z7lw3SuGIaABfBF2TZ/OabNmu6rvP9iBmcEe
	 3ufAwvnh6Znbw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:18 +0200
Subject: [PATCH RFC POC 32/50] liveupdate: install the session descriptors
 when the ioctl returns
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-32-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3361; i=brauner@kernel.org;
 h=from:subject:message-id; bh=B2yzY8WVH9I+iLi4OuPEJenUrd90D6GAB5zasGpbfEQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Kk7WTbjY/LDc6u2Nl9xvMO+7IG4y7ylT0vafyesW
 7+59X5BSUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEdFwZGQ4ll/MKLt9+yuPv
 Ls73Mh5H/nGs+LpMfK0El6Rj9O4LjyQZGY7rKSdd2rLmmIq27bPU4yUy5+NELr/9Lxu7/vCdBG/
 ZPH4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/liveupdate/luo_core.c    | 48 ++++++++++++-----------------------------
 kernel/liveupdate/luo_session.c | 24 ++++++---------------
 2 files changed, 21 insertions(+), 51 deletions(-)

diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 1b2bda22902d..3899bbf30b53 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -270,61 +270,41 @@ struct luo_device_state {
 static int luo_ioctl_create_session(struct luo_ucmd *ucmd)
 {
 	struct liveupdate_ioctl_create_session *argp = ucmd->cmd;
+	const struct fd_slot *fd;
 	struct file *file;
 	int err;
 
-	argp->fd = get_unused_fd_flags(O_CLOEXEC);
-	if (argp->fd < 0)
-		return argp->fd;
+	fd = fd_prepare(O_CLOEXEC);
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
 
 	err = luo_session_create(argp->name, &file);
 	if (err)
-		goto err_put_fd;
-
-	err = luo_ucmd_respond(ucmd, sizeof(*argp));
-	if (err)
-		goto err_put_file;
-
-	fd_install(argp->fd, file);
-
-	return 0;
+		return err;
 
-err_put_file:
-	fput(file);
-err_put_fd:
-	put_unused_fd(argp->fd);
+	argp->fd = fd_stage(fd, file);
 
-	return err;
+	return luo_ucmd_respond(ucmd, sizeof(*argp));
 }
 
 static int luo_ioctl_retrieve_session(struct luo_ucmd *ucmd)
 {
 	struct liveupdate_ioctl_retrieve_session *argp = ucmd->cmd;
+	const struct fd_slot *fd;
 	struct file *file;
 	int err;
 
-	argp->fd = get_unused_fd_flags(O_CLOEXEC);
-	if (argp->fd < 0)
-		return argp->fd;
+	fd = fd_prepare(O_CLOEXEC);
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
 
 	err = luo_session_retrieve(argp->name, &file);
 	if (err < 0)
-		goto err_put_fd;
-
-	err = luo_ucmd_respond(ucmd, sizeof(*argp));
-	if (err)
-		goto err_put_file;
-
-	fd_install(argp->fd, file);
-
-	return 0;
+		return err;
 
-err_put_file:
-	fput(file);
-err_put_fd:
-	put_unused_fd(argp->fd);
+	argp->fd = fd_stage(fd, file);
 
-	return err;
+	return luo_ucmd_respond(ucmd, sizeof(*argp));
 }
 
 static int luo_open(struct inode *inodep, struct file *filep)
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index f48e9a4185f9..7de35bad1ede 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -282,33 +282,23 @@ static int luo_session_retrieve_fd(struct luo_session *session,
 				   struct luo_ucmd *ucmd)
 {
 	struct liveupdate_session_retrieve_fd *argp = ucmd->cmd;
+	const struct fd_slot *fd;
 	struct file *file;
 	int err;
 
-	argp->fd = get_unused_fd_flags(O_CLOEXEC);
-	if (argp->fd < 0)
-		return argp->fd;
+	fd = fd_prepare(O_CLOEXEC);
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
 
 	mutex_lock(&session->mutex);
 	err = luo_retrieve_file(&session->file_set, argp->token, &file);
 	mutex_unlock(&session->mutex);
 	if (err < 0)
-		goto err_put_fd;
-
-	err = luo_ucmd_respond(ucmd, sizeof(*argp));
-	if (err)
-		goto err_put_file;
-
-	fd_install(argp->fd, file);
-
-	return 0;
+		return err;
 
-err_put_file:
-	fput(file);
-err_put_fd:
-	put_unused_fd(argp->fd);
+	argp->fd = fd_stage(fd, file);
 
-	return err;
+	return luo_ucmd_respond(ucmd, sizeof(*argp));
 }
 
 static int luo_session_finish(struct luo_session *session,

-- 
2.53.0

