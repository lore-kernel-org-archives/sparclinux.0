Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24287139B;
	Thu, 28 Nov 2024 00:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732752510; cv=none; b=rvvUHBXqYIXwZUnZDTq/kikFolo0YVIIqmUCrOrxHYRKpx89cAqtrwe6Q5eg5XOzhcgZpnyrd0Jj90jvEPO9qUyxokVTYXJ+nUx6Scb+go2zOFibO7WrqLRTBmbEuKTGRNU0vhb6W+SPFguoVMFuJ8xp45a4ghzXjAp7RXfr8O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732752510; c=relaxed/simple;
	bh=5NLe2btzO9lUQ3yC4DdrEfjudAbd5fsvjZfiayILKm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lo52mHtKYfRX3Ff0QeM+qLne1ZRMerKeiBwLbIhu18p89/blwi2ViMfoPJ1ZlfZ5xaoUuWdeTXWzm68p9nqh9ZT5wmpPKTEuddA/w7NW1nPAGhfpiTt3dszJNDsc0V1RE8DIC+X4L5RsYU8Y34LRwS7rsU3B+v5K7dGQeVzrbto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpmMT3Gd; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpmMT3Gd"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-724f74d6457so349620b3a.0;
        Wed, 27 Nov 2024 16:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732752508; x=1733357308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=T8DTKLWYyJEEVpZ68Si9ZSGjOKCIrmLizkH7/71Xg64=;
        b=DpmMT3GdcTuerWvdnefHw+swK6IpBmu5EnLttpY6lZuJxv/rRI2mSi54oMMNDiPiRy
         zBQFnLVbGJ5699d8ZTYy5IkUqo/0FBAPDnaTDXn4AoMvUt7unPCXmQLE6zVF8QB5iciq
         ngNdkhzp4rjNiNwnM0PXxZUUUia93YeE3OibvayWnf+dg+V0xA4tW+MQDEBNlIu7Mrh3
         qBzH3vifqRLWFC7FN7+G5nuLpbxVYUEnXwfW4B9s1BQq0vishwJMzguo6lYRQPDkWx3y
         PZ5lhdPOcnspqvDNLBBRxdSOXGfIMHVijv/Pua2K7J4+wf+Eck5AwnOBu84WoSS2wdHW
         KNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732752508; x=1733357308;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8DTKLWYyJEEVpZ68Si9ZSGjOKCIrmLizkH7/71Xg64=;
        b=Qo8hNH1bRqdVbN5PVR/L+BvszpqUOd4akyGfv6hEpWaciSPYpvQD/6z2p9PsnskeiF
         wQxLCXVLt+PRvUwprosaBxMqvIiiyPLeWyUOxutNlK24yraaR4sV414B8L37+BkgZjqa
         2MDE/ZvrFHlmyF/JIGcOhT6Hnvnlj+vZIEg6jBEew3IuRvYbFnGzYt9Ovh1GZMhgpemj
         7Z2jpl37N+UTz1KEzY9w5fSkH+6ZDv/mW+gaic5wzjjz1D1sWISlbtVWfrKDjAJuSTIH
         UuDIjcPWmwTfz/Q2sShtZhC2MzvUnZ66HM59wRFdHPaYbldtmfGzRYIRLAk09f1uwW4H
         OhVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr3cS2CzVcgiKUrV8PJLjSvIGhrIpgKpiNAKkqzd7T/oAElR5fJIeLKPc2nIbThbg7zOhVyXMFKnxH0aY=@vger.kernel.org, AJvYcCX2L0dSeH2yquNKa/FaYFFt13jHJlCZNpDLC69Pz4PnYxoGyF5JR10ZPWehhosoOwVf3GFXtiv+ILVUag==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCiXhUXpwJf/OR+RwBRdEE49da9sXsiluJt8xmMXZlyEo3hPZw
	U/cU8QGKCmG1In6UtAQq23drL6OmYyqwMv5sLLYs5iiOLmKOKVLY
X-Gm-Gg: ASbGncsVRUkFUmv6S6VL5S9qdzGPS5gzIbwd3DL9DZ6oKgMRofajrCdzQt/OlrGpkOE
	Ktp5vno2cWgVaIYgoihYNOUnjtLoADgQBaARsJyXY18pqg6J3U5BAis4tINcbF1PbkTY4bqZ1gu
	3G2+Oj8A8HjMoDvy/TNpzvTEEHZJ6fKYtkUWE92IOZtjDpcMH61x0Oou7/xVoXtjEqWmuQ4XKWO
	dCLXUvwidXZny48dNe+Mq/6AblTXhpsw61Y/yETKounKi7mYpICuM3vFUFaXE4zUcwZTd1/IZL8
	JJ7wv/HMkmY7uPNf7ve0thk=
X-Google-Smtp-Source: AGHT+IE9I3p5BiFXkQs+ixEksSB0uuqyKLVGC4imJYak3wOHa3RzIzwKjGHZhcqgudJctIPyP3bE+g==
X-Received: by 2002:a05:6a00:3cc9:b0:724:ea15:fc7a with SMTP id d2e1a72fcca58-72530149e59mr6631563b3a.16.1732752508298;
        Wed, 27 Nov 2024 16:08:28 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254184952csm162099b3a.185.2024.11.27.16.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 16:08:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <93c5b695-4c98-4b3d-99d7-592d949750be@roeck-us.net>
Date: Wed, 27 Nov 2024 16:08:26 -0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc/pci: Make pci_poke_lock a raw_spinlock_t.
To: Waiman Long <llong@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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
 <c029c2fd-8bac-4913-b98f-f09acd7d28e1@redhat.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <c029c2fd-8bac-4913-b98f-f09acd7d28e1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/24 15:47, Waiman Long wrote:
> On 11/27/24 12:44 PM, Guenter Roeck wrote:
>> On 11/27/24 08:53, Sebastian Andrzej Siewior wrote:
>>> On 2024-11-27 08:02:50 [-0800], Guenter Roeck wrote:
>>>> On 11/27/24 07:39, Andreas Larsson wrote:
>>>>> Even though this is for sparc64, there is work being done looking into
>>>>> enabling RT for sparc32. If the amount of fixes needed to keep
>>>>> PROVE_RAW_LOCK_NESTING enabled is quite small at the moment I'd rather
>>>>> see it enabled for sparc rather than risking it becoming worse in the
>>>>> future.
>>>
>>> Okay. So you seem to be in favour of fixing the sparc64 splats Guenter
>>> reported?
>>>
>>>>> I don't know what the situation is for other architectures that does not
>>>>> support RT.
>>>>>
>>>>
>>>> For my part I still don't understand why PROVE_RAW_LOCK_NESTING is no longer
>>>> a configurable option, or in other words why it is mandated even for architectures
>>>> not supporting RT. To me this means that I'll either have to disable PROVE_LOCKING
>>>> for sparc or live with endless warning backtraces. The latter obscures real
>>>> problems, so it is a no-go.
>>>
>>> It is documented in Documentation/locking/locktypes.rst how the locks
>>> should nest. It is just nobody enabled it on sparc64 and tested. The
>>> option was meant temporary until the big read blocks are cleared.
>>>
>>
>> That doesn't explain why PROVE_RAW_LOCK_NESTING is now mandatory if
>> PROVE_LOCKING is enabled, even on architectures where is was not tested.
>> I am all for testing, but that doesn't include making it mandatory
>> even where it is known to fail. Enabling it by default, sure, no problem.
>> Dropping the option entirely after it is proven to no longer needed,
>> also no problem. But force-enabling it even where untested or, worse,
>> known to fail, is two steps too far.
> 
> The main reason for enforcing PROVE_RAW_LOCK_NESTING with PROVE_LOCKING is due to the fact that PREEMPT_RT kernel is much less tested than the non-RT kernel. I do agree that we shouldn't force this on arches that don't support PREEMPT_RT. However, once an arch decides to support PREEMPT_RT, they have to fix all these raw_spinlock nesting problems.
> 

config PROVE_RAW_LOCK_NESTING
-       bool
+       bool "Enable raw_spinlock - spinlock nesting checks" if ARCH_SUPPORTS_RT=n
         depends on PROVE_LOCKING
-       default y
+       default y if ARCH_SUPPORTS_RT

would have accomplished that while at the same time making it optional
for non-RT architectures.

Guenter

