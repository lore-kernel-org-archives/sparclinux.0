Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B91846A;
	Sun, 27 Sep 2026 00:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790470765; cv=none; b=NzrFrRvsw9jDVxaw6Sm2tsO2NUvKACI8FqoK0T/63PXoSdRSDAjlLFq4WII5OqV1gIUGbRUXB50Kn7PIUhIkz8ro+Wpk2ztSq8YnCCDyOqJZ42ZGSYMttzcOa96E8UpT7yszFJslzvAaIsq0YMKui79vGEUd0WenRZgQJ+8rhL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790470765; c=relaxed/simple;
	bh=TNkkdx5WKpm1iiVunVLTQRGySFBqJJM3BXMNlXkdfwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UMslB843eq/kVV+QkYMxb3gRByVhum8SmXJOXHvhQ4MhuYccccPWhl788y4WRIQFX9L7Z3UqgeY39Qtoy0GQmilejcHvAcmT7sGAZlYbe3BBv7JTxZhhj/zeiEXUDqieG6p+eghg8c72/eltYfBqNIPAjAKk5jvYbM03epon+F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJQMQStK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJQMQStK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E791F000FF;
	Sun, 27 Sep 2026 00:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790470764;
	bh=3qEmvdddpg65f5B3VA6Yfjblf35thlprZZm6e9R8o5s=;
	h=From:To:Cc:Subject:Date;
	b=HJQMQStK58QjSBOA87GkSy55GM9idmGRBUCDTxYQ5muxXVV0HVGvhbgmrS4ODu22P
	 Je4/Bmngn3eIrTfQCsWNp1AABpvMktsrpaCunxUU8aayWDfRd0RKn24OjErwyg7sg2
	 AgPy6uBlr9CWJs1MZ61h4ux3XvV2q/IvZE5Lz4aJKNBoFu+RV9SbCWkteWAG0wU8lu
	 8hVqnO/srLO2MZWZRJDjkaw8WhIjPt6mbzynf/VZDM9dYAUzA2Om+/B1yWFXYU24gp
	 HfoYfnnJc//l+N0njCM239A835B7U07ceVH1doHaHl71TaIiAK9wr4B8vuKmt3thsb
	 vmKi7FKQ81yNA==
From: Imre Kaloz <kaloz@kernel.org>
To: Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH 0/3] sparc32: SMP futexes, casa and idiv emulation
Date: Sun, 27 Sep 2026 02:58:18 +0200
Message-ID: <20260927005821.8369-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sun4m has no compare-and-swap instruction and casa is optional on
LEON, so SMP sparc32 has had no futexes, and user code on those CPUs
has no CAS to build locks from.

Patch 1 implements the futex atomic ops in atomic32.c and drops the
!(SPARC32 && SMP) dependency of FUTEX. A LEON part that implements
casa, found by a boot-time probe, runs casa on the user word; other
CPUs take the __atomic_hash spinlocks.

Patch 2 completes user casa from illegal_instruction on CPUs without
it, through patch 1's futex_atomic_cmpxchg_inatomic(), so emulated
casa and the futex ops serialize on the same lock. It is atomic
against itself and against the futex ops, not against a plain store
to the same word, so a C library using it has to do its atomic stores
with casa too.

Patch 3 completes udiv, sdiv and their -cc forms from the same
do_illegal_instruction() dispatch: SuperSPARC and SuperSPARC-II trap
those when the {Y, rs1} dividend has significant bits above bit 51,
which gcc -mcpu=v8 output, including libgcc's __udivdi3, can produce.
It shares patch 2's windowed-operand helpers and the dispatch block,
which is why it comes last.

Patch 1 comes first because patch 2 is built on it. On its own it
races nothing: without patch 2, user casa on these CPUs is SIGILL.

Magnus Lindholm has an independent RFC covering the same ground from
a different ABI: "[RFC PATCH 0/5] sparc32: kernel assisted
compare-and-swap, and futex on SMP" (patchwork sparclinux, Message-Id
20260923201830.865553-1-linmag7@gmail.com), with a companion glibc
series (patchwork glibc, Message-Id
20260924064228.867909-1-linmag7@gmail.com). That RFC adds a new
software trap, ta 0x11 (trap type 0x91), extending David Miller's
2016 CAS-trap prototype at ta 0x23 rather than completing it, so
userspace has to be rebuilt to call it. This series instead
completes the casa opcode itself, so a binary already emitting casa
(gcc -mcpu=leon3 or -mcpu=v9 output, or a C library that encodes it
as a .word) runs unmodified on a CPU without hardware casa, with no
new trap number and no libc rebuild. Happy to share the futex and
do_illegal_instruction() plumbing with whichever ABI lands.

Andreas: do LEON3FT parts want the GRLIB-TN-0010/0011 "nop; .balignl
16" alignment before the casa word here, or is the plain encoding as
posted fine for them?

Notes, not for the log:

- checkpatch on patch 1: "Lines should not end with a '('" is the
  __asm__ __volatile__( idiom of uaccess_32.h; the -ENOSYS warning is
  the futex API's return for an unknown op, as on every architecture.
  "does MAINTAINERS need updating?" on patches 2 and 3 is covered by
  the F: arch/sparc/ entry.
- On qemu's SS-20 with two SuperSPARCs and the casa emulation alone,
  futex() returns ENOSYS and musl's mutex, PI mutex and robust mutex
  tests fail. With patches 1 and 2 they pass, as does a PI lock
  contended between user casa and FUTEX_LOCK_PI/FUTEX_UNLOCK_PI on
  both CPUs.
- The casa branch of the futex ops has not run on LEON hardware. The
  probe runs on LEON only; its fixup path, which a LEON without casa
  takes, has run only in a test kernel that forced the probe on
  qemu's SS-20.
- The divide emulation has run on no CPU that traps it. No sparc32
  model in qemu raises the trap, and no SuperSPARC or SuperSPARC-II
  was available for this series; it is exercised only by build and
  link.

Imre Kaloz (3):
  sparc32: support futexes on SMP
  sparc32: emulate casa on V8 CPUs
  sparc32: emulate integer divide taken as illegal_instruction

 arch/sparc/include/asm/futex_32.h |   6 +-
 arch/sparc/kernel/Makefile        |   2 +
 arch/sparc/kernel/cas_emu_32.c    | 117 +++++++++++++++++++++++++++
 arch/sparc/kernel/div_emu_32.c    | 127 ++++++++++++++++++++++++++++++
 arch/sparc/kernel/entry.h         |   2 +
 arch/sparc/kernel/traps_32.c      |  23 +++++-
 arch/sparc/kernel/unimp_32.h      |  71 +++++++++++++++++
 arch/sparc/lib/atomic32.c         | 122 ++++++++++++++++++++++++++++
 init/Kconfig                      |   1 -
 9 files changed, 468 insertions(+), 3 deletions(-)
 create mode 100644 arch/sparc/kernel/cas_emu_32.c
 create mode 100644 arch/sparc/kernel/div_emu_32.c
 create mode 100644 arch/sparc/kernel/unimp_32.h


base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.47.3

