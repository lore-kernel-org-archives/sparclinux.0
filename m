Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8082B3D3CFD
	for <sparclinux@vger.kernel.org>; Mon,  8 Jun 2026 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928898; cv=none; b=UqCKfLujci7vJPLkF0XivaSPCflCEG8og/IPA3omeBQNFpLllrR+DTUU6B7YnWRoBxj8OMfPrEE1H+mcPmGjHM4VQA0mIF211gd6R3yLEJ3xd73acW4wyvlmZ4LKoJh5jVnhPGzQwfcuyxmZz97SZQX4cJbExCA9lVkUi0lKH4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928898; c=relaxed/simple;
	bh=PHSBDn+EOV9cRPD4tjMDFF7NZh/wndEKOUGnhx8+7jI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XBGwafxr6Go53urc5zRwnCTLt9pz7vhZYB8H+aNlz1QJNHd6cePLLkJF1VOtmYT2PsCdMUOvyDgNZ6cmEQ43WIvXiaFy3yypvhOHlNoI6bTzi01NB2cj1Z7PnYAPo7wHBPRC+/MF4qTAcJnxYW7AVD6TRDtPztRuX0eiDT3FULY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hE8DthYh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hE8DthYh"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b64c8311so49503545e9.3
        for <sparclinux@vger.kernel.org>; Mon, 08 Jun 2026 07:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780928895; x=1781533695; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JErWg4zEtTpgl+LBk0hgPrc4Api/7+6zFB/swmBFkD8=;
        b=hE8DthYhllmHVLf+CVbvOPxXFDOwQIwUwmlHPUb6Lp0ZG18iiFyeZhxMRVM8voWKJK
         dhNR79X++LJrdg7mj5Du8edcM1yQd+kmB5L7RB+CrW1eCw7R4jCIigSjOKUChbWRep1Y
         6v1lVA/zM8kYY/GyVJ/LeFVSIp7aTxTv2DPw2w2Bjtz6QGih1DnHXYlT0baWZOZGeLNN
         co/6yfN1Zi+0hJkWO+CmW3s5Ox7exDfx29B9dmMSiyAg0G6UGGGU9X7KqwnICS/w0W5O
         jL72k4dDNAart0+XDTYN8WPxzKeVrwM0mtkRd3vW5zJQ7MTwqn4Lisx7IcY+1Q0bAry1
         Ltjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780928895; x=1781533695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JErWg4zEtTpgl+LBk0hgPrc4Api/7+6zFB/swmBFkD8=;
        b=Oh2wheXuFv7UOwZiAKq/ribcT2i/McNMyZh70vNx1ZpdcOgvbdduXyNRVPf6xBcAlI
         qrd+YK48w8rsW1AVr844z5nhw3if2JDBQwi9KhXOYTvqEquTaItnSNbpNyedDuWokXIk
         uQ/df9CbueKw15eyxrdEEW8OFN53lBSCFB+i9UDeVVTzhlFrUTgSR+97JvCChYaLvT5Z
         vLx5ZB8gh4HYB+gxYMH4SSEWiWPDcjht5556fRO4VdAXNwFjjSC83OCsIWUpLrAz25Nm
         rUeLdsYTKhukyQ3NfbAB7vpcj3894VAM15HZ8Rrq40r5YKh9r4ij6My7qan0qbRNyIdk
         27dw==
X-Forwarded-Encrypted: i=1; AFNElJ8AOWojnVfr5YANaH80VWN0nmt3Ivf89EObI6hSvNlCeo+JuuCwYoYNaAcR8qU2wWRlIMP4B3CjpDJ6@vger.kernel.org
X-Gm-Message-State: AOJu0YxOruWnGAp29r84+2PidVAtylFa4qR3roikjEc7OutpyIIdNdjL
	P4JT1pLNT2L0j6E1nsktYaRLKUzLHXRU6lYFDIgNZV3Hnmz/Uj4m61KB5l7xwmdx
X-Gm-Gg: Acq92OGZfIVssgKoTfjvkYypBiD0HfrVr9GP9QUcj3HtyUpZvK1RNQ4pbYfJRvcq+S5
	/kwFOwdyAusKUoyw+LZVkZrU/aEQqXowKdIXyS8FPlDb84jBV8ENSSWZx/jmalzs9pDxfOH6HcN
	q0HV5+hhg/mPUbe/p6VEdBlLW58+26K6CeFtEPCymU3iQ3qVnmrmPmPAGvEwTslVeZ49qcz0e1X
	zb8JfOZbhrxPiH5VII/IyoAreZSJrlcfEXy3FeDhcmhcTOZdvZ8CPtBclIoAYjYSB+eeoGOAQvA
	XI7vp08kLQMnv6VjRyD4Mjl4KRjMzMYpKdEuYe6gFhhMC6RByT7A+e+i3eJL3+HkhVqVGINLvr8
	mVo49TCIHS5M+icHXOOz+xK4oBjEeJc1Vsxl+dcUiZZ1BcL0Jz6mL+0BpaV57B9p/4UDCEo1zJa
	R0QpNSV2zE5ddgkPb43R8BJHUk6i7TIsKR9LiMXtRvwz8=
X-Received: by 2002:a05:600c:c0d3:b0:490:53b0:9e53 with SMTP id 5b1f17b1804b1-490c265c107mr218795335e9.1.1780928894804;
        Mon, 08 Jun 2026 07:28:14 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d2d11asm342073845e9.1.2026.06.08.07.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:28:14 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Mon, 08 Jun 2026 17:29:17 +0300
Subject: [PATCH v4 2/5] mips: Remove remaining defconfig references to the
 pktcdvd driver
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-remove-pktcdvd-references-v4-2-72f88b04cc87@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4891;
 i=iacobcatalin@gmail.com; h=from:subject:message-id;
 bh=PHSBDn+EOV9cRPD4tjMDFF7NZh/wndEKOUGnhx8+7jI=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhiy1iwc+2lbJ9etl7Yvnkz732ejVeRe5q673+RbFrRXiK
 rHpq3jQUcrCIMbFICumyPLi3PW2DXvOBNxLsmuBmcPKBDKEgYtTACZivJrhf3zBIjZR55Q8+4mz
 5CZ0NPiaRsjNeszPy8O/86y0m6B+ICPDsq5dpf3HHrUwrAsNW71D8urfbY8KrHfOEC2q3ZYy8XE
 uEwA=
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

