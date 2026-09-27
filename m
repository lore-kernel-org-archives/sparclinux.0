Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253AD378D8C
	for <sparclinux@vger.kernel.org>; Sun, 27 Sep 2026 21:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790545335; cv=pass; b=RUItwxPuKXi11vlaJBFU0/k9FP0h+Yh9DwzqGzkWuZ84hpxJfnB2Aj31X65fDjV9eA0w5Y6bwPBIlAIStMwC4EO53wjYNhvxFmJptcIPzcWaFhln9j4vsPVnbCUlAaf50T6OH/WKKS4GiTKWevIshLMLUcIOe/HGJxhQCLm4qhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790545335; c=relaxed/simple;
	bh=6KLzp4oR3l/0CH9JckxArshHxrcKNasTT1KY+THNbnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiZEP7OpCIsqJjvdYKkevmchA6zgM0L0JbMK2PNOKCmVhlvuhntt6x0vOAA36NF8aE+Xk/ObO3cL/xqlwFU20ld2ZUrKzpVSsXFxYAWYH2lW0El7Pswo+5U7+EGhBQifeaA0oWw3HPwZj5fUwrF9H5HR7cEKONrE+NgH2LvTH6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r18FnzEo; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r18FnzEo"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6aaf28a86b9so3377068a12.1
        for <sparclinux@vger.kernel.org>; Sun, 27 Sep 2026 14:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790545332; cv=none;
        d=google.com; s=arc-20260327;
        b=jIYkWECsINulK5LKE0zVix3Qepo5YcZY8A62wD7pMXnwPa4QffQ6cCmdfD68WKK/UN
         TbTnfwXPiQCq2aExV1b6BKk9W+WeKTwVtUKv/63MqlAw06R9mh6ErVOL+GNHQ5dXL7mq
         /pXptSvb0hvAw5gCj8gdZ5PzqkuVrYvHuYrHJzvzYGJgQnt2Qvpv8EopmBAmUEuD4/w4
         wRdjDBQPl58KubgjnXvvb5+0t1ACKsPucGYBy4uUnx89BiW4TpvtDULahv4u8ZfUWN0N
         yVEh4EMTiav6YrWZ3NFm+s6QXD3LSPdyrcq9wpKYRAA0plwUrBTG4SfYy1Reo+MeArYc
         t9+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mfU1Wi4HmVw8v1AgLudBUPHtwS3RGGdUlRGpJlo9EKg=;
        fh=peaMKzP++d1ylRuUBtlfxHaMPRByZKOESV42P8DH2Ag=;
        b=MPise4hKuRlxvkUNhawZty8nK//1HiHPkCvmXyck20HeBUUb1pH9YI6LoPFzgOkI3P
         cB7oVdohVjGeuCaS+H7sL8pRVTJgsdgglxDE50s2tdi0fj7Kh9rvoFlhGXOlOvVKzfCe
         FSZma74yKiXbTOBl6LdEg+No963o9LfW1A5gDMKyTQVDN0u8zBhkEEYva8eeRIpL0fYJ
         4QkRX3Q2ywNwGHjRYhZtLHijTr8gZCSq42Ip8dLUSP7EdZYkOsJ6Ylxg8ma9mkgLY9A7
         DFnqpwmlJfsy1pVDy7hD7v8frhpq6aO5HYNkT5NanJ6Hpi89HCIiZ4nyV0l9Fik/pXDi
         Unxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790545332; x=1791150132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mfU1Wi4HmVw8v1AgLudBUPHtwS3RGGdUlRGpJlo9EKg=;
        b=r18FnzEo9akq18gGJQ1VbCBFJ/QctnsGUpC24j68x3PpaKmWnNQNVh19PT2GF/PwEM
         SAE+l2/XusEJbHb/upQWIcB5eP/p8UISMvwXwuDqCkGPrayoEx4lhJz+71MGUVogJJkW
         /bqSeNGqHcHEh73vSvFYMt/+uWBifSwJ4fjKJmshex+Dx0+oHhX+DvS1tq+U0st72JQY
         GrhuaON6n3/6Jjg7gn2lC0Dt28FGJC5JjuJIk0/DoyJayfxz5hOVwLKuHyewIEie2/mC
         nWmy0JzFDIXmTtbju4vVhXZzvPXKkBHh9NXVWhQz98ovmdjLj1TGN1GToTTx9FAY5MdK
         bkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790545332; x=1791150132;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mfU1Wi4HmVw8v1AgLudBUPHtwS3RGGdUlRGpJlo9EKg=;
        b=E7ybFDy6NQ193nflPY6Vbuuo2/sEBZHe9sB5LTHqBhM6/kxR7hDQkRm4SUYB+lulOP
         CiWFtrUBkLjiLpDYpemiVk1fzKHg+Y/6MBzAZQQasQfQtuJ9Eqk4k+E/uI7Q+Mx+DSbO
         AtRDe6POQ7lrES9q76DNxs67EJlJYD7PdckrNtgDMvjv+OAuKtUfKoxomwYRLTW08kb0
         5Q9p4EvLNHrIFrV1AIgXQgbIqj99Gv79McGqKyyY3gMhQlI0xq7QUf1OTRI8UNZfn5Rb
         aM7puVLJ+pUkKikItphfWVlRUpSrWLIPjfN7bbfpIAclf6wxrnQ5Ose7+ypYqc9lznV2
         cVpQ==
X-Forwarded-Encrypted: i=1; AKwUvBxCLxM18Mjy3QyaXpXKHkCsi+kgVRB14tw7Rrht8svjrgZMK41H2Nrg/6NQNVcU2WNyf55rPwtsCCHR@vger.kernel.org
X-Gm-Message-State: AFq9FYJeVhhskUV0RTUVeLjzmbsDKmgzVQw/N0MJkHJ3gap8ZzztaoSQ
	iFbuqSHKYWJEmRToaUR+m+YwLETiStTkSVkEau8W3/TcLE/Ue0DF7DrJQWXvDBBnMjL4qYk7K5I
	7KNiwrC6CSTGjeAg7K1p5GYLsJemZGIjxy9G/
X-Gm-Gg: AYBFou05JLuLFvyXzZ35oDT9KQxfDdBeHkBMX1i35P8FKduwJ5y/4PAyvhzK9eOVP/5
	Pwf9pBoQUR5T46m00ABgAeGSxGWbusJ/lFiO6GQoZH1dzjXYB3LtimbJzvj+W8WTrSyke4fV3Q4
	DpZaPJPVTSOg4ZMVaUK0PlQzFJZ9motL990mUMa98OaOgWVF8H8ypsqsO71wIgYdT1igQJ8R8Ev
	XOeqrQzUuSsJLzzRxgIyOEUqBBgYBx7gUuqW/mMCXO/aIER95eePQXUoLwkub6efEF19O/xicQy
	nXBs4BfDgk180cyM11ISaD+CrbLR5IS7Vv8YLZIz8IDQXWXvL3eqc4/bDVV4O5mKY3CGMfP2cvs
	wINENtiURedGRtQ2gj0UmpJVegV6k4YImSdlK5UvdNS9HDNfMd01+
X-Received: by 2002:aa7:cb47:0:b0:6ab:260:6378 with SMTP id
 4fb4d7f45d1cf-6ab026076cemr2280176a12.11.1790545332049; Sun, 27 Sep 2026
 14:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927005821.8369-1-kaloz@kernel.org>
In-Reply-To: <20260927005821.8369-1-kaloz@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 27 Sep 2026 23:42:00 +0200
X-Gm-Features: AclHuK9q0tb_hBdeGsUv9gVCeUkhxtwokVdYI1IVMCxdiVUrGe9SugUg-B68nyc
Message-ID: <CA+=Fv5RrA4iavVf_-0qMst0OKDtCnbB2sbsbjNVnAsRufbboiA@mail.gmail.com>
Subject: Re: [PATCH 0/3] sparc32: SMP futexes, casa and idiv emulation
To: Imre Kaloz <kaloz@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Imre,

On Sun, Sep 27, 2026 at 2:59=E2=80=AFAM Imre Kaloz <kaloz@kernel.org> wrote=
:
>
> sun4m has no compare-and-swap instruction and casa is optional on
> LEON, so SMP sparc32 has had no futexes, and user code on those CPUs
> has no CAS to build locks from.
>
> Patch 1 implements the futex atomic ops in atomic32.c and drops the
> !(SPARC32 && SMP) dependency of FUTEX. A LEON part that implements
> casa, found by a boot-time probe, runs casa on the user word; other
> CPUs take the __atomic_hash spinlocks.
>
> Patch 2 completes user casa from illegal_instruction on CPUs without
> it, through patch 1's futex_atomic_cmpxchg_inatomic(), so emulated
> casa and the futex ops serialize on the same lock. It is atomic
> against itself and against the futex ops, not against a plain store
> to the same word, so a C library using it has to do its atomic stores
> with casa too.
>
> Patch 3 completes udiv, sdiv and their -cc forms from the same
> do_illegal_instruction() dispatch: SuperSPARC and SuperSPARC-II trap
> those when the {Y, rs1} dividend has significant bits above bit 51,
> which gcc -mcpu=3Dv8 output, including libgcc's __udivdi3, can produce.
> It shares patch 2's windowed-operand helpers and the dispatch block,
> which is why it comes last.
>
> Patch 1 comes first because patch 2 is built on it. On its own it
> races nothing: without patch 2, user casa on these CPUs is SIGILL.
>
> Magnus Lindholm has an independent RFC covering the same ground from
> a different ABI: "[RFC PATCH 0/5] sparc32: kernel assisted
> compare-and-swap, and futex on SMP" (patchwork sparclinux, Message-Id
> 20260923201830.865553-1-linmag7@gmail.com), with a companion glibc
> series (patchwork glibc, Message-Id
> 20260924064228.867909-1-linmag7@gmail.com). That RFC adds a new
> software trap, ta 0x11 (trap type 0x91), extending David Miller's
> 2016 CAS-trap prototype at ta 0x23 rather than completing it, so
> userspace has to be rebuilt to call it. This series instead
> completes the casa opcode itself, so a binary already emitting casa
> (gcc -mcpu=3Dleon3 or -mcpu=3Dv9 output, or a C library that encodes it
> as a .word) runs unmodified on a CPU without hardware casa, with no
> new trap number and no libc rebuild. Happy to share the futex and
> do_illegal_instruction() plumbing with whichever ABI lands.
>

For context on the userspace half: the glibc side of this was declined.
Adhemerval's position is that glibc will not carry arch-specific atomics ag=
ain,
and that v8 support should come "first get the support on kernel, then add =
the
support on libgcc, and finally on glibc transparently through GCC atomic
builtins".

That goes against my ta 0x11 trap and in favour of completing casa: a new t=
rap
number has to be taught to userspace, whereas an emulated casa lets libgcc =
and
glibc use plain __atomic builtins with no arch-specific code. Your series l=
ooks
like the better fit for what glibc actually asked for. I'm happy to
drop the trap
and help with the futex and do_illegal_instruction plumbing instead.


> Andreas: do LEON3FT parts want the GRLIB-TN-0010/0011 "nop; .balignl
> 16" alignment before the casa word here, or is the plain encoding as
> posted fine for them?
>
> Notes, not for the log:
>
> - checkpatch on patch 1: "Lines should not end with a '('" is the
>   __asm__ __volatile__( idiom of uaccess_32.h; the -ENOSYS warning is
>   the futex API's return for an unknown op, as on every architecture.
>   "does MAINTAINERS need updating?" on patches 2 and 3 is covered by
>   the F: arch/sparc/ entry.
> - On qemu's SS-20 with two SuperSPARCs and the casa emulation alone,
>   futex() returns ENOSYS and musl's mutex, PI mutex and robust mutex
>   tests fail. With patches 1 and 2 they pass, as does a PI lock
>   contended between user casa and FUTEX_LOCK_PI/FUTEX_UNLOCK_PI on
>   both CPUs.
> - The casa branch of the futex ops has not run on LEON hardware. The
>   probe runs on LEON only; its fixup path, which a LEON without casa
>   takes, has run only in a test kernel that forced the probe on
>   qemu's SS-20.
> - The divide emulation has run on no CPU that traps it. No sparc32
>   model in qemu raises the trap, and no SuperSPARC or SuperSPARC-II
>   was available for this series; it is exercised only by build and
>   link.
>

FWIW, I have access to both SuperSPARC or SuperSPARC-II hardware,
SS-10 and SS-20. I'd be happy to assist here with testing on real
hardware.

Magnus

> Imre Kaloz (3):
>   sparc32: support futexes on SMP
>   sparc32: emulate casa on V8 CPUs
>   sparc32: emulate integer divide taken as illegal_instruction
>
>  arch/sparc/include/asm/futex_32.h |   6 +-
>  arch/sparc/kernel/Makefile        |   2 +
>  arch/sparc/kernel/cas_emu_32.c    | 117 +++++++++++++++++++++++++++
>  arch/sparc/kernel/div_emu_32.c    | 127 ++++++++++++++++++++++++++++++
>  arch/sparc/kernel/entry.h         |   2 +
>  arch/sparc/kernel/traps_32.c      |  23 +++++-
>  arch/sparc/kernel/unimp_32.h      |  71 +++++++++++++++++
>  arch/sparc/lib/atomic32.c         | 122 ++++++++++++++++++++++++++++
>  init/Kconfig                      |   1 -
>  9 files changed, Magnus468 insertions(+), 3 deletions(-)
>  create mode 100644 arch/sparc/kernel/cas_emu_32.c
>  create mode 100644 arch/sparc/kernel/div_emu_32.c
>  create mode 100644 arch/sparc/kernel/unimp_32.h
>
>
> base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
> --
> 2.47.3
>
