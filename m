Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9F14756C3;
	Wed,  7 Oct 2026 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791378806; cv=none; b=iAPsl0xay24zDNO8D5kh/9Rj3aN8USU8O4BJlQ1VPoTWAd/KUVcVNmn9+8RiXSbeZyCEtacWYUaTr+g9axUXg2gkZlRHzA/TAUVmQajkOc3UU57z6SYYE15QwJnptJ4M6K5W4JE0PUPlJIzVrirASo/eJlsaJO5d1LVSh8y/KSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791378806; c=relaxed/simple;
	bh=LsRKjUuA8yiYx/+fduNMj6Pn3ZSeNz80ZMG6BEqYAJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o0qWdDYidcBkZqr39OkdzljfT88OXUiDZFJs45O682u70OeWJRj0I4sroq/pKJcpLwIKuM3ZwfSBlHeOeneH1LHknOXDmlhT6RD3oRUZ0aJWX8iG4fPCjomzfHkrRIMaanRqqln8uyLKwxVU+lgUom6KGoknfeu92Oq7Lwa+X70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=cYKP8h8C; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="cYKP8h8C"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791378794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UinKWqIbgjSBn0S0/ReeQkmBlx3lLuVFDaLY0ELTIy0=;
	b=cYKP8h8CMke1eXZTCl6uC9/ujdqhmiUMfBFE4Q6AbdQcpNSNtzlrUHw1SBuou+tkUyQ2eR
	HS7EBt3esxlFYTAJ2Vv5RLOX+2Oty2jKRm78tyOrijXlpSZE+8+TiyL1TAkJN3R2fpOhta
	tV/HOQCkkI12OuqmJPZXr95SjQiSy3k=
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-pci@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH] PCI: Set supported_speeds in set_pcie_port_type()
Date: Wed,  7 Oct 2026 15:13:04 +0200
Message-ID: <20261007131304.309511-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sparc64 and powerpc create PCI devices from the device tree in
of_create_pci_dev(), which calls set_pcie_port_type() but not
pci_setup_device(). Since d2bd39c0456b, supported_speeds is only set in
pci_setup_device(), so it stays 0 for these devices.
pcie_get_speed_cap() then returns PCI_SPEED_UNKNOWN, max_link_speed
reads "Unknown", and the failed link retraining quirk passes
PCI_SPEED_UNKNOWN to pcie_set_target_speed(), which warns on a SPARC
T7-1:

  WARNING: drivers/pci/pcie/bwctrl.c:125 at pcie_set_target_speed+0x284/0x2e0

Set supported_speeds in set_pcie_port_type(), which all three paths
call.

Fixes: d2bd39c0456b ("PCI: Store all PCIe Supported Link Speeds")
Closes: https://github.com/sparclinux/issues/issues/109
Signed-off-by: Stian Halseth <stian@itx.no>
---
Tested on a SPARC T7-1: before, max_link_speed reads "Unknown" and the
warning above appears with CONFIG_PCIEPORTBUS; after, all 23 PCIe
devices report their real speed and the quirk lifts the 2.5GT/s
restriction without a warning. Not tested on powerpc.

 drivers/pci/probe.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5afc..52a79b033b069 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1651,6 +1651,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
 		pdev->aspm_l1_support = 1;
 #endif
 
+	pdev->supported_speeds = pcie_get_supported_speeds(pdev);
+
 	parent = pci_upstream_bridge(pdev);
 	if (!parent)
 		return;
@@ -2074,9 +2076,6 @@ int pci_setup_device(struct pci_dev *dev)
 
 	set_pcie_untrusted(dev);
 
-	if (pci_is_pcie(dev))
-		dev->supported_speeds = pcie_get_supported_speeds(dev);
-
 	/* "Unknown power state" */
 	dev->current_state = PCI_UNKNOWN;
 
-- 
2.43.0

