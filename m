Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9881647DFA9
	for <sparclinux@vger.kernel.org>; Thu,  4 Jun 2026 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579205; cv=none; b=D1AYt9BTZBThJ1mRCR1x2+O2fq8xJFrACj34bD8NZEJpZagrMA8ndzqzz5boBDFjPyNU4dpV6EhoUKrbcahBAXaIFf9s2+Kip9Vmk6bHqeDaItLOyGK/LUQ5VDMxtYOBvw5FDgcWF5CiCm6FQVQU3CPlZnI6ClTpTRYJ1FjoKLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579205; c=relaxed/simple;
	bh=gzHc6gkZVQYvB/HNV+tpD+0yf/PTlunsXEIfWYwA01U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fi4yf2gEL/Dv40NOqW9CYk+nDXwVZDffDG04gnKorNDrb8/Z67R8ksNu+neyjAR9xWkon009QaAIXSFcggfSsgvgZO7a+dk6jUUtEofFdjZLlSJTNyWl8Udp+5rdx6HqwaPG8whEXZTl3thHvDDxfaRSQzbjAXjwa6AgYqKTdbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xq62RZnD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xq62RZnD"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490ac10e337so4125415e9.3
        for <sparclinux@vger.kernel.org>; Thu, 04 Jun 2026 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780579199; x=1781183999; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qohYqz4B4PBn5o3+UkMj6t+aWtH9uwOMAfqBpeAnghs=;
        b=Xq62RZnD4vbaMsxGWiQ5piP3GG8HVD3wOIguMVkym3xwuigqCO1eeNG5ysmGUu6kyY
         c8MpKgiyfr0OIhMlKyWacocz/RW1J9UfikPsiIVyVGr4KwWmegWpKHfeXji+PDVTGF+z
         5Fm1gdhZbdA8GF6ryR/GiGIlqZbysr4WyVBzFDsSDbCWpJ40C7ijfZMM+RjyeT2sygAf
         t2PMuFaX6+/bJb0g9eFHVj1FU0nf5uDRgSy+OWNVkR5EXpyRbCxYeeeQI5HU6snwRHol
         N55uXXNnpbUXndFPyRsUFocascTIP9PtGpWHW3mfizSKbEDjvgEex1FCzqYKTN6D0C0c
         cBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579199; x=1781183999;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qohYqz4B4PBn5o3+UkMj6t+aWtH9uwOMAfqBpeAnghs=;
        b=rdE8GtnxDAp1QbUxPWmyiEG/XLc/SS/J5facwAcpyC9520tLVsz305Ey91uSX/5W7W
         VpGCkUfPdajlHu/zC+tn1jg8UiGJ1gVdes1urHCiMPkLTNOf68GT7SSj8VVBqp33xdiB
         lBs7HR5aaSyaYTW1EDzxD5vCpvOTcx+9Pg7fGDIRenFKl5hXLq/aapJ7MZ3PSJFwmLy3
         mW+e32fjTbttML/4Iw+xEjbneAokoFwP7KQuNTA+seChqGiEwo1RR7QIQfC7dEjYblSX
         4tyQJODefjv1rz8Jh3k3SVYOn2Xe9g0qAIBIAmrYMZH9hwwDXwqI9irzP6vaaAQYiF9r
         er1A==
X-Forwarded-Encrypted: i=1; AFNElJ8oVW2qfw/UWaVb2nW/Gqst092ZSteqfOKpYEaM1gB5iKqWqcrL5/yUSXm2n+gSxw1ULvUwxsu6GKqb@vger.kernel.org
X-Gm-Message-State: AOJu0YyvoaBWuw2tmck0hMkHsGyPBjYq4bOcDM1swIdZzpD368M4aqGU
	ErLHVDOp+cCc8JerzUPV+B1LBb6RVqxzNDeIe+Rk+BBCZSs2qFT+2m1i
X-Gm-Gg: Acq92OEGhWYoXrpmMmfmdfMdX8VUT1i8LHd/+bfrkgeexVxAxfQ3RKRBnsh3HufOQfb
	wzgVrKTh3yQ23sONrweBK9p3Z5NcWhOHtSpONkTb1tqTJGhoLz+bst6jA3kJvs5ZYk48C6WQGIq
	qPd5qTRPFhVmLg+jKYaReGQBRrv8OpaUmXdnIppuMaEunorqYTMxg2WffGjgr3gLr39ftHtQkD6
	73LqdJw/5BQRSTBeh4AwOp6LLdLAun6cKwGarKgW5XaH0CW5H4CUicHMUCTMzJoDvzfP/CHBKg7
	eDKltth4N2F/O4TJFIMIe7HpA+gjU6cpxhHU/OBPLIn6wtFJWUIHmJ+JPXfZ/slw71wmYj11hL+
	R3msYLeNGIfN0aFH1GcKUZffMegLPlBAxGBrwiVsDZBMrTNRwjLAvupCPGFRZw9O3xc1YBj2gph
	YEWLczb9bdxo1yI49AcGn6ZOeuIXCxyrD9
X-Received: by 2002:a05:600c:871b:b0:490:b9ce:a73c with SMTP id 5b1f17b1804b1-490b9ceabdfmr108163365e9.31.1780579198642;
        Thu, 04 Jun 2026 06:19:58 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413541sm72844695e9.14.2026.06.04.06.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:19:58 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Thu, 04 Jun 2026 16:20:27 +0300
Subject: [PATCH v3 4/6] powerpc: Remove remaining defconfig references to
 the pktcdvd driver
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-remove-pktcdvd-references-v3-4-e2f06fb4eef4@gmail.com>
References: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
In-Reply-To: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
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
 Jens Axboe <axboe@kernel.dk>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org, 
 Catalin Iacob <iacobcatalin@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1209;
 i=iacobcatalin@gmail.com; h=from:subject:message-id;
 bh=gzHc6gkZVQYvB/HNV+tpD+0yf/PTlunsXEIfWYwA01U=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhizF6vVWD6QfaCz/Yty56WrD98M+Qcwrrn9sqvltdV/gy
 rLrO/+96ChlYRDjYpAVU2R5ce5624Y9ZwLuJdm1wMxhZQIZwsDFKQATyWZn+GcaGSFV+FgzPX1J
 Pq8T0x35indl8xo7kg/vsHeqOp1Xm8nwzyLEgilvj/l6p2MrPYTONhpNKdtdUs7dZrS6KkNs9ok
 73AA=
X-Developer-Key: i=iacobcatalin@gmail.com; a=openpgp;
 fpr=F609BFABD84EB5C9DDDC37EDE89C6A3571CD0E33

Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind some
CONFIG_CONFIG_CDROM_PKTCDVD references in defconfigs. Remove them.

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
---
 arch/powerpc/configs/g5_defconfig     | 1 -
 arch/powerpc/configs/ppc6xx_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index 5ca1676e6058..647775f6d174 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -57,7 +57,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
 CONFIG_BLK_DEV_SR=y
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index eda1fec7ffd9..5c3e25fd8edd 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -306,7 +306,6 @@ CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_VIRTIO_BLK=m
 CONFIG_ENCLOSURE_SERVICES=m
 CONFIG_SENSORS_TSL2550=m

-- 
2.54.0

