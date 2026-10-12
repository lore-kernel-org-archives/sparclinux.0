Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA293B4E9E
	for <sparclinux@vger.kernel.org>; Mon, 12 Oct 2026 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830936; cv=none; b=shVbo0eTT56wD+QlGXupF8eI93t+YhhVO9XSA0sTlgReR8cQFSs29GhqfzebstkSVq1E4WbyiiMAmAiSY3kgKUVS6Y52EHpwDRVAAx6bI8U4rVtWzvJc7qH7h+A6H79XhqTx6jzC7z2Tl2YMVbOilY69ijEp0Rwfc6p+c4Hkems=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830936; c=relaxed/simple;
	bh=ytqbOVvXrJO6eXGr1gEj/F4d+JQaBqdQ4fhCdMycmpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+ENEkKdl480zMkr9z/0a3NBdIKpIlB8tuB0y7vy6CbgR5hxasvjjBcKL+XqxPZRwSq2+eqwguVQmCaVr6VdvNoaWd2nBPS4UOfPa655W5PPnKR5rgXWorYK6EmeSmM8rD57LpX3b2ciYTk0I2roasb2yCZsazx322KWFV+v2i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHAHO+L/; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHAHO+L/"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c169ae1cb26so746244366b.1
        for <sparclinux@vger.kernel.org>; Mon, 12 Oct 2026 11:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791830931; x=1792435731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lJQ3Hg947nYGt/YgtzMTiRanQurATHC6+G3Zb6saEl8=;
        b=OHAHO+L/oIlGbhrvFO9sx3GmCkpPxx/dUFtSJmn184TLk/WzkE+eDUvolJrTILtsSX
         Y94YQBg6D0vifPosVtoavLljqtvdgCKXcrUs+nOKnh88uv9i2wAmw149AYeEc3Mps/vS
         Ht54VSX4On9f8yMBCcK9/oQfVGDe2h+LjNKNraQf2QjehJNaZa3Dsl//EVEUYywyVJy8
         LABvZLJwsDD93UsL/jD9G9cBwn2pwLM40VKag2qB7iXjKsREzzoh9BThtFt5vJlkW8ki
         rsSeggGhgboIVcTM1AjbK7COcjxpJwjPoHr5xbGdWK8C/OA0tl8RD5Cf+wybJe3duTQI
         Y05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791830931; x=1792435731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lJQ3Hg947nYGt/YgtzMTiRanQurATHC6+G3Zb6saEl8=;
        b=rgPWe4Mi4QPWGIN+NU2YmfrJ4p/O3pamTpMreOfGOiHlH9qgbd+POfkhHmMgM4pPQi
         HGbaYaq1xosDyQ+WwDctD8lUiludPGXiT4Xj0OHgOjfIPCDWulL6ZQbupwvzFtKgyIxf
         6YEGB6+WbqDZYROFqVE6bNwKVp7JbKGfVb/KznADWolMdwho3Vx6uSYV4h7NUXUYEwrj
         Z7OLbKH0vBHMFup2/ITF3deD6Sm8CPkSNJpMq1ufQyLdGlm4ZJW8ahtVZtRbHBREdvoB
         mJVdR4TjSUmAkapyLdsaS1mb7cqstR01ozwDZiKKRYyNTuMKBaKa8bHKKPffdS5FFEZV
         hTsQ==
X-Forwarded-Encrypted: i=1; AKwUvBzng45SqSh33UmpIrDPm0Gp2hgDPL/WNmJqlTYaHygvmgV2Fi7VRQxRAjQdjK27+KeSbmTA+RVbyy+P@vger.kernel.org
X-Gm-Message-State: AFq9FYKIlw5fB0fS6uoHiBaIujZ4uUMXPuynLHFd7BvGrrw/pIyQ9Di9
	9NM2WlWixXf48WgNUcnBEY4GkTvvronp5r9fKatWUyFaRHHGQZUtyElc
X-Gm-Gg: AYBFou37NRhxk0rUyPb+Q3jLuARdVhJcCTKSXRv9P1bjpiCMySN7em7P4A+ZSNB7Hjc
	UhkYGM9qnTnZGJNtUMYRPpGb54yvhGevJk1d9Oyz+gLRTm6tDDCHuDlb/AUaZJwE1FBoX0KKcOd
	czAj/xDQ8OWZuo/nqrw0T42KotRLCBgq15r5/8fEUgrcUoQeVIOqzoQ5DVYEL/CgNe6Cb1RBwt5
	ShmpFcOqAUha/1NknKGArcQAYvPl9hbvtRFcGkIq9KeoxJoPJuwIErzCrltyFx0StRmzoUENUla
	Wlqa6PvXZeiq4Mu2Z/odMo+FevKR5WIxeKH0QkHJAhEVyew86oxsLQ14Mi7IgBT4voPohEVGzyh
	cDWy+jsrnuLhrry4D16OrqIhKbym6cmmcxNJaN3bLzrSsznBRDeDTwub4FzyuwMh2F6Aj1f3o5G
	PkiMuozQfRoXa7Q0BV4v8khVDxUJfkrdecT+KEE7x3Lakvzz8hf97eXCJVvt/OrSXybGgEEy51x
	iMTMhljWV2A2K2JImrCGnWBEr12c+smL1ktLjAdDmR8a6CU77c=
X-Received: by 2002:a17:907:e105:b0:c32:465f:826d with SMTP id a640c23a62f3a-c32465fa3cemr482522366b.17.1791830931322;
        Mon, 12 Oct 2026 11:48:51 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa5aa7sm488517666b.55.2026.10.12.11.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:48:50 -0700 (PDT)
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
Subject: [PATCH v3 5/8] sparc64: validate Fire register properties before initialization
Date: Mon, 12 Oct 2026 20:48:06 +0200
Message-ID: <20261012184826.986050-6-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012184826.986050-1-linmag7@gmail.com>
References: <20261012184826.986050-1-linmag7@gmail.com>
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
