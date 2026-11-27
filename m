Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779466;
	b=kGmIusq71kG4EbF1JDIo//dxRN90vlIVwnRoOdRVEKQhJC0y70UlpmXBifZS0ykMbc+a
	 cTZ0ceTXUTwuboyEZK3Y99MQKQIOAm/Pdyfd51yi6ErOGi19x8Amlf3Gey2VK3spgiTFs
	 /G/uiA55DLJ/ZyvGMlu2V42CpT90st+imRORzic+pyH6nVtgpOnLvfSuvhRF2CfzeDgPm
	 p1NMIUWTDEZ0R/cXwqGJHSDES/2RWOfNDYibapYSEI9vX3RJYUkcWGnY+mHvXsBbIo24S
	 PvsXlWJicp4uujSWa9y4HAhUp5mmx24CnjpY8ZzCERLn5N7cCkiJZMGw+eIofNerZXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=BOOvIArGpv/xQKQD0TfZwhU1E1OVLGOADwgBsYj6a+w=;
	b=SF+VBhMe08hiSXxApTQs491y2mL4cX4ORif/Aqv6h22QG1X/GnYjRh2XMUG5Ss6DZniC
	 d+kFtbtiu/QGa7mgM7YL8kqBj46mYsxOAIJ0lDQYhFblDgLV9dKod+uWzrwrrR3SVB9gt
	 4WmgFr60WHVT5oeVFTBroPgzbEz2edE+DZPJb3f8habr4dtViVKOsAi4unAqOqWx53sKj
	 dupFOElSLGWpDk58j6XeFrdJNV31RQdaz3h1skeWGg2RZcfq2S6Ocrcwwg+WmaVf+ffBO
	 v8HlzTBdkAKcqaCIYeZr2wKixzgjdnB5WA+pMwx1BCUFdDZQx17Ro0ojwa6VqK1zBNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W81wadcY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F541606A31E
	for <sparclinux@vger.kernel.org>; Fri, 27 Nov 2026 11:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F541606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W81wadcY
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b4bd3d98bfso9966059a12.1
        for <sparclinux@vger.kernel.org>; Fri, 27 Nov 2026 03:37:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795779464; cv=none;
        d=google.com; s=arc-20260327;
        b=WxfGo1xhgYyITuevED7JAKEaEU6+f0pKQOCNACFNdH5qNoC20ICX0LXHkgj/cNN3Tm
         +aBrkzcW8mrhLYOUMc9dlvBFQsCOE/dYU/nahVz7yc0Fg27WUQJPnodh2DUbMIZaU6cf
         UoECY0nDv8ThxRC/jiVp3094ZFHNpKajBccueITcs3LFJgrMIQ+OSnKlvU/H1KVu8feU
         vZshXIQXwvhQDTfNlosxs90rGVdIdR0iAMMQAHMbIvefyQZbB/TOZlxMhGFS85tbT1zW
         jCd2Avvi7OXD7tsFPJvF52Uu9MdHp7ioS343wMbmYM7OB/9TShKdp65l/MLtRp3RNqXe
         Hoqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BOOvIArGpv/xQKQD0TfZwhU1E1OVLGOADwgBsYj6a+w=;
        fh=IwwuMS5aMV1iKZQqRdGP1P6yxpgJs/0OmlDFVoXHpdE=;
        b=E/FfCK1PEn89NDFYUDdBtMCa1ANPFgOvT4S/SK+s3jI5323ymaiaYyOSoI78jZqjCA
         VwqGiZnTpqy9XHqkP4LugA7mFXrvzTG+WmRow7+WNLYc+RobqThYT+6NyFLn7pyubPyk
         3yLfmXfBrZbc0W+WgHfRZIFGUy8JEBPCoOmaM3T86EBXIhJolUA0kWNSOuifr6LmC5W8
         rW/ExHs2yzxDRIPFbBZkwzJP66Sy2nOMWtzQeHyVTriFHLvDnwA0Xu0DueQB3o6bjVHS
         TFvEyaGOvfvxBhGWHeBIMLmIXNz8kS4pqBd+PW09qkg1LC5guxiBaZl3Q+cH55NzDAH8
         iCRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795779464; x=1796384264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BOOvIArGpv/xQKQD0TfZwhU1E1OVLGOADwgBsYj6a+w=;
        b=W81wadcYIpDRilir81/NY+dhFMii3obkB7/j4FDOUXpTH81uWHdkulXGnRu2jHoyEw
         PgugmnspTg5FyFHrmbdnIV7/VBUdTxe5t+PH1fNHogUZtJUa0gFqLF4WYwhh4VuZ8hj0
         B0Vk8nCkkTIagjyET0S03ljpaty7LxXFdsnF/1sPUj8pAGdWRlRcDrsj05MaRTdVzOcr
         SLaI1C7+MTmWWNn2VqqSQFXIdY64rfiyQK6Vp9la+6FhAwzUMHrj5HvkGO3etjvZuih8
         2iFLf0vQhb+z+h1N6vy5MweNZujXxywIZ2rR8bm8en7xfXf8QYhMjCaZ8Edt3HK5lqqv
         c8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795779464; x=1796384264;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BOOvIArGpv/xQKQD0TfZwhU1E1OVLGOADwgBsYj6a+w=;
        b=usN/TTB2+R1/4pYlBMHT+RrSN254QwdIbF7mPdvS6nyrNOPxrTN5PR7q7wCMGGs/4P
         RqbPKSZG43oVahVnlSXAK9CBnXtfjvYgiXamojrOaprZfrdU5f/UFNIcdnhDuexyF3+q
         KIKXRfXULLixOy2rTURP64tH7D1OdRstubWBaOWdj6+yx2no+CUzzwF3WCQdkQVfe9/m
         dpjs2CR2+PGZ9BV0eH1APebOjg7uxAujSeGDZ5DXS6xDA04CMhPMvMLLb5wPo4e12uTP
         qjI2PNdP8nZRc3yZOQR3feM52O96gIoTs8hk4YkTZ0z+JA/5LIaWF4yS5qNQaFXcFEqf
         mpYg==
X-Gm-Message-State: APuU4Z8CVkoQHv2fPy4aoxK5aGpnsTY3m8NRPXzk+/OeR4SsVGaHuU+P
	va/Ik2GYPiwN9bCDb942vF83ytdRk9XgW0Xr2qt1fqNY++akEONmC8iPByxxd7U6tk71R4B2abO
	ISFYKPceU/yRvR/ftIIpC/dUM6UQmzqk=
X-Gm-Gg: AZFdTZeHY5+o54vjfVkUD7EFMYztlaQIyI0Ee5n3spPXua6hSLCXsTcYv44feUiDeya
	wZYjmwH8opY3Q0ddKnfdRIym6Orz/oop/Kl1g02mQDBa4Cs9uDUcxNq/3LXhlg2U1dKEUV3n4+s
	3d9vvaJQI0UzpLm4s6eBQgU84FKXC2KqIlJlrsO/TTA6O+UFXTiLcoALgYcRuaTUnbnKI2Nj1Gt
	/7KlWpwRJajSOquPbzfyy1g4toyMUVAGp4LdyF4nmEIaZnCNH/piPW00DML+gNtruIC8p17tp8F
	gcBjvTeRofwiAlgg2bRXtNcgPcc8y+w7/+53dufmMaRczJzMqfZXCY8x9D7iSfMeJTa4EYAEeKs
	6Hx8UHQCKeMEQSp1rszGHiU8LoYs1jzLRXKl7xk0WKT7z86nV9H5OSf8MPBhnb3N1KXmgMw==
X-Received: by 2002:a05:6402:1f07:b0:6b6:e808:9711 with SMTP id
 4fb4d7f45d1cf-6ba37eae2f5mr16871407a12.29.1795779464348; Fri, 27 Nov 2026
 03:37:44 -0800 (PST)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126093106.1345825-1-linmag7@gmail.com> <20261126093106.1345825-3-linmag7@gmail.com>
 <sashiko-outbox-235154@kernel.org>
In-Reply-To: <sashiko-outbox-235154@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 27 Nov 2026 12:37:32 +0100
X-Gm-Features: Aa3M54qFm0mLIHxqNl3bhCQ5Cp_bYsIXCWqA1F-Us97uON6bz3IR5vS7Z2fpzhs
Message-ID: <CA+=Fv5QXKSDLv_T1av-p5Vkd=xx_a5bRf+1VR1sOh+QejOe3ag@mail.gmail.com>
Subject: Re: [PATCH 02/18] sparc32,leon: retain SMP TLB shootdowns
To: sashiko-reviews@lists.linux.dev
Cc: sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi again,

On Thu, Nov 26, 2026 at 10:41=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [High] sparc32: missing preemption disable in smp_flush_tlb_mm() [1]
> --
>
> commit 20d5675eb7a3d5e5a3910745d8ae9ac1da8711f2
> Author: Magnus Lindholm <linmag7@gmail.com>
>
> sparc32,leon: retain SMP TLB shootdowns
>
> This commit retains the SMP TLB flush wrappers on LEON instead of replaci=
ng
> them with local operations, and updates leon_switch_mm() to invoke
> leon_flush_tlb_all() directly for local context switches.
>

This makes sense, I'll dig deeper into this and maybe this could go in as a
separate patch in this series when preparing a v2.

Magnus

> > diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> > index 145a63a5fda91..fb95865d7ddd5 100644
> > --- a/arch/sparc/mm/srmmu.c
> > +++ b/arch/sparc/mm/srmmu.c
> > @@ -1746,7 +1746,8 @@ void __init load_mmu(void)
> >       /* El switcheroo... */
> >       local_ops =3D sparc32_cachetlb_ops;
> >
> > -     if (sparc_cpu_model =3D=3D sun4d || sparc_cpu_model =3D=3D sparc_=
leon) {
> > +     /* sun4d supplies its own SMP TLB operations. */
> > +     if (sparc_cpu_model =3D=3D sun4d) {
> >               smp_cachetlb_ops.tlb_all =3D local_ops->tlb_all;
> >               smp_cachetlb_ops.tlb_mm =3D local_ops->tlb_mm;
> >               smp_cachetlb_ops.tlb_range =3D local_ops->tlb_range;
>
> [Severity: High]
> This problem wasn't introduced by this patch, but can smp_flush_tlb_mm()
> leave stale TLB entries on the original CPU if the caller is preempted an=
d
> migrated mid-flush [1]?
>
> With LEON now using smp_cachetlb_ops.tlb_mm, flush_tlb_mm() calls
> smp_flush_tlb_mm(), which runs without disabling preemption when invoked
> from preemptible context (such as fork() -> dup_mmap() -> flush_tlb_mm())=
:
>
> arch/sparc/mm/srmmu.c:any_other_mm_cpus() {
>         return cpumask_any_but(mm_cpumask(mm), smp_processor_id()) < nr_c=
pu_ids;
> }
> ...
> arch/sparc/mm/srmmu.c:smp_flush_tlb_mm() {
>         if (mm->context !=3D NO_CONTEXT) {
>                 if (any_other_mm_cpus(mm))
>                         xc1(local_ops->tlb_mm, (unsigned long)mm);
>                 local_ops->tlb_mm(mm);
>         }
> }
>
> Aside from calling smp_processor_id() in preemptible context (which warns
> under CONFIG_DEBUG_PREEMPT), the cross-call excludes the initiating CPU a=
nd
> re-enables preemption before local_ops->tlb_mm() runs:
>
> CPU0                                  CPU1
> smp_flush_tlb_mm(mm)
>   xc1(local_ops->tlb_mm, ...)
>     sun4m_cross_call(...)
>       cpumask_clear_cpu(0, &mask)
>       ...
>       spin_unlock_irqrestore(...)
>   [migrated to CPU1]
>                                       local_ops->tlb_mm(mm)  <-- CPU0 mis=
sed
>
> CPU1 is flushed twice while CPU0's TLB is never flushed, which can cause
> memory corruption after page table updates.
>
> [1] https://sashiko.dev/#/bug/linux-faa0e34b-f932-4bee-ba78-e5a71fbc6fe8
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126093106.13=
45825-1-linmag7@gmail.com?part=3D2
