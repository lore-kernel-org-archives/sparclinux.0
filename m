Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C903FBED7
	for <sparclinux@vger.kernel.org>; Wed,  5 Aug 2026 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922451; cv=pass; b=hwxObg5ziPG2V5jthcATbKEdF+0Zt5ocT0Xv6x5AcLjYfIcCmFZg9CEOJNp6DRVxaQ9KbtkL/KWc57H6NtGK7UGqyxE31EZXvLFWNKhpjHSVgRvH8f5lv4wN1jh0KvOyZwIxPZZmktI0Up8S+f7foZHLzJX6HS+A/DhQldh1REI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922451; c=relaxed/simple;
	bh=9L0j/pbQAIxYms5cegM0F3PFL7ya32kRw+S7PCbwuZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClRcHxsM7I/Q9jvd23Scslr1yYU8kbsmsGtSdfrCVv/WekvkGcdil7Cdq1W0pifPuyMPdaW1i7GaBvF5F5SPGoRYuOIX/zpmm//dghT/AWnCpoPKSAqYc9g//BUzyFaOewMmjrkR21f9hZkdl0r78z4xalDgmpXSgUNpNKdUzNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nxVB3W7T; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxVB3W7T"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a10d02ff43so1282637a12.0
        for <sparclinux@vger.kernel.org>; Wed, 05 Aug 2026 02:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785922448; cv=none;
        d=google.com; s=arc-20260327;
        b=qVAWEtxWfVF+HIhQdguI88zsgBH3MnTm2rPaz8vjRMFN+Yxxg7egY903Mg4i5afPXd
         J4v8l8FO+c5zgcgtfV9qGXl73Mc4CFQnT6aRDe/gB0u0SJEwr4S7wFJAlaOZiIQ/5OWp
         m26YXhvLbQY9Rzqk1+wng5y7wPX3AGUKzUKlO7J6wLntJcCHOKhvbilyhjRVGYoCn/3x
         7xEgUnO6y247uWCqXatfRxWgWJENAxzS7SiP2J+5gr5BwOK0+cIuZGzyJJC+vgDUIYzX
         AGNgXV+l3PiQ0np4DySP0+blmnkYIZTZ+qK7CTQHDvcoHy0Pt2GVO+vhiZa+HvAadtvn
         sq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UaGNs+E1Ex6iz5T9/0x/HPxcs/WYGeua7JSZh/+RxWI=;
        fh=z9M7dnNoCJB7xjkkGCrk5Ie90svl5BoLoqFH4yr31qU=;
        b=iGbwjfO/BhaYg8KohEsTy9+4xvpExWKliZmbEBaRv3Kby4DqXEzBkMULEPdCYDik0Y
         nNY6PnZeQzHSHDTu8Kpkj5C7K1kXQrRn8ny/xbywB+7IqXdw2PVOnsfgIhZBqdEJRIhZ
         onWlolh/kJO/K8S7AFn7yn4fwM7Wqz34t3V8DEZx/a6AuYXHocS9wyxwW7nXsmAvjJiY
         +n8vhtMk9LNLCv/Ekyj2E2ka+5BSAgg6Yze6rhsP12xWOXMSK5672wXC81fQEsCtchAp
         rXbLSSNVoDi4fiwBCh4/ZOgFZQOsfByU0nm9lPkLfm586Kav6ukl2Iu9rOj/ULJBtLLm
         BeHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785922448; x=1786527248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UaGNs+E1Ex6iz5T9/0x/HPxcs/WYGeua7JSZh/+RxWI=;
        b=nxVB3W7T5PzcgNakBP1/wZviKPIr0w6SG7+6Y/KxlFc3c6UOvBeK+7YYF7i1akkkBM
         7UwQGPufJfSULubwn0MN7WYeOwvjEV4fZBUhVbCk60xIcr+afqqGymIW35nRcAYrjm6p
         mjB78uXJT85+sRLdga3nn+YEy1MF2kl+sa/Zst5m6qP4gBB3/bJgeWf93hsGIaWuBcXq
         PbRCoAk/5wMGqFMOftie51sXZexfx+hIyBrnuRGXdsgp7Y/yrLlRxjA6pVZ1XvohGmNv
         zH/GTjk09mzaU0IJ7EGxmI/Rk0KclqUwffzjzzfw4hwmgnM3+lYoVTALr10KCuz+iEM6
         h4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785922448; x=1786527248;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UaGNs+E1Ex6iz5T9/0x/HPxcs/WYGeua7JSZh/+RxWI=;
        b=UO1QL6bQZhZ/mppUQ2oEN9G97PxvA2JMgeteY5gMTYCaJiSGVlIBIWrtM0Zj/8IrOI
         CympDNp0dXrloNPImD0NxjTiF6c6Jf5IvXzvn6GBCHvHRNEQSr4j2WofOFRs394sf7Z6
         SE9W48dlUHSMdCEcW6boHVuXCLTlVdejvs5bSz6CgcAg2jG9gJtQ4kqt1lYbw0KrlOvO
         nZESGxAzG9/yUy8WmhAsLwsc+WL8knZ57Zqh153V21EHHyxCgHbM5FIdaM9PSVEPlv/y
         e7oYtTLv2UA245L04InWvFx18fwkUZ5fS5+Kb6O6OuqqDypDfSaV5jWk7OLv5dRSFtej
         4zrg==
X-Forwarded-Encrypted: i=1; AHgh+Rp5pDe1c3aYiuaqi+k6S+4mCTE/C9l4ZfoyzotzL209nsNNmkvElNZ3rFplZP0z/E3X/7ny17U08ZsI@vger.kernel.org
X-Gm-Message-State: AOJu0YyGiHG3H7/j9KjfvO+HXziKA79v4vclls+c4xA9peKF+dtd/pxr
	rm64ik8bpTLs/8M6xrW32kOx0fb0xkUuYIPKxQ4RjjHpGw1IJVBfAhd//szIa8E3tQ0NhSezrnt
	uBQQQ06P4oSwVjK6S6PS2i7DPFqumE2M=
X-Gm-Gg: AR+sD12iaZyr7L1GVSEtf+jkSGjbO6Nz4e9DwNuVv0HJOXAHpVMaRGto98+89xe3BDz
	OmCy3jzWMHnbpJ6eQOxxq2K1OAaan/HDr47j7+o0D28x1FLQ/zoaTtfRozzhgfWYNhpf2DnVQf/
	fkr1DU1+cjgh7BDWgdr4jYtMJAvYrqFlB/9Uy9emX4EkdahBRZxxgAKe6prITb/kIssH2XiaCbF
	cSkjJnK1Q09yQGX8Nx363ChGHjRuGvgFXfBTl+rYyeoyY4yjGC98c2XtWg008zd0Ctjf5MGk13k
	Rs5WuW/JKNa3XFxpzktvIkY3tv0DgZKN23r/bprNhoW95eaJ3eMGgvub2niilmOgjKzUEY9pNxV
	msldPD/tCZJbR0iLnUvWD8ZGXfFfsgWc=
X-Received: by 2002:a05:6402:1f08:b0:6a1:b0b:ba6 with SMTP id
 4fb4d7f45d1cf-6a14f13e482mr2509895a12.15.1785922446933; Wed, 05 Aug 2026
 02:34:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com> <20260803-alpha-fp-exceptions-v1-2-c99d75608e60@gmail.com>
In-Reply-To: <20260803-alpha-fp-exceptions-v1-2-c99d75608e60@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 5 Aug 2026 11:33:54 +0200
X-Gm-Features: AUfX_mwnXqPqc_k9xGwWzJEiKBh4lXhngC_jeS43aqM9K90q-yJsxGFkXMu1yFY
Message-ID: <CA+=Fv5Tgq7X6Tqt2s6OuoWUQirzYwwyrmwQR_tDXpHRrczK22A@mail.gmail.com>
Subject: Re: [PATCH 2/3] alpha: don't leak hardware-fabricated FP exception
 bits to user space
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 1:40=E2=80=AFAM Matt Turner <mattst88@gmail.com> wro=
te:
>
> On EV6 and later the hardware records exception status bits in the FPCR
> before delivering a software completion trap, and those bits can be wrong
> for the instruction that trapped.  Converting a double that is exactly
> representable as a subnormal float sets FPCR_UNF even though the result
> is exact, and an underflow trap additionally sets FPCR_INE even when the
> emulated operation turns out to be exact.
>
> alpha_fp_emul() only wrote the FPCR when soft-fp raised an exception, so
> whenever it determined that the instruction was exact the fabricated bits
> stayed in the FPCR and were reported to user space by fetestexcept().
>
> Pass the exception summary register down from do_entArith() so the
> handler can tell which exceptions the hardware attributed to the trapping
> instruction, and always write the FPCR.  Clear the exceptions that the
> trap reported but that soft-fp did not raise.  EXC_SUM reports only the
> underflow or overflow when the hardware also set INE, so treat INE as a
> candidate in that case, and treat a trap with no reported exception as a
> denormal operand trap, for which the hardware can fabricate INE and UNF
> as well.  Bits that software has already confirmed in ieee_state belong
> to this or an earlier instruction and are never cleared.
>
> The imprecise path passes no summary.  There the trap was taken somewhere
> in the trap shadow, so EXC_SUM is not attribution for the instruction
> being re-executed -- and only EV6, which traps precisely and so never
> takes that path, has fabricated bits to clear.  For the same reason the
> clearing is guarded by implver(), matching swcr_update_status().
>
> On an UP1500 (EV68) this takes the glibc math testsuite from 831 failures
> to 28, the remainder being unrelated to exception status.
>
> This belongs with the preceding fix to ieee_swcr_to_fpcr(), and should
> not be backported without it -- nor it without this.  That fix stops
> FPCR_DNOD being set unconditionally, so denormal operand traps start
> firing again.  Those traps very often find an exact result, which is
> precisely the case where the old code left the FPCR unwritten and the
> fabricated bits visible.  Applied alone it would make spurious exception
> flags more common, not less.
>
> One case cannot be resolved here: an inexact instruction without the
> software completion suffix never traps, so its INE reaches the FPCR
> without being recorded anywhere else.  Such a bit is indistinguishable
> from an INE the hardware fabricated for a trapping instruction, and is
> lost if an underflow or overflow trap with an exact result follows it.
> The FPCR is the only record of those instructions and it carries no
> attribution.
>
> The bug predates the git history, so there is no commit to reference in a
> Fixes tag.
>
> Cc: stable@vger.kernel.org # 5.15+
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/kernel/traps.c  |  6 ++--
>  arch/alpha/math-emu/math.c | 88 ++++++++++++++++++++++++++++++++++++++++=
------
>  2 files changed, 80 insertions(+), 14 deletions(-)
>
Hi,

Passing EXC_SUM to the precise emulation path and always writing the
corrected FPCR state back looks correct to me.

I tested the complete series with CONFIG_MATHEMU=3Dy on the same machine
and using the same glibc build. The kernel boots normally, and the
glibc math testsuite improves from 48 to 28 failing test programs, with
no new failing tests. Tested on Alphaserver ES40.

Reviewed-by: Magnus Lindholm linmag7@gmail.com
Tested-by: Magnus Lindholm linmag7@gmail.com
