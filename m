Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755CE40B0EF
	for <sparclinux@vger.kernel.org>; Sun, 27 Sep 2026 22:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790546421; cv=pass; b=oJW6d7qDqtWDJeGoG2T7fWlYUOr+h5pRpRlgT7NKCgYZDZ4MJCAeA2X+PRA/fuUlqVyjxNfD2IbZ0VRXhUJJTgzhiBrWYCqPTBjk9zhEVinUDgo2AdLFjS+lHjLa6V+gsFGcqjDoaAL0PJGLJ9bARogCuVV3C7ad4jn4wjRf6zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790546421; c=relaxed/simple;
	bh=ojnNpFAcs+aJppljgRUBBPbKoV50tBwIukLugjIhzxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvHy8fkj609RxzEWAD89LjdUmJgKlbi4dMhdVN8nCwQH9bapgVFIY/X/v+Pv0/j3BYZuq+G5j4J1FMDcWlzO4GX5MXqG79d6fBdFoM/utbxF/bgF855QI4jw60/Fk0+ypVZ/fhfsnmq3Ap5PTmaMhE0raqRdWOp3RCBGLSqnM78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLTqNPvj; arc=pass smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLTqNPvj"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aae1f2cedfso3047738a12.3
        for <sparclinux@vger.kernel.org>; Sun, 27 Sep 2026 15:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790546411; cv=none;
        d=google.com; s=arc-20260327;
        b=QDqPlplhn4LLIuB10PMoF2Mx8irptifaBK0QnerlCfbXYJjCovX62+0X1hfYxSMY4x
         R9Cr+WV6ZZmrhgYgOEmE0eA+eO+cXcfylZQ0cAfdftZ5t2dY1mxvW33Q6KTbalD4/Bbp
         lEMPEAWsmddafW7p1jlhUEbGIRNizRo9UXWinEFJ0RSAM5ChJ59RjXUr5ig2U+jNVqit
         VdO86E2PUe16hK5qVwqrLQV9QK3j/ZsdgnQcGpV5smd0K7GNHL2uR9JhA+pTMgpW/6e7
         pDSVYeRfRj+VtkDSR1ofyvcpv01MCGSCfQLszeqTOqHfxZL6pB5FGMfunLQsG01tYwFL
         vaEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w75/rsx/tttnCbPtKQAiCIgV7C32qVgicTV8Ei4olls=;
        fh=h7KQXp34GHcI+HygZ/dbT4rnoTyncs9Qa2/POxO42qQ=;
        b=ddofpDWdKz5lVvj7+nOq0NKLu2gP5ObSiNRkFZyojOrCGQFY5OTlA3RySR1dXUhbYr
         Ph/gqTnBS6rpHoDC+o/dSls4DnsrtCNM/dzRmW5vcsB3VphCWCs2elVDDeN2HWyEEaBH
         wvwgm42U+VgTPl8b8CoXh5QMdUA5rEdRUN1UxKjE50XQT/VvSy8V8dZ1d7b59E4ErJDX
         Ik7z+PXGJu2m246WwrJ5ToWU+7aSU4lsXEmoWebdH2qvQxYvS1XX0ikpJAQMbRuOviNG
         raGWvIFdnnUbVl2WGrwEvXynPr08V6DyAiDRKGAOlonSmWMRgb7aNsG3e4mM0dmWcC3U
         Bshw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790546411; x=1791151211; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w75/rsx/tttnCbPtKQAiCIgV7C32qVgicTV8Ei4olls=;
        b=NLTqNPvj3qzZbMUP3ZtdtDhCOXB1ElkeZ7kkKY45sAQqy1m+EDcaEy6NDHyX/yShCO
         /TRlsiWtUTSpU3rC0xS/PBFa3QeD8VqdkEpMtig2M8h8X8bGezkYrbbwYRmmlE5y8aXE
         l5RzIY+NTSSYjp172r5KVKw9XfA82emUfRxQ3ggZyOlydIMUQBfnAmLesYs27Ymxfk34
         Yx4CX5wbESfpRuyzzNxEGkJW8vxfyki3sh0CaeGn+iVx82BQ2KRqg0xy0+FxvW2NSGku
         vXJbXwfPH+IxGrZhusqyyulYNthPpbRqk7fIB4RWLUy67s1Mtc5bu13RrPUU1G6Yp1Pe
         Vfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790546411; x=1791151211;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w75/rsx/tttnCbPtKQAiCIgV7C32qVgicTV8Ei4olls=;
        b=Y4w9fdujrbRZYgM0IcHvV3w+Mb2Y9g/phVLivx9lmOAbdblck9kyADlygJIH0MrePi
         UnaZCKBIMSPfuIy1UOifi+nvikaoae0e9lTv02Pxm9KxMtRewbLZmjngtbtbky5P0XWb
         K9SesH23KnpIgOzcjo/eMK0ipNhUjbtRx3RQfBEn01pgjjnPx7LNo1lcvQxwwIZWYFuU
         FIcepAbb6CVQmT1K652Bo6y3JOW3NOW/FLihfeG7Gc9OTAcuHaJP9Nx8GlXjtqCGomqz
         hXM4bCEsQJfA+YgD8KJkv+vTBW2VCjrOfHkv3McHSxZ/qaoGBG7phhWEvS7yYYCt8l+G
         CZaA==
X-Forwarded-Encrypted: i=1; AKwUvBxVwgnpEG/7Y1tTEv9lvM1L20kd6RBrV+ccw/fxISl8tOEKD26995GNGaPaRIC9kyFY12+zy5LUL1n0@vger.kernel.org
X-Gm-Message-State: AFq9FYJaXg7dLD1Ddm5HbNgNbGKboS8QM/sLjYjcKT9olVNDuND6Q/JZ
	qWwKVs8XFItKgZVD66X2FOQT5q3ve+yyXfA7oGRKIeRwErbJMTc2nVzGgUj1C/tK3KO1xbZq0l2
	fC0DpRHXOSta5ama+9cCVUPTSfpRcgOE=
X-Gm-Gg: AYBFou3rmJfEKCjIf6yqOeeWW0/eYMR4S2EP8k4u548GIURCTzFtHFEjE+9oTiAdSwS
	3Sq8R+oWx6ckuMcgAFWa98jqfnO6MHSbctjvw/EG9k0wFF6k8d6S0uaWoTTXex5IeQAD0Nw4z1y
	tq+6RD3Uq0GmWTR/QEVpYLgc5yc2FYdgMawJhh+lqgBRFYv5VfUbb2KvInL6WoztDnAlrc3vVuS
	rz06cxdLPTypZWykfcvjuuq+xRgDunnD8yZiYuL07u7IodcAGnExYZnJzwsjFRWiKyUL5ueiOG0
	6DnKft3nJVRS4/HJ7KFfvfN1fBd2fBuFPixhTjLyP2iFunTifW1+8F4mDbs2lGyhzKiCmLDDA55
	Bh+RHErqCsQOFIbjQRT3n1qTSqpqcshH8CF4DbDbsIA==
X-Received: by 2002:a05:6402:e96:b0:6aa:924d:900 with SMTP id
 4fb4d7f45d1cf-6aac90efbf1mr9690769a12.38.1790546410412; Sun, 27 Sep 2026
 15:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927005743.8299-1-kaloz@kernel.org>
In-Reply-To: <20260927005743.8299-1-kaloz@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 27 Sep 2026 23:59:59 +0200
X-Gm-Features: AclHuK-6m-r_7jB5HpKM72-JdYXDgtlwLzDmRV3LgFit-40iHT3z-9gejMq9kFI
Message-ID: <CA+=Fv5RjY_7VHh-aqPrwPd99hUVrQQWiScbPAjAgXAHtSJWsnA@mail.gmail.com>
Subject: Re: [PATCH] sparc32: add the CPU to mm_cpumask in switch_mm
To: Imre Kaloz <kaloz@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Imre,

On Sun, Sep 27, 2026 at 2:58=E2=80=AFAM Imre Kaloz <kaloz@kernel.org> wrote=
:
>
> The SMP TLB and cache flushes in srmmu.c cross-call only the CPUs in
> mm_cpumask(), which only switch_to() updates. exec reaches switch_mm()
> through activate_mm(), so the exec'ing CPU is missing from the new mm's
> mask until its next context switch.
>
> If a thread created meanwhile unmaps memory on another CPU, only that
> CPU's TLB is flushed, and stores through the first CPU's stale
> translations land in freed pages, as when a detached thread frees its
> own stack. Only sun4m cross-calls its TLB flushes.
>
> Set the bit in switch_mm() as well. Tested on a dual-SuperSPARC
> SPARCstation 20.
>
> This has been broken since 2.3.35.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
>
> Notes:
>     No Fixes: tag: this has been broken since 2.3.35, before the git
>     history.
>
>  arch/sparc/mm/srmmu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> index 9a74902ad181..7d423e5fdc94 100644
> --- a/arch/sparc/mm/srmmu.c
> +++ b/arch/sparc/mm/srmmu.c
> @@ -466,6 +466,13 @@ void switch_mm(struct mm_struct *old_mm, struct mm_s=
truct *mm,
>  {
>         unsigned long flags;
>
> +       /*
> +        * The SMP TLB flushes cross-call only the CPUs in mm_cpumask().
> +        * switch_to() sets this CPU there, but activate_mm() at exec com=
es
> +        * straight here, and a CPU left out keeps stale user translation=
s.
> +        */
> +       cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
> +
>         if (mm->context =3D=3D NO_CONTEXT) {
>                 spin_lock_irqsave(&srmmu_context_spinlock, flags);
>                 alloc_context(old_mm, mm);
>
> base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
> --
> 2.47.3
>
>

Nice catch! This looks correct, and it matches what I have been seeing
here.  I think
this is one of three mm_cpumask problems on sparc32, the other two are in a
HyperSPARC series I am preparing: smp_flush_tlb_mm() narrows the mask under
active_mm and can drop a CPU that is still running the mm, and the cache
cross-calls are gated on the mask as well.

The last one does not go away once the mask is accurate. mm_cpumask records=
 TLB
residency, but on a virtually indexed write-back cache a dirty line outlive=
s the
TLB entry, so the mask cannot gate a cache flush at all. Broadcasting it
unconditionally took a fork-heavy reproducer from 70 faults in 6258 forks t=
o 0
in 5798  for about 7% fork throughput.

I'll build and test this on my SS-20.

Magnus
