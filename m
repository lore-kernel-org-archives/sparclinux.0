Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAEA39CCF7;
	Wed, 14 Oct 2026 20:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792008080; cv=none; b=SQ9zBwhZhkz8a+mXPv5TSCx8MlO4mQAh7IVM+ZHmb6gG+VdcbJy82P1cewir7krMzBfPxGu/vlKrP1Ph+X/Xh/8G/Z4W/ZmpNsb4N+WMFOZw9+LT4uDDSEmftbh/pdSVm+1tOYDJMf2TWro1eXzDkgneJQtLRezszubWLk3YgTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792008080; c=relaxed/simple;
	bh=mtluyz/puIC0o6bnuVygouk4ZxWzFo09N/PvKQqAh1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CJ6NRAMC8NnHiUZUFXGS6v8EN9wkzgoLuLMroS3U7OGZM7KUGkgN+b1ZGT5ohWKpmymQD3JAJXp2y8fVaRgkJrhholC791zMKweca1IYk+6SN+MD/4yRPz2wHlYPBSg7FADDRbbV1UAdVKMg1+4QrKNeIcXeyYQyNexDrzLHWL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6eL6YOF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6eL6YOF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AADC1F000C5;
	Wed, 14 Oct 2026 20:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792008079;
	bh=dgx7fdVL3gslgVt9JDPuNjkPT/2OnyYQOFdGME5nfVM=;
	h=From:To:Cc:Subject:Date;
	b=V6eL6YOFwWuYgmDoB3mIA4GJ3F4OZCBk9aFgeGrpcuwi4o03Vd8ovkLKlg4UChmYN
	 sVTjzdqjPsjT704Blk9YrdyohlOwJm6FDtk4Xq+Qr0MtI3sGGargh5Q0RpngXYtWuP
	 qWn+QZiUctW5JOGzpaKCvhxi+39imNKSXDfzb9VJm6wIFmM5UGhGiZhkmNUC89V9M5
	 0xnUQ1Zqpq1EyaEZBTxYDDU9DOwGjBsh4D0hSmr7MsiVRe9LcEeYXyBE9cBMPNycEj
	 cD30B5U6lNd2UZAVhcZwEio5JDcB1vuZcEO6kepMkEQVDY7ZFo0ImmBN5E6caFwgpv
	 yLzcvxBt8kORQ==
From: Sasha Levin <sashal@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] selftests: report per-suite build results without failing the build
Date: Wed, 14 Oct 2026 16:01:08 -0400
Message-ID: <20261014200115.1363363-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building the selftests succeeds as long as one target builds, so that a
single broken suite does not cost CI systems the coverage of all the
others. Commit cad6f32665cb ("selftests: Deescalate error reporting")
restored that policy after commit 7e47389142b8 ("selftests: Preserve
subtarget failures in all/install") had made any failure fatal. The
other side of the policy is that make cannot say which suites failed,
and CI systems fall back to guessing from the installed files, which
misses suites that installed their scripts but failed to compile and
flags suites that legitimately install nothing.

This series keeps the policy and adds an opt-in report instead:

 - Patch 1 fixes the exit status of the top-level loops, which wraps to
   success once eight or more targets fail.

 - Patch 2 adds KSFT_BUILD_REPORT. When it names an absolute file, the
   all and install rules append a "phase<TAB>target<TAB>status" record
   per target, without changing what is built or installed or the exit
   status of make.

 - Patches 3-7 apply the same policy to the suites that build their
   subdirectories in shell loops (futex, arm64, riscv, powerpc and
   sparc64). A failing subdirectory no longer hides behind the status
   of the last one, nor drops the whole suite from the installation,
   and each subdirectory is recorded as <suite>/<subdir>. FORCE_TARGETS
   keeps failing fast, now also inside these suites.

Patches 3-7 depend on patch 2 for the recording helper, so the series
is easiest to take as a whole; acks from the architecture and futex
maintainers would be appreciated.

Tested with mock suites for every converted loop and with native and
cross (arm64, riscv, powerpc) builds of the affected suites against the
base tree. A kselftest-install of 20 suites gives the same installation
and runlist as before, plus the report.

Sasha Levin (7):
  selftests: keep the build status from wrapping to success
  selftests: optionally record per-suite build and install results
  selftests/futex: report failures of the functional subdirectory
  kselftest/arm64: keep building and installing after a subdirectory
    fails
  selftests/riscv: keep building and installing after a subdirectory
    fails
  selftests/powerpc: report the outcome of each subdirectory
  selftests/sparc64: report failures of the drivers subdirectory

 Documentation/dev-tools/kselftest.rst        | 38 +++++++++++++++++
 tools/testing/selftests/Makefile             | 31 ++++++++++----
 tools/testing/selftests/arm64/Makefile       | 43 +++++++++++++-------
 tools/testing/selftests/build_report.mk      | 26 ++++++++++++
 tools/testing/selftests/futex/Makefile       | 32 ++++++++++-----
 tools/testing/selftests/powerpc/Makefile     | 20 ++++++---
 tools/testing/selftests/powerpc/pmu/Makefile | 20 ++++++---
 tools/testing/selftests/riscv/Makefile       | 39 +++++++++++++-----
 tools/testing/selftests/sparc64/Makefile     | 33 ++++++++++-----
 9 files changed, 218 insertions(+), 64 deletions(-)
 create mode 100644 tools/testing/selftests/build_report.mk


base-commit: 4eb2586bd40db27d77cc5b724ca9386ed0c71d53
-- 
2.53.0

