Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0EA57D231
	for <sparclinux@vger.kernel.org>; Wed, 23 Sep 2026 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194763; cv=none; b=bBESTZ228gqZyX/1M1q7XB91Uded/8mPqy/AHJuhUhrXD4B49arXw0u5poM6i1KhVTDSigyMoPVmjSB2izh8GZDAeg/VYRE1g/VLW7sNKAdgcdrd5DBLenJmiLcw8iPD0GPs8n0aoFDmmVfyrx44DutR8lDNJHdQl2av13cY+c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194763; c=relaxed/simple;
	bh=j9ml7moNdZTZRiqUKuFEvti0+5715fcA+evNmXPT3E4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hrwkP+A3t/UCD02hWLPlruMeH+llPnAE//NhDtazazmd7G61lFT4nTSzG8H1BbUWLBWgeX+A03t1/2kiMSoA3ztIkcsL6txggmGCES9eTMPTfqZPIaUg12D0kl9w2EdBYexfDF+9kThgKfS4Mu1BQ2gbbBuxflRA9dYvmLy6bM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFQRGnXC; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFQRGnXC"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f70553dso207145566b.0
        for <sparclinux@vger.kernel.org>; Wed, 23 Sep 2026 13:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790194758; x=1790799558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Oxi+D6Hm89oUa+qfqKu+JYDtZ0PtvCxhaa4mk2qXNVs=;
        b=CFQRGnXCR5McwsDz9SVXsKHUVqijKDuxEYlD+fCIT4Vee5H7VtIKAnqOUq8/Nb3S1b
         MrN3nnWWmwopKM6Q/zzxIQ/Q4UXq2R2Lx64fcJGkVgtJ+Xyuy3lSq5wmllEunDmgW6kY
         C+Xvsxtaw1vaPx/I3sfO37EExtfOzalthLNcrDHZKqsBoTHNktTtV6fW+lagldoVVmqw
         yXyfSA+TCxi3pKMFHz3H+K8T0MliiKHoVfAvYvYvCE5zlwVJpjxewvw06r3IQlC6ikl8
         eVaKRoC/txwjKCtD7QJiOoUJrMpX5BIdr262wana5w4d2yGMWIIdZsCVAiOg+FGMvAe9
         kPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790194758; x=1790799558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oxi+D6Hm89oUa+qfqKu+JYDtZ0PtvCxhaa4mk2qXNVs=;
        b=kQc+92k2hvZ3wUETEqtm+oGWtwtnsdt8XYhvGwCoJbv9SmJTkC1J2a4vWTM8rgSXSB
         oKP4deXxrF3+8q3m1NRgQ7U+yBHdwHHZP3ttIcy9SPllbxuFFZs3uc8aF0Sw91uhmpnO
         CZ76GRUmtsv1us/txFcVNdWwL1wUHugO7HKJx7kEuKXR3sqTv2XLsJU+BgAubxldCbDc
         k/49MSJmrrstW33egPs6D0EXVmsXVarNbF5tbTxo/naozNlX6houX7n2Fzie0v5F7z67
         mKRMr7sjp2qjrwzFFnh6x7sbcH08wm0sHFWvhQSdc1WzleEt7x1/b2JJn6i0+BiUQ1ih
         6zQg==
X-Forwarded-Encrypted: i=1; AKwUvByVg4yv+T3jf7D4izwtfg4sKi76267t3irZs8ppUKtadsQv0nYcrKGge5ubVZxEsloueJNb5bl5luip@vger.kernel.org
X-Gm-Message-State: AFuF++k7YxNsCuRYmwgMCUCfcJvwflmX6m0IB27deB3qLjgtbg3TDP7h
	x4hNprdAdihc+y/amqJDx3t2SK1A74BO7Ie3okv4CheI+syY1T5wRuWY/dGa2TVf
X-Gm-Gg: AYBFou3ix++2ggLDrUTk+ssFHIWWbLcbyJ9WpdkNBW5eWHCyaRhrhdsUhPtn+c0XDhT
	fQMiXcZMgZJHHE65JslyT7oNY1n863FF/U0P3I7APb0DtbO6d5NRYYBJa59sV78+9iwzak5pWzV
	jqBney1VcqRg6N7gR/qesXR+8Gd2ev53rox53RHh7Y8IdXhHf6Il84LHba/UGBqQrBB/lZSBeeC
	5WA6ap0d+tVtFP/jC94wpHHh0adCuGR/KxmN6TgI+dY5kisELps3wiiTCK22i3zk1fJV8AZ6iVZ
	Us1LemoqsAk/+RyBewK63brPSiO/9Bd2GjYVjqe6dYB8UbmgP/M2gt4zPMMofN6cUzsL3tQohN7
	gcXsPxAw/GpIV5LnjZpuOykJpnY67IZ8AkE4LuOgt8t4osZihqvsvqg06R4BQlofAXr17u0A1n3
	6icqbSnSD11rVI32djZtS2wPFMDJYXzUrqphM4H6cQiw/YVhbnaKCT5t6IX2SIdSdsQa9Cs4IAY
	B7t2hi5qM6EnZhEQFh4XZIn1KmxURb9RwpoRNfJ5euU1N/9Uzc=
X-Received: by 2002:a17:906:f588:b0:c26:1648:a065 with SMTP id a640c23a62f3a-c2ac24ba0demr21153866b.32.1790194757536;
        Wed, 23 Sep 2026 13:19:17 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae63dc17sm183626966b.33.2026.09.23.13.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 13:19:16 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [RFC PATCH 0/5] sparc32: kernel assisted compare-and-swap, and futex on SMP
Date: Wed, 23 Sep 2026 22:17:16 +0200
Message-ID: <20260923201830.865553-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is part of my effort to get modern Linux kernels and a
current glibc-based userland running on my SPARCstations. With the SILO
and kernel fixes I've been working on, these machines can now boot
recent kernels again. Booting the kernel is only part of the work,
though: running a current glibc-based userland also requires working
futex support and userspace atomics that cooperate with it.

This series addresses the kernel side by providing a kernel-assisted
32-bit compare-and-swap operation and implementing the architecture
futex atomic operations needed to enable futex support on sparc32 SMP.
On machines without hardware compare-and-swap, the proposed userspace
trap and the architecture futex helpers use the same kernel-owned
locks, allowing their operations on a shared word to participate in
the same serialization mechanism.

A companion glibc series addresses the userspace side, with the aim
of restoring baseline SPARC V8 builds. It uses native compare-and-swap
where available and the proposed kernel service otherwise, including
for libc's internal atomic stores and exchanges so that they
participate in the same protocol.

CONFIG_FUTEX depends on !(SPARC32 && SMP), so an SMP sparc32 kernel has no
futex at all, and glibc has relied on futex for internal locking for about
a decade: such a kernel cannot support a current glibc userland correctly.
Arnd Bergmann observed the same in the 2023 "sunset sun4m and sun4d"
thread [1], and on what a v8 versus a leon build actually uses [2].

The generic futex helpers must update a word in user memory atomically,
and the baseline v8 instruction set lacks the general compare-and-swap
operation that needs. A kernel-private lock does not fix it, the kernel
does get_user() then put_user(), and userspace holds no such lock, so the
mechanism has to be one both sides share. parisc does this with its LWS
compare-and-swap, the model followed here.

The ground is not new. David Miller prototyped a sparc CAS trap in 2016
and Andreas Larsson proposed kernel-assisted atomics again in 2019 [3],
including compiler builtins trapping into the kernel [4]. This is a new
ABI along those lines rather than a completion of that one; patch 2 has
the detail. Software trap 0x11 gives trap type 0x91, immediately following
the Linux syscall trap at software trap 0x10, trap type 0x90. sparc64
compat mode is deliberately unsupported, since ta 0x11 is the old 64-bit
system call trap there.

Patch 1 detects the v9 casa extension at boot. Patch 2 adds the trap -
userspace executes ta 0x11, since sparc adds 0x80 to form the type. Patch
3 puts the futex helpers on it and drops the Kconfig dependency, 4
advertises it in AT_HWCAP, 5 documents the ABI.

Patch 5 documents the limits, which are worth reading first. On a cpu
without casa, storage that participates in this protocol must have every
atomic write built from the trap, because an ordinary store does not take
the kernel's lock; that is Andreas Larsson's 2016 point, and why parisc
ships a kernel-assisted atomic store beside its LWS CAS. Replacing the
__atomic_* symbols is not sufficient, since gcc can expand some of them
inline on v8 - and covering libc's own uses is a different scope from
covering application code built with atomic builtins. One aligned 32-bit
word is also not general byte and halfword atomics. So this is a
kernel-assisted 32-bit compare-and-swap enabling futex for cooperating
userspace, not arbitrary sparcv8 userland support.

One kernel path is worth raising. futex_robust_unlock() clears the futex
word with unsafe_atomic_store_release_user(), before the hash bucket is
locked and not through either architecture helper. SPARC32 uses the
generic definition of that macro, which ends in a plain user store, so on
a no-CASA SMP system it does not acquire the lock the software CAS uses.
It can land between that CAS's load and its conditional store, letting the
CAS overwrite the unlock and still report success. Dropping the Kconfig
dependency is what exposes this on SPARC32 SMP, and it has not been
observed in practice.

The requirement is only that the two agree on how they serialise access to
the word. The macro is overridable, so SPARC32 could supply its own
definition and keep this within the architecture; whether that is
preferable to a futex-specific interface is the question I would like an
answer to.

Choosing between lock and instruction follows the hardware, not a build
option, because userspace's choice does too:

	hardware   trap-aware userland   userland uses   kernel uses
	no casa    v8                    trap 0x11       lock array
	casa       leon3                 casa            casa
	casa       v8                    trap 0x11       casa

Row three is why the trap handler uses casa where it exists, and why the
futex read-modify-write is a casa retry loop rather than a locked read and
write: a binary using casa inline holds no lock of ours, so between our
two accesses its update can be lost while both appear to succeed.

Applies and builds standalone on v7.3-rc1, cross-built for the
SPARCstation 20, no new warnings. Boot-tested only; the trap itself has
not been issued by a test, and the concurrency, fault-path and
cross-process cases have no runtime results yet. The casa path has never
executed here, this hardware has no casa.

Boot testing on my SPARCstation 20 used these prerequisite series, since
that machine does not boot current mainline without them:

  sparc32: relocatable kernel / phys_base + Viking fixes
    https://lore.kernel.org/sparclinux/20260816075141.3489194-1-linmag7@gmail.com/T/#t
  sparc32: replace sp_banks with memblock (v3)
    https://lore.kernel.org/sparclinux/20260901214611.60560-1-linmag7@gmail.com/
  sparc32: SuperSPARC SMP synchronization fixes (v2)
    https://lore.kernel.org/sparclinux/20260917075842.784996-1-linmag7@gmail.com/

[1] https://lore.kernel.org/all/01ea8c41-88cd-4123-95c7-391640845fc3@app.fastmail.com/
[2] https://lore.kernel.org/all/55c0b9a5-6ba3-4582-97f0-225d0119da5d@app.fastmail.com/
[3] https://inbox.sourceware.org/libc-alpha/10289df2-0b5e-dbd4-fbde-dd3bf96a914d@gaisler.com/
[4] https://inbox.sourceware.org/libc-alpha/bd5bc3bb-fbf2-398d-0485-21bba3c86798@gaisler.com/

Magnus Lindholm (5):
  sparc32: detect the compare-and-swap instruction at boot
  sparc32: add a kernel assisted compare-and-swap
  sparc32: implement futex atomic ops with the compare-and-swap locks
  sparc32: advertise the compare-and-swap trap in AT_HWCAP
  sparc32: document the compare-and-swap trap ABI

 Documentation/arch/sparc/cas-trap.rst | 163 ++++++++++++++++++++++++++
 Documentation/arch/sparc/index.rst    |   1 +
 arch/sparc/include/asm/cas_32.h       |  33 ++++++
 arch/sparc/include/asm/cpu_type.h     |   7 ++
 arch/sparc/include/asm/elf_32.h       |   7 +-
 arch/sparc/include/asm/elf_64.h       |   3 +
 arch/sparc/include/asm/futex_32.h     | 137 +++++++++++++++++++++-
 arch/sparc/include/uapi/asm/traps.h   |   3 +-
 arch/sparc/kernel/Makefile            |   1 +
 arch/sparc/kernel/cas_32.c            |  96 +++++++++++++++
 arch/sparc/kernel/cpu.c               |  24 ++++
 arch/sparc/kernel/entry.S             |  17 +++
 arch/sparc/kernel/traps_32.c          |  16 ++-
 arch/sparc/kernel/ttable_32.S         |   9 +-
 arch/sparc/lib/Makefile               |   5 +
 arch/sparc/lib/casa_32.S              |  46 ++++++++
 init/Kconfig                          |   1 -
 17 files changed, 559 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/arch/sparc/cas-trap.rst
 create mode 100644 arch/sparc/include/asm/cas_32.h
 create mode 100644 arch/sparc/kernel/cas_32.c
 create mode 100644 arch/sparc/lib/casa_32.S


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.43.0

