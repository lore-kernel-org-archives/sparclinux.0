Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE5B352C3F
	for <sparclinux@vger.kernel.org>; Mon,  7 Sep 2026 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788809830; cv=pass; b=MUqCLVOoF1J4ErWw2mtGXllAvl/6qPt82M8SGq0frmjo52jNwXKvmc3jyO5aRqRVld+MoBjfgizSObCjqPDysizSaWSoxkIf7sT+zOT8qNdr1wWrwAkNqi4L5ctjGzas24nvixMHjnstkHVJck0C4OMax8S+5XAaJnAWkvsxxJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788809830; c=relaxed/simple;
	bh=pAmDg64TOE5VZzyufwgiqVMUbG4l1wO3gZod6MM4Li4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDgwNpnZD68N7QoKPcpLnPZ4tbigFP0n1mHU+M9cyYuCFsKWL3IAUQkfMtuHQC7ebVI05yxg5UV0zZNKobSmPVZ+CrZTqquNke69YraNXfOTdOsrZR15y/0P0TVHBRIhO087kk3joPD71RwPryes8ejTLYXjzxqraSXu4lAhX5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbGzL2Ns; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbGzL2Ns"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a63667b78aso6092882a12.3
        for <sparclinux@vger.kernel.org>; Mon, 07 Sep 2026 12:37:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788809827; cv=none;
        d=google.com; s=arc-20260327;
        b=pzk60llWs9h+xA+sx/yV2jCMr/Cnsdw97V4tAV8VgR6ZwPBaQnxf3Pv8FTGz9cdiNi
         5t4HuOuP9Aa3ByrDKa2cPYS63RqixXGFUChvSYNRlKkQ9CcFY8StIcaI/rCDdSodX/af
         /GciCzP6VmrISEuhWfts5qYh39TOZmUJtUmW3snDZEsIUV6oBPZ59yM/I5wd5fTxdXgN
         Zofdk2/HFSeJAeXuPhCGR5ySKRo/kvZthjVrPm73xENuHixrZwtCQuTmehuxU2N13xF8
         0hBAMAvat0NiwSdnJFX810OIRl+kD+BFTKe00lwj4Psl7wyH0WncSw/kP/U+c3y/bxeX
         2LFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rCDQa/mg3a9yMD9wIkpq0CYkOHi539ohf0EULzMvUjA=;
        fh=PustfUGMGZpSjv16MtNXv8AuPVMTyF8wGK5sNdq0A3U=;
        b=Ygvc9Wh4FzfouZfshNho15PjFZsTwmhKtLAdM674TrZIZXc9FLbiQglnCtfE4G7Aew
         FUs1LyIglDYDdfpGDc2+Druc95NKL/T1qj/JxsX9ghklkhY8z56UML5arkq9Fpqa0Gfy
         6gv4Y/JmDPgZvYJIpb6NX9tJ3obu1RbuVeIOr77rkno/FzOZburyHhPDdJaM9eGqs6Xp
         gabS/tTMaBgx3ZDBXftem8RADai4iOtrGPopqzM61lbcsGKPlrI1oBPq0zE8TJGVFLzF
         cW9XLthS6vRqGE/IGfv9pkNEpv4nsWHf9iT+pYdbHomhqK55rkKGElGFw0wa2239n1/d
         GH3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788809827; x=1789414627; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rCDQa/mg3a9yMD9wIkpq0CYkOHi539ohf0EULzMvUjA=;
        b=kbGzL2Ns0CHUX3ICTGFl4SwKJZmIKamaMD71JSD7X8oogUBsFR0S/K1fivQSlYOQXy
         /JeqbVKvO1aXmRVW2pe3LMwILKLcMCCkD5Hve+w1oFyPCn27sTCjbZJBMPexVCs3jUcw
         Xm38mGZVlotx2PiKMztwu6ENPqjPU3U3LSpKysf1vKsRXIUUCLiRt+4O3nCdnmGdu46W
         77rsXx6dif9jWTG5xdcEPf1E/zPAjxp/Br/Fz+wkngv6icZ7hZgNFKuXfFdxzxzWh5w/
         mn1+GRd7lRmN8RQYg1jsloLNAceOKokjcSJ+aP27J+ktNWUgRlTicRNI0+7B+qYvliiV
         qIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788809827; x=1789414627;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rCDQa/mg3a9yMD9wIkpq0CYkOHi539ohf0EULzMvUjA=;
        b=jKJGNsfLhR5ZMex1FKOhDEW4kQB0kaqv9dpMzkCJKZO1NgyP4D4bU1zecfm4vHUgZd
         Vcbh4wug88h0cwtgBTCmyT9D/5xOKd2XZe2Vt8PKlOx7aNRdXaln+pUVZa4sRhW7OjC9
         cFAjp3F9StohORhVHZqpDdG54ABQh/mDPZoceIfLynaFPA3Gzl7h9RCqgtdkroHPuxw2
         Xjtp+3YmOhkcC1eaHvYJYVRz0SDXqWyn2mCIsMiTLEaVNmpM75gegpQfvE9ngzXbAtrp
         N4zKFGYxPLYlKXEWxawXEkvUnzxcO6EatoTylzwvpncEu7PdplYSvXpT0hU3B3qMWJzn
         JfwQ==
X-Forwarded-Encrypted: i=1; AKwUvBzMLeTINdVO+n6R6PMjqyZ37KfC//k7KtmNAaT5jcGRMY/ResIBosZSED0l1MJBjdczIsgy7RBnXoGs@vger.kernel.org
X-Gm-Message-State: AFuF++nd4O0TSl86QPUdhfN4lhLoaCDcorL2vkBgAmb6d+KAbeykjyUn
	qTbkOGP4nm/DWU/9eeWYclr+WUPR71DQr1F7WgG0H3gpbYhsD6tg1w7Uh23KK/ifCCZZLbZjzOU
	iEzfNzuu9jTMeXqAAt++g+RR3rJOB5TAsmdtsF1M=
X-Gm-Gg: AYBFou3Yk1/W4ptw/Nmbd2dbYVQ+GM5hRekxuxmfyF5Hd8BmaNA5FcXJmx4GJQlRySb
	QearDhTqzc8cZObu5+tJXfXtqD795p6oZo7Bxw2Tr4lvu+F27lx0sBBnfZ77oZVhS0QCFKVWJZZ
	W9LL5xlPKbbHJ4cuLchDGWesCPM/HppNVTzD+y12wGvNkLT+pylFteElc7ijyRFP9KVaohmXLo8
	XIJSwIVVqfY5JsKA9hFuMvKl0AKo3pqbPTsY4xgCAAqXwenSUz5LtuJ9CoDPnUl6AoE/NMZS4Hv
	P3BM/gHdts3Ni8t6BX1trRNuZnj/BirrPcvCdFyuADSOeCF8p5AjNAhT+ijRnFO/av99hn+7Ars
	=
X-Received: by 2002:a05:6402:5113:b0:6a7:ee55:dcd7 with SMTP id
 4fb4d7f45d1cf-6a7ee55dde4mr6871345a12.38.1788809826547; Mon, 07 Sep 2026
 12:37:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904055359.327050-1-linmag7@gmail.com>
In-Reply-To: <20260904055359.327050-1-linmag7@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 7 Sep 2026 21:36:55 +0200
X-Gm-Features: AcwNN1XKNSsHfM35Gym2RgpjA4w21sbKhoTs4rKY8si_jlYcMqJSokUdV6gGC_M
Message-ID: <CA+=Fv5SvHh4Tjqchcfofi91ZArOGMROfVkKXDQCGrEwTUrwZgQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] sparc32: fix SuperSPARC SMP synchronization
To: davem@davemloft.net, andreas@gaisler.com
Cc: sam@ravnborg.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 7:54=E2=80=AFAM Magnus Lindholm <linmag7@gmail.com> =
wrote:
>
> Fill two gaps in the SuperSPARC/Viking SMP synchronization paths.
>
> This series is based on the three sparc32 relocatable-kernel fixes which
> honour and derive phys_base and advertise the relocatable image. It does
> not include those prerequisite patches.
>
> These patches can be found here:
> Link: https://lore.kernel.org/sparclinux/20260816075141.3489194-1-linmag7=
@gmail.com/T/#t
>
> The SuperSPARC Family User's Manual requires software to keep at most one
> Demap operation in progress across the system. It also says that an MBus
> system must ask every processor which can retain a stale translation to
> perform its own local Demap [1, sections 8.5.3 and 9.8.2]. The Sun-4M
> architecture specification likewise describes SRMMU flushing as local to
> a module [2, section 7.1.4]. Patch 1 serializes each complete shootdown o=
n
> sun4m and invokes remote CPUs one at a time. sun4d already serializes its
> Viking Demap operations.
>
> SuperSPARC maintains I-cache coherence by snooping, but FLUSH is still
> required after modifying instructions. It drains the writer's unsnoopable
> store buffer and clears local pipeline and prefetch state [1, sections 7.=
4
> and 10.2.5; 3, section A.8.2]. Patch 2 executes FLUSH first on the writer
> and then on remote CPUs.
>
> The series was tested on a dual-CPU sun4m SPARCstation 20 with TI
> SuperSPARC processors and Viking/MXCC:
>
>   - boot to multi-user with both CPUs online;
>   - 200,000 concurrent mprotect iterations over a shared address space;
>   - 12,000 executable-code rewrites checked on both CPUs;
>   - removing flush_icache_range() reproduced a stale instruction on the
>     first rewrite.
>
> [1] SuperSPARC Family STP1020 & STP1090 Series User's Manual,
>     Revision 1.0, April 1994.
> [2] Sun-4M System Architecture, Specification 950-1373-01,
>     Revision 50, July 19, 1991.
> [3] SuperSPARC II Addendum, Revision 1.3, December 1994.
>
> Magnus Lindholm (2):
>   sparc32: serialize SuperSPARC demap operations
>   sparc32: synchronize SuperSPARC instruction updates
>
>  arch/sparc/include/asm/cacheflush_32.h |   2 +-
>  arch/sparc/mm/srmmu.c                  | 120 ++++++++++++++++++++++++-
>  arch/sparc/mm/viking.S                 |   4 +
>  3 files changed, 123 insertions(+), 3 deletions(-)
>
>
> base-commit: e6de5705a9f0d81f67bdb2917108784b5839cecd
> --
> 2.43.0

Hi,

I'll send a v2 of this series soon, simplifying patch 2 to use only
a local FLUSH.

SuperSPARC maintains instruction-cache coherence through snooping.
The writer's FLUSH provides the local synchronization needed after
modifying instructions, including draining its store buffer. Remote
FLUSH cross-calls are unnecessary.

My earlier justification based on instructions already in a remote
CPU's pipeline was insufficient: a cross-call cannot prevent an old
instruction from executing before it arrives. Callers modifying live
text must themselves arrange safe execution during the update.

The v2 will retain the local FLUSH implementations for
flush_icache_range() and viking_flush_sig_insns(), while dropping
the remote cross-calls introduced by patch 2.

Patch 1's TLB demap serialization is unchanged. Cache snooping does
not invalidate another processor's TLB entries.

Thanks,
Magnus
