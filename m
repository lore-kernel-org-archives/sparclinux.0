Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCC510F4
	for <sparclinux@vger.kernel.org>; Thu, 28 Nov 2024 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732753899; cv=none; b=MKxxlmyt2UmxiEtRE9YC4MV4m0SGHtn35neNHsBWJeVNeH+j01CMaKC7INsR38+WlV7MMN2FC6ze5jnlmT9VQP25JcxbiyjdCoL+oB4emZxvXnnfwxDutyoIEMEl9guzwRo0/KQ+z6xK3fw7gqHE9e1qxsP+mT3rp8We8Xk/XQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732753899; c=relaxed/simple;
	bh=AoDIcArxj8ATSkVwXz8Zpe7AfDUM3odoWu8H6UoSl5M=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jh39L0eiFfjsN4Za712GxZxR3dnaGnevdNZa1uzAmyRrwpkYHThKq/d+i9BhfSTyNH3d7ljMJrTdEikhUFdtqV7i2JwalQeXAQE+B9nbGE1edXnLlafvu5cbqW9h+tlO+LSZREmm/XmEmxyRTD4s/Iud55zKDOrERSMAeOrt2Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LpBZKkVb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpBZKkVb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732753897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ibAv9WDOQTixkDjvaqVvQ7a/S55WmxPj/4iL3m5MBQ=;
	b=LpBZKkVbZmAub+dDlsY5PmQAoRbAi/FLLgHJ6/InoazhxVSGhU//xQlbkuuMExDdUQesaH
	AxVodtG72zE4PGVn2qSNq2kcdhm7vnsGnKDM4Ox7S8niW8ZBC8A6/yoIJl9z51mwJ+0Cqd
	1CadN/BYLDUAuCdn9dcAh5B4G35xRgM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-Yk6QAva-Pv6G6utxd5TtaA-1; Wed, 27 Nov 2024 19:31:36 -0500
X-MC-Unique: Yk6QAva-Pv6G6utxd5TtaA-1
X-Mimecast-MFC-AGG-ID: Yk6QAva-Pv6G6utxd5TtaA
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4608d303ebeso4588481cf.0
        for <sparclinux@vger.kernel.org>; Wed, 27 Nov 2024 16:31:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732753895; x=1733358695;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ibAv9WDOQTixkDjvaqVvQ7a/S55WmxPj/4iL3m5MBQ=;
        b=txL8I3BOqZqmhHlpZ7t1m8eczOJUKuLOHmrr2oAN2i6R67jqgOPjogZDVQw/QaYKbT
         VP/7ZSHMiM1dBnu9KY1mfF1hQPiua9vRQJpBdOQ7fIKjbURAFAMFYq2YaIWIaXblK5DP
         K41jZ3PMjDqfo3D2Hm7oj6tG9TeUS83rvtjVTnHKUs+sQ5OeAwxOM+SsPkFLZcfbWUgc
         SYLubP1h6UWmzlOlingS8xLhX6LAirvO1pT/udzoK3KZd80/OiTdjXxVtPHmZD8KnHbN
         O8WyWSav3oWg5Pun3ldVbdiEZA4h9AFbF0NlUrwUnHkRLNN5f+mh2sX5cx/Xq9QU4bms
         Bpkw==
X-Forwarded-Encrypted: i=1; AJvYcCVXOFv3ol0ETlrTTqV34G3RWpOa7JVJX9dwK5WsR1EjCkKHRzCulAbxD81Q3mX5NhqN0OT7Da434Uc5@vger.kernel.org
X-Gm-Message-State: AOJu0YwmJT2VWZ/eRanKEBug9/SpGbEcKAu6X+sGu0geA1Ye8KxChr2y
	unRtMhkS95mQojQkwKcaD1iH4EtfHKF7Eh8Cb9o0wYWrc3rFVb1UO7WQiKFjG9e9GV6sFD141ob
	l5Xdqp7PSf2diz4vBRcJR+cSoqlCQGhSt27FPVWEWs9lE8dDh8RQzFu30o+s=
X-Gm-Gg: ASbGncsHKizpFkbLkWIy2B/9lwZ2gxrVuNoELKHG7m48U83UdB/7U8ytwdIcfoUB3D4
	OPlWRQFtFnaPDeRow73MNIjp1Vapb9BYkUCmHBUV0yeO75T1Pk74K0rg5CzaC+oH6PtXkmzP/CZ
	6K+aTsc1regQeNG1mFAHBZoB6U0FTPhqDJ+ex4wDL9KOz4yEfXysNKJQnPKeouLGHdd1+7UXXIA
	S6jwAQKAC4YpY/ps84m0sutUEaWGu4yl5ZDpBD7WzF4opXeLF3TJWyAjpDnAL6deRjb12LeX7Zx
	J918fqUHm480fA+azJl6
X-Received: by 2002:a05:622a:4c6:b0:461:263e:6ab3 with SMTP id d75a77b69052e-466b352850amr62815861cf.30.1732753895434;
        Wed, 27 Nov 2024 16:31:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/W+l9R6WzLCY1srU7yRdeSZ+03DxWX+0nFMWAkGHZPdrlg8bWU+gD1kjpnaQyMur/Z8EuAw==
X-Received: by 2002:a05:622a:4c6:b0:461:263e:6ab3 with SMTP id d75a77b69052e-466b352850amr62815571cf.30.1732753895062;
        Wed, 27 Nov 2024 16:31:35 -0800 (PST)
Received: from ?IPV6:2601:408:c180:2530:d041:4c25:86b8:e76a? ([2601:408:c180:2530:d041:4c25:86b8:e76a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c40663a8sm1095201cf.23.2024.11.27.16.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 16:31:34 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6279e38a-9a3c-46ba-9161-5bc61f62d6d2@redhat.com>
Date: Wed, 27 Nov 2024 19:31:31 -0500
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
Content-Language: en-US
In-Reply-To: <93c5b695-4c98-4b3d-99d7-592d949750be@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/27/24 7:08 PM, Guenter Roeck wrote:
> On 11/27/24 15:47, Waiman Long wrote:
>> On 11/27/24 12:44 PM, Guenter Roeck wrote:
>>> On 11/27/24 08:53, Sebastian Andrzej Siewior wrote:
>>>> On 2024-11-27 08:02:50 [-0800], Guenter Roeck wrote:
>>>>> On 11/27/24 07:39, Andreas Larsson wrote:
>>>>>> Even though this is for sparc64, there is work being done looking 
>>>>>> into
>>>>>> enabling RT for sparc32. If the amount of fixes needed to keep
>>>>>> PROVE_RAW_LOCK_NESTING enabled is quite small at the moment I'd 
>>>>>> rather
>>>>>> see it enabled for sparc rather than risking it becoming worse in 
>>>>>> the
>>>>>> future.
>>>>
>>>> Okay. So you seem to be in favour of fixing the sparc64 splats Guenter
>>>> reported?
>>>>
>>>>>> I don't know what the situation is for other architectures that 
>>>>>> does not
>>>>>> support RT.
>>>>>>
>>>>>
>>>>> For my part I still don't understand why PROVE_RAW_LOCK_NESTING is 
>>>>> no longer
>>>>> a configurable option, or in other words why it is mandated even 
>>>>> for architectures
>>>>> not supporting RT. To me this means that I'll either have to 
>>>>> disable PROVE_LOCKING
>>>>> for sparc or live with endless warning backtraces. The latter 
>>>>> obscures real
>>>>> problems, so it is a no-go.
>>>>
>>>> It is documented in Documentation/locking/locktypes.rst how the locks
>>>> should nest. It is just nobody enabled it on sparc64 and tested. The
>>>> option was meant temporary until the big read blocks are cleared.
>>>>
>>>
>>> That doesn't explain why PROVE_RAW_LOCK_NESTING is now mandatory if
>>> PROVE_LOCKING is enabled, even on architectures where is was not 
>>> tested.
>>> I am all for testing, but that doesn't include making it mandatory
>>> even where it is known to fail. Enabling it by default, sure, no 
>>> problem.
>>> Dropping the option entirely after it is proven to no longer needed,
>>> also no problem. But force-enabling it even where untested or, worse,
>>> known to fail, is two steps too far.
>>
>> The main reason for enforcing PROVE_RAW_LOCK_NESTING with 
>> PROVE_LOCKING is due to the fact that PREEMPT_RT kernel is much less 
>> tested than the non-RT kernel. I do agree that we shouldn't force 
>> this on arches that don't support PREEMPT_RT. However, once an arch 
>> decides to support PREEMPT_RT, they have to fix all these 
>> raw_spinlock nesting problems.
>>
>
> config PROVE_RAW_LOCK_NESTING
> -       bool
> +       bool "Enable raw_spinlock - spinlock nesting checks" if 
> ARCH_SUPPORTS_RT=n
>         depends on PROVE_LOCKING
> -       default y
> +       default y if ARCH_SUPPORTS_RT
>
> would have accomplished that while at the same time making it optional
> for non-RT architectures.

I had actually thought about doing exactly that, but decide to keep the 
current mode for forcing  PROVE_RAW_LOCK_NESTING for arches that support 
PREEMPT_RT. I won't mind doing this alternative if others agree.

Cheers,
Longman

