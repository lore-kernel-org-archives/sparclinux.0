Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A733D091A
	for <sparclinux@vger.kernel.org>; Thu, 17 Sep 2026 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789631953; cv=none; b=lkezYT8kgbk1ib+RI8e77Ssj5jAyRP9NN/f11+IxkWaZjjyyBxiNFi6LF1fEIkDoRU03o12NYGBrOfv170tpSEOqjhrHbVS4LQ8jeTRi61KF3IILaQvtSncgZF6Hc5wV6jXOszc9AvHIZ+5zdJe+wKm5BEF9QP2QyX32KBuQlS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789631953; c=relaxed/simple;
	bh=HzxMf9+8T6QPlATP3+kPcAW2ULqoRkB/P0Uf3YNk5yM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7tGjKT7eOrNWj0qRNhRkfX9y5IbOWtBKsJt/UEQeNs7Nrh8MdgK0yMVDHWAVOOTrclMGfZ+E4kUa/8wPvHJDhROWxopPuFqSo9X0OwyPEcSIKADE0QOhHT1XuMHZwbyiiEjyhlXnQjcmVtFcfyqhIWu6mQNi2MMcS3vfLPMdqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huv7/E1q; arc=none smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huv7/E1q"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6a9dfe4dfc0so889857a12.0
        for <sparclinux@vger.kernel.org>; Thu, 17 Sep 2026 00:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789631949; x=1790236749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GOfKLa1W7BWMMHOij1kNXtl7XucEhCyieOIZlA8fo3k=;
        b=huv7/E1qv4mSBia1m5TrNhiFYEtn8QmwbBv2I9RqnBZKu1MDuvEWEvZitGzT+78nwh
         rhhRkfylBXu/eXedEhVsNC+qU3jhsdLh6CzwNDhsruCPWtKSKQi1BgPjGVhwFpDwPdbl
         Kb7QzUJC6F/acykt876juwDnHZNzXU/KUjE3ckB2FND/gGcLOQVP6RU0a1qKezyqc334
         GxAT1oIBRlCkcNOyxHZOF0J8GMbcCkUQLsT69XPnPaegWd0ymjRYpqm3EeVW9Ey22jca
         X+DRowM9fwsb3Md1boQkA2zBFELHId32ViGUiIqo4NsRVzsqE8yDIXNF7vW03MDYa1Uj
         jQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789631949; x=1790236749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GOfKLa1W7BWMMHOij1kNXtl7XucEhCyieOIZlA8fo3k=;
        b=X3imNSbluYlr4TIzdAMcvaG28pz01OPrY/EIiG24tGH3dKa63lVfANe/FC3zhsOdqh
         3J1CZnDjKa+kz7/DhPEGZlo4M6WTG77u4NveJvpJJ3pLbubr6XH9FbrcC0wBlzuOEqw/
         Jd6WxQxqlJTqTa7uvbfa6t0yG8M0C+LrXRiscNJVTPVG18lBAGjEt7C35EB8BZGXDxsD
         Knsq6carLLJgO0zATc+AC1K5ax6SOscl5/8WAu2F7eVM3RfMLShTsLsHkzWrFwekwoqT
         E4Wc8ueuGntIbG8aU6b0MityfU8djAVhSmiy7Civcmq+QMktSX1KuFiEiTiwCgBZMHhw
         DVEQ==
X-Forwarded-Encrypted: i=1; AKwUvByHi++kyND9twcSJf9tW0juloCWrYHSrDmzlW10Y+5+Qoy8P5gBGzV/1TaOkoWNWo91E2B7bGSXSuyl@vger.kernel.org
X-Gm-Message-State: AFuF++lg0VdyiIR1ybp+lIBS4hYcD9ntFD6Mh/0tJzQ1LKrf7KRLzrBf
	hUYBDllZPgQbGIg+R9ggBVi2E2qrrhqV+rWyw4Udr/OVzQkFckdgpbcF
X-Gm-Gg: AYBFou3Ly3NY/Peg2TOL1JZp1BTH2eAwcLS4IlmXe5CgRaTSTmRKwlgqczGb65nJb3e
	75z/HPRzIlpkCVootIqDmSOCO/kVKRw5p/TXsqB+8n4wqJ5GAP6uzvPkenhW7gPDaIKKdkyaZRd
	kd7mrcYKlK6o3uo1JQkCqcKDjcry8fqeK0OEVNLHvlg000zyN4MnL4x8DMaxX7Xxlzth7ep4JQj
	zbizOTIWttYvgZkIdYhBDxvR6mSNzCu+iYvTr23EGOJnSpw7Io2N4IL7ShB6VW5tbw+vwJRyHsd
	faknSKtE0MCWs7ZOVqx32cFxGsMZdAN8MGwbRARRn+0WST2QOxGN85u5NR1Dnh+x3WN63ZFZR1q
	bex0dkKD2trcQbB94j1ae4g6GCOFEL7BDj+B2sNHmTNyFnUunf85j4prRifvUMijYiYWma0sqDV
	Nq0gsoFupM2qLogXyDGHTVaOTDZ9FcVNd7fNP/bMcj1sWMh0o1wIIy6WQjHfOtl6Kcnr3A8XmeC
	IB9OqksJajFLn+orWnT0h7jP7kgE0dlM+MZ4oTiag==
X-Received: by 2002:a17:907:6d1e:b0:c29:5af0:3b44 with SMTP id a640c23a62f3a-c29e52e0551mr377872566b.41.1789631949444;
        Thu, 17 Sep 2026 00:59:09 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de453ea0sm250287766b.11.2026.09.17.00.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 00:59:09 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH v2 0/2] sparc32: SuperSPARC SMP synchronization fixes
Date: Thu, 17 Sep 2026 09:57:03 +0200
Message-ID: <20260917075842.784996-1-linmag7@gmail.com>
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

SuperSPARC maintains I-cache coherence by snooping, so no remote processor
needs to be told about modified instructions. FLUSH is still required on the
processor that wrote them: the store buffer is not snooped, so FLUSH is what
pushes them into the coherent hierarchy [1, sections 7.4 and 10.2.5; 3,
section A.8.2]. Patch 2 supplies that local FLUSH on two Viking paths that
performed none at all, viking_flush_sig_insns() was an empty stub, and
flush_icache_range() was defined as do { } while (0).

Tested on a dual-CPU sun4m SPARCstation 20, TI SuperSPARC-II with
Viking/MXCC:

  - boot to multi-user with both CPUs online;
  - 200,000 concurrent mprotect iterations over a shared address space
    (patch 1);
  - 40,000 executable-code rewrites, each replacement executed on the
    writing CPU and on the other CPU, with each CPU taking a turn as the
    writer (patch 2).

An earlier revision measured a stale instruction on the first rewrite with
no flush at all, but that was on a kernel predating this series, where the
whole Viking icache path was inert. On a patched kernel the same control is
intermittent, so it is not offered as evidence for anything here; the
argument for the shape of patch 2 is in its changelog.

Changes in v2:

  - patch 2 no longer cross-calls remote CPUs. Hardware snooping maintains
    instruction-cache coherence on the other processors; both FLUSH
    operations are now local. Callers modifying live text must arrange
    safe execution during the update. A later cross-call cannot prevent an
    old instruction from executing before it arrives, and cannot by itself
    make an otherwise unsafe concurrent text modification safe.
  - patch 2 no longer routes Viking sig_insns through the SMP wrapper, so
    that path retains the local-only behaviour mainline already had.
  - patch 1 is unchanged. It is a TLB shootdown: MBus cache coherence does not
    make a peer discard a virtual TLB entry, so each processor must still
    demap its own.

[1] SuperSPARC Family STP1020 & STP1090 Series User's Manual,
    Revision 1.0, April 1994.
[2] Sun-4M System Architecture, Specification 950-1373-01,
    Revision 50, July 19, 1991.
[3] SuperSPARC II Addendum, Revision 1.3, December 1994.

Magnus Lindholm (2):
  sparc32: serialize SuperSPARC demap operations
  sparc32: synchronize SuperSPARC instruction updates

 arch/sparc/include/asm/cacheflush_32.h |   2 +-
 arch/sparc/mm/srmmu.c                  |  98 +++++++++++++++++++++++++
 arch/sparc/mm/viking.S                 |   5 +
 3 files changed, 104 insertions(+), 1 deletion(-)

-- 
2.43.0
