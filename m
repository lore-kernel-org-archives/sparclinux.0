Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5D9503BE0;
	Tue, 29 Sep 2026 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790680218; cv=none; b=b1mpeFsKhFfEzIIcgaI+2oCf/zXronWQtWvxJCOT5UYoCFjVwStB0xb0CX1FcXIXWsWa663EiAr4LArvG4Aa3vpMCT30R1mrJVV0Yh9mlMGCBt4TsozYk93WZBqH8giyYOEVN35MURwjeIHhAvT3/pqLxoO55VSvHcQtWcD0JeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790680218; c=relaxed/simple;
	bh=YH0Um3VSovZ7PqOPyzS2SRP920gv50q/1sSMhdd7um8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oUSymIUI6BuIJ+ueK0zefgZqMvlMsTcODAh2rbv5kWuKCpor0fjVzJoOOpjdfqHg7+ste+LfWiIQxPXSUSL3PV0KVV7jDifVVLQ5R9T0iEdFUJLdkHz1lRBfRLv6wnaMcwkwmcjypmUMcDQm7AmmsUUh3Idp2ytNvN3HQbgrcW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=IlcaUC9y; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="IlcaUC9y"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790680213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dPCrE7MS2QE6KWBYSZz24ZoIsqbiNbT5XOja2Ud4bdQ=;
	b=IlcaUC9yMpKF9EvJYISpIKOOBmJlar/lf28fuiosiXJKaEffHBejle14KLwLHF4saqNQt2
	dfgyJKoG+RANo6qnp6pmVBZ/Vcq9MsOupAr1arKO7NRy/VO3YOp5X9aMBGJWR/+IM8fDBu
	sTnZlc2kYkVtRFXmCZfJpsjECyO6L88=
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH] PCI/MSI: Clear msi_desc::irq in the legacy teardown path
Date: Tue, 29 Sep 2026 13:10:03 +0200
Message-ID: <20260929111003.3707239-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_msi_teardown_msi_irqs() runs the legacy teardown and then calls
msi_free_msi_descs(), which refuses to free a descriptor that is still
associated with an interrupt:

	/* Leak the descriptor when it is still referenced */
	if (WARN_ON_ONCE(msi_desc_match(desc, MSI_DESC_ASSOCIATED)))
		continue;

MSI_DESC_ASSOCIATED is msi_desc::irq being non-zero, and nothing in the
legacy path clears it - neither the generic arch_teardown_msi_irqs() nor
the arch_teardown_msi_irq() implementations on sparc and mips/octeon.
Every teardown therefore leaks one descriptor per vector. The check is
WARN_ON_ONCE, so only the first teardown after boot is visible and the
warning understates how often this happens.

Before commit 9fb9eb4b59ac ("PCI/MSI: Let core code free MSI descriptors")
free_msi_irqs() freed the descriptors unconditionally, so a stale
msi_desc::irq was harmless. That commit moved the freeing into the core
and added the precondition without satisfying it here.

powerpc overrides arch_teardown_msi_irqs() and clears msi_desc::irq
itself, so it is unaffected; do the same in the generic implementation.

Reproduced on an UltraSPARC T7-1 (ixgbe, "ethtool -L <if> combined 4")
and on an UltraSPARC T4-1 (igb, unbinding the PCI function). Verified
fixed on the T7-1: repeated MSI-X teardown and setup is clean.

Fixes: 9fb9eb4b59ac ("PCI/MSI: Let core code free MSI descriptors")
Closes: https://github.com/sparclinux/issues/issues/104
Signed-off-by: Stian Halseth <stian@itx.no>
---
 drivers/pci/msi/legacy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/msi/legacy.c b/drivers/pci/msi/legacy.c
index db761adef652b..f174859485552 100644
--- a/drivers/pci/msi/legacy.c
+++ b/drivers/pci/msi/legacy.c
@@ -45,6 +45,7 @@ void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
 	msi_for_each_desc(desc, &dev->dev, MSI_DESC_ASSOCIATED) {
 		for (i = 0; i < desc->nvec_used; i++)
 			arch_teardown_msi_irq(desc->irq + i);
+		desc->irq = 0;
 	}
 }
 
-- 
2.43.0

