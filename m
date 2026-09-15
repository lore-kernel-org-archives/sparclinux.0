Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63974A9D71;
	Tue, 15 Sep 2026 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472231; cv=none; b=h8gk64vs0k16w7K5Ht5FYY1t6bgNqZedL2hsUz9qxszmr7NWloVqJkHebhP2f4ouD/zTc5aiXaL6jwlA7fVIKgSF3X6k2CHiF+YFtw+KCVVEsukFk8WCZn1Us/U6loHz1QJeQCFAmSlTys018PoTULIYL1gUjaa0u/jmJLYs3lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472231; c=relaxed/simple;
	bh=ydrjF0IvCagPMk+8W3Lo5F+Om/GvHyzFN7KTNwOeZ+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZfAphqqhxgavVw9mGRB5AjFOpovN6cEU+H4mJwc5m70NiB+bgLkPKt4hZgac2GVcUdBndrykWENMtP2VHzbMY/cEBsPGsCMsdl7ogCtgXWS/nzfiAk1JfbzXwVQ98jqg53nDL58sSVVEoDHDsnxgjpAbsqFx4AbkoNPqfT7DMPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOCbPxoT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOCbPxoT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6561F000FF;
	Tue, 15 Sep 2026 11:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472229;
	bh=xKFkiCa0hlTe3sMnpSzoSnXToiZbVbh61g+KJO9ieuc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oOCbPxoTA5tRVDE1SDW2p9tC0NlFv3Be5GpoNWhYmURnweQxEsEdX5T61GQni5xDr
	 dB8oKq6yW0o0+gkex/ln8ORrTi4m/ksGAeRyzNp36yZlNMlPyIA0cXetpfDQyX5Jlw
	 kUeKik4FTXQWhScuFLMluxrSG6c9A9ZCbrTYp9zYSiEAOHtRRYECmeCyootOfrgsFF
	 4aVzqXKYOQKlcIlDUd5HFPC99RpSLMKbQX+NeTk8Ib6ernTnIZhKKs5s66GAw9HT8a
	 aS1v8S5YrjxrTs7D5UvVddV+Ou7n/rKAkdnUoUpvZBcB6uDYitfeHcIW+Z9u4N80Fg
	 U5N4JdROMjYmQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:31 +0200
Subject: [PATCH RFC POC 45/50] accel/habanalabs: stop putting the dma-buf
 descriptor back on failure
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-45-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1297; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ydrjF0IvCagPMk+8W3Lo5F+Om/GvHyzFN7KTNwOeZ+c=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Kn/suYdZ5X5676SLT84zbaJW7EmM036Hiq6ZOOqB
 ZPZLiWKdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEfjfD/8KDx3tMQu5s8Nvq
 pTQrXEN8zcGDu7l3Sq29EHzMOo0/S5yR4VJD+//LnadWytZe1frxs+H8kb1LmHzvH1hrULDM+7H
 3NRYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/accel/habanalabs/common/memory.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/habanalabs/common/memory.c b/drivers/accel/habanalabs/common/memory.c
index 361cff577381..1559442cd56f 100644
--- a/drivers/accel/habanalabs/common/memory.c
+++ b/drivers/accel/habanalabs/common/memory.c
@@ -1861,11 +1861,13 @@ static int export_dmabuf(struct hl_ctx *ctx,
 {
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 	struct hl_device *hdev = ctx->hdev;
-	CLASS(get_unused_fd, fd)(flags);
+	const struct fd_slot *fd = fd_prepare(flags);
 
-	if (fd < 0) {
-		dev_err(hdev->dev, "failed to get a file descriptor for a dma-buf, %d\n", fd);
-		return fd;
+	if (IS_ERR(fd)) {
+		int rc = PTR_ERR(fd);
+
+		dev_err(hdev->dev, "failed to get a file descriptor for a dma-buf, %d\n", rc);
+		return rc;
 	}
 
 	exp_info.ops = &habanalabs_dmabuf_ops;
@@ -1889,8 +1891,7 @@ static int export_dmabuf(struct hl_ctx *ctx,
 	 */
 	get_file(ctx->hpriv->file_priv->filp);
 
-	*dmabuf_fd = fd;
-	fd_install(take_fd(fd), hl_dmabuf->dmabuf->file);
+	*dmabuf_fd = fd_stage(fd, hl_dmabuf->dmabuf->file);
 
 	return 0;
 }

-- 
2.53.0

