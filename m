Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4139A29993F
	for <sparclinux@vger.kernel.org>; Thu, 18 Dec 2025 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080083; cv=none; b=jDpNTEHknshh5K28XnkShTkhatmJy/A+B6usegbiRjx/Pads/nx3nhb5ijrv8KehYmTydzBOoXjtOlKGt25AMYF2rjjddjqovinx4oA21ess5E9bDf7DliHE6ymXc5p7IZMhoZIRRL9bAuIVjYCY+aacYV/wyPX1KYt/Y0Fc54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080083; c=relaxed/simple;
	bh=NQp3i2eTUCVGBhEuaxCCFEKw8TPRsENjT5cgIgF6tfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tba1qVfE4ipshFm3ZZeRWy4rfNY/5fxX52yLOCdvcfO6nI4Ko3kApjfXnWnkPz3bq67Xpv0diEVtMrsVbfng00A9C0Q53Q72ELkCMzG2ZcrRSaDOzLJe/zgwVc0HVORHeJg966Em5s5jDB56sf6+N6zgknUIOSv3Srf6Qky3hjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjSQNete; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjSQNete"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso1550405b3a.1
        for <sparclinux@vger.kernel.org>; Thu, 18 Dec 2025 09:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080079; x=1766684879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yvi6EEyWQGpmoQ+sKyKT1UGoOl5UFeYLCESoPn30Km8=;
        b=LjSQNeteI3bLH6I/6QLIJmE+D9k4rJBZif+Snc7shAmf/me9L5i23cSF+UhMv9PifU
         da3Pyr9Utups3HR/bsMw0dkJXg2pWjfTLp0XI84p5eiD/wICx5tNP15A6xYrPsvM79GN
         Bzfc1vD5rQIv6vQN3YSoY/1EurMWtIfJe7Wfch9yW0vQi29eNrvjB4GcH5yhFmGonvdh
         iuEnXDtiM0+e2dWpvrSxrZxi+qa6OGxqrZhvo75pOxRuE8Ban9Wh6MVz5lTnF2R7Y5dn
         gzMwBytT91MVQVqplRCbMinlRE7B4g9dCUqUkt1d42otWvswIU5Su1M613nEBV3+M7hD
         b1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080079; x=1766684879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yvi6EEyWQGpmoQ+sKyKT1UGoOl5UFeYLCESoPn30Km8=;
        b=VkigZvczAdxlAvKozftH5PJyoBx1o3iyKzSGwQYEP4FSNy6DCUITpom7TxTTewJmvh
         Ji9rshxCkgN7jZN+zGs02Cf1G9SNNq1Sgg874lpyZEgajnTmxsQ8/qIo85NWLWVD0qOK
         tR7KxidNbiPE/FtpxfdMEZN2Zq55Ho4FS1L3/Qr89Jx4JfMgWcq/In0GHYHY1VmS8S3A
         u7h1Jlt6HAWOqDttzU5bQtaIb65XPuLLzRMOJVq8otBqpQwNT5dtBMrWclCv057RR3BK
         Gp2GWCLi2jY+rvQXpfWoHEFHrTDB6qqVBIyFPUDiBzz3HBrM08BpgdqJ6K2m/TurB7wn
         7n6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFy4w9Aws31RevTfYYj1t80b9W2ro7zleBMsSwDuKiUA0flcqMSi8tqzc7/jU9+kMmH/Gcgku9k59h@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkz4feezUCRUb26ZkSrbT9o/g1Rg+tU+YNw/gC9G+3PWxbRKT2
	NhX2UL68fUH4/B9j3qQU/a36Dn3FK+2ZpdaI3GBYFnnwWoT1kryAlsS6
X-Gm-Gg: AY/fxX5hzBfxBh9M4GyvAambVu1ECTGOV74x5ySD4YbY33g4Eh2XYGKp1DjmdPdqBrE
	D0AuzUI8nIFzexz3v7yPWAp8LGtcW4v+xic7HCglAkIzmSqHAno10CCNfijdi/gY+/sxPenManT
	ka/gYuLkxQeyXS7WdK/iof/kezajkL2/h/5Vd1K8Ulej7hPZR7AUYD9Cq5Xt28rPv8PFm93Ipg1
	wn89bCcyxpc0DkqEIa/vMoONBqQ2Sihyt+gOoMWVRlpL40pb4iEetIS6IPe92lexKTwJ0219wlL
	J2Co0qltx6Ei9LqFOzdsdmSwwwnEn9zeknS67yvGYfI64qZDdscTpdx+E+GYAG/h9AOAjdRZ72M
	9rYZXN5K+5RozWVEyVA71AROaw1mcC8rbKdDV1hsRG0HSss6SsMVrkNzL8cLjVnuvRfwfBkjRpc
	/v7aPRKDAW0ePpViP5uvsY/btV5SDi1RkJzQXtrTBbkQ0=
X-Google-Smtp-Source: AGHT+IFWmt4iH/1kf4fkAJoa+/tbrjhvDMeZi8TMTmoV9V69RJumexby9oqnT8yZuZgLFEmR98CpTQ==
X-Received: by 2002:a05:6a20:72a4:b0:35d:cad7:cd63 with SMTP id adf61e73a8af0-376a8eb1773mr271781637.30.1766080079248;
        Thu, 18 Dec 2025 09:47:59 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.152])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1d2fffa3e7sm2847400a12.24.2025.12.18.09.47.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Dec 2025 09:47:58 -0800 (PST)
From: chengkaitao <pilgrimtao@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com
Cc: kevin.brodsky@arm.com,
	dave.hansen@linux.intel.com,
	ziy@nvidia.com,
	chengkaitao@kylinos.cn,
	willy@infradead.org,
	zhengqi.arch@bytedance.com,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	chengkaitao <pilgrimtao@gmail.com>
Subject: [PATCH v3 0/3] Generalize vmemmap_populate_hugepages to sparc
Date: Fri, 19 Dec 2025 01:47:46 +0800
Message-ID: <20251218174749.45965-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sparc implement vmemmap_populate using vmemmap_populate_hugepages
to streamline the code. Another benefit is that it allows us to
eliminate the external declarations of vmemmap_p?d_populate
functions and convert them to static functions.

Since vmemmap_populate_hugepages may fallback to vmemmap_populate-
_basepages, which differs from sparc's original implementation.
During the v1 discussion with Mike Rapoport, sparc uses base pages
in the kernel page tables, so it should be able to use them in
vmemmap as well. Consequently, no additional special handling is
required.

Remove unnecessary whitespace from sparc.

Changes in v3:
- Allow sparc to fallback to vmemmap_populate_basepages
- Convert vmemmap_p?d_populate() to static functions
- Split the v1 patch

Changes in v2:
- Revert the whitespace deletions
- Change vmemmap_false_pmd to vmemmap_pte_fallback_allowed

Link to V1:
https://lore.kernel.org/all/20251217120858.18713-1-pilgrimtao@gmail.com/

Chengkaitao (3):
  sparc: Use vmemmap_populate_hugepages for vmemmap_populate
  mm: Convert vmemmap_p?d_populate() to static functions
  sparc: Remove unnecessary whitespace

 arch/sparc/mm/fault_64.c   |  4 +--
 arch/sparc/mm/hypersparc.S |  4 +--
 arch/sparc/mm/init_64.c    | 53 ++++++++++++--------------------------
 arch/sparc/mm/io-unit.c    | 12 ++++-----
 arch/sparc/mm/iommu.c      |  2 +-
 arch/sparc/mm/swift.S      |  2 +-
 arch/sparc/mm/ultra.S      |  4 +--
 include/linux/mm.h         |  7 -----
 mm/sparse-vmemmap.c        | 10 +++----
 9 files changed, 36 insertions(+), 62 deletions(-)

-- 
2.50.1 (Apple Git-155)

