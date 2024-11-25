Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB4717BB0F
	for <sparclinux@vger.kernel.org>; Mon, 25 Nov 2024 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732568098; cv=none; b=lfBBAylk5rHkwcmjgR4zb8lsqh1eE7yez5DfdF+NqNV6cjX5MROWExR7xk+RBERbFBodRd7dbdQYIX1LWKOMihmXR1fAtCihWAnzREHF35OjMLdBceZL66SCUYZ32pHiJVOQ8f7ZSYXtVCSNo8JKydzlnYlzmBu3Wjbmw/lVjGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732568098; c=relaxed/simple;
	bh=pLNGI3q63utN8E5O8PwVt6jG77VGVKk9hwrtqocmqZ8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EZQtwObcIUeCj84XsL8otdegn9sCI1wuX7KDClNsV6AHkYw7l9RUoKX1jxrgtdEFD3LclE7rM8A/TJ8qOVYO6XCKfj237aOICeHW6CM43Qb9MBWpWrUxSAwLy7t+M989f6hotjtEUTu8vboAwzLNioNntQre2AnLuIEKYaO/vik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TQdmp/V7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQdmp/V7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732568095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXlYeOLU4oFXvqovS4V5YzUg2MzzvE9IQ02L3dWn00E=;
	b=TQdmp/V7HYcVf+oUtLOg0OTNibJmDO6V8Tlo5CNsyZbG5hkJ9UMtTXc3HNB3UxbSMCP3s5
	Up+5adlsW3nAIGZpaKHA4QajROx/0fuEaIAKMc5UHkXAATSH5p9edfMlENNj1lGJUVivx9
	Boz8/OJgoFG5YY0ekQPLupSkEazGfRk=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-aeCdy_hIMWmx_Gj_w7vGqw-1; Mon, 25 Nov 2024 15:54:53 -0500
X-MC-Unique: aeCdy_hIMWmx_Gj_w7vGqw-1
X-Mimecast-MFC-AGG-ID: aeCdy_hIMWmx_Gj_w7vGqw
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a78b04470cso54193225ab.0
        for <sparclinux@vger.kernel.org>; Mon, 25 Nov 2024 12:54:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732568091; x=1733172891;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXlYeOLU4oFXvqovS4V5YzUg2MzzvE9IQ02L3dWn00E=;
        b=auuTN9jUxHqFDRoCX+cujChQPK0jttVnsm4OgNJPZ1pGSUcTNeRsUnC5uOwojdiRmt
         vlfmPdnf5Xtx64xkj7Ag0LV+1m4enSVer33Qvg8pnp8WxEYxtVWoARcWmPU5yfftIKC4
         ZW5M97Iq4/BcS244eW/baU6xL10CiuKjxxMvyM3b6+Z5bdOhqEyh7m2xk9TqyFmet/Q4
         yS0ZPUqouxKy+7Tp3+cTIq6/FJUo6haUunz3RTslv+05I3WnuoIs2nq17a9gzyfujaqI
         PfSYNVUac3eqfn3ycDykSXkDu2/9NeDrt80SSNLWViaDe6ekOiTpPUaUQ+sg8DQ22KHN
         9e8w==
X-Gm-Message-State: AOJu0YyXP0da/Wh29CgtSqrAnt6HJRGDtz1Z0s7W7puEa8JTmgdFjb2D
	IlYzufecbkWO8e+7njEJu703qQV+8eJMcE/IKJA1WU6IOsaphQz77o6Rd6EKa8ntbquOzz5gEKb
	B2S945Q4VwjCKxi0IxRMGz7EN0ZeKiJkB5xYg6jNMUgcAVNZPp7Zlt7xU2rZY8E7OpvM=
X-Gm-Gg: ASbGnct4ct7l6U2TQ+nmlS0dFFkjF2r05LMbqs8kAncdjHNEE7+tcn0xdRgTdj0fOGT
	7RWSf8pUfJHVYMFIT2dJI+JKQ88qcY1KylB/tQgQci+G2EJFiaOjZR+tR4hT0RmnEeG5IO915K6
	aGtUHRQUMvbGH9nU+iavnHRbZdqVvJ1E7ViGsox5gsJeSYsDttGdH0UdbNF2uThV44Ajb1k2JBz
	wsASEC8xzs7wpF4YxcYmyPtVqWPvILHXSbuXNSw/jD6x82XLS3xdcJXHeti9rKQku3sKG5sXuAG
	uU5DHhyG5lLzluW0qr8x
X-Received: by 2002:a92:cd8b:0:b0:3a7:acdb:bba1 with SMTP id e9e14a558f8ab-3a7acdbbcd5mr88391535ab.10.1732568091321;
        Mon, 25 Nov 2024 12:54:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2OPuDbfEZwRc71nZMt8IBM7SpoizaQ/nKYjayi2HmctgMXcafVqelE4xIlz2UnR/Ohd0j+A==
X-Received: by 2002:a92:cd8b:0:b0:3a7:acdb:bba1 with SMTP id e9e14a558f8ab-3a7acdbbcd5mr88391335ab.10.1732568091044;
        Mon, 25 Nov 2024 12:54:51 -0800 (PST)
Received: from ?IPV6:2601:408:c180:2530:d041:4c25:86b8:e76a? ([2601:408:c180:2530:d041:4c25:86b8:e76a])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a79abbebb7sm20193135ab.24.2024.11.25.12.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 12:54:50 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <88f47cea-baba-4673-9bd7-7b7c3f421008@redhat.com>
Date: Mon, 25 Nov 2024 15:54:48 -0500
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
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>
References: <20241009161041.1018375-1-bigeasy@linutronix.de>
 <20241009161041.1018375-2-bigeasy@linutronix.de>
 <7656395b-58fc-4874-a9f3-6d934e2ef7ee@roeck-us.net>
 <20241125085314.1iSDFulg@linutronix.de>
 <b776ca37-d51c-47e2-b3bb-aee8e7910630@roeck-us.net>
 <20241125174336.8nEhFXIw@linutronix.de>
 <c77c77d4-7f6e-450c-97d5-39dc50d81b1a@roeck-us.net>
 <20241125181231.XpOsxxHx@linutronix.de>
 <72991b83-173e-492e-a4aa-5049304c1bd0@roeck-us.net>
 <5d269249-afd1-44f5-8faf-9ac11d9a3beb@redhat.com>
 <dea92bd5-65e5-4c5c-bc93-5bef547c935e@roeck-us.net>
 <2a940822-b4d4-43ea-b4f7-4294043b76ea@roeck-us.net>
Content-Language: en-US
In-Reply-To: <2a940822-b4d4-43ea-b4f7-4294043b76ea@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/25/24 3:23 PM, Guenter Roeck wrote:
> On 11/25/24 12:06, Guenter Roeck wrote:
>> On 11/25/24 11:33, Waiman Long wrote:
>> [ ... ]
>>>> Fixing that finally gives me a clean run. Nevertheless, that makes 
>>>> me wonder:
>>>> Should I just disable CONFIG_PROVE_RAW_LOCK_NESTING for sparc 
>>>> runtime tests ?
>>>
>>> If no one is tryng to ever enable PREEMPT_RT on SPARC, I suppose you 
>>> could disable CONFIG_PROVE_RAW_LOCK_NESTING to avoid the trouble.
>>>
>>
>> SGTM. I'll do that unless someone gives me a good reason to keep it 
>> enabled.
>>
>
> Actually it can not be disabled with a configuration flag. It is
> automatically enabled. I'll have to disable PROVE_LOCKING to disable it.
>
> config PROVE_RAW_LOCK_NESTING
>         bool                    <---- no longer user configurable
>         depends on PROVE_LOCKING
>         default y
>         help
>          Enable the raw_spinlock vs. spinlock nesting checks which ensure
>          that the lock nesting rules for PREEMPT_RT enabled kernels are
>          not violated.
>
> I don't really like that, and I don't understand the logic behind it,
> but it is what it is.
>
> FWIW, the description of commit 560af5dc839 is misleading. It says 
> "Enable
> PROVE_RAW_LOCK_NESTING _by default_" (emphasis mine). That is not what 
> the
> commit does. It force-enables PROVE_RAW_LOCK_NESTING if PROVE_LOCKING is
> enabled. It is all or nothing.
>
I think we can relax it by

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5d9eca035d47..bfdbd3fa2d29 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1399,7 +1399,7 @@ config PROVE_LOCKING
  config PROVE_RAW_LOCK_NESTING
         bool
         depends on PROVE_LOCKING
-       default y
+       default y if ARCH_SUPPORTS_RT
         help
          Enable the raw_spinlock vs. spinlock nesting checks which ensure
          that the lock nesting rules for PREEMPT_RT enabled kernels are

Sebastian, what do you think?

Cheers,
Longman

> Guenter
>

