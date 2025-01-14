Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2097C20D50A
	for <sparclinux@vger.kernel.org>; Tue, 14 Jan 2025 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886334; cv=none; b=VWnQscqVhLaKj5T+/3yWwD/c6a+UB5dXmba4qTiDOKvlR+AkM/SjBddJJuAbHzN2SDDiAb2wbShFdFI6eopcZUKNFW1/XOh/4Uyh4GQ0JHdTXETEIAFj1LIQIBKMk8GcEOODMGfTjA1Uw1EVESqBnlXav9HR7EpYeS613DuMKUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886334; c=relaxed/simple;
	bh=fFMlpy075VF2iVm7KnCPgWABwgfTFUQR/WaG7uIC8pE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rs8JDQUjMmHLInE/6DFXpLNh1AEPKltY/28cOc5ynT83NiFe2n9Qi/7P74IcbyJjr0/pp9rJvH5O8XblCud7II71zaVMshMB0RqoDCVGMZe6kUIihK/c61GZky8Jgs46wfpqWQNWQkc/PGdZdfKUkmrFghx/FfEJk7Kuw9Y/tFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uYR9utJb; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uYR9utJb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736886319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nq1GSoyzFE050E1zP4B3DD0NdLu0U/eq0P6oGsh9EnQ=;
	b=uYR9utJbb2djwe0tnRFisVmuETxI52KvtdZ7SWp2G2y3mghnQuvIeT12k327KpqyJWzhNe
	VGbuq0v/GKEs5vj9n5cdXMnNr2fgRt9Cl2Szp7bKq18JXj+yQBfy6j5N0NLwauQ4GpDlpG
	xNU53ntiERkb1Ag3tuiE+e/V7pkM+UA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Dawei Li <dawei.li@shingroup.cn>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sparc/irq: Remove unneeded if check in sun4v_cookie_only_virqs()
Date: Tue, 14 Jan 2025 21:25:00 +0100
Message-ID: <20250114202502.912690-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove the unnecessary if check and return the result directly.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sparc/kernel/irq_64.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index aff0d24f8c6f..81fb49b089a8 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -146,9 +146,7 @@ static int hv_irq_version;
  */
 static bool sun4v_cookie_only_virqs(void)
 {
-	if (hv_irq_version >= 3)
-		return true;
-	return false;
+	return hv_irq_version >= 3;
 }
 
 static void __init irq_init_hv(void)
-- 
2.47.1

