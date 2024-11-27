Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F369B1FF7D0;
	Wed, 27 Nov 2024 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722473; cv=none; b=mbLz0AjGafwktgzBK2//4x5cm9H3vRiJhenfKO9tWq8EAv8Y4/eTAoxiAO76U2Pv78lheBnpruuyCIXUdGVcx9LOAOcXnPJfs/dCBg+WFdsOY9HYrUPt3RfGxDbYCxChZKB3JsCvZuFXiJg4M17yga9ddhKMs1rNz1t6ELTlnsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722473; c=relaxed/simple;
	bh=0H4Z6LOXgcnshlU8GxRnM1zGH12MwkSEOJIBSGlVL30=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y3ABuz/13m24nuGZ/rYAkYkAlycc2AvoyjpjaCvZ11NPOEV/QJePucz90tjNrN/O6o2JTNzlGQl/kw4dy3H4MuV1rnzC7wYfuwqxaNmgvqlcGmfPwD83zVEcbVhlGS+mI4Ets/+gT8pKdm3FM9HgHUL611z3cioGCAHLrR6uivE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=TGi39SSz; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="TGi39SSz"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Xz3XP0M1fz1DHnm;
	Wed, 27 Nov 2024 16:39:33 +0100 (CET)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Xz3XN52xYz1DHf3;
	Wed, 27 Nov 2024 16:39:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1732721972;
	bh=rPzh/pdZBw+UVZQCjG2qotS1eu5Tr0DEI4hOscQ5l/4=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=TGi39SSzTG92wr1Qx2gWxoxOZbsJokRA+RtvcUzfG1Eirpi8ZsltE6qA+8LbtsSFq
	 DbiAsUPL2Dr2zVvUlnqAT2yqAZxucypWZ2sA5d3TkmZ5zmRJDOVdRwKpbmoVJ0VfOd
	 yKJlvQ3XC2X0bqHr9EyGEkfoalwyYq7RTqxXJ+G4=
Message-ID: <b698d599-ef4e-4966-92fb-1f84d7a0df75@gaisler.com>
Date: Wed, 27 Nov 2024 16:39:32 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH] sparc/pci: Make pci_poke_lock a raw_spinlock_t.
To: Waiman Long <llong@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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
Content-Language: en-US
In-Reply-To: <48b9d642-9739-4333-b4b9-319df8a85e2d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-11-26 17:59, Waiman Long wrote:
> 
> On 11/26/24 6:20 AM, Sebastian Andrzej Siewior wrote:
>> On 2024-11-25 15:54:48 [-0500], Waiman Long wrote:
>>>> FWIW, the description of commit 560af5dc839 is misleading. It says
>>>> "Enable
>>>> PROVE_RAW_LOCK_NESTING _by default_" (emphasis mine). That is not what
>>>> the
>>>> commit does. It force-enables PROVE_RAW_LOCK_NESTING if PROVE_LOCKING is
>>>> enabled. It is all or nothing.
>>>>
>>> I think we can relax it by
>>>
>>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>>> index 5d9eca035d47..bfdbd3fa2d29 100644
>>> --- a/lib/Kconfig.debug
>>> +++ b/lib/Kconfig.debug
>>> @@ -1399,7 +1399,7 @@ config PROVE_LOCKING
>>>   config PROVE_RAW_LOCK_NESTING
>>>          bool
>>>          depends on PROVE_LOCKING
>>> -       default y
>>> +       default y if ARCH_SUPPORTS_RT
>>>          help
>>>           Enable the raw_spinlock vs. spinlock nesting checks which ensure
>>>           that the lock nesting rules for PREEMPT_RT enabled kernels are
>>>
>>> Sebastian, what do you think?
>> All the changes Guenter proposed make sense and were limited to sparc.
>> So we could apply that. Limiting the option to the RT architectures
>> would silence the warnings. If there is no interest in getting RT on
>> sparc there is probably no interest in getting the lock ordering
>> straight.
>> I remember PeterZ did not like the option in the beginning but there was
>> no way around it especially since printk triggered it on boot.
>> I'm fine with both solutions (fixing sparc or limiting
>> PROVE_RAW_LOCK_NESTING). I leave the final judgment to the locking
>> people.
> 
> Right now, ARCH_SUPPORTS_RT is defined for most of the major arches
> where most of the testings are being done. So even if we limit this to
> just those arches, we will not lose much testing anyway. This does have
> the advantage of not forcing other legacy arches from doing extra works
> with no real gain from their point of view.

Even though this is for sparc64, there is work being done looking into
enabling RT for sparc32. If the amount of fixes needed to keep
PROVE_RAW_LOCK_NESTING enabled is quite small at the moment I'd rather
see it enabled for sparc rather than risking it becoming worse in the
future.

I don't know what the situation is for other architectures that does not
support RT.

Cheers,
Andreas
