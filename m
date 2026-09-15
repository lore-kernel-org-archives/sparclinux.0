Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F0B486647;
	Tue, 15 Sep 2026 11:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472175; cv=none; b=A9vYIBzj7K0SzCFLv35fkHke8lnFKdwb+n+22xz2zRfO/+0uUVGcUoGbTIPxLNPuihLtcl6kRwZ7VNxMTmobMDSj6ziscSg3WedhwDIWie0mPdR1ReVdyyz3P3bwdAvE5r0kc+Yj8IjZi7UcLITet+TL5Xje2lzqkExe4Fsf8ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472175; c=relaxed/simple;
	bh=gBId4KwT9HjrpRN/GtoshdJN45hNk2Km5XhUS+Rx/dQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ToDB89T5I4VlHXyELwjxMRX8K2FxwUrRc8W9T2XuVx9MekMPPxCaL0Ue1iprIJeQ1T+ugtxhoNoAiIbqIesW0d61hBW+7OKG0Y+qbUg7OWC1V8/kr/yl99CVucVP4AKpziIXpFy3qm+1EAs/neMv0KqPTxbWiEWoT+vwaRPY/us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXxOaBNd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXxOaBNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F6B1F000FF;
	Tue, 15 Sep 2026 11:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472174;
	bh=SUM43IO6qNWvRdNooAPnPsLAAH/RcolhMgr+hyP1MvM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fXxOaBNdJwFX/Lk/E/kRGTURHefQKpPPy4SOimei8WnuQFymjQ54Osu1qX23oVPTQ
	 m0A8Uo6l6w4qKA2hJ3urgORqbpweOp4clPRtYTGkNID+oymAFlp8BwoOHfWgXjq00g
	 2jaCNdDGKnUTjAY9tG8l6AGYNW5fihLVRuWziN2I32TvRehjGk6CF4lsh9F7JKNwM8
	 v5WKv5XKjGiJgpuTC+6woLjedYHaONUBygXryBe6w8FmgPTi4h5Mt5Fbn+0QCTmLSc
	 1dRRPZi0WCjS5bVpj31Cm7wGEaPUy3iJpp2OQokIUXhIHQiwa1Leonc8PLtC/JB8/R
	 gVXIBaAx596pQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:24 +0200
Subject: [PATCH RFC POC 38/50] perf: stop putting the event descriptor back
 on failure
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-38-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2461; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gBId4KwT9HjrpRN/GtoshdJN45hNk2Km5XhUS+Rx/dQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Knz3yduOPXT6cQYVeXHZzbnqs7Zqcayytk3qHiay
 eV9UyYIdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwk7jIjw7OGE8fOrTS3bVvT
 7m02I8bx3+9MntLGq9z1gtyNvPx5jAz/fe684tNnVrol8LfYa7a9+/c7fcJ8jXoa4n6P/MXywr1
 5AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/events/core.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a6c8e38a3110..54834a7aca53 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13924,7 +13924,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	struct file *event_file = NULL;
 	struct task_struct *task = NULL;
 	struct pmu *pmu;
-	int event_fd;
+	const struct fd_slot *event_fd;
 	int move_group = 0;
 	int err;
 	int f_flags = O_RDWR;
@@ -13990,9 +13990,9 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (flags & PERF_FLAG_FD_CLOEXEC)
 		f_flags |= O_CLOEXEC;
 
-	event_fd = get_unused_fd_flags(f_flags);
-	if (event_fd < 0)
-		return event_fd;
+	event_fd = fd_prepare(f_flags);
+	if (IS_ERR(event_fd))
+		return PTR_ERR(event_fd);
 
 	/*
 	 * Event creation should be under SRCU, see perf_pmu_unregister().
@@ -14001,15 +14001,11 @@ SYSCALL_DEFINE5(perf_event_open,
 
 	CLASS(fd, group)(group_fd);     // group_fd == -1 => empty
 	if (group_fd != -1) {
-		if (!is_perf_file(group)) {
-			err = -EBADF;
-			goto err_fd;
-		}
+		if (!is_perf_file(group))
+			return -EBADF;
 		group_leader = fd_file(group)->private_data;
-		if (group_leader->state <= PERF_EVENT_STATE_EXIT) {
-			err = -ENODEV;
-			goto err_fd;
-		}
+		if (group_leader->state <= PERF_EVENT_STATE_EXIT)
+			return -ENODEV;
 		if (flags & PERF_FLAG_FD_OUTPUT)
 			output_event = group_leader;
 		if (flags & PERF_FLAG_FD_NO_GROUP)
@@ -14018,10 +14014,8 @@ SYSCALL_DEFINE5(perf_event_open,
 
 	if (pid != -1 && !(flags & PERF_FLAG_PID_CGROUP)) {
 		task = find_lively_task_by_vpid(pid);
-		if (IS_ERR(task)) {
-			err = PTR_ERR(task);
-			goto err_fd;
-		}
+		if (IS_ERR(task))
+			return PTR_ERR(task);
 	}
 
 	if (task && group_leader &&
@@ -14298,8 +14292,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	 * This ensures destruction of the group leader will find
 	 * the pointer to itself in perf_group_detach().
 	 */
-	fd_install(event_fd, event_file);
-	return event_fd;
+	return fd_stage(event_fd, event_file);
 
 err_context:
 	put_pmu_ctx(event->pmu_ctx);
@@ -14316,8 +14309,6 @@ SYSCALL_DEFINE5(perf_event_open,
 err_task:
 	if (task)
 		put_task_struct(task);
-err_fd:
-	put_unused_fd(event_fd);
 	return err;
 }
 

-- 
2.53.0

