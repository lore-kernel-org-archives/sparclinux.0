Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF2E4A99B5;
	Tue, 15 Sep 2026 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472263; cv=none; b=Jm0miXCRDXqzvEML82FcFSQu+fV0XgXxaecrTZlNO5oGqxQHyIW33UBCo22gIM04+M/EEFp/BX15zpGtPQSM6ttsjk0J3zWHBtuHoGOwzKQDQ21gPa1IDa6NqyMoUSV2HcYXIQQH6xHcBmRp6aY5K7helPB1seq6oY1QGCZPVY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472263; c=relaxed/simple;
	bh=Tx0MTQ1YnVtsCJithyQQ1YlkyHM6SB+QGz8po6KWPTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ow3rGa0cUOUL44cQX/2/NQN3CcVVbKE5c/8unYHPFkck3IG+UAA/OMNBK5wFKFHPydAkpEjoGLry0DarkMxA2hpPZxSSjxQYtWpS6tslgp3EJmCSRbahZMMA2/nk4zZTJz18FD5U6d3u2GVFyvFThgane5J2q21epHyJe5r0fcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMo47o/J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMo47o/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B071F00893;
	Tue, 15 Sep 2026 11:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472261;
	bh=tjgNPx3x7WII2tr/AwvmAnEJWXGOM0OeaxbIcUanKyI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SMo47o/JPxKGY6qTNLRWBziEbn+58IX3nPctPMC7Rjv/4Cm+o+BJijIJnYVe8zJNi
	 wtm2ogfTwLSXwVXiRa8BwU676bAhTFIUDdSLL7QWmD6wZs73V9DyEUOfRDrJ+IY403
	 kqv0bmOC18w9ruJeugOg/OVAFQjR9gpxqiygmBT/TwoeVymZyVDEbKq6Hd3l29gwkE
	 6gMLb1D7frbGbL+XuuTzjEeBT25eZX3KvVOEPtQdK5AuDh5R02exf0Wm9bz+fe67Iz
	 hw49+A+yqFYEMWzyNlTUmA/r+VKXbFFAqeFAkxdiB9zM9A5cJNU9ykZ66qrgX/f5g4
	 5B2mHT5wBqVHQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:35 +0200
Subject: [PATCH RFC POC 49/50] iommufd: stop putting descriptors back on
 failure
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-49-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3656; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Tx0MTQ1YnVtsCJithyQQ1YlkyHM6SB+QGz8po6KWPTc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Kk3WbDjFvN29pT3Xq7896z8vX2FtjvvefB1xQfue
 XsWsk4o7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI3CuGf/rLHM5NDdh5MSei
 56otb6TCFq/HRZ/fcG4J0t5of2Rr5hxGhp4HVV1b2aIEtkx5uGOb3IS1967+fbb6v6rTAdk7ocz
 G3mwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/iommu/iommufd/eventq.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index 747dd5155121..f5fdc6cdf0a1 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -412,9 +412,9 @@ static int iommufd_eventq_fops_release(struct inode *inode, struct file *filep)
 		.release = iommufd_eventq_fops_release,                        \
 	})
 
-static int iommufd_eventq_init(struct iommufd_eventq *eventq, char *name,
-			       struct iommufd_ctx *ictx,
-			       const struct file_operations *fops)
+static const struct fd_slot *iommufd_eventq_init(struct iommufd_eventq *eventq, char *name,
+				struct iommufd_ctx *ictx,
+				const struct file_operations *fops)
 {
 	struct file *filep;
 
@@ -425,14 +425,14 @@ static int iommufd_eventq_init(struct iommufd_eventq *eventq, char *name,
 	/* The filep is fput() by the core code during failure */
 	filep = anon_inode_getfile(name, fops, eventq, O_RDWR);
 	if (IS_ERR(filep))
-		return PTR_ERR(filep);
+		return ERR_CAST(filep);
 
 	eventq->ictx = ictx;
 	iommufd_ctx_get(eventq->ictx);
 	eventq->filep = filep;
 	refcount_inc(&eventq->obj.users);
 
-	return get_unused_fd_flags(O_CLOEXEC);
+	return fd_prepare(O_CLOEXEC);
 }
 
 static const struct file_operations iommufd_fault_fops =
@@ -442,7 +442,7 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_fault_alloc *cmd = ucmd->cmd;
 	struct iommufd_fault *fault;
-	int fdno;
+	const struct fd_slot *fdno;
 	int rc;
 
 	if (cmd->flags)
@@ -458,22 +458,19 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 
 	fdno = iommufd_eventq_init(&fault->common, "[iommufd-pgfault]",
 				   ucmd->ictx, &iommufd_fault_fops);
-	if (fdno < 0)
-		return fdno;
+	if (IS_ERR(fdno))
+		return PTR_ERR(fdno);
 
 	cmd->out_fault_id = fault->common.obj.id;
-	cmd->out_fault_fd = fdno;
+	cmd->out_fault_fd = fd_prepare_fd(fdno);
 
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
-		goto out_put_fdno;
+		return rc;
 
-	fd_install(fdno, fault->common.filep);
+	fd_stage(fdno, fault->common.filep);
 
 	return 0;
-out_put_fdno:
-	put_unused_fd(fdno);
-	return rc;
 }
 
 int iommufd_fault_iopf_handler(struct iopf_group *group)
@@ -506,7 +503,7 @@ int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
 	struct iommu_veventq_alloc *cmd = ucmd->cmd;
 	struct iommufd_veventq *veventq;
 	struct iommufd_viommu *viommu;
-	int fdno;
+	const struct fd_slot *fdno;
 	int rc;
 
 	if (cmd->flags || cmd->__reserved ||
@@ -543,24 +540,22 @@ int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
 
 	fdno = iommufd_eventq_init(&veventq->common, "[iommufd-viommu-event]",
 				   ucmd->ictx, &iommufd_veventq_fops);
-	if (fdno < 0) {
-		rc = fdno;
+	if (IS_ERR(fdno)) {
+		rc = PTR_ERR(fdno);
 		goto out_abort;
 	}
 
 	cmd->out_veventq_id = veventq->common.obj.id;
-	cmd->out_veventq_fd = fdno;
+	cmd->out_veventq_fd = fd_prepare_fd(fdno);
 
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
-		goto out_put_fdno;
+		goto out_abort;
 
 	iommufd_object_finalize(ucmd->ictx, &veventq->common.obj);
-	fd_install(fdno, veventq->common.filep);
+	fd_stage(fdno, veventq->common.filep);
 	goto out_unlock_veventqs;
 
-out_put_fdno:
-	put_unused_fd(fdno);
 out_abort:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &veventq->common.obj);
 out_unlock_veventqs:

-- 
2.53.0

