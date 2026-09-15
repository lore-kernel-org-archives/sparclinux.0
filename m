Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CB04A8A04;
	Tue, 15 Sep 2026 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472200; cv=none; b=Qds8/uclOY7MnZCuSz3IsRFr/3yDbMAYsBFgxnLqQuzu4FvnxDt+Oed94pE4wSdftEaynFasziOj8vBSKGtGNaFE7dM+pFogMa5KoqE8EcYndslGkOzpeGCkYrx/j4mmiQsp5Yym73ytQiZ8UkrOhkW61lMEmKSrCPEG+LxX8y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472200; c=relaxed/simple;
	bh=KLCbLLJNzFhK9KnJoDv8kDUlKXi4pqPjbkN6aCwr8bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=humiqd6CmvDgM0K5Pr6eCu60EC7evt2AEdsotXxaca51XmF55QVKeVc51SCIa0V1ORN9N63cf6R+H/pl5CVzSAUkB+q2D+c4HvJxgN6ScaPjV3GA878zDqKt5rGSP7I3wUiLktdbwlesOuLSxI7lNlXrWlt6fwyUjQ5fMV9dOzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keM2MELZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keM2MELZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948881F00893;
	Tue, 15 Sep 2026 11:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472198;
	bh=dR2AT7slAh5QiQGKBciNLhR24TAk5bJ3ys4Ah5Rt7mE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=keM2MELZ8tMeEj63s6rILS1a6ikUND0cm/hSBjQN5i9zsMHRwumL2LpgndOJca1Aa
	 97kIpfNmItf2JE76ybod5HhCCbaR3uSYEM810jrmgilIii5FRWRh1O86tNdM0FYWJl
	 38f1UHzSPEd+hj/T0Nlt8QEoyRs4wb5r4JVdV9i/rSIOmEYhsfaqAD31KqLx/f0h3O
	 ACHfbLbzGXb+++iV7WaxfM+tTIGP+WsUWGxYSjDxuYEbOqm0MVVuZjc4buiK4jUw7O
	 C9LHTBiZSEultvzvuQBhaDEJQMVPhyftCJPppnofTMl7IPUPEYHfgCv4gmlMrEOmjT
	 oPjncB8aAwY0Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:27 +0200
Subject: [PATCH RFC POC 41/50] KVM: guest_memfd: stop putting the
 descriptor back on failure
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-41-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1418; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KLCbLLJNzFhK9KnJoDv8kDUlKXi4pqPjbkN6aCwr8bo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Kk/tfzHImu/Gp6ZRSssN5fyinw4ruUhZCIkyWFT3
 bH7k9a5jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm8sWZk6GKcxbHPfdfrbYrn
 f0Zr1u290KLF8etT65HPSeyxa5JK9zH8jwg7xHPKv6v/9/8HHp3fHOUXznI3MuD7/nrNS8a/OUU
 arAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 virt/kvm/guest_memfd.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 625e62e1a031..e0d1cb869342 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -526,17 +526,16 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	struct gmem_file *f;
 	struct inode *inode;
 	struct file *file;
-	int fd, err;
+	const struct fd_slot *fd;
+	int err;
 
-	fd = get_unused_fd_flags(0);
-	if (fd < 0)
-		return fd;
+	fd = fd_prepare(0);
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
 
 	f = kzalloc_obj(*f);
-	if (!f) {
-		err = -ENOMEM;
-		goto err_fd;
-	}
+	if (!f)
+		return -ENOMEM;
 
 	/* __fput() will take care of fops_put(). */
 	if (!fops_get(&kvm_gmem_fops)) {
@@ -575,8 +574,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	xa_init(&f->bindings);
 	list_add(&f->entry, &GMEM_I(inode)->gmem_file_list);
 
-	fd_install(fd, file);
-	return fd;
+	return fd_stage(fd, file);
 
 err_inode:
 	iput(inode);
@@ -584,8 +582,6 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	fops_put(&kvm_gmem_fops);
 err_gmem:
 	kfree(f);
-err_fd:
-	put_unused_fd(fd);
 	return err;
 }
 

-- 
2.53.0

