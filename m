Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177359;
	b=BK6sH2AOBwICE/aq/PEPsNcfKG+ZCGK2qQp+PEIiZpGZNCUzzymXrYPX9Ms+uaOu9z+P
	 VkdaW1SmddwLM3qBWqzz71mkTkbHNz6hsxKzR0DPxZ2IBqdlp9BO7gtrKvx04j03zbeRJ
	 U8GzGpRPiN3llX6OGQwVbAh9in1TdtQ72mAO7jD2B2c8S3IzmugzFjge36fQTzdmPqGmR
	 FkUJ02X9UszFS31lPjFq/QFAVNoB/7oOx+Z+dcaxzEgNL3FAMx2F01LlMkUNIWuLL7fpx
	 /6XSSfNj12ntHqeYCAPxV/SwlbxDTOk+sal4rmuSLjbTFxW18/aZp5cGw3EbOayHBKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=gdffhIhcUKdlCUb+ddUagwMtCEoAwvnKtouK4rLwIVA=;
	b=SV2TIRKNsG8V+DmrznFAd84w4rzRAIj3z1UeW/fJkRc1v/0PCHyJtYfGfl9oZPvbcYnU
	 vy+KwdjbPSifrqI6AxGNparvsLxiCzVj6NIo4Qt/OLaYQ4rsqg83WCNce0BHZLSHO3u5C
	 OhBx8k8eJzmc4EitivBlDrSN/AlG4Oz186BIbjr+GRO2+I8KDqcv890Rfr8UaLMWh/eT6
	 TSkThAhnPz4lPKhnOdEMo6nPf9Y+ExNPHdX5xm/RWM/eOZgMk7v2UqN2Baaapzx4+W2eH
	 EfrEWOLJh0cvWwkMA0BPSz6BLkH7XY+uImbKYbgYFeFFkeGXS+0WuqcAfd9EksgnQ8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ynx3XGJG;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7168606A320
	for <sparclinux@vger.kernel.org>; Sun,  8 Nov 2026 22:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7168606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ynx3XGJG
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b596afb4c5so310199a12.1
        for <sparclinux@vger.kernel.org>; Sun, 08 Nov 2026 14:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794177357; x=1794782157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gdffhIhcUKdlCUb+ddUagwMtCEoAwvnKtouK4rLwIVA=;
        b=ynx3XGJGKNtNHaeP533ZA+ojfGmjYuUYJUXFI4zTgkFL03ZPknQrjx0UzwmTWJbej8
         QF9obID6slJ5JPi/880OGo2lx94EmN56GBHdGDnQMUIN2FjZpUj7uettslsTHDcj1S9Q
         I9Boe01r3oeeJBDYn99L2LgbAakYJpZFzSr6WxEtFOw2zdpE4iEExAuSkhsS5DxOtxC+
         Hzm6EGCBSm+JdExarstw5wISWn29jDLHYl9eRzuJEgknYcBbMYwXMx5k1OBpL/g7JgPA
         3nspQ1LPRvI5/OYgkAqKyV0L6PpNwbLkRtl8bKgevvO5vweXQlJdXkGXqC1M8nQYAIrI
         0f7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177357; x=1794782157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gdffhIhcUKdlCUb+ddUagwMtCEoAwvnKtouK4rLwIVA=;
        b=1UtfdI+bF6d52Q0q+O3ehb+Fa1tqJjDx1zBdr2/DlSoHW2qaBjTFfYn/Edgj1OMlNl
         8MUrLq1EngFujXfgxvPIDLYuHbDW1fEDV5CVma83w0iIPMuyrotReaFqRjHaUcI6TMI3
         IN5WczIZZoLFRnVKF78MTu2f2l63GCtAvnout2Yv6QFzjW7TwXD8x8XtN/1kKFdjdlxe
         Yyi6JEFmQdBE4ObFla0qFOf8ls36BTCTjlrAG8oO3O7QsfqVzj0+m3V3np+qI61sf0xg
         TGbbNsIhzo8lAtSaL4SU4hvqIV/fj+Jjxpmx1M/KD+98vl1psbKYF19F189VZfGnX5J3
         7zAQ==
X-Gm-Message-State: APuU4Z/j3vR6rzeEn7oBFhB66ZIfcUGu+R6j/QDQX5jLDlNlHZk2iu3H
	MK+vGMAaMSFibSDd+u+TqnAIopaydbuJxU2jx6FFZBfPijjrG0Yo5tMA
X-Gm-Gg: AYBFou2GpLJxAMGsJL1oZTXC1RTFdUQk37cvrIWFNEd0oppMTuom6Z+WVAuIbrlRXiC
	j3WiCFs/gNeydyImhphyBIbJFn4ZOgtFWmBHgT3ZAbeecy7Xr7Zq5u2kQkfw/XJVxCW3FFpOR0w
	jYL5uwI48kJeadtlH2g0TQmeVoMUifhQTIdv8GvnVu10GEaVuk9LSZ7uMgzX0LgOllxF+qHg3hI
	IhEN8yaa9Mh7WatMvqz+kwnzwJbZmVaJs5SC2Grfc3cPl/xPkv/nQWgC/PZhfUW+dgSd/B7mP1M
	tvyw+5GGs1mEgBW/n7PjKoRfQVoRSGGMsHmDDnEsV1mJQ2vN25rzf9h/FVSuHPRPI6Ho+Inh55L
	YmKpkz54xFVMO7nG/ALQwHZIs4fNZXsOS0e6ULoc/dSZhgNcESYB3l3hFUFeNQA+9mzyDWxpdIq
	O4GinzfHzxi27uVu9/j4MLEDaGyRlKEjrhXZsu8FuapBARFGmGn8qz0Y6jBDn6lRYdttk7HfQ+i
	bsuSD2tMPIEjWUjXlFu7X8yygyGKjpTndw5jfxZZe1B9e26XBMfLtB/yxhZELcc2hPiz4FWVN7j
	K2etBOlTJnxAzWHMCxSqhSbvEmEIMTal0Hq+LLJgibM2rcXacm4AS3N0YVQtdSmlA2ZNerU=
X-Received: by 2002:a05:6402:24a4:b0:6b7:1c:ead7 with SMTP id 4fb4d7f45d1cf-6b722410b3amr1371092a12.20.1794177356394;
        Sun, 08 Nov 2026 14:35:56 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ebc7b0sm859272a12.14.2026.11.08.14.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:35:55 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH 0/9] sparc32: repair cache hooks, mappings and TLB tracking
Date: Sun,  8 Nov 2026 23:34:10 +0100
Message-ID: <20261108223516.1125534-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I am submitting nine fixes for SPARC32 cache geometry, user-page copying,
folio and anonymous-page maintenance, kmap PTEs and CPU-mask tracking.
They apply to linux-sparc for-next at the base commit recorded below and
apply independently of my separately posted bit-lock fix.

Since summer 2026, I have been working on getting Linux to boot and run
reliably on an SMP HyperSPARC SPARCstation 20, with native GDB builds as
my main workload. That work exposed problems in both the HyperSPARC
backends and the common SPARC32 cache and memory-management code.

I am submitting the common SPARC32 fixes first because they address
architecture-wide hooks and bookkeeping rather than HyperSPARC-specific
backends. Some symptoms were exposed by HyperSPARC's cache behaviour,
but the affected paths are shared with other SPARC32 processors. I plan
to submit the HyperSPARC-specific fixes separately on top of this series.

The SuperSPARC demap serialization change is a separate companion. Both
application orders produce the same source tree; neither change narrows
mm_cpumask. HyperSPARC-specific fixes and optimizations are not included.

I completed a native GDB 18.1 build on a dual-CPU HyperSPARC RT626
SPARCstation 20 with 512 MB RAM, using a native SPARC32 SMP kernel with
the combined fixes, optimizations and separate platform prerequisites.
I observed no core dumps, livelock or new kernel messages. This was
integration testing before this context-only rebase, not isolated testing
of these nine patches. Individual patch test details are retained.

For this rebase, SMP and UP builds and QEMU SS-20 fork/COW smoke tests
passed both with and without the Viking companion. Validation builds
included the separate PIL and IPI fixes, which are not in this series.

Codex assisted with the rebase, review, validation and cover-letter
preparation.

Magnus Lindholm (9):
  sparc32: inspect every PROM CPU cache geometry
  sparc32: flush the source user alias in copy_user_highpage()
  sparc32: do not flush a NULL address in flush_dcache_folio
  sparc32: flush the cache when a kmap_local mapping is installed
  sparc32: preset modified and referenced bits in kmap PTEs
  sparc32: colour-align private file mappings
  sparc32: implement flush_anon_page
  sparc32: retain mm_cpumask across TLB shootdowns
  sparc32: enroll and order CPUs before switching address spaces

 arch/sparc/include/asm/cacheflush_32.h |  6 +++
 arch/sparc/include/asm/highmem.h       | 21 +++++++---
 arch/sparc/include/asm/page_32.h       |  6 +++
 arch/sparc/include/asm/switch_to_32.h  |  1 -
 arch/sparc/kernel/sys_sparc_32.c       | 17 +++++++-
 arch/sparc/mm/init_32.c                | 44 ++++++++++++++++++++
 arch/sparc/mm/srmmu.c                  | 56 ++++++++++++++++++++------
 7 files changed, 130 insertions(+), 21 deletions(-)


base-commit: a9e88d617a25306fa7e532b0b8be08df778872cc
-- 
2.43.0

