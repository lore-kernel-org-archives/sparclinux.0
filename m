Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663AE2556E
	for <sparclinux@vger.kernel.org>; Thu, 28 Nov 2024 01:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732758930; cv=none; b=F6KFbOD3+yGDjLUwiVAxevGh83c0TSy0KxI3kKw4OGUSKHiLBLUX4IC9Xs1otlWSSu+z2OObEX+b1P05foiiFSEu8quDmwQHHXL+maS7Ru2bIL/qxkOeFssuPjoFFIGPYYSSLmjnahAlvv38bFSR5LeQfGruNOv92RAXkX/VvLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732758930; c=relaxed/simple;
	bh=+lMbtx1tFi7sfzPnTRMaKCnwCdvjvH9av+TEvheS3wk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FOdFoBQhHFijwiUgoq/mcwALOmAX776urxW/7HkO83WSycL3qYCxJ9743vmjHecx10XQYEQgRacObIGFrMyCT2h5hLQbUbql1F5yCCWyXDUE2f+OVAvraaLnn3dB5/XF3TJx6+ojvZaseY6SjKvROds7JtS3oaCGtwxQdfr/HSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HPB8t8Kn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPB8t8Kn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732758926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pt1xoTsh4Jb2fg+vNFVLxj4Xr1q9iTUZq5l4MXLHBNI=;
	b=HPB8t8KnWhysqp1JMdOQnEw5IGZIpIg3pxCj4uf2D+78gx4hem1TWn45FRirquL16OPsaK
	lhpF0TOWECRoPqfePFTIyIv3DjlsBxvqz1zVBH48gNa5VFPPgic7HhiarjkmFGxdefnL+q
	NJ/kDNFYfPRvIF4BiGuOaVRvCAGkpwE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-iebCTbOhNHOEmZOpsdYR8A-1; Wed, 27 Nov 2024 20:55:25 -0500
X-MC-Unique: iebCTbOhNHOEmZOpsdYR8A-1
X-Mimecast-MFC-AGG-ID: iebCTbOhNHOEmZOpsdYR8A
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b66f8fb697so47185285a.1
        for <sparclinux@vger.kernel.org>; Wed, 27 Nov 2024 17:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732758924; x=1733363724;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pt1xoTsh4Jb2fg+vNFVLxj4Xr1q9iTUZq5l4MXLHBNI=;
        b=oZ8pzGClcErcY/SFSGaHUK8P86G2Hl5GIrdwnUwr8llfjMvlAFEFEW6m3+XZMpMfSo
         VU0opQsaOMbRiQ4MBmUb4ygcXFYEY7LWnsJf7Q3drl+XdF8BenscnuYiJ8JsZDlc6gwG
         70urq8j4hx1XsInY473Gg4IXnN7y9Lsja4dFVTlP2EfkQFAsr86LgE+Ldw4x34lPmi13
         O835QzLdpCzbzQzY9KKteBoNiqmmflw+O8smeBxXa+OWCQjNu3Kuhyp2pBWM+TzaDVVL
         rhaF6663jlVB9A1b60REbyt9sBprl34dxFZ2BGZnPG50nE0Ff70OQ7i05eZuBQXnVGpb
         Xf9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGvj/YtvTNvd0O9B9atc7kNNttWMmyvPffH9wOyBgG3TZ+bsjR4k/epKFRFL500+QSQAceltO3LPlE@vger.kernel.org
X-Gm-Message-State: AOJu0YxJZ1zIXLrPsdN6FmZ/+TKSqe5IGePtI13K9uNsPxP3XxihTvn7
	pUIEZT9P7txOd5apXY/qypRtmMlBuj6dVZUN7DOVslIpkFx4JxBtlr6jyueDkaXi9O2/AvDLlAJ
	gCZVPDYo/Wv9grfk/gv2ou1DvAQgEbXqkc1LgvpA8o8jLQocz0jBIKkVxETA=
X-Gm-Gg: ASbGncsA/5A/dbZtMuGNNwgO+ZO8G/thdoZvetKGz/jW+q8iptBIoIntnfobemGHfwT
	3zF56rm+qkNbiWCM1ce8CnXrWYXCCl1hqz2g1HD9fQBghHsHiaQMBEBl7NPpcynZl1m+WcKf0Di
	Zk7boS6vSpgun3Ib0nuTYoRcd2PBvsYGNt5L2++HXq7iSXhPnk9HEqaGiTlYlInVIBh92P3/BN3
	73+e1XxZembNpVpMLjaowFY7p8n3Q2JiY7KR9TKQ4xOIjwDIxuLu6V0+bgxB6wj/3L72kOjvQod
	xgOsEvOTYawKH9A41xto
X-Received: by 2002:a05:620a:178d:b0:7b6:7653:ee07 with SMTP id af79cd13be357-7b67c2ceca3mr707435585a.30.1732758924617;
        Wed, 27 Nov 2024 17:55:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFx2LUdpqc02lSn2Y8MLvZ4OqE1eHnalk/fgIqtR9eVAjWVi6pHvscP1L3unwF4laM4geXhUw==
X-Received: by 2002:a05:620a:178d:b0:7b6:7653:ee07 with SMTP id af79cd13be357-7b67c2ceca3mr707432685a.30.1732758924240;
        Wed, 27 Nov 2024 17:55:24 -0800 (PST)
Received: from ?IPV6:2601:408:c180:2530:d041:4c25:86b8:e76a? ([2601:408:c180:2530:d041:4c25:86b8:e76a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6849aad39sm16655585a.80.2024.11.27.17.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 17:55:23 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f6667d73-231c-481a-9b55-b75ea845421e@redhat.com>
Date: Wed, 27 Nov 2024 20:55:22 -0500
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc/pci: Make pci_poke_lock a raw_spinlock_t.
To: Guenter Roeck <linux@roeck-us.net>, Waiman Long <llong@redhat.com>,
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
 <93c5b695-4c98-4b3d-99d7-592d949750be@roeck-us.net>
 <6279e38a-9a3c-46ba-9161-5bc61f62d6d2@redhat.com>
 <b59961b6-2026-4f7a-8b72-9b94adfff310@roeck-us.net>
Content-Language: en-US
In-Reply-To: <b59961b6-2026-4f7a-8b72-9b94adfff310@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/27/24 8:17 PM, Guenter Roeck wrote:
> On 11/27/24 16:31, Waiman Long wrote:
>>
>> On 11/27/24 7:08 PM, Guenter Roeck wrote:
>>> On 11/27/24 15:47, Waiman Long wrote:
>>>> On 11/27/24 12:44 PM, Guenter Roeck wrote:
>>>>> On 11/27/24 08:53, Sebastian Andrzej Siewior wrote:
>>>>>> On 2024-11-27 08:02:50 [-0800], Guenter Roeck wrote:
>>>>>>> On 11/27/24 07:39, Andreas Larsson wrote:
>>>>>>>> Even though this is for sparc64, there is work being done 
>>>>>>>> looking into
>>>>>>>> enabling RT for sparc32. If the amount of fixes needed to keep
>>>>>>>> PROVE_RAW_LOCK_NESTING enabled is quite small at the moment I'd 
>>>>>>>> rather
>>>>>>>> see it enabled for sparc rather than risking it becoming worse 
>>>>>>>> in the
>>>>>>>> future.
>>>>>>
>>>>>> Okay. So you seem to be in favour of fixing the sparc64 splats 
>>>>>> Guenter
>>>>>> reported?
>>>>>>
>>>>>>>> I don't know what the situation is for other architectures that 
>>>>>>>> does not
>>>>>>>> support RT.
>>>>>>>>
>>>>>>>
>>>>>>> For my part I still don't understand why PROVE_RAW_LOCK_NESTING 
>>>>>>> is no longer
>>>>>>> a configurable option, or in other words why it is mandated even 
>>>>>>> for architectures
>>>>>>> not supporting RT. To me this means that I'll either have to 
>>>>>>> disable PROVE_LOCKING
>>>>>>> for sparc or live with endless warning backtraces. The latter 
>>>>>>> obscures real
>>>>>>> problems, so it is a no-go.
>>>>>>
>>>>>> It is documented in Documentation/locking/locktypes.rst how the 
>>>>>> locks
>>>>>> should nest. It is just nobody enabled it on sparc64 and tested. The
>>>>>> option was meant temporary until the big read blocks are cleared.
>>>>>>
>>>>>
>>>>> That doesn't explain why PROVE_RAW_LOCK_NESTING is now mandatory if
>>>>> PROVE_LOCKING is enabled, even on architectures where is was not 
>>>>> tested.
>>>>> I am all for testing, but that doesn't include making it mandatory
>>>>> even where it is known to fail. Enabling it by default, sure, no 
>>>>> problem.
>>>>> Dropping the option entirely after it is proven to no longer needed,
>>>>> also no problem. But force-enabling it even where untested or, worse,
>>>>> known to fail, is two steps too far.
>>>>
>>>> The main reason for enforcing PROVE_RAW_LOCK_NESTING with 
>>>> PROVE_LOCKING is due to the fact that PREEMPT_RT kernel is much 
>>>> less tested than the non-RT kernel. I do agree that we shouldn't 
>>>> force this on arches that don't support PREEMPT_RT. However, once 
>>>> an arch decides to support PREEMPT_RT, they have to fix all these 
>>>> raw_spinlock nesting problems.
>>>>
>>>
>>> config PROVE_RAW_LOCK_NESTING
>>> -       bool
>>> +       bool "Enable raw_spinlock - spinlock nesting checks" if 
>>> ARCH_SUPPORTS_RT=n
>>>         depends on PROVE_LOCKING
>>> -       default y
>>> +       default y if ARCH_SUPPORTS_RT
>>>
>>> would have accomplished that while at the same time making it optional
>>> for non-RT architectures.
>>
>> I had actually thought about doing exactly that, but decide to keep 
>> the current mode for forcing  PROVE_RAW_LOCK_NESTING for arches that 
>> support PREEMPT_RT. I won't mind doing this alternative if others agree.
>>
>
> Forcing PROVE_RAW_LOCK_NESTING for arches that support PREEMPT_RT is 
> exactly
> what the above does.
>
>     bool "Enable raw_spinlock - spinlock nesting checks" if 
> ARCH_SUPPORTS_RT=n
>
> makes the flag visible (only) if ARCH_SUPPORTS_RT=n, and
>
>     default y if ARCH_SUPPORTS_RT
>
> (force-)enables it if ARCH_SUPPORTS_RT=y.

OK, I missed the "if" part after the string. Yes, that do force 
PREEMPT_RT supporting arches to set PROVE_RAW_LOCK_NESTING while 
enabling arches that do not support PREEMPT_RT to optionally set it. I 
will post a v2 patch with that change.

Thanks,
Longman

