Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F62D82D66;
	Wed, 27 Nov 2024 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732729456; cv=none; b=UdM91sBfx1i0GPUPbX7Kjw7HzQq62oejFmDU5c3GM20W0YInZVqZqg5r8sUjWbCZLFuxfAIvdKC/OhQAkq6lhaa9pqaZlX/vHXUueOkX2zhmhaoCjpW/dMIFTdZ49SNy9nLj35dsRtnQWzWBqIcmU2QjMBz7Urf+RQJXsTJsRvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732729456; c=relaxed/simple;
	bh=+eFuGiRB9NGC9kVe6ln16P/DFk8VUcFI6/sS/Jv8lvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WhE4DTJj9GvRNmSSZW/2NZc98hD/8WtsYdpBUClbO0uG9VswFrUJyEsH80TfG09da0cMyGoGp2I00q+R3iLRkz/NHBZHkaZzh+e+Gua5cEHtvO3Zk101BvL5PuFlRZ7iZyiSwn/ETJL7cFsJGdVV6HWDi7Jw/6fdvfqP0Adduro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IebulABI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IebulABI"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-214f6ed9f17so16666215ad.1;
        Wed, 27 Nov 2024 09:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732729453; x=1733334253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=TiSuNuhwO0yubwLJzQyK8WEXsFm1/gv3rHqAnFLtdLA=;
        b=IebulABIJqoz7m8qQre5IWThWZWk/37B9WmGfbwvZFN7GgkI7Fpmuoubsv0lykTqL5
         j/SAsDVDMlAXuocv8qgWflpXAFtnSY6iibNhtt52+HUhKRumyTP0HIQVCejbt46LxIoS
         mdfGY16YCsHu8cMStdUczBc4nURIYnJX0efs6rbZR1JLpYyJs07TEtb3UPPZvsDA3xev
         N9IJzTLGS/6ujWycoazrIin+kTweGA9r1DdTTa5Nb0WigO+3SxMcu1hONXOzG+2ZUott
         wqVmn7I/daTO8f5KCmc9iKw+qm66/czRQDcyUR491tIYl4+49egXFsUWnPxFVUMUq/mR
         ehAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732729453; x=1733334253;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiSuNuhwO0yubwLJzQyK8WEXsFm1/gv3rHqAnFLtdLA=;
        b=DIlWap2evKVnjpUkHLnFotzOMetOueewb8FASELZhIzsbroxeRqHRAmgY7WCmoixhj
         kwFG/JWOJQ1Ao0aWrj9K7PJfjapaeJvN6MdvVdJI8Dod4p231lhKgZm5PzXtcVhRsGsm
         lRQlRj6Wpd2GxLD1d4AZM/xarvADtnmDD8/WHSwsmWw44neteVVWTHE9zoNSvEaWIegj
         lbZ5DoyhxqRMsXqFq67MTSQnQAgKC+AJL/W2tgRtSl31i0kn5+HhrKid5ELHD6LxrGps
         0/R0efEGbB/fZyKYalVHbuwTiSKYxOKY6Fu+epO40UQIpkiDIlaqMtF0QTEpX06giTQK
         sePg==
X-Forwarded-Encrypted: i=1; AJvYcCVzEkafFfz2A//K0ZpgzPMZhtdr+iaCdsYDHcEcvRQZ6OOIkb2RsELXRcztBKIMLTP/6IsnQiORp3wvnA==@vger.kernel.org, AJvYcCWi42/BbroPTrZyX0/mus1z1rI3iZ0+g+uSkgUmZS4RowAcaYJlAdmISvX2++EdQcK3+rVgHlOtCS0g2K8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNzPFKo/kekT/weLaDIGce+V5bxGIUZi2j0q2Ty5i3sVms2Wbm
	W1qONjsdOUqJrQwVLFDC1SGx2iFS1goouPrAE4qt+rigHvh9vmHv
X-Gm-Gg: ASbGncsTKcJSemM+1Juu+a5RpMGorKtkiW/ziCeHrR1ngA1vfcRj1ZLqqWipQGnGLfR
	/9QedOeRT4i6vyv+eNlkoKMJqSaEr9y+Sx3s44G0B8p7fo6nmKbB7xTrJRWdklxOGTqZ81jnQJQ
	o+Az0gjL4gtRvpTSy1HWCruloQtxCnxg0Q+AibR8KU20uLxSJKg2UxUUV3ZIHwNILT2+1Nw+eK1
	em1vOPkDd69NZBpumqCZcPCKkXyHIXb0gLfY75t1FvTjI1ME3GQADZxjIa/+5dYbUrX0eGSlHN0
	1UcSQOAS9NZtjviqgZrVqHg=
X-Google-Smtp-Source: AGHT+IHl9Et5/Qsxwc/wpdMHf8XN802q6WDhySpHgBLFUYXujwyEQD3VuOjxqZA0FxYSk0qYeN08Pw==
X-Received: by 2002:a17:902:bf06:b0:212:190c:d9e with SMTP id d9443c01a7336-21501086335mr36035345ad.11.1732729453308;
        Wed, 27 Nov 2024 09:44:13 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba269csm105992745ad.99.2024.11.27.09.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 09:44:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bf7bd668-974f-481d-9526-94964455a250@roeck-us.net>
Date: Wed, 27 Nov 2024 09:44:11 -0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc/pci: Make pci_poke_lock a raw_spinlock_t.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andreas Larsson <andreas@gaisler.com>, Waiman Long <llong@redhat.com>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>
References: <20241125181231.XpOsxxHx@linutronix.de>
 <72991b83-173e-492e-a4aa-5049304c1bd0@roeck-us.net>
 <5d269249-afd1-44f5-8faf-9ac11d9a3beb@redhat.com>
 <dea92bd5-65e5-4c5c-bc93-5bef547c935e@roeck-us.net>
 <2a940822-b4d4-43ea-b4f7-4294043b76ea@roeck-us.net>
 <88f47cea-baba-4673-9bd7-7b7c3f421008@redhat.com>
 <20241126112000.UkTwR0Iv@linutronix.de>
 <48b9d642-9739-4333-b4b9-319df8a85e2d@redhat.com>
 <b698d599-ef4e-4966-92fb-1f84d7a0df75@gaisler.com>
 <4eb7bb8e-c2aa-4ce5-9f15-3086fccf4e46@roeck-us.net>
 <20241127165356.hnkqmgcc@linutronix.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241127165356.hnkqmgcc@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/24 08:53, Sebastian Andrzej Siewior wrote:
> On 2024-11-27 08:02:50 [-0800], Guenter Roeck wrote:
>> On 11/27/24 07:39, Andreas Larsson wrote:
>>> Even though this is for sparc64, there is work being done looking into
>>> enabling RT for sparc32. If the amount of fixes needed to keep
>>> PROVE_RAW_LOCK_NESTING enabled is quite small at the moment I'd rather
>>> see it enabled for sparc rather than risking it becoming worse in the
>>> future.
> 
> Okay. So you seem to be in favour of fixing the sparc64 splats Guenter
> reported?
> 
>>> I don't know what the situation is for other architectures that does not
>>> support RT.
>>>
>>
>> For my part I still don't understand why PROVE_RAW_LOCK_NESTING is no longer
>> a configurable option, or in other words why it is mandated even for architectures
>> not supporting RT. To me this means that I'll either have to disable PROVE_LOCKING
>> for sparc or live with endless warning backtraces. The latter obscures real
>> problems, so it is a no-go.
> 
> It is documented in Documentation/locking/locktypes.rst how the locks
> should nest. It is just nobody enabled it on sparc64 and tested. The
> option was meant temporary until the big read blocks are cleared.
> 

That doesn't explain why PROVE_RAW_LOCK_NESTING is now mandatory if
PROVE_LOCKING is enabled, even on architectures where is was not tested.
I am all for testing, but that doesn't include making it mandatory
even where it is known to fail. Enabling it by default, sure, no problem.
Dropping the option entirely after it is proven to no longer needed,
also no problem. But force-enabling it even where untested or, worse,
known to fail, is two steps too far.

>> So, if people want to keep mandating PROVE_RAW_LOCK_NESTING together with
>> PROVE_LOCKING for all architectures, I'll disable PROVE_LOCKING for sparc
>> in my testing. NP, just let me know. I'll then do the same for other
>> architectures not supporting RT if I hit the same problem there.
> 
> Waiman posted a patch to disable it on architectures that don't support
> PREEMPT_RT. You could also post the patches you discussed. Andreas does
> not seem to be against it (but then I don't know if he is a 32 or 64bit
> guy). I did not year from other architectures so far.
> 

I don't have time to work through all the issues, much less to argue with
affected maintainers to get the various patches accepted. I am open to fixing
regressions if I can, but it appears that this is not considered to be a
regression. I'll just disable PROVE_LOCKING for affected architectures
in my testing after -rc1 is out.

Thanks,
Guenter

