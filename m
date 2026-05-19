Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC90736C0DC
	for <sparclinux@vger.kernel.org>; Tue, 19 May 2026 23:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779233159; cv=none; b=YevG4RLV5uHlQK1HcKVHxE2crfFlyyFP4g6aD+33XdSZqNkY0CSoaltHBYf3I99n4pic66nRNEGZsd4MP1N/dicCMM3FqIullUK515Elcrl3sDYBrs+BGTFSyFfHVyhflz1r+5ZBQ9dmTqKy5rJXVtgCeN581N9nlU6a1p/RC+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779233159; c=relaxed/simple;
	bh=qzAr6/WsgFKssqlPCxXSDzt8GyeSAbibXjHXxB4WTP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qr638imO9iDf5k2Cwmakfy+tjc+m8rlaS4rbY+ElsUbTPCuRs9K/Qkqivm9V+g4jrDUH4uKKE/9Krl4oBsUhwIm+R3tSAVJEgYXi9c3ZlaR8vh2wGluvonauHBTK6UdmmZhq/F5H1MnrH4tL91akOct9C7TMKZuVGHpMLIdZdBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehXqV/TY; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehXqV/TY"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-134ac81c445so855554c88.1
        for <sparclinux@vger.kernel.org>; Tue, 19 May 2026 16:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779233157; x=1779837957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q3SS2yS5uCTePausm4fGtWUlfakc5T6xBGkbwj6NS7w=;
        b=ehXqV/TYxg/OG/RsQqL10m+W4a9YfynrDzhTSBDY8+rai7Hkz6up2XY2E84Kn9ZiFM
         3+Ivbn4Oxl1M+1+oKrZsX+hThdIdrp5c0J42OOkv4LZHSHPJOe/rDlJZlgT5/0vLPeB7
         6GGtejnrn1FGSD2bqb5kv+HwBEdYNn7nDbjpDBNuMwP3hL7Juk1Wj8fdzVbnUCvVxzi6
         1qN/F+taCVIuC3I1i+AQ0syY5BGzjLKza3lQkKSSV1T3r4KBTBKZkmLEp3wxv5Uv3ZIG
         lZ8EfmKqMWuo2fFTZm2jFWiShhIU9Ger+RkoEYU+shPVaQBbWdj5trlpM7wMelxTgvMU
         aorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779233157; x=1779837957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q3SS2yS5uCTePausm4fGtWUlfakc5T6xBGkbwj6NS7w=;
        b=a/H2OrTOXyQLvWQORvlaHMEqgQy+YPCOOpORxUvi04nnES0Mu7yg7xYoPkuKGsBBDV
         lPfoQqb9f3S1QuP0ILu9aDjwTmMxGAchnmuRXi5AeACBCGc2LhCohG0b4gwdxUtR+mGM
         kh54lYRi5KpR6O84H/QfI1Y1wDyVUT8/dzb7hR/dUDdap5HTQ/VapwWF6MJUoGWNSYCd
         ZZHpqcHneMdbxvM/Hl5qUNhkLFBnEJM3BOwudP7C0ALGiMrzl/O39zC+ucqnECmwB35E
         eBNn+tPWcfKffMRkg5BbS9wHICk5Ofa5jc+BEnH3L972u1bkqPFkUBotK6ixV90lmejI
         OPaA==
X-Forwarded-Encrypted: i=1; AFNElJ/HU6gMFobs2OmSmjCoPvieW3v5Kn5iUJYN9IsJFIMjMvS4Fl1a0pwqfgRbJzZWZV3eATnGqU/agHW3@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx2DkbfQAF7Bj8WnrYD7uegrJa9KFz3FAbwOI1V5Lh6up8WIQ+
	PwubSTfw4Qb6UeHtjlYlW6wFRqHpq59BDSORxPAJMznvKXhH9ig6pXqi2lnYj5QV
X-Gm-Gg: Acq92OGphRwqasG4ISG0NCO5u8fSbeDqyYVp36g3XQx3hPB2wsObd6dU2Eqfr9r3Rkq
	mQs4Kz5PL/Bs6xqgApcnZaCsU11vueFGENCi5SPBWvAUMFnEbv7p3hunGIfrOq511CCxMFj2CBr
	fPwUka+SE7NwZxfBDem5X+wPpe4imVa1JkSJFs08wWa2GhXwc6xIhufeFVALoo7gG8DUQ91mgWP
	i+8aOeFUIlZ7setWEX7Cdra9n9GtI9YpA16XUlC28G3yA8g3hmbHZ4QSvyRXqElZQVpkdAXuOBS
	pqk1uPXoSzF/DfTS9UXzcI4Vv8tvMHjihpV8hawEHv7zNtWRx/iWHwNiz8q55X9RuIa+QzRsSOY
	Pui9l53AC0IEVhBUqHepX5TyX/dkKBbFxRsHPB9vuQHqwuhHUenJhf5AAvOGRGwKOG1n1HD7mpo
	fi82mz9GF+XPLHZGo1eZp2dYGNEWDeHw==
X-Received: by 2002:a05:7022:43a4:b0:134:a701:de8 with SMTP id a92af1059eb24-1350441871fmr9821327c88.5.1779233156752;
        Tue, 19 May 2026 16:25:56 -0700 (PDT)
Received: from [192.168.21.192] ([67.170.89.46])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb93f3sm25577758c88.3.2026.05.19.16.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 16:25:56 -0700 (PDT)
Message-ID: <10382506-3f57-4b33-8356-34f23fb5f153@gmail.com>
Date: Tue, 19 May 2026 16:25:54 -0700
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2 1/1] sparc64: Fix comparator problem with timer
 interrupts
To: Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel@vger.kernel.org, andreas@gaisler.com,
 thomas.weissschuh@linutronix.de, regressions@lists.linux.dev,
 glaubitz@physik.fu-berlin.de, linux@leemhuis.info,
 torvalds@linux-foundation.org, davem@davemloft.net,
 sparclinux@vger.kernel.org
References: <20260519022421.5978-1-unixpro1970@gmail.com>
 <20260519022421.5978-2-unixpro1970@gmail.com> <878q9fxywc.ffs@tglx>
Content-Language: en-US
From: Tony Rodriguez <unixpro1970@gmail.com>
In-Reply-To: <878q9fxywc.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Thomas,

Thanks again for the careful analysis of the comparator ordering. After 
applying the changes in the patch I confirmed S7‑2 and T7‑1 systems no 
longer hang; timer scheduling now behaves as expected.

I don’t have bandwidth right now to finish the remaining tidy steps and 
I’d rather avoid delaying this fix. Since we worked on this together and 
you’re familiar with the issue, would you be willing to take it over so 
upstream has everything required for approval? I’m happy to answer any 
questions; if you’re busy I can ask the maintainer to reassign.

Thanks again for the review and the clear explanation.

Tony

On 5/19/26 7:22 AM, Thomas Gleixner wrote:
>> On SPARC64 the check:
>>
>>      return ((long)(new_tick - (orig_tick + adj))) > 0L;
>>
>> Is safe only if retries make forward progress. The comparator can
>> take effect with a latency, so the moment when counter == comparator
>> may be missed, which can cause delays or hangs on some SPARC64 systems.
>>
>> For clarity:
>>      exp = orig_tick + adj   /* expected comparator value */
>>
>> The current check requires new_tick to be strictly greater than exp;
>> equality (new_tick == exp) is treated as not yet passed and the caller
>> will retry.
> That's confusing at best. You really want to explain how the ordering is
> similar to what I described in the analysis:
>
>          exp = read_cnt() + delta_ticks;
>          write_cmp(exp);
>          return (read_cnt() - exp) > 0;
>
> If the counter advanced past the expected expiry time, after writing it,
> then the caller will retry, as the calling code does:
>
>       return tick.add_compare(delta_ticks) ? -ETIME : 0;
>
> But it won't do so when the counter is equal, which is causing the
> problem.
>
>> By contrast, using:
>>
>>      return ((long)(new_tick - (orig_tick + adj))) >= 0L;
>>
>> causes the caller to stop retrying and assume the timer is scheduled;
>> both equality and greater-than are accepted (new_tick == exp or
>> new_tick > exp).
> It's the other way round. When counter >= expiry time, then the write is
> considered failed. If the counter has not yet reached expiry time,
> i.e. it is smaller, then it assumes the timer is scheduled.
>
>> Signed-off-by: Tony Rodriguez<unixpro1970@gmail.com>
> It would be nice to have a link to the original thread in the change log
> itself as that gives people quick access when they are wondering about
> this a year down the road.
>
> Thanks,
>
>          tglx
