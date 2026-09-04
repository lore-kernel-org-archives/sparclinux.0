Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3933876B3
	for <sparclinux@vger.kernel.org>; Fri,  4 Sep 2026 05:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788501257; cv=none; b=QBd8H1GivpXurNw+rq3G69AtieaqVu6B/Qg3sPRrcBlYhvRJdeCjfn5ceWaKODxHYs/sqJu7xbdbpbLOYoXNBqXR5dPs8hssKfM+lP04j09sM7oEBNr9rRp+WDaQ99fts8FJ8J7kyC5NTbIqZeWJL1sVFMtYS+pKDzD4krFehJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788501257; c=relaxed/simple;
	bh=GxdFFEBziRWArRZIYgTS/uaZ4xH7TbMAI2n25jau+FU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kNNkYsEoBSpu2tv/2BgW41/B58FljmZeK1mOfiBhvXsNAgsfhnbglNoUJxm+Dq+s4b5eEUKp8QdbYBiGxyJlHifYSQBk3T2WIAeMzP2bca3+aXKljflaZMNMVnOrVqCxOfh0LREozSg/gQT6YbPDfgjZqye5M0AZb1XnyZLIKg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFfXVZ5s; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFfXVZ5s"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a5e971c970so3239604a12.0
        for <sparclinux@vger.kernel.org>; Thu, 03 Sep 2026 22:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788501254; x=1789106054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0e1R5GYTD1G+kVWlbZTazQ1YNcTLXzOn5cXd3jmGpV0=;
        b=IFfXVZ5sUrvTdLMw7mI+Esudl40+0NmTTnmUqoPa6V0UA80TRVeM0cbJ04tWtq8680
         VIDW+i4i6qfXge3NpWMYPyX1NLuQt5ts4C/h+Y3R6vtV+HDJpczPpgPnRw3ETLIb0SWT
         3hD/Tx0Iz4E3idKVp0/MZiKiuNFt+qMVvEVpoL3hCINqmSDH/SkeltVqiT1NAyfk9f5n
         L1ROZdbXvsHqKnZ5WU07iitA2CsQ1jKwpRziyNx7vb4CMshpYGi2quPLEEKsOm7N21mN
         utYoNz0pY2iHNayFl9cRFZiHQ6MdZIbXE709PZJmIqcCpfgKOFZYf3eEvCKX/U8VtUC7
         TXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788501254; x=1789106054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0e1R5GYTD1G+kVWlbZTazQ1YNcTLXzOn5cXd3jmGpV0=;
        b=VgVf90gXlqagWlLSWktQSqmhThYJwmQlFDe9YGRpYuqmyGvqxQIs4DzBD23UUmKjgp
         VMnFhosvzA6fnxiixKZL4BG7SteQLnjhpwtbEdT+QBJ7qXgVYmG1P1tmdC1pzpkmi6Ie
         YnUW+XbU33YfkxajmMlps14SKWHXVMtvcFJF6EHclsNsLeH0KiQCWbfgRKlPtJQZQ7UC
         PdGPY5sNq+oRQtv46qufy7eA30bqqLMiHxP0P61giiDwPWwkg6eiju3joJ3DpGEISXPg
         i6RDlxSqo3HW3bJzHYoz0jv40sjYGDBrznoXF0J9wK6rqCjXss63zmnGmStf4i19mUum
         L73A==
X-Forwarded-Encrypted: i=1; AKwUvBzRRdhQ9VDfcXD83GTpzpt33Zok4CNQcHIldMQivpHkPJbp0OumNTOwcNxkRPgRo5jjR7V0r1Z14q9v@vger.kernel.org
X-Gm-Message-State: AFuF++kVQ0BDiLXCHvYl0HWIfi3sJERSfyGMCxpGI8xawSqmnwY4pjJq
	WHqBPaGDohRtNXOJCczLqWgHl4bY3TlHtV2igRkXrasdHuzBnzBF5fE2F/c2vEpZ
X-Gm-Gg: AYBFou1iTV67JII8EHJqSIYdacs/pWQVb068fTmG/zdpn7c2qj3Qr09C7RTOexg3RKn
	H2OOYC77Q67Qr2mXib7yqEu2ZUBAz3+r44+p9OmvVLH/sCBcgX6W0L0IvyACQ/M029RUZIrRlVL
	ZkxYs0aZ3EqXannbNmK502HiWnnXYIh9pX2AZqL6p5wmd5R/YdGsoy21Hxr4hnhiHaDJYivwD+C
	jkRxZVfwd14AKx9VuNvHiqUKd5pMAlGPnkRC94x6b86zRNwnsOua20st1uD6DC4EUnHU36++pSl
	OkHRyE/5y+DOSIYBXpIcBswFHyVzBmJSr3/efKvUEcEXjsIHROvLgqY2fFdklyKrP8U3eFqDJK/
	shIrYbc9OQwbkGUrOeWzZsDWTHQaIjvSZhfMcOnP8JD45qvMiVhFzDuCszX2RRoQxCcI2LLfMMf
	zuM0VeWv6xYNrSPP995uRGeFoieQU6LHodao3n/ARJaw2UWkpvCtw2Xr9H0T05TD5t35Bxm/O6W
	VV86KkmndW2z34ZNreOBS+YvGJeG1g=
X-Received: by 2002:a17:907:72d2:b0:c25:f7db:4be9 with SMTP id a640c23a62f3a-c2610474cfcmr108471166b.15.1788501253841;
        Thu, 03 Sep 2026 22:54:13 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d6e1c01sm55918466b.62.2026.09.03.22.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 22:54:13 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH 0/2] sparc32: fix SuperSPARC SMP synchronization
Date: Fri,  4 Sep 2026 07:53:04 +0200
Message-ID: <20260904055359.327050-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fill two gaps in the SuperSPARC/Viking SMP synchronization paths.

This series is based on the three sparc32 relocatable-kernel fixes which
honour and derive phys_base and advertise the relocatable image. It does
not include those prerequisite patches.

These patches can be found here:
Link: https://lore.kernel.org/sparclinux/20260816075141.3489194-1-linmag7@gmail.com/T/#t

The SuperSPARC Family User's Manual requires software to keep at most one
Demap operation in progress across the system. It also says that an MBus
system must ask every processor which can retain a stale translation to
perform its own local Demap [1, sections 8.5.3 and 9.8.2]. The Sun-4M
architecture specification likewise describes SRMMU flushing as local to
a module [2, section 7.1.4]. Patch 1 serializes each complete shootdown on
sun4m and invokes remote CPUs one at a time. sun4d already serializes its
Viking Demap operations.

SuperSPARC maintains I-cache coherence by snooping, but FLUSH is still
required after modifying instructions. It drains the writer's unsnoopable
store buffer and clears local pipeline and prefetch state [1, sections 7.4
and 10.2.5; 3, section A.8.2]. Patch 2 executes FLUSH first on the writer
and then on remote CPUs.

The series was tested on a dual-CPU sun4m SPARCstation 20 with TI
SuperSPARC processors and Viking/MXCC:

  - boot to multi-user with both CPUs online;
  - 200,000 concurrent mprotect iterations over a shared address space;
  - 12,000 executable-code rewrites checked on both CPUs;
  - removing flush_icache_range() reproduced a stale instruction on the
    first rewrite.

[1] SuperSPARC Family STP1020 & STP1090 Series User's Manual,
    Revision 1.0, April 1994.
[2] Sun-4M System Architecture, Specification 950-1373-01,
    Revision 50, July 19, 1991.
[3] SuperSPARC II Addendum, Revision 1.3, December 1994.

Magnus Lindholm (2):
  sparc32: serialize SuperSPARC demap operations
  sparc32: synchronize SuperSPARC instruction updates

 arch/sparc/include/asm/cacheflush_32.h |   2 +-
 arch/sparc/mm/srmmu.c                  | 120 ++++++++++++++++++++++++-
 arch/sparc/mm/viking.S                 |   4 +
 3 files changed, 123 insertions(+), 3 deletions(-)


base-commit: e6de5705a9f0d81f67bdb2917108784b5839cecd
-- 
2.43.0
