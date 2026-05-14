Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300233D7D99
	for <sparclinux@vger.kernel.org>; Thu, 14 May 2026 07:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778743491; cv=none; b=tbY9D4eSZd9HnoQ/dgQ5G7VKytjJu+8lEvR08/wL9FzJ6DRJt+CLHm8tH1H9su/qBzglsnDuNUKaXPW9o4syP5gkOzUxbSw/BOHwcxMfe3HK3KgUXN8fg/E6xOVCiZI4LLMb8oWN5bneXhDrtJ8FnAA8EKqlV4JEYstavLmH8rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778743491; c=relaxed/simple;
	bh=ZsIbdxclhE0yu0CL85hsH+17xmgFscAym9LDrlC1wNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lk4ii9ozZaxGfsrXtI1LYlkG7qCeGuq1ZiiKktSOaTKv0+ucRpwbxwWA+hEp0aWxd5zR5WLELng8cZB5JVTIzLXjsgBEK3NMOkXAv7ptDwOLfIMyFhPP1e/Q7oVsyaU/kcpS42J+kjLwSe64Grp/RmnSDwrrLEsqFSqfb4UDsOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ixphh4m/; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ixphh4m/"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-132d1b2519eso1683460c88.0
        for <sparclinux@vger.kernel.org>; Thu, 14 May 2026 00:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778743489; x=1779348289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F97Fyk4de96jpUWYQ2GaVritRCACZPpXcVzTRglA1VM=;
        b=Ixphh4m/Wzj4cKb10gxR2KwhZuLu5sJtlgNJVzptEMMEQHVHTsgav4iGRKeXjpEaEw
         MjlpMV7sHbdjwJzi4tpzExf0dV7NyjtIm7NvdoS9m0tp6DodUWXS1OIoKo0+3fISA7TA
         oLeGgbOcZboofmTVuIZ1+bwbhx2Hlt75PjxnIjRMb+pVtA3U5946Jiwno2xq3x2TDfUH
         G/26YOxQfWWP+PE44tLYCh4YxBZf7lrRYsjBU70K8kyGQHx5uYVfXhcD0gHlDtjwpJx9
         u5bSb4p19eEgNkfGb6KOLJNoc8kIgYqicV8DXIRDJrkJva/sLeH2+7qABBAqnCUelKEj
         7hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778743489; x=1779348289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F97Fyk4de96jpUWYQ2GaVritRCACZPpXcVzTRglA1VM=;
        b=RcSmf0NT2Y7tN6NIrNyI8H0cXoo+/6OB9yKoR2iKiwnK4zs4pQM+svfIbhHPEFM9Cb
         5rdkEzQeAS5AMsvCl/Fy7MurQL+3wvtilNDEfS6FgJWjxUs7lBKOUeSZZndnEgom+Xm0
         tYhMlRDpaZByM0mYcI7rkoX1AR54Xpz2JSnwIPGK8s+uXamxR5FPEs5EpWX5MTz7cryG
         rrdGowkhqplKxUjj4xIDpiugbsX/BnCuI8PrUwC4IkmhJsAmesKL+PbneoMMZoAn5y1e
         9mB05cD2V4Ui2+kqJSqDgYdOBSoFIXD4xiaUu0r0X/Tm1z4d41R3RP165i3yq4SbjxZG
         3ZAA==
X-Forwarded-Encrypted: i=1; AFNElJ+96MP0/ankXrzKdF4GsbVV9X206jJOI7q22cNQ7MaUNU7EUXdjjTCGCB9XCQm7U+qveqkYW3yCNKyE@vger.kernel.org
X-Gm-Message-State: AOJu0YzIcGJ+B3E41hA4SYRBiA6NFn50IFE7Y9vNWkIyccjOQ19FhXi4
	HaTogv/YEtnmJkbwYW6vhvejr4glixNWN0G57bRGPMzSvgPr2I+lnaCH
X-Gm-Gg: Acq92OHmIsIwj+Q63KzxicIZwEjsUnf0qMpW98t0bHub1VFiZT7xSPDm67w0CTrLFoZ
	8cs0VThLe8bADQwzURviQPauWWY6ftOJi7xT/ofuPXycALW4X1BYmbtaTFuxDjwQC1e6iau3EwK
	YEqx3BqKNOZgjb4poi3X5kGSNtQWcB4h0ltpzKBvEWC6mqQDy16yL0gXmgcUPeax0ocbtJ+/oJk
	Ho4BIKcynFAa8V8jTYXWfGqSUrfKjCkGa1EnYY/C1ubfg8f2O/tfm2cZIpHkgMlsibstJiFytpK
	Th7PkFOYcnmhUqq6pek3zHCqOe5rHuJLUVLhcZq9WUtH96vUWIuwII+OY8zIgXiABybmeA+yXvt
	ZVpBsvMkm2mkCtiNcUxByMFV0fuo5Ku+NRckng/Xbopz3ppUEao0VsH3Vwem+JRWdkpIIDuFr5k
	zwNPWbxKHDSGtxAPS+w0yrDZV+PU1aaeGi3mpKpwpt
X-Received: by 2002:a05:7022:6612:b0:12c:6da8:856d with SMTP id a92af1059eb24-1349ab4b4a8mr3637724c88.26.1778743488955;
        Thu, 14 May 2026 00:24:48 -0700 (PDT)
Received: from [192.168.21.192] ([67.170.89.46])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb93f3sm3248292c88.3.2026.05.14.00.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 00:24:48 -0700 (PDT)
Message-ID: <e45438e7-8501-4c10-95ee-07f118de8a51@gmail.com>
Date: Thu, 14 May 2026 00:24:46 -0700
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: the stuttering regression in 7.0: should I have done something
 different
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <ffb44522-f01c-4be3-849d-27dc17fbca7f@leemhuis.info>
 <D5D19776-C809-4284-9417-F9A860877B98@gmail.com>
 <1c165caf-36b4-4673-97fd-ed86bef17b88@leemhuis.info>
 <3332123b-9e11-4895-9ab3-1707fba5815c@gmail.com> <871pfj9cmj.ffs@tglx>
 <a7a0d78b-435e-43c8-b436-5e7f4dd39dee@gmail.com>
 <088e6cfa-0167-4748-af6c-458ade2f303a@gmail.com> <878q9p82je.ffs@tglx>
 <64f465ca-6117-4375-9c4b-af771b8205fd@gmail.com> <87tssb6olo.ffs@tglx>
From: Tony Rodriguez <unixpro1970@gmail.com>
In-Reply-To: <87tssb6olo.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Thomas,

Cheers!

Initial validation of the test patches for v7.0.6 and 7.1-rc3 on the 
S7-2 looks promising: I have not observed panics, timer delays, or other 
timer-related issues so far. I will pause broader validation on the S7-2 
and T7-1 until I receive your recommendation or any requested revisions 
(see inline comments below).

Note: I did see an intermittent error on the S7-2 running 7.1-rc3, 
usually when the system is under heavy load during a kernel build. I’m 
not sure whether it is a separate problem?

"[676.464681] BUG: Bad rss-counter state mm:000000008d9f1cf2 
type:MM_FILEPAGES val:-4096 Comm:cc1 Pid:78165".

On 5/13/26 1:28 PM, Thomas Gleixner wrote:

> Just to be clear: I never saw the VHDL code of that CPU, but that
> pattern is way too familiar.
>
> Those equal comparators, which were designed by AI (Absence of
> Intelligence) before AI got popular, generally work this way:
>
>    The comparator is only evaluated on the clock edge which increments
>    the counter, but not when the comparator value is written. So a write
>    of the same value does not result in an interrupt.
>
> That's an "optimization" which spares quite a few gates and is obviously
> nowhere documented. So software has to deal with the consequences by
> using a crystal ball, which is trivial to get wrong and can go unnoticed
> for a long time until it roars it's ugly head at some point for whatever
> reasons.
>
> I'm willing to bet a round of beers at the next conference that this is
> the problem and that it will magically disappear when you change that
> condition to:
>
>          return (read_cnt() - exp) >= 0 ? -ETIME : 0;

Attempted to locate "return (read_cnt() - exp) >= 0 ? -ETIME : 0;" but 
could not find an exact match. After additional inspection I updated the 
following functions "tick_add_compare()" and "stick_add_compare()" in 
arch/sparc/kernel/time_64.c to from "> 0L" to ">= 0L". This appears to 
have resolved the lost-timer behavior.

--- time_64.c.orig
+++ time_64.c
@@ -146,7 +146,7 @@
                              : "=r" (new_tick));
         new_tick &= ~TICKCMP_IRQ_BIT;

-       return ((long)(new_tick - (orig_tick+adj))) > 0L;
+       return ((long)(new_tick - (orig_tick+adj))) >= 0L;
  }

  static unsigned long tick_add_tick(unsigned long adj)
@@ -277,7 +277,7 @@
                              : "=r" (new_tick));
         new_tick &= ~TICKCMP_IRQ_BIT;

-       return ((long)(new_tick - (orig_tick+adj))) > 0L;
+       return ((long)(new_tick - (orig_tick+adj))) >= 0L;
  }

  static unsigned long stick_get_frequency(void)

>
> unless they managed to add some extra propagation delay to that
> comparator write like the HPET folks did at some point without telling
> anyone. I doubt the SPARC janitor who implemented it did so because
> that would have made the failure way more likely.
>
> I have truly no idea why the original code did not expose this problem,
> though it might have been just papered over by sheer luck and timing.
>
> Thanks,
>
>          tglx
> ---
> --- a/kernel/time/clockevents.c
> +++ b/kernel/time/clockevents.c
> @@ -381,6 +381,8 @@ int clockevents_program_event(struct clo
>   	if (dev->set_next_event(dev->min_delta_ticks, dev)) {
>   		if (!force || clockevents_program_min_delta(dev))
>   			return -ETIME;
> +	} else if (delta <= 0) {
> +		dev->next_event = ktime_add_ns(ktime_get(), dev->min_delta_ns);
>   	}
>   	dev->next_event_forced = 1;
>   	return 0;
>
You mentioned this kernel/time/clockevents.c patch is optional, but I 
propose revising clockevents_program_event(). If the requested event 
time is already at or before now, record a sane next_event (now + 
min_delta) so core code sees a future expected time and can behave 
correctly. Does this seem reasonable?

  --- clockevents.c.orig
+++ clockevents.c
@@ -347,6 +347,11 @@
         if (dev->set_next_event(dev->min_delta_ticks, dev)) {
                 if (!force || clockevents_program_min_delta(dev))
                         return -ETIME;
+       } else {
+               ktime_t now = ktime_get();
+               s64 delta_ns = ktime_to_ns(ktime_sub(expires, now));
+               if (delta_ns <= 0)
+                       dev->next_event = ktime_add_ns(now, 
dev->min_delta_ns);
         }
         dev->next_event_forced = 1;
         return 0;


