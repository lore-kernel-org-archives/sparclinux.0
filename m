Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C499460;
	Sat, 17 Oct 2026 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792231516; cv=none; b=MbGpDGcoP6C70hr9cUjM3NNMirGb5pN/uvlv+ysj9gG6hXtMVWC/oS5F8TiSUCFSlyVlIvtBGn8kwnhQjfhVCmLtmia2fuHaaF2mBqi1AEWAp2+Na4dtu1fIpsh/D4HPaST5hZwQyw0YD8BaMJiNFVo9zTHVq2XerwuLRmDb7xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792231516; c=relaxed/simple;
	bh=3+CUiZupQ/OfXONh6RN/fGN/BMA62IWO5v8svztUCQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rmQpRMLg7BFwK3/2zW1UJ4T6d32Sa1A8jhBLgkJ9C7BIwqwvLcU41B+xAimFoy9oyhyF9QV/5gBKLtyVFhbneST2FAX1X7WggsZw1Vl87z6moyDGcIrlWBkcBErv2TMuzaUrsgQGSBsnsSuqTVAKv26vPVChcci2M1bs5CRYYt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=UuKUJYUC; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="UuKUJYUC"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1792231506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yRhFdLBL4t8sg9K3bLI8rm4y+3N0uLfoGZpRMgEEt3g=;
	b=UuKUJYUCnz1kmck6qfdZGwFxsrBF00gCwHJ1BFU1WVvodz6uT0e/v/1jXfn8doksv3Mor8
	0cSWrsXT2AgoxZ7tZEqZEsZr6UTJZLo/N8GB8Pzt2DnSznmYiPsDjqtsY6ZYRPoCewGF2/
	kzfogMZoA+Yws/vpgXkg2KXQjqJJB10=
To: Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: Kees Cook <kees@kernel.org>,
	Michel Lespinasse <michel@lespinasse.org>,
	sparclinux@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH 0/2] sparc64: Randomize mmap base and PIE executables
Date: Sat, 17 Oct 2026 12:04:49 +0200
Message-ID: <20261017100451.2266781-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On sparc64 a 64-bit process gets little address space randomization:
the stack moves, but shared libraries, anonymous mappings, PIE
executables and the brk heap land at the same address on every run.

Patch 1 makes arch_get_unmapped_area() start at the randomized
mm->mmap_base again, which it has ignored since v3.8. Patch 2 selects
ARCH_HAS_ELF_RANDOMIZE so that PIE executables and brk are randomized
as on other architectures.

Found while adding PIE support to the sparc64 Go port:
https://github.com/sparclinux/issues/issues/119

Tested on a T4-1 and a T7-1 (sun4v) and a V240 (sun4u), with 64-bit and
32-bit userland. With the series the program image, brk, shared
libraries and mmap base move between runs, and with
randomize_va_space=0 or setarch -R the layout is the same as before.
The exec and mm selftests, glibc's elf and nptl tests, the Python test
suite and a kernel build give the same results with and without the
series.

Stian Halseth (2):
  sparc64: Start bottom-up mmap searches at mm->mmap_base
  sparc64: Randomize the load address of PIE executables

 .../features/vm/ELF-ASLR/arch-support.txt      |  2 +-
 arch/sparc/Kconfig                             |  1 +
 arch/sparc/kernel/sys_sparc_64.c               | 18 ++++++++++++++----
 3 files changed, 16 insertions(+), 5 deletions(-)


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.43.0

