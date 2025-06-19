Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502AF28B503
	for <sparclinux@vger.kernel.org>; Thu, 19 Jun 2025 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750345340; cv=none; b=SXFoSsiWk4WpG71VN6QTTILDerU3tXMOb4vOYV0DpmXF7Rz2kAgSm6QawCH/YVL3Nnu+WG2fAOZGPKbvVmimZfT5YuRlhrSk+l1qYmeWpFUWV16b18tsAU48swzdLDaHfot1sEKa3gH0BCrFaxeagTSOBp1j6ZjfmXswHhruZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750345340; c=relaxed/simple;
	bh=IKBa4fdDM5m3n0gUqcpAHTOYK8EQ+UNtqzJMikfZ9YE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ji8BKirUBHxNOytdsjTXlDW4/F0B2dLdJo+ikk/Nja9h901JqhdpaRtjbpt3MhjaiWt0FoMNW+fj9Ox4yAcBgnVU5Fd/ChXqjFemIZRcTJgTCJ5IZyP9CMFreayQ8qLOdp4SoNyjfC1ZE6b1Naia2h3+PfTbvGsUTzHNgj7l/PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oCeA20lM; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oCeA20lM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750345326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eMlnqWclCfnWGbyuoWPGL3n3kDlUTflxlSnTbzTPBEY=;
	b=oCeA20lMKCkKaY1Yo1pocpupJzIIXMP/YluFYwXfmM5ZbMQon++axkaDkTLnT1VnqdT4Zd
	p1aK4IFgktNTbfTz36UKIIvz5gZB2EQkpMezDn6Z1mszxPCh4UlqwhYzNGwWfpAnukdfuT
	AfQJ4WvAkN90EwEHz7U2qOpRAqVndp4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] sparc: Remove commented out code
Date: Thu, 19 Jun 2025 17:01:49 +0200
Message-ID: <20250619150151.174832-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The struct fields have been commented out ever since commit 1da177e4c3f4
("Linux-2.6.12-rc2") - remove them.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sparc/include/asm/pbm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sparc/include/asm/pbm.h b/arch/sparc/include/asm/pbm.h
index 0c86261721e7..a26d9d5e0631 100644
--- a/arch/sparc/include/asm/pbm.h
+++ b/arch/sparc/include/asm/pbm.h
@@ -28,8 +28,6 @@
 struct linux_pbm_info {
 	int		prom_node;
 	char		prom_name[64];
-	/* struct linux_prom_pci_ranges	pbm_ranges[PROMREG_MAX]; */
-	/* int		num_pbm_ranges; */
 
 	/* Now things for the actual PCI bus probes. */
 	unsigned int	pci_first_busno;	/* Can it be nonzero? */
-- 
2.49.0

