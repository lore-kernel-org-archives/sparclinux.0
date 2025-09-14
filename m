Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A1C1DDC1D
	for <sparclinux@vger.kernel.org>; Sun, 14 Sep 2025 04:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822701; cv=none; b=hojgIOt4qD6Fnyb2NIyGYv/4FtTE5Pvjkt8nlMyYibavKzPUCB+69vdpMHxQ2jwq9KK5O/SEdHiOAws7FIPn1UEPGnLi/ZO8g2J8iFrK5627x9V/8elO6yyQF3k1UM8OntwA31wXiadkCkse4FiM7i2L5A7e0Nk4GKo0gupoVwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822701; c=relaxed/simple;
	bh=K5eh5PFkTwqgMsR/pgApUC7mRgd5tIkIjFvctye1Fsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1xsPa1M3auFuqi7vEns28iv5o8eWcLs3dxLopUpt+ciUKbWg+fkb376QiPeEdHPKF7pilYJDStmYoFxLTT9f20IcuJpGeSvsfpTarRgwIk0w+wEd0I83jW+eZKv6hK0pXQnPTu1i5tk1pBsqBF8pWd0tTvWHqn775FUwf4TacQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPbZj1qM; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPbZj1qM"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b07c081660aso429397766b.0
        for <sparclinux@vger.kernel.org>; Sat, 13 Sep 2025 21:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822698; x=1758427498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mw6NNXq6XfJ0FNmZ5frjZGClHo0iZVSxbFf+bMTHIN8=;
        b=kPbZj1qMmGYeecjJGUIlyIHIYamuich/CNzkJDmaNgGaqWvmKRH/xWtRF41uM5qkzv
         aCOo6S2Jlgd26xKUeuaakbbG7HEqDWn4lpel7AStmc2VlwPrBzY5joso88BimDPHYlXE
         lGKrirBAgOS/lwpoTHzC/tUmPxv1QF+CBszBJWWwZ+66J7mYEyOimyL2AtSvZIWLx1gK
         5mb9tOIr2zMFazTcGHaTU8u9ffMEBQkt1YmPKV0KVFaH5qyy1RH+UXAWhuy3AcjFOjXc
         Kxvqk7LMiYKMLQ7+ce+4bi1vcyj+dMrkLMVvDZ3cpLh4Ep/R+rND2M09mBBHfKuxH8K6
         CeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822698; x=1758427498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mw6NNXq6XfJ0FNmZ5frjZGClHo0iZVSxbFf+bMTHIN8=;
        b=oK1TinlKm9I9GUafEQOKtlaXRVxWxLqE2VlLsI5ByFED8h2wM2jNvuzDY0twocDuSx
         8Xtr5l2Gboz6k/CUl+F3DtctS687uo6YdYNpyZ/HLqER17yt5PCwt1LIRaPGHZTMalNX
         ilCUFugeZ4133geXs4oeFTqqwFIsJBZEkFKT3+oPD22i6Vy6yPN35EzkC3t/30GUpr+o
         ll16//fGMwMJeFn8/yyVthkefOppeUJ4W/g7U1ZJb8TN42k0DNFexzkKMP0ethnarLLX
         QZikeUk1671tHeTfhA2NGfCLc5/ciPdF9dO6ENxNmTc07Ius4MKplPN7euBNIuyGCIRN
         s+zA==
X-Forwarded-Encrypted: i=1; AJvYcCVrzF6pXlOn9dt14bXoI7+/C+k+0wAsEP+z4qiIIpufyAzfB+ZipCtLzsqZQF2HfME4MaFPDuCrqxuq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1paACwIHjS35dCAv/M97oaEqEBNzrF3r42iBR6eF3QQGGlSFd
	ckQNwypi2/62J3XjohACbyidVe0YlMwyD5QYpgWeKOzs86P8HS3v+UiF
X-Gm-Gg: ASbGncukcU/gew8iTrkwjM6i1fTcDRrndGWJv+pQ1n/l3tfbNxqCnEb6AnQGymrWBqp
	5lnxDv6iTZBe81CNUCC1FhDsdBGRews2kaWWrEQewm55k7XveMlxFNbombIPAlTnLMb3ixzM18z
	IUwaPU3OtiRBFEqHrQgmhybTjgQaYVrS/zYuVMvYd4/2d0xor4xXEZ9EA4rHf7AxSalzscrtcFs
	HFVVrsur+u0K9cxicGxVKWE/xokoA14ndaf1LJnZ8ClzFcqAA/Z7Ves8EGi+IwqEFDCa060+flk
	3bwrPvujnoi9gcjVU1KWEC2AqUeUK+OnSnpc/zq2MCTYnq3/2+ru+gmzpautn12WNVbE8th+dkC
	ERBlt0FImtZA/BtEL67w=
X-Google-Smtp-Source: AGHT+IEha/cEycx+vu0xF7TxjEegwfvZABBYj962u8Q3zWPEYF1LD+BxwewIqIoCpytaOJDSx3nrIQ==
X-Received: by 2002:a17:907:3d8e:b0:b04:706a:bcfc with SMTP id a640c23a62f3a-b07c37fd45cmr876333266b.33.1757822697695;
        Sat, 13 Sep 2025 21:04:57 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07dbf5dbf5sm308085466b.79.2025.09.13.21.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 21:04:57 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 62/62] init: rename CONFIG_RD_ZSTD to CONFIG_INITRAMFS_DECOMPRESS_ZSTD
Date: Sun, 14 Sep 2025 07:04:51 +0300
Message-ID: <20250914040451.3848715-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initrd support was removed,
and CONFIG_RD_ZSTD has nothing to do with ramdisks.

Update your configs

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 arch/riscv/configs/nommu_k210_defconfig | 2 +-
 usr/Kconfig                             | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index 6e961256a941..68cae0496b54 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -7,7 +7,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
-# CONFIG_RD_ZSTD is not set
+# CONFIG_INITRAMFS_DECOMPRESS_ZSTD is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_SYSFS_SYSCALL is not set
 # CONFIG_FHANDLE is not set
diff --git a/usr/Kconfig b/usr/Kconfig
index 3a891a0c9ef4..06e1c1474b68 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -100,7 +100,7 @@ config INITRAMFS_DECOMPRESS_LZ4
 	  Support loading of a LZ4 encoded initial ramfs.
 	  If unsure, say N.
 
-config RD_ZSTD
+config INITRAMFS_DECOMPRESS_ZSTD
 	bool "Support initial ramfs compressed using ZSTD"
 	default y
 	select DECOMPRESS_ZSTD
@@ -206,7 +206,7 @@ config INITRAMFS_COMPRESSION_LZ4
 
 config INITRAMFS_COMPRESSION_ZSTD
 	bool "ZSTD"
-	depends on RD_ZSTD
+	depends on INITRAMFS_DECOMPRESS_ZSTD
 	help
 	  ZSTD is a compression algorithm targeting intermediate compression
 	  with fast decompression speed. It will compress better than GZIP and
-- 
2.47.2

