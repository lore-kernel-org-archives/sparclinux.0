Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7712B3D5246
	for <sparclinux@vger.kernel.org>; Mon,  8 Jun 2026 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928900; cv=none; b=nycg1Ek/TEFDQ151ZP1D7QNUgDGPFEySouJ643keVnF6wS1Y/SqX+7n87FwgdnYYSmZxSgInjvzOMbpmzRIjmmahDgU31Auxl4jVHimtCMz//kH5gHkLgDeuPHKHYSorcfn1OcfJIGwGEP0nmsEtHkDBn7V5616abc+dy2ZS8os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928900; c=relaxed/simple;
	bh=gzHc6gkZVQYvB/HNV+tpD+0yf/PTlunsXEIfWYwA01U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g0Pmnq5NXfc/wVXI0Tnljbe6QWvIGjKbM/5zgmfOTWEI/lzCniOD3nkGK27sftSDmu77BRGSvnwkrkgNBocHJHHdpVqS7Ad0SGOHTwQynliqfdO45scGVsBrNGW8FT3bGJNHwHtLamrFDtHlmHsPZXiElNaFALaQW5VjAqv7X7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pjfKWEW0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjfKWEW0"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490ac10e337so40666565e9.3
        for <sparclinux@vger.kernel.org>; Mon, 08 Jun 2026 07:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780928897; x=1781533697; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qohYqz4B4PBn5o3+UkMj6t+aWtH9uwOMAfqBpeAnghs=;
        b=pjfKWEW001D4YEjJQ1VE244wapauduv6wivj5ZIgUpExBrQaatIJrayTbrJ/UcLnI6
         iiSzJxmwDkxnbRbKZt7vpGC+MksPQhgA5UO9CrUa3PvY4Y6reeeMfhsc2rlu+wTiw8cA
         oB6O1x1ydNa2mFWaV9P+RTMkYiRe5oFzoLgyVmtq2mrlQhil0+ZLslLYoO75bbzUsvUy
         iqqMTXYWkFbyEGcKj5Ikln2LvJyqIv0mZGTVVXvpSlvH4sDVpumIThP350dQE6L92Rr9
         31mHyXFqiSIVV4LgJlqfbYWr5f+RhFbi1fh/vC3te5oO4xR4ZrxC3LMGhvSe7FJaEOzU
         dv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780928897; x=1781533697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qohYqz4B4PBn5o3+UkMj6t+aWtH9uwOMAfqBpeAnghs=;
        b=Nn/iCQTv6i7wBmozTzKobo53b0qlswEhbrEx82fGYEh3IYKwqBKIJMQ7qF11WhpXQQ
         5A0ZwAy80eIx95StspjC2X0Hq7sqyJxKSMRXiYapCcnsGS6jJC0YBfMHqxi94FFhF5eo
         03NLucVm0Ykbw0VHVM0LN1oGQGfcj8ZbeY27ImW7OBIURVpq5Un7TOKZ/MCYMBEyw5Zz
         lgWVAVzs3Cqkk/jD3LOKV2xwPCeCXzub8tr5d5Sx9y6hOR1D9dV7rH7jGayzgkfOSdb/
         ErYhpTwjToIE1Eri3oU+Gs456PANDUNP1kenpwsYggjJaBHp9aSHbFdUMiqdQZ4vFZoB
         cusQ==
X-Forwarded-Encrypted: i=1; AFNElJ+sGUEgoanMZzsC0cYAnw3xKXBfYQ9Mqy8VngAFirGAMP/5+uuFTby2+8T/+m/aGRUB4M5l8PLrXHpf@vger.kernel.org
X-Gm-Message-State: AOJu0YzYFnS/GFgA3H1O3KwSlYJujBPWSNGKIg+umx4ODypxbvE8+Ig/
	Kx9i0u64nwXEG+r1iBuoxYV6+BLTOV9tFOW0XUOvqi3S+MaXnMj9JGAV
X-Gm-Gg: Acq92OHDSyMEssuB6m30YLPQtU07dwLGGiVYp13/IzwbxY53RAi1YB5krbbwRma2/7w
	B/E3dYe0yrrYVodMfwIVulXe6+J0X7FQWXOkJkgLUIt6O9Pgh5iNSmtRxGAtaTrRrrpPIMW8LYo
	+lWTOnIPYv2TwaeO7w5rbQz0VFmA2WJr92+GsYaF6g7sH8ruy1yhr473Qv1bQ0lDe6WYL9Aer0z
	8drDVdhfMN6l5SpVXaiyoVPoG3/hPupYTxBoq6/G8P3A1G45KuwYBV1NX0YCR7vAOQE3jkA58SD
	CvsCBehLSbZWEH+SI9SI5aJQNZKYu7xognvUrJZ9AHxSn2+L6TQ+VcLD1JOGG570Mr7prRLVhyk
	qQ4QlMAZxkOscTPTo/nU4QOd+WNSSe7+Lu+nVJcECcI9sZws9UQ15n3L28zVLYaRP6icAjCvF7+
	Sf685xuBKbcAKbRtFcyjr2+Kkdg8PfvLeD
X-Received: by 2002:a05:600c:1d29:b0:490:50eb:b777 with SMTP id 5b1f17b1804b1-490c2597822mr265428775e9.5.1780928896699;
        Mon, 08 Jun 2026 07:28:16 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm58108978f8f.5.2026.06.08.07.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:28:16 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Mon, 08 Jun 2026 17:29:18 +0300
Subject: [PATCH v4 3/5] powerpc: Remove remaining defconfig references to
 the pktcdvd driver
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-remove-pktcdvd-references-v4-3-72f88b04cc87@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1209;
 i=iacobcatalin@gmail.com; h=from:subject:message-id;
 bh=gzHc6gkZVQYvB/HNV+tpD+0yf/PTlunsXEIfWYwA01U=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhiy1iwfmTElx/xK55o6i86kC379LZn9k10kzaVc99Njd3
 jPQfnZYRykLgxgXg6yYIsuLc9fbNuw5E3Avya4FZg4rE8gQBi5OAZjIVFGG/1EhNZ1mKjOin/vU
 q7bP1LpQFJ4t+z+hMjdmjWGLWsGTowx/xW85dQpMajBlsOM6uceUz326+1uFPIOPe7lffQvjmFj
 PDwA=
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

