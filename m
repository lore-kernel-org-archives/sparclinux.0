Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DDB3BB113;
	Fri,  9 Oct 2026 06:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791528943; cv=none; b=NH2FXGQNvuVMG5LYUNeIGWX+08dW1uWtG56juY5RZoE9tw6snrOorhqbyBVYYmdIXYNaOHl7d8che2miT9bV5GWr+hjQczUKLTyuPwwQxzAhs0lRzO83gN1Gzz4U4cStCWYQEHdNTzo7xyHeiOQz5dD5xhUDonxofiXxIWDXvb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791528943; c=relaxed/simple;
	bh=TFly4YRi98bd3xcBpu6fw8QMIpY1nTYbC6E/AtorbGU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SN4+/NwHrxNmDaCDqpC0WDPjT6Q1nVKGkhHFh9vEBiwbQksdFaJ9YfB+CrAE2M9RPiz62VCjoXU/nDmuIwnmmBhsx9NsaToG7pAJkxEMQxvrypLC11wXuFUZkOzM22/pM8vu6yBttbnXVu16Xhau/Y3RddEVSjbidD8lXwQaJ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=ireJgISA; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="ireJgISA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=/rQu8tiHfx3yHjUrmgq/27APde4aL0+gwH1XMh/5v+0=; t=1791528939;
	x=1792133739; b=ireJgISAmrIyQOyZKO6WijSlyeTiZ2/cMyhQYXVO1bw6HQPc8i7j3HnS4GT5W
	T+YqcTlbwWT4c/5tflu3tZgfXyXRIugmw1hQVayZyFgpsHmNbpX5c6KzrtAfN3nPQecDh4iclV2Pn
	eqiMofWSOPNXKlZ9uOBSRYGwYFJmOa1rEcKi/UlOQlkTUEu/GWM1fTpsrz+ROHcmfEbr/Yfzqrtm8
	sZHkP2sGckKWLBGpGQhLluGRltL+sHEmVg+q6nS47ujPg+6aKf3uYq+EKOrgcUiQqghRWex2BBKNI
	CXiJCTICMiQ8pNdZXaShNPp9KAHgofidT0OfyYYSpgoKoJDgLw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xF4Vu-00000000TCp-0DF8; Fri, 09 Oct 2026 08:55:30 +0200
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xF4Vt-00000002Msd-3Pis; Fri, 09 Oct 2026 08:55:29 +0200
Message-ID: <b9870d3274294bc7207de5637b29e55c125f6ffc.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 0/2] sparc64: add seccomp filter support
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Andreas Larsson <andreas@gaisler.com>, Stian Halseth <stian@itx.no>, 
 "David S . Miller"	 <davem@davemloft.net>, Kees Cook <kees@kernel.org>,
 sparclinux@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Fri, 09 Oct 2026 08:55:28 +0200
In-Reply-To: <f32e114c-718f-46d7-9388-fdc5c382ddaa@gaisler.com>
References: <20260902072745.3412940-1-stian@itx.no>
	 <f32e114c-718f-46d7-9388-fdc5c382ddaa@gaisler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Andreas,

On Wed, 2026-10-07 at 08:14 +0200, Andreas Larsson wrote:
> On 2026-09-02 09:27, Stian Halseth wrote:
> > This adds SECCOMP_FILTER support for sparc64.
> >=20
> > The arch prerequisites have been in place for years, so patch 1 is
> > mostly about the missing piece: letting seccomp veto a syscall, and
> > returning to user space with the return value the seccomp core set in
> > pt_regs rather than the -ENOSYS the assembler stubs used to force on
> > any denied syscall.  Patch 2 teaches the seccomp_bpf selftest to
> > drive sparc64's registers.
> >=20
> > Tested on an UltraSPARC T4-1 (sun4v):
> >=20
> >   - tools/testing/selftests/seccomp/seccomp_bpf: 95 passed, 0 failed,
> >     16 skipped (uprobes and other optional features)
> >   - libseccomp with its pending SPARC support (libseccomp PR #471)
> >     passes its full suite, 5190 of 5190, including the live tests
> >     that require kernel SECCOMP_FILTER
> >   - docker containers run confined by the default profile, and a
> >     custom SCMP_ACT_ERRNO profile denies as expected
> >=20
> > The libseccomp side is https://github.com/seccomp/libseccomp/pull/471,
> > and the tracking issue is https://github.com/sparclinux/issues/issues/1=
1.
> >=20
> > v2: drop the local regs-struct definition in the selftest in favour of
> >     PTRACE_GETREGS64/PTRACE_SETREGS64 and the uapi struct pt_regs
> >     (Kees Cook); patch 1 unchanged.
> >=20
> > Stian Halseth (2):
> >   sparc64: add seccomp filter support
> >   selftests/seccomp: add sparc64 support
> >=20
> >  arch/sparc/Kconfig                            |  2 +-
> >  arch/sparc/include/asm/seccomp.h              | 15 ++++++++
> >  arch/sparc/include/asm/syscall.h              | 11 +++---
> >  arch/sparc/kernel/entry.h                     |  2 +-
> >  arch/sparc/kernel/ptrace_64.c                 | 28 ++++++++++-----
> >  arch/sparc/kernel/syscalls.S                  | 28 +++++++++++----
> >  tools/testing/selftests/seccomp/seccomp_bpf.c | 36 +++++++++++++++++++=
+
> >  7 files changed, 99 insertions(+), 23 deletions(-)
> >=20
>=20
> Looks good to me, and selftests runs fine for me as well. Thanks! We have=
 a soon
> incoming patch set adding support for sparc32 as well on top of this.
>=20
> Kees, are you ok with the selftest changes being taken through my tree?

I think it should be safe to take the tests through your tree although
it would be nice if Kees could ack the changes.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
