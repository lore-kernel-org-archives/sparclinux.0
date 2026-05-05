Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFEA42AB7
	for <sparclinux@vger.kernel.org>; Tue,  5 May 2026 00:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939769; cv=none; b=UW+YpKLpy8T8RJBWlsL0LN41X8++Ubfmz5EvnUGCuKCLeqnUGFspiYzuPCf4MZ8Cynpc71ejTifDIblWB7TgiivEo3c44ZX6LZzaqPVHOleTDqxA3Lmu7JGVKujIG4lww/R/L08lm4hsS9ioOkzIPjq4b+EW6h3ybrrf2QAu8WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939769; c=relaxed/simple;
	bh=ffdFtLX0QriqrCpK5790vZSF1WkZbc+9EpOUnwocJj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8+ATi1+pg3FTuu6rtRveDXrLiR6XQI44QUWLMHoLXoGTSTWuameXpybOE2EGIKz2c2hf+pGsqzqvTvl8v9wGPNVusEpkG89tmwYFUrH3FO1tRoVFN6MbDCwt07bwd1tTTZlmh2qnbPguzwZtEmXu426hMkHOi+xiC20gkJEJ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8PjGcf4; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8PjGcf4"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-12c19d23b19so6817079c88.0
        for <sparclinux@vger.kernel.org>; Mon, 04 May 2026 17:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777939767; x=1778544567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6SiGGmk1W7rGOAmTgu0wNG7K88mTT/h+RH+oM7T/g74=;
        b=O8PjGcf46TLb6NR649Xh5ZTyga/BCn1dT8nl5CARSadrx5YRodCvITbEa7F/CX0A5k
         rikYDCFuYllT3k33AeR8qPVfo7nZXmhH6/1KP45hllRnACepEJB0xZG430YY/etYkXrp
         O5fgGRSSqMuB5nqKEc65wHs2orGMfc0WYy2la/Ty/k3ZqbanbAy7eJJuy+XEw0PzP8rS
         c/YafPEReYxbRWoYfIMPRn0YXRh0Qf+hYeNy/F+7KOOCScfi2O1DACm36jY0qGasIKZ7
         oaZ3b5HqaoOUztq5P6vd+ZJyRNnvLgVTQVRkMyy/nSWpiQPz8AeMRw/1RpASh33Ep+bK
         p9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777939767; x=1778544567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SiGGmk1W7rGOAmTgu0wNG7K88mTT/h+RH+oM7T/g74=;
        b=dnBfv0fhJx4AEM2s0Goq9yqKfmvIfBXtZwv8h7exNyyZ14T68vjBYOzkQzmtthLNA3
         IlhHBBLDNYZW5hhLbTJOg4puHa6kgtqZaSuw4Esbu87pqSnBGetW6ONr4s2Kv5BOFY65
         7h18kTcle1QGACZFU9KMiQ0tQaYj+q4uH1Qguq2gpseLD30a/aZIYBR4hCTLUbZAclPm
         ybjtk+Z+TbaT3g6WmGVk2vU421iXWvCT3LUBwb2HQ8reOJiU4vwIjQrNVPXgJ/53+hLZ
         BC/JCxBLR0V4p5n9HovQHq9NNAgpTl1qlowHxOIv2N2j37YvD4QnhdYj/7EiQ3VxuoE8
         FK9w==
X-Gm-Message-State: AOJu0Yw/ce3JdqFvlo4P6twZjbp72GfiYNbrvS4DFk+0/NAr0IXWhewK
	zLd63m+bFyQPdG3XVbUMZuLY+FWh66lQb83+9uzCN677n9OVCjkuWq4I9WZBmtiN
X-Gm-Gg: AeBDievgLJRMqjZkpQt9leBzjM6qhTlFe1mHR2DcS1gAB+CPYSvvmoe3LBw99jRDXsE
	hQ6q4bEFv7yo4MAhG0OMFE1LNvyDpqyEbE0oNhBLp3vJMByGj+RUxRzFvec62zrvHpQnI8WgELb
	sHP9C/DPR1wZPoQbXTMmFKaEw9FLAO0w3oHpCf1zBtJ5di/uYd1qpUhKa6/MfO15S99dRAhxRRE
	ustF0k4AmF+5Y4EdranwVRdfx8Zw71G9irIc5GIcWOrxC3dVVWhO6HdOFUtAA51a7IFwXzfxfXk
	KYdVZ+TWvcfupUCTqpg2kKaqp1wnhHnuPk2BEXqxnvgA5GPXuoNo8XHrQOugFV+aOzhHH2T2hqO
	ccmYboTi4tC4JmOLkdxCKSN8Wjdnvp6gBHg4Kxr6/Ojmlfdf/US36Ia1f6gNNbA99QdjqyfpjZF
	pdmMeBwD6GG+C8lEcHYapBfedVXQwtQFWGiHDqJV0YmYL2RgqC3mYPIsMZHCjZNeRDbi+Cr99Lz
	aY3iYILG0G9DTrh6MzlbqzdJFc/kkbbGKqIjkAK2WxdadL6DXTgb/Lbb1wplgd5kM0Rix3PmaAJ
	SbMJvN5K93YpzEgp/Sw/53go3/WK
X-Received: by 2002:a05:7022:b8f:b0:128:d577:dc21 with SMTP id a92af1059eb24-12dfd7bd8fcmr4329561c88.13.1777939766982;
        Mon, 04 May 2026 17:09:26 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df82a141asm20608603c88.8.2026.05.04.17.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 17:09:26 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: sparclinux@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH] sparc: remove unused SERIAL_CONSOLE config option
Date: Mon,  4 May 2026 17:09:12 -0700
Message-ID: <20260505000913.25576-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no references to this option in SPARC or
architecture-independent code. Remove it to simplify the configuration
process.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 arch/sparc/Kconfig | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index a6b787efc2c4..fb53b21a8696 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -327,30 +327,6 @@ config SPARC_LED
 	  by reading /proc/led and its blinking mode can be changed
 	  via writes to /proc/led
 
-config SERIAL_CONSOLE
-	bool
-	depends on SPARC32
-	default y
-	help
-	  If you say Y here, it will be possible to use a serial port as the
-	  system console (the system console is the device which receives all
-	  kernel messages and warnings and which allows logins in single user
-	  mode). This could be useful if some terminal or printer is connected
-	  to that serial port.
-
-	  Even if you say Y here, the currently visible virtual console
-	  (/dev/tty0) will still be used as the system console by default, but
-	  you can alter that using a kernel command line option such as
-	  "console=ttyS1". (Try "man bootparam" or see the documentation of
-	  your boot loader (silo) about how to pass options to the kernel at
-	  boot time.)
-
-	  If you don't have a graphics card installed and you say Y here, the
-	  kernel will automatically use the first serial line, /dev/ttyS0, as
-	  system console.
-
-	  If unsure, say N.
-
 config SPARC_LEON
 	bool "Sparc Leon processor family"
 	depends on SPARC32
-- 
2.43.0

