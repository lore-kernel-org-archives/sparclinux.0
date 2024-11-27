Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7AC1FF5FE;
	Wed, 27 Nov 2024 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732723375; cv=none; b=nVXUj3154Tg78kSjDoXsS4svc2IR9STAH9psk/CxJ1eeaisEpz/2N1/S6Nuyc62Eoz1MugEfTgEr2zYH7BLB/H/8PpApOnhOjMUUQ/R8BHz2s2tfmLL31UQ1zDdpTfcbmZekR9f5RZrW15PfHX6OaUga3ysFGqkETQOG8c3pvDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732723375; c=relaxed/simple;
	bh=//VdA2MCfMNgLcVe8mKZzguObzG+hvPXughJi1UkVo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gG4kk64eYirLaQeChJZPt5x29vrCUG1QmpccxKcw8uAaQIFCP3xcelNBSq9VWc7ocMX+KOM3qdTsA/GBN2zT26zvOzrbcZHcgxgYvn/irEykjZjTSSjXSjIRNRQD1BTvP2EvvHR6we8JfxW4cgwwxNTvyUtN2PwE+oIldqvYmiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOQPxdNq; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOQPxdNq"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ea8d322297so5354706a91.1;
        Wed, 27 Nov 2024 08:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732723373; x=1733328173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RhIk8wkZbllGKUN5kEmw0FVPpg4PusvGuHlmbjwQHqA=;
        b=eOQPxdNqmptVl9fzuYldyrymkapWstK7Wu0WoxXHagxubHDiu7Lq3gdKGJh84dGOMF
         /Y49jA2WE/1lgtU0EtJtvyR6iGB9Fsad4xiYQOSm8nPUFWXvwjD1OKS/4L0sRcggCpNq
         VwQkdCpZscAiQ4fj+6WS+LU58WPkxEcX6aKDmYHqiBNDUJuSBBKoj7veKW0AVa7B+Q4Z
         xqlkiwo2k/38OZxResVgSe0dtkq6SQDFsv+f1XlYSJMm6MI99UaMoRJh4vThbW7nfzkf
         UmCcF1TOiSYTvVl1f6X+vVWtOOZoU569JX5hcj2bCwrZ2jak0KP4SWecEATHM9d/o3vT
         P7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732723373; x=1733328173;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhIk8wkZbllGKUN5kEmw0FVPpg4PusvGuHlmbjwQHqA=;
        b=Z7YIigLGDLCcDUd2X47ejqGsT2t63rT4aN8z5v/HY2oPfi9s8gPMTzQoY6ygpOFGnT
         BpAzZnGIJJCBjMXhcBIXXqOWa/A02wNlCQZSNbbB/Yvatg34p0hEGPrBt3i2pR9+iSly
         jcxhUqCKb2z5N7Vu5AnymQN2QDm0foDnG+TU7nrkITSPdOuFk32zJiIakI+Dl6hkx6IY
         l63MWlqWdbVpYNdqNoyMddpjRNBw25xdwMH0u9KozMLYS+G16ZfuO1BIakcl+fDMwzmj
         J5zyacIeJopvjl2YZzelyA9mHciYJq183iLrAGWxZH/K8YLZD4sqV6VIFQ3EW7KXH/yr
         taew==
X-Forwarded-Encrypted: i=1; AJvYcCXb23gKdoz7Ucjab1HSxqT6wYobhFjwOHm3NCNoocQfaFLsdHkz2UzS6+y6WkcTlE+SpTcJpauy3qKItP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1yd72lBNPaNM8fC1OkCO/7PiWmagORFDtAO8v22xwtQPtJnpf
	LbxNN28nD9zDxpTKiUt5378xhbqpL7l7A5DvU4ieoZELMqZfmbHqGNy4kw==
X-Gm-Gg: ASbGnctJ+wMBBwyABaostBDLyw6JI3GiSJMEJu0zELvJQ14Np32Op7F5YYOYzKlTChB
	UMBznbbVHe3gLGWZNMp6IT33rIA04GutCsXQr4c8u8eVGfJan3s1nDgEDpG+/bzUJvpTVYxPxcL
	uqV+/ElfUyyUUbG3xc08NODQdL+TWX0HKd5Q0urO4cDsKuIz66oCS4bPxsgXqLnGSQ7PocL3Lo6
	4MECxGsxhaHdmxh6ohej9rBM417ulKVWdsFolRzqX/Mdo2gnmjMRdzKnxh96rQ+hjl7al6ik6uq
	egKcE4dq0dUc7Mvdr6tQuL0=
X-Google-Smtp-Source: AGHT+IHqhAv9LfmUPLfcffAxWtK6bnaS77u7PJYxmxWxoLdKbqTRI43/nRbBR5FEAQXrrXoP7+GjnQ==
X-Received: by 2002:a17:90b:390b:b0:2ea:61de:38f1 with SMTP id 98e67ed59e1d1-2ee097baf85mr4276240a91.27.1732723372978;
        Wed, 27 Nov 2024 08:02:52 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de454b65sm10460870b3a.6.2024.11.27.08.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 08:02:52 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4eb7bb8e-c2aa-4ce5-9f15-3086fccf4e46@roeck-us.net>
Date: Wed, 27 Nov 2024 08:02:50 -0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc/pci: Make pci_poke_lock a raw_spinlock_t.
To: Andreas Larsson <andreas@gaisler.com>, Waiman Long <llong@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>
References: <20241125085314.1iSDFulg@linutronix.de>
 <b776ca37-d51c-47e2-b3bb-aee8e7910630@roeck-us.net>
 <20241125174336.8nEhFXIw@linutronix.de>
 <c77c77d4-7f6e-450c-97d5-39dc50d81b1a@roeck-us.net>
 <20241125181231.XpOsxxHx@linutronix.de>
 <72991b83-173e-492e-a4aa-5049304c1bd0@roeck-us.net>
 <5d269249-afd1-44f5-8faf-9ac11d9a3beb@redhat.com>
 <dea92bd5-65e5-4c5c-bc93-5bef547c935e@roeck-us.net>
 <2a940822-b4d4-43ea-b4f7-4294043b76ea@roeck-us.net>
 <88f47cea-baba-4673-9bd7-7b7c3f421008@redhat.com>
 <20241126112000.UkTwR0Iv@linutronix.de>
 <48b9d642-9739-4333-b4b9-319df8a85e2d@redhat.com>
 <b698d599-ef4e-4966-92fb-1f84d7a0df75@gaisler.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <b698d599-ef4e-4966-92fb-1f84d7a0df75@gaisler.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/27/24 07:39, Andreas Larsson wrote:
> On 2024-11-26 17:59, Waiman Long wrote:
>>
>> On 11/26/24 6:20 AM, Sebastian Andrzej Siewior wrote:
>>> On 2024-11-25 15:54:48 [-0500], Waiman Long wrote:
>>>>> FWIW, the description of commit 560af5dc839 is misleading. It says
>>>>> "Enable
>>>>> PROVE_RAW_LOCK_NESTING _by default_" (emphasis mine). That is not what
>>>>> the
>>>>> commit does. It force-enables PROVE_RAW_LOCK_NESTING if PROVE_LOCKING is
>>>>> enabled. It is all or nothing.
>>>>>
>>>> I think we can relax it by
>>>>
>>>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>>>> index 5d9eca035d47..bfdbd3fa2d29 100644
>>>> --- a/lib/Kconfig.debug
>>>> +++ b/lib/Kconfig.debug
>>>> @@ -1399,7 +1399,7 @@ config PROVE_LOCKING
>>>>    config PROVE_RAW_LOCK_NESTING
>>>>           bool
>>>>           depends on PROVE_LOCKING
>>>> -       default y
>>>> +       default y if ARCH_SUPPORTS_RT
>>>>           help
>>>>            Enable the raw_spinlock vs. spinlock nesting checks which ensure
>>>>            that the lock nesting rules for PREEMPT_RT enabled kernels are
>>>>
>>>> Sebastian, what do you think?
>>> All the changes Guenter proposed make sense and were limited to sparc.
>>> So we could apply that. Limiting the option to the RT architectures
>>> would silence the warnings. If there is no interest in getting RT on
>>> sparc there is probably no interest in getting the lock ordering
>>> straight.
>>> I remember PeterZ did not like the option in the beginning but there was
>>> no way around it especially since printk triggered it on boot.
>>> I'm fine with both solutions (fixing sparc or limiting
>>> PROVE_RAW_LOCK_NESTING). I leave the final judgment to the locking
>>> people.
>>
>> Right now, ARCH_SUPPORTS_RT is defined for most of the major arches
>> where most of the testings are being done. So even if we limit this to
>> just those arches, we will not lose much testing anyway. This does have
>> the advantage of not forcing other legacy arches from doing extra works
>> with no real gain from their point of view.
> 
> Even though this is for sparc64, there is work being done looking into
> enabling RT for sparc32. If the amount of fixes needed to keep
> PROVE_RAW_LOCK_NESTING enabled is quite small at the moment I'd rather
> see it enabled for sparc rather than risking it becoming worse in the
> future.
> 
> I don't know what the situation is for other architectures that does not
> support RT.
> 

For my part I still don't understand why PROVE_RAW_LOCK_NESTING is no longer
a configurable option, or in other words why it is mandated even for architectures
not supporting RT. To me this means that I'll either have to disable PROVE_LOCKING
for sparc or live with endless warning backtraces. The latter obscures real
problems, so it is a no-go.

So, if people want to keep mandating PROVE_RAW_LOCK_NESTING together with
PROVE_LOCKING for all architectures, I'll disable PROVE_LOCKING for sparc
in my testing. NP, just let me know. I'll then do the same for other
architectures not supporting RT if I hit the same problem there.

Guenter

