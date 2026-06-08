Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430C13D79FE
	for <sparclinux@vger.kernel.org>; Mon,  8 Jun 2026 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928902; cv=none; b=ndMVtXbPmiKs/rNtqqqENN5TjhE45k+46sM8oJlQWtruFstcP7MS/NUapihHlo9vkoadV/H376CGqzGIwEMNTaPJShbQ72d/YYqczAvdInvb55jZ88qveDbtYMLhX0BoZRt7uZSNGAUzz3pLSDjiZckD4kq8vwrFdt1RxOfUqCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928902; c=relaxed/simple;
	bh=T2wQkK65vboZ4IeGnr4NbeD+9D8laMYxlcwY9lW95Qo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CajqXclDdBJGLyphQJjz+IeKenuRALXYSqUQ/l0ECZDBMHo+jQfdrxJqNej/+Zqz6+b1QX9B7jgzSviclKwEhupdUvO907Rn74htm1FpH9cO7C6XMi0PY5XLacB6ACoHFZruT8oQUEIfPtieUBvxuDziahXKfG+Y5QKaXpZU8gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4+PRLYf; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4+PRLYf"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b9318997so32538855e9.2
        for <sparclinux@vger.kernel.org>; Mon, 08 Jun 2026 07:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780928900; x=1781533700; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCy5icZAFPKbCxn3K3WrZKHkVhOrNfCywaz2Tw/0Yng=;
        b=c4+PRLYfSizK7opXh5cj1qYnHZKBU5HOolrz1/48cF1y3mCOrDbMK1C9CxUfYsJYqw
         nFwyfrpmjtGiv3xlQbKtUv33/6XzyLzmL3hUi3XRHhSrzMAzNwcvmDs11knaw+mCoV5d
         KCR3G79oQrpXz3H/bkx5axQ5AntiOCfnc3ySkzUzQ03qwpFqrpCEx3D4GLCHy5cfFZTq
         JHPwH0Uh0cuHD4e1++rK7KclkVhGSQY69JkC3goefx+MOtsR7qy4YfIeaBy7ZnmKsfBW
         BDxyIqb9RXOFzHPvutpfAj+wnsIMDHbSYCQ7Oev5Jle/z6izykTtfZxFVcpTzUjmFNjy
         okSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780928900; x=1781533700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nCy5icZAFPKbCxn3K3WrZKHkVhOrNfCywaz2Tw/0Yng=;
        b=Es6sIi0FgGyk/5hhiNcpr2A7OEUn0eBL19r4DX8EyHsSOCzZs3MyEt+TJJcR/1TB99
         dzI2JSsoUyAj4j1bGlmzxBSzYOx0nVZ42h0W046f/GkdnsLcde5VYfszep35s3/f3zey
         EN0GGxCwBjpMcnvV48Jqwg2BiFO7uZxOTo9KiLnkCc1HQ7Pvr5bB3UrZ3NieOllUGDZF
         qxhoI0cnj+ufddJx1Su3X1PKtAMFxRrpHJubNqCoucxCz7o+nMZ2eGobeQuVts5mxvxN
         U8at0Sw6je6IdxQWn0HzrGcjNT3WH9FCYN9YQBGlr7CUa2mA1q1infQDGX5XPtpUdtG2
         3lNQ==
X-Forwarded-Encrypted: i=1; AFNElJ82hOEELiXmZcLfS3TVAr48DghNtkVjZAbuDm7DHsZi8blGd8rJTYf/UgQC3e+FyeTm24y05QzCBDA8@vger.kernel.org
X-Gm-Message-State: AOJu0YwOz0HmNVw0vHSY5vyxj2Jzo+OK2rLgnYCn4h+ynE0JCNneGKCe
	C+0Oxz3rGGlucP7Wea8bR+KUCcho2Q2HfL/VMzqRU4sOPNAQv0E5ZSRz
X-Gm-Gg: Acq92OHFhSevaTHYUo1PCGaUyS78sb1tWokJMZE5wYh4YZ2Ib15I0+B/2s8PbkrkzYV
	iFT38M9EP+WKgysQLXB4rgm7sAMV4cjMoJNXxbshPfU309+aRK/xhXV4Xmg19MsdE3nY2b4Qr84
	Y2+O0YDO4ZVmdzfZULIIEuFU0QEvLgULmoXjlIFRQBqsaxAu30HSKXQ1idwVjICULYkSCNWQn09
	vUOeGlT5gHyEZsynfqmuHyFELcZUIXwJ68C3Rw8PXcdYlglzkJNWpLyrT/JnTXCmO9vAwlI7Nb5
	oLKoXydv6mv/yAYpQggoPUXSCs9xFym+pWHtJ5MAr83c9JKzBa8bHkmSi1fXR2z4ZAeNyzCmGIL
	HQhwXDBHMkMpTEC6TRWH8M5YH43nl2tvzm7RIIEkbbkD+m2RSy9HzOmfhPT8IEodW8rQC0whRUn
	441uADexOVy+nDgj4qjhNwNh08z0XBxvO3
X-Received: by 2002:a05:600c:1c13:b0:490:a646:9d75 with SMTP id 5b1f17b1804b1-490c25acd23mr285116345e9.9.1780928899673;
        Mon, 08 Jun 2026 07:28:19 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm41300869f8f.32.2026.06.08.07.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:28:19 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Mon, 08 Jun 2026 17:29:20 +0300
Subject: [PATCH v4 5/5] sparc: Remove remaining defconfig references to the
 pktcdvd driver
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-remove-pktcdvd-references-v4-5-72f88b04cc87@gmail.com>
References: <20260608-remove-pktcdvd-references-v4-0-72f88b04cc87@gmail.com>
In-Reply-To: <20260608-remove-pktcdvd-references-v4-0-72f88b04cc87@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org, 
 Catalin Iacob <iacobcatalin@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=746; i=iacobcatalin@gmail.com;
 h=from:subject:message-id; bh=T2wQkK65vboZ4IeGnr4NbeD+9D8laMYxlcwY9lW95Qo=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhiy1iwe+fN176W16YWiVeI9314lb07p6Lzj+3W/788muq
 H+7k59N6ShlYRDjYpAVU2R5ce5624Y9ZwLuJdm1wMxhZQIZwsDFKQAT2fWHkWHapXnibIku550W
 mbk6q0jxNRhGT0j+lmLZuitp3hHHL9sYGWbP0NXee8F19p7y7cxsz/zmV57RcN3f5PimMlXv5Um
 OFi4A
X-Developer-Key: i=iacobcatalin@gmail.com; a=openpgp;
 fpr=F609BFABD84EB5C9DDDC37EDE89C6A3571CD0E33

Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind some
CONFIG_CONFIG_CDROM_PKTCDVD* references in defconfigs. Remove them.

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
---
 arch/sparc/configs/sparc64_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index 632081a262ba..4abea39281cd 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -60,8 +60,6 @@ CONFIG_CONNECTOR=m
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
-CONFIG_CDROM_PKTCDVD=m
-CONFIG_CDROM_PKTCDVD_WCACHE=y
 CONFIG_ATA_OVER_ETH=m
 CONFIG_SUNVDC=m
 CONFIG_ATA=y

-- 
2.54.0

