Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4422E06D7;
	Fri, 15 Aug 2025 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254513; cv=none; b=Lwr3ZPF07w1uTegYkI99qdnFYFhi+FhaKmehlxRHYgN6MHXgF78e0wLToH6G0QKGSxwdYJfq5mt0nIfPHpKM36uen130cQrY0xv0JFa1hXFb6c/1O/EMugoBuOK/5Z6v29xZG2EHjq5HxQZ4jm+Dxw7d8E/xZRE9jVayNyVu800=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254513; c=relaxed/simple;
	bh=GezbE6Javv5lzzHLNiiYIvpbKO7h3akyX18C4XKG/gA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Uo4bUudK+dHL8V8+C3Xdko3z+dKhq3gDx2n4LFYL+3p110W7yl/azKPwcFUt1pQIZsA4YQ5ZEvjNBH0WvYHP8AeBIt3g9FbTfSUsHTztABao0JjineBYHk1/tH4aOGkjWtwBFSOH9BvVMWC2yyVqrtqcag/FR7B0olged0vUz+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O9hRCXFw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BzbDdsds; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O9hRCXFw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BzbDdsds"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755254509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GmIxZUwWpxDPsHJfwq3XHDhpbjvVVIixs7jU2J99Av0=;
	b=O9hRCXFwmKPM3e3BNfMk4sAxb58LgQzJvlbr2/5XWPLNvz7WhOElKKh/3+67mwVin0zFZs
	aLtIu4JtOyCgbjN2sE7cO2GL8Q9c/bGOYejsIpz6LoVDBLyfVIfnmVLa/eoUibALUMnAhy
	i3rSChXl3UsJnnfTKEhRidXvVSioUaeLtM7Ka8x2Wac1H78atbi8E+f/M11wfjUz/lGAnu
	jZFjY4rbotrYeYymPvYbesJ12POeWClw8X4V8C4Kw5oeZlQ8y0HAmhjVX7FZmVSNRAQD0i
	e/Hl+sFaWEXeSbUdD4fKY4koURFumi5xDGa48Oz93h6T29ajoE2rGlo66j7ijg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755254509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GmIxZUwWpxDPsHJfwq3XHDhpbjvVVIixs7jU2J99Av0=;
	b=BzbDdsds+S+2USi582Es3P5yA0Ydhtc/iYll5zj1qSSB7VoHOfIPepWXDt/L+RMHBE0a/A
	YmFiPi2LeKiuWrDQ==
Subject: [PATCH v2 00/13] sparc64: vdso: Switch to generic vDSO library
Date: Fri, 15 Aug 2025 12:41:09 +0200
Message-Id: <20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMUOn2gC/3WNyw6CMBBFf4XM2jFleCkr/8OwwHaASUxLWmwwh
 H+3krh0eW5yzt0gsBcO0GYbeI4SxNkEdMpAT70dGcUkBlJUqYYIowkOw9x7XZc4sk26RkKqBmJ
 VXfhKGpI8ex5kPcL3LvEkYXH+ffzE/Lv+kuW/ZMxRIRdN3RcPQ6XJb0+xr8U7K+vZMHT7vn8AH
 Qiqe8AAAAA=
X-Change-ID: 20250722-vdso-sparc64-generic-2-25f2e058e92c
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, 
 Nick Alcock <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Arnd Bergmann <arnd@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755254507; l=3767;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=GezbE6Javv5lzzHLNiiYIvpbKO7h3akyX18C4XKG/gA=;
 b=qUnSyKpPr0qgERf5kY0sGviGxVTv+0pxOTTYFS6rDLaA88QM1n2W75Vgsmf+v1b4YmLs/aXLv
 obIdMPjv7EZCiEZHny/D7tJmKFX4Xw8yBvDXfVfqOY3ECHU0ULbr6yh
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The generic vDSO provides a lot common functionality shared between
different architectures. SPARC is the last architecture not using it,
preventing some necessary code cleanup.

Make use of the generic infrastructure.

Follow-up to and replacement for Arnd's SPARC vDSO removal patches:
https://lore.kernel.org/lkml/20250707144726.4008707-1-arnd@kernel.org/

Only tested on QEMU.

This has a semantic conflict with my series "vdso: Reject absolute
relocations during build". The last patch of this series expects all users
of the generic vDSO library to use the vdsocheck tool.
This is not the case (yet) for SPARC64. I do have the patches for the
integration, the specifics will depend on which series is applied first.

[0] https://lore.kernel.org/lkml/20250812-vdso-absolute-reloc-v4-0-61a8b615e5ec@linutronix.de/

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Rebase on v6.17-rc1
- Drop RFC state
- Fix typo in commit message
- Drop duplicate 'select GENERIC_TIME_VSYSCALL'
- Merge "sparc64: time: Remove architecture-specific clocksource data" into the
  main conversion patch. It violated the check in __clocksource_register_scale()
- Link to v1: https://lore.kernel.org/r/20250724-vdso-sparc64-generic-2-v1-0-e376a3bd24d1@linutronix.de

---
Arnd Bergmann (1):
      clocksource: remove ARCH_CLOCKSOURCE_DATA

Thomas Weißschuh (12):
      vdso: Add struct __kernel_old_timeval forward declaration to gettime.h
      sparc64: vdso: Link with -z noexecstack
      sparc64: vdso: Remove obsolete "fake section table" reservation
      sparc64: vdso: Replace code patching with runtime conditional
      sparc64: vdso: Move hardware counter read into header
      sparc64: vdso: Move syscall fallbacks into header
      sparc64: vdso: Introduce vdso/processor.h
      sparc64: vdso: Switch to the generic vDSO library
      sparc64: vdso2c: Drop sym_vvar_start handling
      sparc64: vdso2c: Remove symbol handling
      sparc64: vdso: Implement clock_gettime64()
      sparc64: vdso: Implement clock_getres()

 arch/sparc/Kconfig                         |   4 +-
 arch/sparc/include/asm/clocksource.h       |   9 -
 arch/sparc/include/asm/processor.h         |   3 +
 arch/sparc/include/asm/processor_32.h      |   2 -
 arch/sparc/include/asm/processor_64.h      |  25 --
 arch/sparc/include/asm/vdso.h              |   2 -
 arch/sparc/include/asm/vdso/clocksource.h  |  10 +
 arch/sparc/include/asm/vdso/gettimeofday.h | 208 ++++++++++++++++
 arch/sparc/include/asm/vdso/processor.h    |  41 ++++
 arch/sparc/include/asm/vdso/vsyscall.h     |  10 +
 arch/sparc/include/asm/vvar.h              |  75 ------
 arch/sparc/kernel/Makefile                 |   1 -
 arch/sparc/kernel/time_64.c                |   6 +-
 arch/sparc/kernel/vdso.c                   |  69 ------
 arch/sparc/vdso/Makefile                   |   8 +-
 arch/sparc/vdso/vclock_gettime.c           | 382 +++--------------------------
 arch/sparc/vdso/vdso-layout.lds.S          |  26 +-
 arch/sparc/vdso/vdso.lds.S                 |   4 +-
 arch/sparc/vdso/vdso2c.c                   |  24 --
 arch/sparc/vdso/vdso2c.h                   |  45 +---
 arch/sparc/vdso/vdso32/vdso32.lds.S        |   6 +-
 arch/sparc/vdso/vma.c                      | 274 ++-------------------
 include/linux/clocksource.h                |   6 +-
 include/vdso/gettime.h                     |   1 +
 kernel/time/Kconfig                        |   4 -
 25 files changed, 343 insertions(+), 902 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250722-vdso-sparc64-generic-2-25f2e058e92c

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

