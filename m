Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3E14AA1CE
	for <sparclinux@vger.kernel.org>; Sun, 18 Oct 2026 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331381; cv=none; b=MJcsqnISJEZd2qbaTxl/hBigu/bBPykcCtX+6vNnoZcSslWS9PQk79goBhqTIm5Y7lTwh8qJYr9InLk1QMbj2vI6PQAWui7fU3ogVFJ0fLmjnM8hU9HK4TDnqpfq4s8tMvCWCKA30NGtUNTj6j32IiByFERo7McRD4IMFYDIWyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331381; c=relaxed/simple;
	bh=7MGTJdk+4Foua3uK4fT3tosb12DKYulonOLvYMkMDW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxYFQCMEKl5NLO60NHA9VVD3MosNx8va67O/DFWBSwJqD7vZvadiNWODEHDUtvcaGFOMwA4o9GwoyMb+p33VbZndeBkG2bjv3uigjHM3zRKe14/ABzXeY3FqNt22bFfvAGLhfoeUoouPslWIUqXB64nBY8Yp91PXKfMENkfsB9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pa2FZ2+L; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pa2FZ2+L"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6afa651700eso1527911a12.2
        for <sparclinux@vger.kernel.org>; Sun, 18 Oct 2026 06:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331378; x=1792936178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QgyOpAgwDJcgNK32/9PGTXHO9coJXI+TEruCjzlJ5Mk=;
        b=Pa2FZ2+L/iITeJOAk5eZ7nVtdjgLS0dBf1QrSKg19f+7gHyFMXPWwzmuUBeyqVr5Ur
         VJ9pi10ckWgzDpWG7C9v5FJGqaJSPeSNtXrQgIiRONz8ha/z5t95QUy9zX08VJ1FmOgF
         7E4ox0cqAhHaF58Jc8JqGln5rVHykaqijkk7QBjvySH2udGVAoJxbEno9peE1W4Ejlz/
         U31Th+AqB4V9r5HlFRRM3fxpHW3ecFEUYr5Nx0gkcO9YBgQ4uxoUzMG0a95WKWNbxhWy
         vkiUktCMsGw90p6Wy0jefQ95At39fqHibmzN8Y4qNwmwR2Qnv+0I7KSjWQkwBPIMZPhS
         5QOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331378; x=1792936178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QgyOpAgwDJcgNK32/9PGTXHO9coJXI+TEruCjzlJ5Mk=;
        b=wdDUN6m2X5j+8uR7BFFiRFEpYVogQLK4CamfUj3bMacOT3oVFfdx2BFuQwcEIvdk6u
         IAAclw96jW30zQ7v49XdmSQtBYK77REBmYiG7qsz5AJ7lQfKyrljFp9/fTrqS/jPhRTs
         kfqMPkIvr7ZO8VcgEsB+vrO/7NSKXRMmHgS1KIUXkVAJRvPLJG2Ad92q4us3oDJ5F5mK
         QEtgd5pZNEWMEMg8gV4bLogtbIVbMKFL7D4dj4jcgMiIjvTDJhWX1trcSzsdFpDyry7z
         +rgesnV5Nw0EkBi/0qn+logKSWvkPGNBZi9MaUmUCHXqgOROld5jlsFoNZ5ZUnvxSX99
         Iq1Q==
X-Forwarded-Encrypted: i=1; AKwUvByNQtLPbx6SQnbXAxsb0dxh0Chh2KPLleRV2V+GPP1Wz9+El32R7EoXcAkIrpQ/o0gEVTIM+s74qFdS@vger.kernel.org
X-Gm-Message-State: AFq9FYK3FcazU06clyIrh42daGjGKwMLgSSjaApVcBkJGgfxv+lMoJ5c
	Lx6cWFhxwk0dnDdGPSG11tobpGiOzEkTz/Wdhr2bl0DL26ULLE/MaoFemikArUKQ
X-Gm-Gg: AYBFou2mjxuWOJVcBKfMHy8SvppxLnZwomCrRgsJMgGnxAMvf91QoCe12upaIrxLkpS
	ImjMF2DJ2EDcWyQDy/wC3jVYOOiePNGqlAbLpCBF2MO7qjmWvNTU2ywAVrbxLX0uWI5+9ZezgEN
	//8sITTKoc4PNzphk7DaMuvwa48J24Q8lGOZ1uKarW/Hw5MlSdVhQpMRK0/08fKgi/AIJl7m1pC
	q4ZkWOnAKmcxKAk4p2F685zxd7RazTHUlC5+jVLj9p+xnmJf1UXerQeAgAhK7GlTtKwnaysfLwK
	yVrsgzpHEAM/BKK0nio7UiSC87CMZQ7fBVdbJJuGUdIug3iBRNk1ur1F2TPd/6VePKJoX7OrJrB
	u5Q0O0oGPejUpRi0/4+yIJPeSxT/paIiMh8b+GK1q0XajvL02L99eBi9Qv51x3SyWOQsYfVxT+F
	2+T3D0/WWa1lhpoy94cdUoyiw8QMlCmOiTdHuENY+gIYgz550thm+D7Swx99cmlMTAGUA1YGVPN
	ng2Vndxc5ZSYsspTmlzO0Cnw5vkvyM3+8P6EH/K
X-Received: by 2002:a17:907:d86:b0:c29:f5d5:5aa4 with SMTP id a640c23a62f3a-c41a08dbe04mr331615566b.46.1792331378553;
        Sun, 18 Oct 2026 06:49:38 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:37 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com
Subject: [PATCH v4 05/10] sparc64: validate Fire register properties before initialization
Date: Sun, 18 Oct 2026 15:45:07 +0200
Message-ID: <20261018134738.1016106-6-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018134738.1016106-1-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Fire interrupt translator reads one reg entry, and PCI PBM setup
reads two, without checking that the firmware supplied enough data.

Check the property before allocating the translator or changing PBM
state. Halt early translation on invalid firmware data rather than leave
raw interrupt numbers untranslated. Return an error from PBM setup so
probe can release its allocations.

Fixes: 861fe90656b8 ("[SPARC64]: SUN4U PCI-E controller support.")
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/pci_fire.c      | 9 +++++++--
 arch/sparc/kernel/prom_irqtrans.c | 8 +++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/pci_fire.c b/arch/sparc/kernel/pci_fire.c
index c35a8e3c1eae..db160eeb0ffe 100644
--- a/arch/sparc/kernel/pci_fire.c
+++ b/arch/sparc/kernel/pci_fire.c
@@ -416,7 +416,13 @@ static int pci_fire_pbm_init(struct pci_pbm_info *pbm,
 {
 	const struct linux_prom64_registers *regs;
 	struct device_node *dp = op->dev.of_node;
-	int err;
+	int err, len;
+
+	regs = of_get_property(dp, "reg", &len);
+	if (!regs || len < 2 * sizeof(*regs)) {
+		dev_err(&op->dev, "missing or short reg property\n");
+		return -EINVAL;
+	}
 
 	pbm->numa_node = NUMA_NO_NODE;
 
@@ -429,7 +435,6 @@ static int pci_fire_pbm_init(struct pci_pbm_info *pbm,
 	pbm->op = op;
 	pbm->name = dp->full_name;
 
-	regs = of_get_property(dp, "reg", NULL);
 	pbm->pbm_regs = regs[0].phys_addr;
 	pbm->controller_regs = regs[1].phys_addr - 0x410000UL;
 
diff --git a/arch/sparc/kernel/prom_irqtrans.c b/arch/sparc/kernel/prom_irqtrans.c
index 5752bfd73ac0..558ed5114664 100644
--- a/arch/sparc/kernel/prom_irqtrans.c
+++ b/arch/sparc/kernel/prom_irqtrans.c
@@ -544,13 +544,19 @@ static void __init fire_irq_trans_init(struct device_node *dp)
 {
 	const struct linux_prom64_registers *regs;
 	struct fire_irq_data *irq_data;
+	int len;
+
+	regs = of_get_property(dp, "reg", &len);
+	if (!regs || len < sizeof(*regs)) {
+		prom_printf("%s: missing or short reg property.\n", dp->full_name);
+		prom_halt();
+	}
 
 	dp->irq_trans = prom_early_alloc(sizeof(struct of_irq_controller));
 	dp->irq_trans->irq_build = fire_irq_build;
 
 	irq_data = prom_early_alloc(sizeof(struct fire_irq_data));
 
-	regs = of_get_property(dp, "reg", NULL);
 	dp->irq_trans->data = irq_data;
 
 	irq_data->pbm_regs = regs[0].phys_addr;
-- 
2.43.0

