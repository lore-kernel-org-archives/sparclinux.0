Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C73CBE8F;
	Sun, 18 Oct 2026 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792326468; cv=none; b=YGssEAprEXDFVKP9I39YUil3TciCQMP+mSpqufsslXSKaR4+ZtvN5VDe+fVkfdSjRB+rWfdiSMG1SiTXyrTrZDLN0rtb6cEaz3Fm0fGjuYnb6ftZiIMPHRP1YEneVSq+aArbT2vTD/NkiU6PhHtUpP6GDEpUf9x5k9ATrfeBsEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792326468; c=relaxed/simple;
	bh=GmmF0QJRdzpzhmf7Q064KOktoztMoNkAQCm3dNg3dno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d32JX3V7xNdV58Xt1c6OpY6TtisCZSqEZ/LijpCs3SJE2wMGRQVty8c9RrpbM/SPA/q6GrUJCGzRIwhM7xF6R2o/FDqPNFeHcC+gi83xnd0FoVu+YTZgyb3Kx6D8ild9izEQg8LthJQaG98BgOAv/Hquy7JbFTwNSSgOAlNWilI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=XOKoEzin; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="XOKoEzin"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1792326465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lYkr+husjlk64iLj9K/N8BDK8HbaHvelmyk4t5RYKIE=;
	b=XOKoEzinrSofyoPTQy8RmxgyigBmHkTwjEOouaBzs8DaJgvpEgGuYf07MTNk1r0plL//ZT
	BhI62j8GlGTUsiIpOsu24dFCaeyKTIQAzabV3NasVEXyjBK5rPW1grKH1LFlDtHsHTvkcr
	Q5OWUXMigj0q607Gji1n3040QHYYx8U=
To: Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: Kees Cook <kees@kernel.org>,
	Michel Lespinasse <michel@lespinasse.org>,
	Jan Engelhardt <jengelh@inai.de>,
	sparclinux@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH v2 0/3] sparc64: Randomize mmap base and PIE executables
Date: Sun, 18 Oct 2026 14:27:31 +0200
Message-ID: <20261018122734.2594904-1-stian@itx.no>
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
mm->mmap_base again, which it has ignored since v3.8. Patch 2 moves the
32-bit PIE base out of the legacy mmap area, so that patch 3 can select
ARCH_HAS_ELF_RANDOMIZE and randomize PIE executables and brk as on
other architectures.

Found while adding PIE support to the sparc64 Go port:
https://github.com/sparclinux/issues/issues/119

Tested on a T4-1 and a T7-1 (sun4v) and a V240 (sun4u), with 64-bit and
32-bit userland. With the series the program image, brk, shared
libraries and mmap base move between runs, and with
randomize_va_space=0 or setarch -R the layout is the same as before.
The exec and mm selftests, glibc's elf and nptl tests, the Python test
suite and a kernel build give the same results with and without the
series.

Changes in v2:
- New patch 2: move COMPAT_ELF_ET_DYN_BASE below the 32-bit legacy mmap
  base, so a 32-bit PIE and the brk of an explicitly executed loader no
  longer land in the mmap area (Sashiko). Tested on the T4 with 32-bit
  userland, including PIEs with large p_align.
- Add Jan's Tested-by to patches 1 and 3.

v1: https://lore.kernel.org/all/20261017100451.2266781-1-stian@itx.no/

Stian Halseth (3):
  sparc64: Start bottom-up mmap searches at mm->mmap_base
  sparc64: Move the 32-bit PIE base below the legacy mmap base
  sparc64: Randomize the load address of PIE executables

 .../features/vm/ELF-ASLR/arch-support.txt      |  2 +-
 arch/sparc/Kconfig                             |  1 +
 arch/sparc/include/asm/elf_64.h                |  2 +-
 arch/sparc/kernel/sys_sparc_64.c               | 18 ++++++++++++++----
 4 files changed, 17 insertions(+), 6 deletions(-)


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.43.0

