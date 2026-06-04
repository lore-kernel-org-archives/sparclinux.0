Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495F547DF8D
	for <sparclinux@vger.kernel.org>; Thu,  4 Jun 2026 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579204; cv=none; b=onJvB+UB1G8zRkVB+d2DHcmI2IO3lL487NvRXGDJ0N4/zLP5Y21quXMzwV9c2Hfv2qnZK8F+35+ksUCcQSpf5s85d6f0qsucYKy2Dzzb2To9BnexTD5UGAyRqq7w1tAQEDU6n+buqMo39vFUGzZqpSGp6tVewDEnaxEf3PeLty4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579204; c=relaxed/simple;
	bh=PHSBDn+EOV9cRPD4tjMDFF7NZh/wndEKOUGnhx8+7jI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sQHHoCakOn+iC7NYiYXzYMJQjSAg1JYZHEATpYOSKi5HOC7iJI7lwjiAluhVNR8kAUOGSvMZBkLDC8m7riAybbHSXw6WiTfiK8x/laTASK5y/qRxT0XeWL18CuW2cEhx4ZNcB3Paqars1oBFGg5WZCdOBftvY6hUF0+m0XRy9Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pm2OGKHR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pm2OGKHR"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b09e4cccso5986975e9.0
        for <sparclinux@vger.kernel.org>; Thu, 04 Jun 2026 06:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780579195; x=1781183995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JErWg4zEtTpgl+LBk0hgPrc4Api/7+6zFB/swmBFkD8=;
        b=pm2OGKHRbbhfhdSTB/ugmp0VhlPbw/VtEbcHGLNSaUzLgy0vMFyrcrZTZdpU+C1wOC
         2qnYbHSF8I5PpIDow7RPBvqtxIWFhie0ZybuBuk3i173nBb5EOOWzNN7cLvic1uk4ooi
         K4B6bAqMhm6UvXOQQu87//MvA1CWfh8xVg/EueyRaY+IoeB0efGIb6+1Zlvvi0cLMjec
         s2ySj8frw6cJ1X6E9TNmXwTewzGkGlPDCXWA/5lzI4kn+B/dg4S79YFSnfqoisKh9FCa
         urlefM5mvg9dr2lOCD3U8T/dGhf9dBUtlCPsw9hQcise6I81ljUEjkzoOFw70DZ8mzCC
         aJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579195; x=1781183995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JErWg4zEtTpgl+LBk0hgPrc4Api/7+6zFB/swmBFkD8=;
        b=EkxlyCraUDFgff5JeJqBcAy3Jn/+PJUWsoUrjYHKTiRXKQiFhQwW8HMx5NwF5hgFDl
         Ry91EONlyHEmZhnWpSojtZ3qirsWigcNGx8gDwvx9hJlbK/diY0WQASgvI1EHqq30va7
         5akYINqVVaCqX26Z2PrYqkaKtjdowi9g6azl67TNp09mwdAozfj5o5y+98HWU65mFlWs
         G8/P9SWzKWJDJdrFadFfRmLZtpKZGjGZhxqhpcKYjiX7X+sSCgzmIG3DKeAFF3XfhNPA
         ejCr/zdiKpRY9czWG9fY74UsYLzGK0aiquGnxuNuYD3FGjnvm8MGdlWgAQRiowheHH1p
         EJ1g==
X-Forwarded-Encrypted: i=1; AFNElJ/hXPnUMPwE8saAyMZQNpsTRLLhLVn/wOosSCSVF583weSgxoK6dtE8QT5VuHxXCk0KDJyyACTZbTSU@vger.kernel.org
X-Gm-Message-State: AOJu0YwIxecjTFUJgpz35hIThv3X5zuMPxuEkgaxXuYVx+6sP2AT3dh3
	hD/vEDe4+jcf2UiT1DXetFyHAH2T/9iSWNcyR0DgTTPfKIHaze8qTCgC
X-Gm-Gg: Acq92OE/nlaruUhX6C2tkBM4ry5JQbFgEfw62Anj9+pE1c4/SOHgYrf33Imqd6SYN87
	XGChFkDp+zQTxxFk1j0N7KEOLawkk0/BrlbNY6OVd70aSI1/zFPZ27dU4GbHDmucEQb6gW5HjNz
	0IYwQK0zw+2WrlX8Zww2NVERRS6n35NkEI3J8brHAE+Ym9L2HUKmtTO7yB20vLK8N1pxDDc6Q9W
	/oKYdUvquPKb6XSMnJIw1u3uzEqEuuaei9kaedOpb/WQHbfK1VQ5Zryeym3EzB9077Y1hH/VGke
	Mi4NqOt/r0sTqc9WJmSgnRyeY5jLebSkXGFn51cKVKAwQNIdIFa04RcpB7UGVh3MwCvy5lXz2Zq
	OFATY2yLVqBlvAz1DS9EmWTC9MS2cX7hdaae/5i/wZsmAArI09wTzsY0Sm8+u3rkcvJMD1LrY5t
	TZAop57GIYxRdLLzvj/JwdkBLz9MlFvprI
X-Received: by 2002:a05:600c:1551:b0:490:5466:8576 with SMTP id 5b1f17b1804b1-490b5e9fca9mr130752605e9.1.1780579195429;
        Thu, 04 Jun 2026 06:19:55 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f368e9fsm15750607f8f.37.2026.06.04.06.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:19:54 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Thu, 04 Jun 2026 16:20:26 +0300
Subject: [PATCH v3 3/6] mips: Remove remaining defconfig references to the
 pktcdvd driver
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-remove-pktcdvd-references-v3-3-e2f06fb4eef4@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4891;
 i=iacobcatalin@gmail.com; h=from:subject:message-id;
 bh=PHSBDn+EOV9cRPD4tjMDFF7NZh/wndEKOUGnhx8+7jI=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhizF6vVTc+KTYw73r5fOi9NlmJC+WWdX4szitUmdB0627
 omxYxPoKGVhEONikBVTZHlx7nrbhj1nAu4l2bXAzGFlAhnCwMUpABPpr2D4n+pW9+X+bI+0NSUc
 vy5x7l5o9GPanunid7TdhNqEmf4aRDD8jwiVUi4Nzc1l2Foqk3fBr21nj6Hhn09/0p/+W8ddte8
 cDwA=
X-Developer-Key: i=iacobcatalin@gmail.com; a=openpgp;
 fpr=F609BFABD84EB5C9DDDC37EDE89C6A3571CD0E33

Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind some
CONFIG_CONFIG_CDROM_PKTCDVD references in defconfigs. Remove them.

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
---
 arch/mips/configs/fuloong2e_defconfig    | 1 -
 arch/mips/configs/ip22_defconfig         | 1 -
 arch/mips/configs/ip27_defconfig         | 1 -
 arch/mips/configs/ip30_defconfig         | 1 -
 arch/mips/configs/jazz_defconfig         | 1 -
 arch/mips/configs/malta_defconfig        | 1 -
 arch/mips/configs/malta_kvm_defconfig    | 1 -
 arch/mips/configs/maltaup_xpa_defconfig  | 1 -
 arch/mips/configs/rm200_defconfig        | 1 -
 arch/mips/configs/sb1250_swarm_defconfig | 1 -
 10 files changed, 10 deletions(-)

diff --git a/arch/mips/configs/fuloong2e_defconfig b/arch/mips/configs/fuloong2e_defconfig
index b6fe3c962464..840130a73992 100644
--- a/arch/mips/configs/fuloong2e_defconfig
+++ b/arch/mips/configs/fuloong2e_defconfig
@@ -89,7 +89,6 @@ CONFIG_MTD_CFI_STAA=m
 CONFIG_MTD_PHYSMAP=m
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=m
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
index e123848f94ab..61f09cc9ac12 100644
--- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -177,7 +177,6 @@ CONFIG_NET_ACT_SIMP=m
 CONFIG_NET_ACT_SKBEDIT=m
 CONFIG_RFKILL=m
 CONFIG_CONNECTOR=m
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_RAID_ATTRS=m
 CONFIG_SCSI=y
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index fea0ccee6948..60da9cf71b72 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -83,7 +83,6 @@ CONFIG_CFG80211=m
 CONFIG_MAC80211=m
 CONFIG_RFKILL=m
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
diff --git a/arch/mips/configs/ip30_defconfig b/arch/mips/configs/ip30_defconfig
index 718f3060d9fa..5c2911ff9a87 100644
--- a/arch/mips/configs/ip30_defconfig
+++ b/arch/mips/configs/ip30_defconfig
@@ -77,7 +77,6 @@ CONFIG_NET_ACT_PEDIT=m
 CONFIG_NET_ACT_SKBEDIT=m
 # CONFIG_VGA_ARB is not set
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
diff --git a/arch/mips/configs/jazz_defconfig b/arch/mips/configs/jazz_defconfig
index a790c2610fd3..dd3486b8d1fc 100644
--- a/arch/mips/configs/jazz_defconfig
+++ b/arch/mips/configs/jazz_defconfig
@@ -33,7 +33,6 @@ CONFIG_BLK_DEV_FD=m
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=m
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_RAID_ATTRS=m
 CONFIG_SCSI=y
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 81704ec67f09..b10dac71f400 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -224,7 +224,6 @@ CONFIG_BLK_DEV_FD=m
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_RAID_ATTRS=m
 CONFIG_BLK_DEV_SD=y
diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/malta_kvm_defconfig
index 82a97f58bce1..bdd5d99884e3 100644
--- a/arch/mips/configs/malta_kvm_defconfig
+++ b/arch/mips/configs/malta_kvm_defconfig
@@ -228,7 +228,6 @@ CONFIG_BLK_DEV_FD=m
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_RAID_ATTRS=m
 CONFIG_BLK_DEV_SD=y
diff --git a/arch/mips/configs/maltaup_xpa_defconfig b/arch/mips/configs/maltaup_xpa_defconfig
index 0f9ef20744f9..523c0ff329ac 100644
--- a/arch/mips/configs/maltaup_xpa_defconfig
+++ b/arch/mips/configs/maltaup_xpa_defconfig
@@ -226,7 +226,6 @@ CONFIG_BLK_DEV_FD=m
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_RAID_ATTRS=m
 CONFIG_BLK_DEV_SD=y
diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
index ad9fbd0cbb38..60054e54bc5a 100644
--- a/arch/mips/configs/rm200_defconfig
+++ b/arch/mips/configs/rm200_defconfig
@@ -177,7 +177,6 @@ CONFIG_PARIDE_ON26=m
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=m
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_RAID_ATTRS=m
 CONFIG_SCSI=y
diff --git a/arch/mips/configs/sb1250_swarm_defconfig b/arch/mips/configs/sb1250_swarm_defconfig
index 4a25b8d3e507..a50a7c097542 100644
--- a/arch/mips/configs/sb1250_swarm_defconfig
+++ b/arch/mips/configs/sb1250_swarm_defconfig
@@ -43,7 +43,6 @@ CONFIG_FW_LOADER=m
 CONFIG_CONNECTOR=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=9220
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_RAID_ATTRS=m
 CONFIG_BLK_DEV_SD=y

-- 
2.54.0

