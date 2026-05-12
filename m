Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CECB387341
	for <sparclinux@vger.kernel.org>; Tue, 12 May 2026 21:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622233; cv=none; b=p1K2HaxWKA89oMAGFhIwp6oMoHxFEAPUxhc8GmKDbIaX3jzqznsRiA5UUSuX72TV4lNFHn3/mneRqWpE2Pggm3tHvAqFNLfa10yXdK1C8Gb7xWjS2BzImGSOBiPFUO4VDUR3qHQcmkpCQ2y7DD1XM1GDOMIZo88swAa3BqB3zbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622233; c=relaxed/simple;
	bh=+TVkWqui0GoSvFUjZQX/OAkYaopZk2awnHkswxWIKJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PY5g2L2HEd9nFemLGmadzBurSvmXU46MhHUdblDALvHzkbU1+9dmp34SwydRmg8tDNDEBJKk8ZF0Xl1AfLoWC5XTARC68CBOa5qx4X6FNjwit++wvqm59EQhQEP+mc4NJ6FEJ3VZk9mnja8Q0cd4It6ega6k89mZsJgG9oHscl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7MNM5OV; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7MNM5OV"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ee990e8597so10342752eec.1
        for <sparclinux@vger.kernel.org>; Tue, 12 May 2026 14:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778622228; x=1779227028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ENfghvyJePtUcbcYUBfCy8Gb5BU9pVX2Sr9eVZ+IT9w=;
        b=I7MNM5OVrysQVC0EzAYUI+jah7MmeJy2979s0HKWP+PfQS6dzW/ZrHAqpY3SLSy0X5
         h3h27hAGdXYNUnaY5ny7tYRhM0TVNFauYZxvcoghPsdLSVgv8SC5vXbXosgKW6GZLzAT
         jaXCQQBMazaSxcO3mihyVJFxwHprWFVHgTSUb4xhJyEQL0Jn3FhLKrx4hpidiT0uApFW
         lKtFRY06GMIZIvNtTHvTmS4HSH645gu7EmC4lH47D4ce1BNpa0FB4SnMwV0FMsGz7Q0/
         S4WLjobOA5N2s0tIkGZnsahukswz0zUTF7Yy9+5dGm8TmbqF8bp+pjbGjxdNPieYdoX+
         tPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778622228; x=1779227028;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENfghvyJePtUcbcYUBfCy8Gb5BU9pVX2Sr9eVZ+IT9w=;
        b=XINuJu7sp89pOFTSjJlGO68lLdg+4/RYVeheMgIRF+VfMETZ5Sd8G93s5AfjbFjY4u
         LKsV7Tlf4BN51vfYg1rWBoOx/X/Y0Op+8EY3IVm8n76fcwMJ0y2Mugid5BOdjKyfMdai
         s7gi1XTEvqRjSZf2RPtOS7k7TFekR+Yx61E32LLzY9Cgnq5ZgRdaSL0nBI2VmLJ2mB/5
         zxe2OM/551YeBUqQBU8JXZYrO2unG0E9VexOoDS8KLotvcScdCeEG1JqIjiaFlBq3J4b
         VnOj8OhFEyyZsagXS04hgAbdGiT4Edu84Gz7wXLXu/iuqFMY6ebX1/EjyzS0atHFhdfM
         EknA==
X-Forwarded-Encrypted: i=1; AFNElJ/NMxbfEA0lF9BGeQVlSompmQul3eOGrb3fHTW1mqZU5X8lGsydCQbd3El9j5WYhy2bbPHU2qk7s1vP@vger.kernel.org
X-Gm-Message-State: AOJu0YwUg37BGeutL+hsrHwt4B0UFGKfjZswjEwAa5xB0xHQsHzCTPCP
	3SGOa8EFjdr665d+wT2Icq7hXU69ENlmBoRUsQf+SpyX6DsXOPGk4N+p
X-Gm-Gg: Acq92OHuFivh1KOj5P+M1ispxBISOwQ2WuGWjzn4F+LaJT6s6ii8zqg6cma2wWSh+qI
	qdoVsFLN6ALYiovCJhppC4lRl8SxAxLPOHaIjLNF2ThNQGFWut2/girXp7mqeDdjbPN7RKV66T2
	Onc0sQ8DtyM5bbmBVq/U5s+zr3VdRGxd7TjI8I5O7QS52mRguIyHgTzKTVqG9qw8aQP+s9tLXWt
	YyJHPdjJPd491CSQm35IpVC2S+23z/K77WBLIGuIK3pvSCQaNmeY4abDL7/ltbDqE//r4zi0cXP
	x698IZGj3bFvxzCXYmnvk7v5vziAQWQYlFDy/31lENi6yGWuTCB5eWmP5oyCxtIaNK7by8CYIoy
	kb8GLcXz8QOg3eLKIkPM7ufigKtGvxFy+qFoSe15idw5hunRY6foadbPi6bFuW00kU8lb3zOh5+
	oLpPpmXdVfwig2QqiQPnWIl2QYDNyGfg==
X-Received: by 2002:a05:7301:2a29:b0:2de:cc07:e99 with SMTP id 5a478bee46e88-30116f8cbf5mr513224eec.7.1778622228454;
        Tue, 12 May 2026 14:43:48 -0700 (PDT)
Received: from [192.168.21.192] ([67.170.89.46])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eb034sm19704759eec.5.2026.05.12.14.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 14:43:48 -0700 (PDT)
Message-ID: <64f465ca-6117-4375-9c4b-af771b8205fd@gmail.com>
Date: Tue, 12 May 2026 14:43:46 -0700
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
 Thorsten Leemhuis <regressions@leemhuis.info>
References: <ffb44522-f01c-4be3-849d-27dc17fbca7f@leemhuis.info>
 <D5D19776-C809-4284-9417-F9A860877B98@gmail.com>
 <1c165caf-36b4-4673-97fd-ed86bef17b88@leemhuis.info>
 <3332123b-9e11-4895-9ab3-1707fba5815c@gmail.com> <871pfj9cmj.ffs@tglx>
 <a7a0d78b-435e-43c8-b436-5e7f4dd39dee@gmail.com>
 <088e6cfa-0167-4748-af6c-458ade2f303a@gmail.com> <878q9p82je.ffs@tglx>
From: Tony Rodriguez <unixpro1970@gmail.com>
In-Reply-To: <878q9p82je.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/12/26 1:17 AM, Thomas Gleixner wrote:
>> [  249.004209] [<0000000000000000>] 0x0
>> [  249.019116] Dumping ftrace buffer:
>> [  249.025666] ---------------------------------
>> [  249.034534]   <idle>-0         0d.... 1836659us :
>> clockevents_program_event: Successfully programmed 4000000 4000000
>> [  249.055418]   <idle>-0         0d.h.. 1845926us : timer_interrupt:
> So this is the interesting part, but that's starting at 1.836659s
> while the actual problem happens ~120 seconds later and the detection
> takes another 120 seconds.
>
> Assuming that one of the CPUs does not get timer interrupts anymore, the
> trace of that CPU should end around the time the last programming
> happened. So the interesting part is at the end of the output. The
> default buffer size per CPU is 1408k, which holds about 150k entries, so
> we can just shorten the buffers to make this less painful.
>
> Can you add 'trace_buf_size=50k' to the kernel command line, which
> limits the buffer size to about 640 entries. Assuming 115200 Baud this
> should then take about 4 seconds per CPU to dump, which still is a bunch
> on a large machine, but definitely way more workable than the default.

Done.  The complete trace file "s7-2-05122026-dump.tar.gz" can be 
obtained from my GitHub repo:

https://github.com/unixpro1970/Sparc64-Kernel-Debugging-Dumps

> IIRC, SPARC64 S7‑2 has 128 threads total, so the resulting uncompressed
> output should be around 7-8M. That's highly compressable text, so the
> resulting dump.xz should be suitable to be stored in github. If github
> does not allow you, let me know and we work something out.
>
> Thanks,
>
>          tglx
>
