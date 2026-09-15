Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC7D4A8A04;
	Tue, 15 Sep 2026 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472191; cv=none; b=AnJ7NoOT49ubbpToWzkRi0NrsxrucIo0v1NHSEhx6pzPOgbiE63XDTprQWtSBxnc5uOZYhnBH84zoW2a/HL01ItdkLPG7XhIjX7Xxfm8soiHYb7qUqKspgSF+G7rdwp+Bt03a/U3bLlk/BHbxXUQmnwMRaUFuka7ak9hiUTDGAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472191; c=relaxed/simple;
	bh=78vO7PDsYGy3GJUzt5pCpyZhq20MYXeEqBv9mkCwUOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SDeK3bSSJlgbjTiuFanJ8kYFEnU/wrnSk46D91fBEv0QSUDrQ/rbAWPDrbnrzIC1EFJpJmsX9lySTPYuHWR2YktnIGbIETN7sT9NtcPFLCiHT0OYFByt05BPkj6GL+LhsOtbRYIlOxOwX0RZFv4prRvKqMpPVE8/ruPiBU/KuhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOl8mduH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOl8mduH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A888C1F00898;
	Tue, 15 Sep 2026 11:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472190;
	bh=0ixA4Ace6BJn7IjrzCTCU0/h7/zoW2kue4sGkrY9xCg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JOl8mduHPaeVv3eaq9MEhCqzMicOygBaK5O7Dzp/RHXpO7NODADnSsZqyfqWqEQZR
	 lR/VPeQyWMIddPe1rPhDu05Hlm3nHa5FLkG932tVgVvVmp1QfM/hVE5mMYh+azuISL
	 UmAM+w7jZ6/RT6AK2zvRXbcbWwva8oTaEAofof43ADeJYUXP4l+fKFnPm5nLpARsob
	 2FLL0ErbZn7q0fCeD9rQeCPTtW4yh3QMmMpEVQM39yn4qUnY43PiI3hNDpcRqaUIti
	 KY9m4cCM616bpCnYMsG+DY5wREnfHQo42u9v21mvFC1w6Cr6Wausbj6m5LHNP95jEM
	 Ck7KRCyZ89YTg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:26 +0200
Subject: [PATCH RFC POC 40/50] KVM: stop putting descriptors back on
 failure
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-40-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3135; i=brauner@kernel.org;
 h=from:subject:message-id; bh=78vO7PDsYGy3GJUzt5pCpyZhq20MYXeEqBv9mkCwUOM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KmrZTOP7Ev9FMJVxubVxbdNfUMIq6RooWz7Kg6W0
 u0ly+I7SlkYxLgYZMUUWRzaTcLllvNUbDbK1ICZw8oEMoSBi1MAJmLaxPC/6MvkYx+dQ5OZjxmx
 1NY+4H3y0sQ15JTH4W0GqkVf38y+wsgwpWTB7u0yUtPOBqdErHHe3P2Vb+cBu4mdx15GLt51wuM
 UCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 virt/kvm/kvm_main.c | 65 +++++++++++++++++------------------------------------
 1 file changed, 21 insertions(+), 44 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d..8d3d47a6c98a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4326,27 +4326,18 @@ static const struct file_operations kvm_vcpu_stats_fops = {
 
 static int kvm_vcpu_ioctl_get_stats_fd(struct kvm_vcpu *vcpu)
 {
-	int fd;
-	struct file *file;
 	char name[15 + ITOA_MAX_LEN + 1];
 
 	snprintf(name, sizeof(name), "kvm-vcpu-stats:%d", vcpu->vcpu_id);
 
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-
-	file = anon_inode_getfile_fmode(name, &kvm_vcpu_stats_fops, vcpu,
-					O_RDONLY, FMODE_PREAD);
-	if (IS_ERR(file)) {
-		put_unused_fd(fd);
-		return PTR_ERR(file);
-	}
+	FD_PREPARE(fdf, O_CLOEXEC,
+		   anon_inode_getfile_fmode(name, &kvm_vcpu_stats_fops, vcpu,
+					    O_RDONLY, FMODE_PREAD));
+	if (IS_ERR(fdf))
+		return PTR_ERR(fdf);
 
 	kvm_get_kvm(vcpu->kvm);
-	fd_install(fd, file);
-
-	return fd;
+	return fd_prepare_fd(fdf);
 }
 
 #ifdef CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY
@@ -5136,24 +5127,14 @@ static const struct file_operations kvm_vm_stats_fops = {
 
 static int kvm_vm_ioctl_get_stats_fd(struct kvm *kvm)
 {
-	int fd;
-	struct file *file;
-
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-
-	file = anon_inode_getfile_fmode("kvm-vm-stats",
-			&kvm_vm_stats_fops, kvm, O_RDONLY, FMODE_PREAD);
-	if (IS_ERR(file)) {
-		put_unused_fd(fd);
-		return PTR_ERR(file);
-	}
+	FD_PREPARE(fdf, O_CLOEXEC,
+		   anon_inode_getfile_fmode("kvm-vm-stats", &kvm_vm_stats_fops,
+					    kvm, O_RDONLY, FMODE_PREAD));
+	if (IS_ERR(fdf))
+		return PTR_ERR(fdf);
 
 	kvm_get_kvm(kvm);
-	fd_install(fd, file);
-
-	return fd;
+	return fd_prepare_fd(fdf);
 }
 
 #define SANITY_CHECK_MEM_REGION_FIELD(field)					\
@@ -5499,21 +5480,20 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_is_kvm);
 static int kvm_dev_ioctl_create_vm(unsigned long type)
 {
 	char fdname[ITOA_MAX_LEN + 1];
-	int r, fd;
 	struct kvm *kvm;
 	struct file *file;
+	const struct fd_slot *fd;
+	int r;
 
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0)
-		return fd;
+	fd = fd_prepare(O_CLOEXEC);
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
 
-	snprintf(fdname, sizeof(fdname), "%d", fd);
+	snprintf(fdname, sizeof(fdname), "%d", fd_prepare_fd(fd));
 
 	kvm = kvm_create_vm(type, fdname);
-	if (IS_ERR(kvm)) {
-		r = PTR_ERR(kvm);
-		goto put_fd;
-	}
+	if (IS_ERR(kvm))
+		return PTR_ERR(kvm);
 
 	file = anon_inode_getfile("kvm-vm", &kvm_vm_fops, kvm, O_RDWR);
 	if (IS_ERR(file)) {
@@ -5529,13 +5509,10 @@ static int kvm_dev_ioctl_create_vm(unsigned long type)
 	 */
 	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, kvm);
 
-	fd_install(fd, file);
-	return fd;
+	return fd_stage(fd, file);
 
 put_kvm:
 	kvm_put_kvm(kvm);
-put_fd:
-	put_unused_fd(fd);
 	return r;
 }
 

-- 
2.53.0

