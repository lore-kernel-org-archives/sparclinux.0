Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A41B529414;
	Tue, 29 Sep 2026 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689447; cv=none; b=mt7ifZ3JQVTkNCv+CKbCYrbZ3NLl6DlM27aDu6FaRquHoVjQBs0BLub1KyvRR1l26AYhV/YizVVlOLmSr8V5UAo/NrAgzk9TdZHt8x9tCkGVuNFgOKcRzh0m5hE8dTV7SI5/XnuSfWg7K5Kj/ZdS1gK669flT8X7FSz216nAeIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689447; c=relaxed/simple;
	bh=Fpn03qimaoke8YGvS4OLP3GU5bRQ4qiAf3HiLvseimQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMHycAD6TWLJeJtvWsYpYUY/WHBL+s7sYypyxiCT0Y3CBmH/S0YPO7HF5UI94HFdYVkAHGbbYlasGsx+PHNeXwxlahI1z8K9wS0pdJgDKy3NdrUZjXWoaU8uPaGnyO7Y6GDTYVCpp++o7GA7phT9KFw+MkFMk042AwhjlVBvP6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=M/BObsxp; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="M/BObsxp"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790689442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dco2wntbp7gwZCwHul/J8+TIvApIUknJKKkQup4QQJs=;
	b=M/BObsxp4FBnyYOcTucsftDcE0uvYsrxnFbcRgdxUa+gv9IzRY2hXf/11Nh7P2qsIXysC3
	KMgcRiaiinOcT7Bvmd/UQ/fdIZG1WKhw9TiGVn1gc9tJ1UryMDE9yCDAxoUxmrDzZmU6GX
	uifUtX4DJXsZMXYVO1t4BXqClafxO6U=
To: "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH 3/5] sparc64: Report the extended crypto capabilities
Date: Tue, 29 Sep 2026 15:43:51 +0200
Message-ID: <20260929134353.3879030-4-stian@itx.no>
In-Reply-To: <20260929134353.3879030-1-stian@itx.no>
References: <20260929134353.3879030-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

crypto_hwcaps[] is indexed by CFR bit and stops at crc32c in bit 11. The
loops in cpucap_info() and report_crypto_hwcaps() are bounded by the
array, so a higher bit is read out of CFR and then discarded.

A SPARC M7 sets CFR bits 12 to 14. Name them.

  T7-1  CFR 0x7ffb  bits 0-14 except kasumi, so 12-14 are set
  T4-1  CFR 0x0fff  bits 0-11, unchanged by this patch

Signed-off-by: Stian Halseth <stian@itx.no>
---
 arch/sparc/kernel/setup_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index d819ce65d1d44..71d30b3bf276f 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -393,6 +393,7 @@ static const char *hwcaps[] = {
 static const char *crypto_hwcaps[] = {
 	"aes", "des", "kasumi", "camellia", "md5", "sha1", "sha256",
 	"sha512", "mpmul", "montmul", "montsqr", "crc32c",
+	"xmpmul", "xmontmul", "xmontsqr",
 };
 
 void cpucap_info(struct seq_file *m)
-- 
2.43.0

