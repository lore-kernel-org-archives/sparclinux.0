Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2AE17B418
	for <sparclinux@vger.kernel.org>; Wed, 27 Nov 2024 23:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732751235; cv=none; b=U4AWbKuSwDH2Ic4nMkPoohvCnyC5BK9gjd/cabpE2qHTvpsamkwJGmmRU3xn9/IDAPHxy/Sd+82iqdlC9wlzeK/2GtJ2nNVmYNGpRENbYACoti1m6XIKkmX6jnvKbQ+9RNN6GLqOm+lyeN/osXfzp9O2iqFdEC+e4ns3st0Vmbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732751235; c=relaxed/simple;
	bh=zIZOGs3TGu4OiEXHVauYi64/pBLzpSKkYakChN7IasY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WMV8+SqqKfOUeD7PjyMUwr6c26UNCrLM3MA1FQIICLD4k0Q56k/nYfBEJ2Qo5b0NkWwamvzXV/eGH04C8GClsHseN7f9LEF5i0FMnz5CucAglMTsL6BVASirLN0rV9/QLo13XV26ECsLWPWmEqTNCpirNpOqk/n/+cmw0A04hao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CMlQ1lrb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMlQ1lrb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732751232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHfrhH67Yu5xJzPz/jJPuyaVxyTQmB96/Ced1XLsseY=;
	b=CMlQ1lrbJBUvrRe9059PW/fL/Z6qeggcjxSaPbcjYUVcZ4oKNPpm11UejdKnNy6ULgptlR
	epx6MnoO/YVZTg14iKR2usR68B4Z20blICLfPKACpZ6FecLUtAFVhFrCiFG68CKTv+6Wgn
	JsSV/7zYCAAi3IVwC/+8wsMM992egxs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-qYSDjl0UOKyIhtlG58iBdA-1; Wed, 27 Nov 2024 18:47:11 -0500
X-MC-Unique: qYSDjl0UOKyIhtlG58iBdA-1
X-Mimecast-MFC-AGG-ID: qYSDjl0UOKyIhtlG58iBdA
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-466a500d7b5so4419431cf.1
        for <sparclinux@vger.kernel.org>; Wed, 27 Nov 2024 15:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732751231; x=1733356031;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHfrhH67Yu5xJzPz/jJPuyaVxyTQmB96/Ced1XLsseY=;
        b=nnh5eQK9UsmxDFCEYTIcXxSU+9Zy72K1p1ZhBJbwuJaJ1wbHvQ2MICM2TAq2d4iQeJ
         vAveErQXd1lITbmTunE5stIIaeSnQsEQ0oJ/xGOIrRGK6izBWYU1YeyGOJEHAnT7G5hK
         8rLqRy7oyG1NluSYlAzwmT/DSmcTKM4YW1BqJLiTATU0pKWXybZR0n2coGHGt57CXuO3
         p/PH5zPzk7nBJIBN4VlqUo2RtPp0T0G8zUbgXr5rgOhrC/xaLC5O/qnza4XYU9ApX65f
         CQYMtrsFccpzmM2xnHh+ug9rCPzftXVX/jZ5zKfbI0RKPlsGF7aHceWCGLNghytOmpHx
         sDuw==
X-Forwarded-Encrypted: i=1; AJvYcCUZcfZS5xr7iiHpG904qEuhJxqV5iqZ2W43C1ityFye7fNHafbRCCbnTPEdHuBKhIuv1NyOWmscB3Xf@vger.kernel.org
X-Gm-Message-State: AOJu0YyOvN1vWxKj1SKICUwwPSEHpkL9/++ksj7hiDiEkRvBhiw6SbpT
	DDv+CnisvSPwQBjARGoqpUL4NglGvkdycQXR6hmwUHQU0r6nCNJmccRjonlAdehhyq9kxVciLK/
	VDGRjGXrVDstnb/rqmaTLi+xO/BTSz+1B02mnix6d5XJQF71TxaOOXOqQLaA=
X-Gm-Gg: ASbGncuG0D+7GEcgRnLeNK8XNZwcJR1vbWY7nc3fPl/jy+0G/y/Tq/f27mn8RUGVKUx
	6R8dSNO1MdpBOkXMsJ1Z/ReAW+sIZtT13qLmvO9i+kuSOFubYxPmUAvX21MuEAXV0GqLxeRrNzn
	LJuuaYRBpkQEyUmxBORnSpNboJF+JJlma/HU2VL7tE/uokU4bpPDvCo7R2uaR+sDcU8rfH+20Xp
	/8wVnUMb7SUX0bfNxSDRqA0RHzYS74VktlxXpKJ9WWm4w2dd6Ze5vakK/WOFt8RU4FVfPlZI5H/
	V2+Kl6BBQd1Xo/H19HD/
X-Received: by 2002:a05:6214:1c4b:b0:6d4:1c6f:97b with SMTP id 6a1803df08f44-6d864da1287mr74874036d6.39.1732751231173;
        Wed, 27 Nov 2024 15:47:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhoi/EzTmu7WPrE04Dpf/+5MiowzUXRgu4qjqLXIF7KRMMrBmwKTwQBCnbbn0rr+d09BQArQ==
X-Received: by 2002:a05:6214:1c4b:b0:6d4:1c6f:97b with SMTP id 6a1803df08f44-6d864da1287mr74873756d6.39.1732751230892;
        Wed, 27 Nov 2024 15:47:10 -0800 (PST)
Received: from ?IPV6:2601:408:c180:2530:d041:4c25:86b8:e76a? ([2601:408:c180:2530:d041:4c25:86b8:e76a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8751f7221sm850936d6.91.2024.11.27.15.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 15:47:10 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c029c2fd-8bac-4913-b98f-f09acd7d28e1@redhat.com>
Date: Wed, 27 Nov 2024 18:47:08 -0500
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc/pci: Make pci_poke_lock a raw_spinlock_t.
To: Guenter Roeck <linux@roeck-us.net>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
 <bf7bd668-974f-481d-9526-94964455a250@roeck-us.net>
Content-Language: en-US
In-Reply-To: <bf7bd668-974f-481d-9526-94964455a250@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/24 12:44 PM, Guenter Roeck wrote:
> On 11/27/24 08:53, Sebastian Andrzej Siewior wrote:
>> On 2024-11-27 08:02:50 [-0800], Guenter Roeck wrote:
>>> On 11/27/24 07:39, Andreas Larsson wrote:
>>>> Even though this is for sparc64, there is work being done looking into
>>>> enabling RT for sparc32. If the amount of fixes needed to keep
>>>> PROVE_RAW_LOCK_NESTING enabled is quite small at the moment I'd rather
>>>> see it enabled for sparc rather than risking it becoming worse in the
>>>> future.
>>
>> Okay. So you seem to be in favour of fixing the sparc64 splats Guenter
>> reported?
>>
>>>> I don't know what the situation is for other architectures that 
>>>> does not
>>>> support RT.
>>>>
>>>
>>> For my part I still don't understand why PROVE_RAW_LOCK_NESTING is 
>>> no longer
>>> a configurable option, or in other words why it is mandated even for 
>>> architectures
>>> not supporting RT. To me this means that I'll either have to disable 
>>> PROVE_LOCKING
>>> for sparc or live with endless warning backtraces. The latter 
>>> obscures real
>>> problems, so it is a no-go.
>>
>> It is documented in Documentation/locking/locktypes.rst how the locks
>> should nest. It is just nobody enabled it on sparc64 and tested. The
>> option was meant temporary until the big read blocks are cleared.
>>
>
> That doesn't explain why PROVE_RAW_LOCK_NESTING is now mandatory if
> PROVE_LOCKING is enabled, even on architectures where is was not tested.
> I am all for testing, but that doesn't include making it mandatory
> even where it is known to fail. Enabling it by default, sure, no problem.
> Dropping the option entirely after it is proven to no longer needed,
> also no problem. But force-enabling it even where untested or, worse,
> known to fail, is two steps too far.

The main reason for enforcing PROVE_RAW_LOCK_NESTING with PROVE_LOCKING 
is due to the fact that PREEMPT_RT kernel is much less tested than the 
non-RT kernel. I do agree that we shouldn't force this on arches that 
don't support PREEMPT_RT. However, once an arch decides to support 
PREEMPT_RT, they have to fix all these raw_spinlock nesting problems.

Cheers,
Longman


