Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6881648C8D2
	for <sparclinux@vger.kernel.org>; Thu, 27 Aug 2026 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855301; cv=none; b=PKunmwnoq5WRo8gm8xEz391wrUcprUTmWDCeBdwMbsoCq6ca0ilDIhKppO8m/6MBzUgjAT2P1SujrDAhXDOcX7YzmVpIt5ZnP+hUgW9v5bdTj+CZC2g2DTEmzECLd4uORowZ2Q3zCSNP4WLTB3E5XFyH+6ut84p0yXtc5ZIfpIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855301; c=relaxed/simple;
	bh=8WvPnhhFeZ2URlGzjg9e0UUP8uR+W+FeMhbeU0YInps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kBtjGVCqukLbcQkjVKdPJrTvAgn9GfT9jsNQqUOB6o5dCqqs9G+bTpyNEU05Mw7QzZQPSn1HAOn705QBRF1pD/rrdBpksn5a/qvmHRtsVV9tYavDfbfkELWg8eDH+mi5o92Tu6x5qjpxAT7EVHwKiMVopA8B6OCWtbNNCk1jdzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEQX1ZI8; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEQX1ZI8"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2533d83e3bso25287866b.2
        for <sparclinux@vger.kernel.org>; Thu, 27 Aug 2026 11:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787855299; x=1788460099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jg0L0KQH1TGgD5UWd+gOmMXSQA65MZQV6AxkueBsrHg=;
        b=KEQX1ZI8hP9BkFYFpWf4y4sbKyZnZldebZ3hiW4bHP8f15xQ6aKsyhJf6bXCbK1JI8
         CORgUdrKFQ6r4WB1Fz3oLgs+6pskccOf39wz2RmpO61L4KfEl6JmIYsQRt87ZImsXUFI
         3jX96BGzoPBU3epRYFhIkl3QPOVVnvFhhkI8RXnb4Z/Sd9NlfxprrTd7Xo02OnsAOuwT
         GfFa6+UxY1HwLc57cmSwF8xMU8JhhR5XDAhiYWacbYd15bBmyTm+Mg0AWejN7+sbDu94
         h6cR6iyNL5TW3MuVIxBFVrMUnqLxzvIgNUP/gvIB0JSKz4uw14N7/CBCNJL61cg3UeTl
         uwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787855299; x=1788460099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jg0L0KQH1TGgD5UWd+gOmMXSQA65MZQV6AxkueBsrHg=;
        b=nSIwXSStJPXXZBoM1txppalgMt5MIwZys2JKC9niB/Q+vYQ6vNiooP1BVoG6z2o7G/
         6CtYsaDesoKCh1Ahzywp3fPSIs4XtYhyrW2LwwJyn41DyiLhZ4cA0gHrncl+JtJTiM8J
         gXEeDMx/c3Ebb5E+IOMwQes4XbjHyVtxkSRlre5NE97WwnrenWY07hNgWwv5Dj0GWu7r
         XOSsIPafWEHXnkd3TGoQk0WXBjO4ReRgIheX/YH20jxZ0eFvFN55ljNDgK2KV5NHMcAu
         mc4OGfq3xeCFu7XgRWqpSzon/X94hdBy6Muyi7b1DneITHeQR6IM4pbFkIt79/E1ZFvY
         jH8A==
X-Gm-Message-State: AFuF++nW/c1cRBnOI8boO7ZqiwoyYrBALCG5d9TRz7AG2l35cQ/AWfBT
	qHMCoNu74MJDo7nLPBBfn5bF6BOcH4DINwk1RArzqM3gIpAqXQAgEOtYe63C+I1X
X-Gm-Gg: AR+sD108t2/zmnguwKiXZz41EZVM0BGDHx8u9CzEPl7VK/q3JMWHK8e8Gum1I7CvPmA
	Dfbak4DH94IC7LMWsvUGKlpbgBgzP0PXh8NH5Tn9IojyzPU6JZAvMrLhJ9cfQ15AWrv7FiYIl/I
	r4Tx7I33hv4j0bWFAwFSKuZdS08z/7qLzphtvi+/CxK3HJTtQYhz3TuK53cnVJVKi5hYWJc9NQb
	oiNtAtM9Kq4QjcGfzEm9n8duPsf7rJdEQUFja0RzDIuJFDPAbP6/CBNYnLT+XTkH9Mw5kKU76CV
	IxKITRgctrbCor4p0Q03e/rYUy0nUhNJ4qAE7KlpNtZku5C7450lv1yVXZMig+XGo1U3W2ivQok
	jDlcvXfK4f8uZhPuDqGYr3UL/ZXkprXpIz6DUigzOmyTXroaXxg8S3OUFUan8TSxPSEHMK7bTwi
	ySm4NkJI7oLdBGYAxJ2R5BseSuDQVWQ6odUCyupfBAv9eFbJM3fnVtkestPsSay33J7rqsPHZAJ
	3vckRWe8wjL6vqHxQ0+dapuyg4vqkMCJ9lGz11gmQ==
X-Received: by 2002:a17:907:e1d3:10b0:c16:8799:fcb4 with SMTP id a640c23a62f3a-c25571a63c1mr37073766b.19.1787855298365;
        Thu, 27 Aug 2026 11:28:18 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c254e4e736dsm61288266b.11.2026.08.27.11.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:28:18 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org
Cc: davem@davemloft.net,
	andreas@gaisler.com,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH 0/5] sparc32: replace sp_banks with memblock
Date: Thu, 27 Aug 2026 20:24:12 +0200
Message-ID: <20260827182757.6856-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the sparc32-private sp_banks memory description with memblock.

The first two patches convert the SRMMU consumers that already run after
bootmem_init() has populated memblock. The third patch moves memblock
population to prom_meminit() and applies the mem= limit there, keeping that
intermediate state correct. The fourth patch moves the early memory setup
into setup_32.c and the final patch removes the now-unused sp_banks array.

This work is based on an earlier eight-patch series by Sam Ravnborg.
Patch 2 directly carries over Sam's memblock sizing conversion. The series
has otherwise been substantially reorganized and reworked for the current
kernel. Compared with Sam's series, this version is ported to the current
generic MM setup, keeps the sparc32 mem= command-line option by using
memblock_enforce_memory_limit(), and uses memblock's exclusive range-end
semantics throughout.

The series is based on top of the sparc32 phys_base and Viking fixes. In
particular, setup_memory() preserves the relocated-kernel handling by
removing RAM below the physical address to which PAGE_OFFSET maps.

This series is boot tested on a Sun SPARCstation-20 with dual
Supersparc-II cpu (SM71) as well as dual Hypersparc RT626.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://lore.kernel.org/r/20260817153237.GA702187@ravnborg.org

Magnus Lindholm (5):
  sparc32: use memblock when mapping the kernel
  sparc32: use memblock to find available system memory
  sparc32: populate memblock from the PROM memory map
  sparc32: move early memory setup to setup_arch
  sparc32: drop sp_banks

 arch/sparc/include/asm/page_32.h    |  16 ----
 arch/sparc/include/asm/pgtable_32.h |   3 +-
 arch/sparc/kernel/setup_32.c        | 118 +++++++++++++----------
 arch/sparc/mm/init_32.c             | 139 +---------------------------
 arch/sparc/mm/srmmu.c               |  65 +++++--------
 arch/sparc/prom/memory.c            |  51 ++--------
 6 files changed, 104 insertions(+), 288 deletions(-)


base-commit: 982260b3f81e405af4a65a3029399840a2d2a4be
-- 
2.43.0
