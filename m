Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5405616A2
	for <sparclinux@vger.kernel.org>; Wed, 14 Oct 2026 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995836; cv=pass; b=dHQ2dj/2DppHhUoFuaTot18jPBIQ/BHfyPpbSLV4t84evfbYcZdiq0q1HUjAZyb+FXLDcpnDnf5oiTCpFxKhph+k9rRo1lMHmOB61sReDMJSCOMPY96C8isBLZQgJDsE67nCCHbQbiBjCDDF6GzrleLFF/GdrUPXw4KRqBTf+8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995836; c=relaxed/simple;
	bh=4Ce3A1dUBiGV5q4+6qdTDhsc65OklCGH9uvF3HVnuco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPu0+fqHCTpW0sLQ1N4SCaBYF5LFTusP3Qn8C47PANm/EcPl8q+mZi8/5zopSN14XoWdzzyM+Wic4eMymx/0xKZsflj8XCQKVnqUNlNSoKy0Xbrt/XBOmSHnq1FEpwup5RybMesXsJYhBfPOTmtCluBqsrM87w9gVepgZTB8bvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTYTCsa6; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTYTCsa6"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b1a86c0316so5304078a12.0
        for <sparclinux@vger.kernel.org>; Wed, 14 Oct 2026 09:37:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791995832; cv=none;
        d=google.com; s=arc-20260327;
        b=OzP0iqoNqXsgDwYIy6dqXInA+PLYWKjHAcpPIthX8PAnr/R2ImH2onN33QxIM2AHPP
         mn0grTv4vjUpSmaeeaiFFL4SSa1Uc55KKc3qF2WTFAtsSDXPP/z/ITbh5cZkSCiioxLT
         YwgYHR/UqJXlrb7UQb9rBr40+sGrwDsduPy7WZ7Dvt6z92MmvvTR7/RhLpHw6ewkTY/F
         jFEd9ESah7/W7sojJBZ2CUv4Q7IqUjxtIwK9/FmUBBxBO7NYpZRpQLAhbkXRsxL/5Kgv
         1nQdr87hQ98c2lKvw7ZPHU9DFry81lhKPxfsKFu/do56kCllKzzrRMPIqiGLzyF+6ERS
         OLCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OuNAqYyZmsOksNl+TNR2Xq9jMZpySZooddEaC50en2k=;
        fh=x5dOkZSNysDVu3+i1Cwoh4eK9hwIeG31NrYTqHrWMg4=;
        b=PaysUMJtS09mdY1gLLdoq9TIYOcNEyOFeQExreJ54x7zJ44SR4gCbeGr4UywvXuNIC
         YmHi4Ze3+ROmsr6N/8okS5G+TH0zA/6futWsPXDDFmgoVzK5uqI+NdFKv1FB0dsT82oS
         Ro6E+yY9difmzUPPfCPIhdwr4xBX21O5BmfaGt8Ud1RGVO4jc9R43hw+XR1iAsO7iqN5
         NzoTrejHbXfmmzjKPUvGREVAA50k+OrSB2p2OGZH5em4aRdc8Gp59gvxyFrtRsiS0mOX
         hL9IMpkC/OM9AhQZugcj4YIaFH+k+H96UMoq7NL526Mc5VVtBmb65DCDrVQBHoxIPm7T
         kqbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791995832; x=1792600632; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OuNAqYyZmsOksNl+TNR2Xq9jMZpySZooddEaC50en2k=;
        b=OTYTCsa6IUhAoIBQ62uigV1V5mo6qVy6LHrEBrj1PfpxDkC47Y1SA2rB6wnTWumW2i
         oQeG3RuIBHW2xgNJaVqw0hPVMNgRF94u5ixigsshnxtPhwMIoxFgRpoBTkO8dAVCjIuA
         Fwf5vqba0jthrLs9LeGXIXI8khZTU+7V0k9uAcyVZ2R0DzKKnTXdItHe2DmdJ0x0QxUt
         dZhc7vfV185KOqMxSfqyToHMMqhuqtCCA5MytwHYOR0FkI0wRo32yHmVQh+VaarX5HoX
         D5Jl/c1LB3RdSp7K8T1H9L7ziBb770cvEIhsa8Y4vVDjfbzVEpyr6QJiYKN+AgBFpwFP
         gIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791995832; x=1792600632;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OuNAqYyZmsOksNl+TNR2Xq9jMZpySZooddEaC50en2k=;
        b=QPcUGbG7V3DH0voJ0m6mKSQ8uRqjL5HeW+nL0gM/d/7ETWndL2+oqe5CRZWi1wZKTJ
         8o4zWjmTuEaRFWEbU+YHlPiZKsvTlCvjCNxvOlJc81BwyWi1CroF8y0Btc3iJPBpcdUl
         zaDu0R1QKaiL9x5A/JDjAutw/H4DkQeqPztfM9quMFEKzGKRjez6R82Sv83ReCEOTEwn
         bcbp1Y/3gzUFwDaJ9V1ikrRbTtbFXUTbzMJXQ0ad95QRX8h/OXIzNGLTVR7iAuSemNMU
         wgiPwcYM8sB2BQcGEZAD4+GlTYIXeCGf9AoBcB4kMXP0MGEYv1QZfc0NGAcjvBpsOM31
         GFXQ==
X-Forwarded-Encrypted: i=1; AKwUvBzUa+9r60Z+sqhP6iiLMn6JYGUhUSZnPQ+1tUjXlAlJfzSanwd97+mJ4WOHZ0HbQh1tdFm+IEZdRFco@vger.kernel.org
X-Gm-Message-State: AFq9FYIQNReVdK8qFQ/pGazu1UyGgBen7wF7nmNPSh22H71r1tfjnWv8
	Ktw5B+juWuGq5CtFYITK3zbR50uK0D6jJOwAAcysmRfsLPjY9F4Cw4gV5d8F6Kl6J5m6HrSTnjG
	ywUqlykmpxhF4fex05umax7a9cdnEUXbxIfqWgWU=
X-Gm-Gg: AYBFou1r2qPKJDe9XHvJzetLBS1MvGZNoFjqWeZ8CInTt7KVSNtCNIYNEsZJunPEdL6
	Z7VILmqHs/Gfp7oFBkNy8KdSDaH1AYfvxshUqKp34l0ILIod5zQGE8N6cgOFhbgVYIRLW8C8rjp
	zdI/IzKOBvbz8phc9S37Z1Anq4YYV8allqRCQfXNZnq8+e7wI5/+X5UTH8mi9Musb78GWnoLUwZ
	jdrXxhgsTyst5voWdtdZukWB4HTfV7uRGpU4N9AFrjWzgBTy1z3dXPQBtCUzPGT7ceRfULnJ+Qv
	/3uqNI64kGEt8+aCdNJeVsrtnj2OEwbDpLaColXrhDt5NMpht2pqZqSBbBKh9K1zeqVII2Xk9Vu
	L5Mr//SJBNnudug4y5ntTMJbHyrfmgcO3ZXZbOOaG0A==
X-Received: by 2002:a05:6402:21c3:b0:6aa:e263:51c with SMTP id
 4fb4d7f45d1cf-6b17c24db3amr11030515a12.16.1791995832171; Wed, 14 Oct 2026
 09:37:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014080730.8817-1-ludwig.rydberg@gaisler.com>
In-Reply-To: <20261014080730.8817-1-ludwig.rydberg@gaisler.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 14 Oct 2026 18:36:59 +0200
X-Gm-Features: AclHuK_ZGp2lGIoPZvcbnwXZDKGGTjofIqBhe5kacncTBCbRPxupw58DTxV_730
Message-ID: <CA+=Fv5Tz8Nq3TrAvejMK0oroPsXz1PGdXoAj=ck5WcArU4j9dg@mail.gmail.com>
Subject: Re: [PATCH 0/3] sparc32: add seccomp filter support
To: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Cc: Andreas Larsson <andreas@gaisler.com>, "David S. Miller" <davem@davemloft.net>, 
	Kees Cook <kees@kernel.org>, sparclinux@vger.kernel.org, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Stian Halseth <stian@itx.no>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ludwig,

On Wed, Oct 14, 2026 at 10:07=E2=80=AFAM Ludwig Rydberg
<ludwig.rydberg@gaisler.com> wrote:
>
> This adds SECCOMP_FILTER support for sparc32 on top of Stian Halseth's
> sparc64 series (v2):
> https://lore.kernel.org/r/20260902072745.3412940-1-stian@itx.no
>
> Patch 1 splits syscall_trace() into syscall_trace_enter() and
> syscall_trace_leave() as on sparc64 and most other architectures.
>
> Patch 2 adds a call to seccomp_permit_syscall() in syscall_trace_enter()
> to filter system calls. A denied syscall skips the call and goes
> through the syscall exit work with the return value already set.
>
> Patch 3 extends the seccomp_bpf selftest's SPARC support to sparc32.
>
> Testing:
> seccomp_bpf on v7.3-rc1 with the whole seccomp series applied on a
> GR-CPCI-GR740 board from Frontgrade Gaisler:
>
> - UP: pass:99 fail:0 skip:12
> - SMP with out-of-tree patches that implement the futex atomic
>   operations with CASA on LEON: pass:99 fail:0 skip:12
> - SMP without them: pass:89 fail:10 skip:12.
>   FUTEX depends on !(SPARC32 && SMP) (see 3f2bedabb62c) and glibc aborts
>   with "The futex facility returned an unexpected error code" in the 10
>   tests that use threads (KILL_thread,
>   user_notification_filter_empty_threaded, tsync_vs_dead_thread_leader an=
d
>   the 7 TSYNC tests).
>
> The 12 skipped tests need the UPROBES which sparc32 does not have.
>
> Ludwig Rydberg (3):
>   sparc32: Split common syscall_trace() to syscall_trace_{enter|leave}()
>   sparc32: add seccomp filter support
>   selftests/seccomp: add sparc32 support
>
>  arch/sparc/Kconfig                            |  2 +-
>  arch/sparc/include/asm/thread_info_32.h       |  2 +
>  arch/sparc/kernel/entry.S                     | 33 ++++++++--------
>  arch/sparc/kernel/kernel.h                    |  3 +-
>  arch/sparc/kernel/ptrace_32.c                 | 26 ++++++++-----
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 38 +++++++++++++------
>  6 files changed, 66 insertions(+), 38 deletions(-)
>
>
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> prerequisite-patch-id: 5772aba3cb572833df13529ec6bb03ae9e848e25
> prerequisite-patch-id: 70a54ba398c763e45f9332ff4cc06b3f2a3e7825
> --
> 2.35.3
>
>

Tested the series on a dual-CPU HyperSPARC SPARCstation 20 with
my patched v7.3-rc1 kernel, including SMP futex support.

The cross-built seccomp_bpf selftests completed on real hardware:
92 passed, 0 failed, 19 skipped. The harness timeout was increased
to 180 seconds; test workloads were unchanged. No new kernel
messages or taint appeared.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
