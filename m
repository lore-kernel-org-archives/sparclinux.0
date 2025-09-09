Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D2232CF8A
	for <sparclinux@vger.kernel.org>; Tue,  9 Sep 2025 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428131; cv=none; b=c/t7ZAsbVn5cS1Igp0qUm+O8Y84m7XtJYjnh4Iv/fG3JC6/3tNIMQfJwKTguHTlH88271HcG5ko1Tk8NwHnLXnjbAuKB5gLR0n8kyZU0hz6XdxlopFwhkHhAa4DQOHz1yBE+fC2R0eOM/1p/YsQPTCKa81JXGPXeexTTX3xDbDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428131; c=relaxed/simple;
	bh=1BZnNKXeGB+6L5jUpmOZ9oeM4h6hqyksOwPtwXHYHuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mX+TwsyJNxEsnTOoa+PcGIiCbTfV88dUjXtwDw2TRc4w2y15ev7owx4uMWbFIaCm4Y6nE9IWpzOhQOA3M6HqH2o1emDewxArVBmtMYJ+ZwEyoR5WGHTDQdDsLzsykBCkX65H+rfzMgsPbeFuBkq9Ba8iDWOly+iSKEnaHcmIWuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f2SWvfkM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2SWvfkM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757428129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D4QRi7hDsi9OF+uq4PfR985/VTCgDFYnf6cObBRAB+8=;
	b=f2SWvfkMQUOZdt3NP39GIKxjgDtCvpFGjWyi/FhhuKmXC8ir85mkJXL3iC467iJZDVWUh/
	u0VJbxKjREulLhnXnB34nnjL6lngjlIoVXPvnhtC8bm8e0UwANcbQ4/bf8f/L/gRfHVSyT
	cNyisjVfSQWlQ43aiT082Lm3/UTSOqg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-MUEOUyojM3uAPIoRwSNsJQ-1; Tue, 09 Sep 2025 10:28:48 -0400
X-MC-Unique: MUEOUyojM3uAPIoRwSNsJQ-1
X-Mimecast-MFC-AGG-ID: MUEOUyojM3uAPIoRwSNsJQ_1757428127
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3dbf3054ac4so3395097f8f.3
        for <sparclinux@vger.kernel.org>; Tue, 09 Sep 2025 07:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757428127; x=1758032927;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4QRi7hDsi9OF+uq4PfR985/VTCgDFYnf6cObBRAB+8=;
        b=lF3GXJ4paGb4aJ1o9ZmfJfIuG5Xfi6ArK+oYD8QGN397/MFyqyfyKff4JZddP0jpt1
         eofDeCml3phrQ461cinCy/v5m0VUIbOH/4kTnbgdw58g0U0GHtaNMr+hjIANy1OTMls6
         CIkJzwrYvL6NnzXQcZ6XdC3Y1quTNTO/5WcL31cX/fvfYjvaFf2Kih7hxh8sFbhsRfTR
         lqbaHPhpDThd41RoGPNgurl0WT+OSarp8Kt5U0bgmOGBe2TPZzUM567Ki5w2qgpxhX1W
         0lYtYsKx94NYYOrYWYtMAT6xzufonrmUh1IEE2kuOHeRPQlY4SI7xznvozq5x7pZ5WgY
         lk2A==
X-Forwarded-Encrypted: i=1; AJvYcCUfmMfJXy3nILEkasskooa6epF11o0SYJXZve1RqPtr7U8TSwx6HG3P+BuCt9geUzWb8BDsZ1ROJIqx@vger.kernel.org
X-Gm-Message-State: AOJu0YyK6kYYOUuVX0cgwKVtJs5skNRVQkgtzMswwamzIRyqhgXD+et0
	FBG+ss5itj+2/fuyibAMIWJVVnlcud7ivRG2bYYhoPGLFwDwKPW9DOVGFmmFO6eKcr8gTbylAWe
	Q1IvM6gn2jEAu3IOOLqkhDkddVM6UKf2ccSu0T+pRFngmc4oOC2ChWWS3RT+6iBg=
X-Gm-Gg: ASbGncvGryFRjISikuttHOkgLwCp/AYYzAvzyxz7Szre35jj7eS0Xc7iGwYdByF6V10
	gi7o5rVhi4/Aqc/ZjSvVbOlUFgEk96Zx00930nFoKFfBjoOAqPJbYT2focg0imv1AMK8ILHGzmh
	fg2/x99pkk/SalDV1DO2txhGTFKzm+QbXTTx8m4LFZA9/d2Z+9XzXc9DsFwcvAhNa7Ts9z6Ee5A
	2cPuF68ytP3GJiUMV3AkS618imjOG4avcHj3RXl5EEt+6eEFuOrKbjXEq+peloFihUoxxITsxmR
	q6FvNUMOUQPNgQKzG8tPXgVOLiM2oUbXrbTeA9IBELfIKAsv6fTGWuZ3tx5M+fxA1XYXgf1pXg0
	PaLTqUcmAKmlSbkBpddFbQEPIkV8m9+z9n4gh2i5lpnh7pw++ItmQ1qxxHfGw4zSHZ0Y=
X-Received: by 2002:a05:6000:40dc:b0:3b7:9c79:32bb with SMTP id ffacd0b85a97d-3e643741232mr9630218f8f.44.1757428126465;
        Tue, 09 Sep 2025 07:28:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD6jqBYDWaPdeHuZLYdYngedHnwSRwLh5c9r19frL6eN+mcEvQ/xbzM3ef+SL3HLWhKdEABQ==
X-Received: by 2002:a05:6000:40dc:b0:3b7:9c79:32bb with SMTP id ffacd0b85a97d-3e643741232mr9630184f8f.44.1757428125875;
        Tue, 09 Sep 2025 07:28:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:9c00:d1f6:f7fe:8f14:7e34? (p200300d82f239c00d1f6f7fe8f147e34.dip0.t-ipconnect.de. [2003:d8:2f23:9c00:d1f6:f7fe:8f14:7e34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521be57esm2887963f8f.2.2025.09.09.07.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 07:28:45 -0700 (PDT)
Message-ID: <29383ee2-d6d6-4435-9052-d75a263a5c45@redhat.com>
Date: Tue, 9 Sep 2025 16:28:43 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] mm: introduce local state for lazy_mmu sections
To: Kevin Brodsky <kevin.brodsky@arm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
 Juergen Gross <jgross@suse.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org
References: <20250908073931.4159362-1-kevin.brodsky@arm.com>
 <20250908073931.4159362-3-kevin.brodsky@arm.com>
 <d23ea683-cca4-4973-88b1-4f6fd9b22314@redhat.com>
 <ca2054ad-b163-4e61-8ec4-6f2e36461628-agordeev@linux.ibm.com>
 <e7acb889-1fe9-4db3-acf4-39f4960e8ccd@redhat.com>
 <2fecfae7-1140-4a23-a352-9fd339fcbae5-agordeev@linux.ibm.com>
 <e521b1f4-3f2b-48cd-9568-b9a4cf4c4830@redhat.com>
 <47ee1df7-1602-4200-af94-475f84ca8d80@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <47ee1df7-1602-4200-af94-475f84ca8d80@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>>>>> Can't we just use an "enum lazy_mmu_state" and call it a day?
>>>>>
>>>>> I could envision something completely different for this type on s390,
>>>>> e.g. a pointer to a per-cpu structure. So I would really ask to stick
>>>>> with the current approach.
> 
> This is indeed the motivation - let every arch do whatever it sees fit.
> lazy_mmu_state_t is basically an opaque type as far as generic code is
> concerned, which also means that this API change is the first and last
> one we need (famous last words, I know).

It makes the API more complicated, though. :)

> 
> I mentioned in the cover letter that the pkeys-based page table
> protection series [1] would have an immediate use for lazy_mmu_state_t.
> In that proposal, any helper writing to pgtables needs to modify the
> pkey register and then restore it. To reduce the overhead, lazy_mmu is
> used to set the pkey register only once in enter(), and then restore it
> in leave() [2]. This currently relies on storing the original pkey
> register value in thread_struct, which is suboptimal and most

Can you elaborate why this is suboptimal? See below regarding the size of task_struct.

> importantly doesn't work if lazy_mmu sections nest.

Can you elaborate why it would be problematic with nesting (if we would have a count
and can handle the transition from 0->1 and 1->0)?

> With this series, we
> could instead store the pkey register value in lazy_mmu_state_t
> (enlarging it to 64 bits or more).

Yes.

> 
> I also considered going further and making lazy_mmu_state_t a pointer as
> Alexander suggested - more complex to manage, but also a lot more flexible.
> 
>>>> Would that integrate well with LAZY_MMU_DEFAULT etc?
>>>
>>> Hmm... I though the idea is to use LAZY_MMU_* by architectures that
>>> want to use it - at least that is how I read the description above.
>>>
>>> It is only kasan_populate|depopulate_vmalloc_pte() in generic code
>>> that do not follow this pattern, and it looks as a problem to me.
> 
> This discussion also made me realise that this is problematic, as the
> LAZY_MMU_{DEFAULT,NESTED} macros were meant only for architectures'
> convenience, not for generic code (where lazy_mmu_state_t should ideally
> be an opaque type as mentioned above). It almost feels like the kasan
> case deserves a different API, because this is not how enter() and
> leave() are meant to be used. This would mean quite a bit of churn
> though, so maybe just introduce another arch-defined value to pass to
> leave() for such a situation - for instance,
> arch_leave_lazy_mmu_mode(LAZY_MMU_FLUSH)?

The discussion made me realize that it's a bit hack right now :)

If LAZY_MMU_DEFAULT etc. are not for common code, then please
maintain them for the individual archs as well, just like you do with the
opaque type.

> 
>>
>> Yes, that's why I am asking.
>>
>> What kind of information (pointer to a per-cpu structure) would you
>> want to return, and would handling it similar to how
>> pagefault_disable()/pagefault_enable() e.g., using a variable in
>> "current" to track the nesting level avoid having s390x to do that?
> 
> The pagefault_disabled approach works fine for simple use-cases, but it
> doesn't scale well. The space allocated in task_struct/thread_struct to
> track that state is wasted (unused) most of the time.

I'm not sure that's a concern. Fitting an int into existing holes should work
and even another 64bit (8byte )...

I just checked with pahole using the Fedora config on current mm-unstable.


/* size: 9792, cachelines: 153, members: 276 */
/* sum members: 9619, holes: 20, sum holes: 125 */
/* sum bitfield members: 85 bits, bit holes: 2, sum bit holes: 43 bits */
/* padding: 32 */
/* member types with holes: 4, total: 6, bit holes: 2, total: 2 */
/* paddings: 6, sum paddings: 49 */
/* forced alignments: 12, forced holes: 2, sum forced holes: 60 */

Due to some "arch_task_struct_size" we might actually allocate more space.


Staring at my live system:

$ sudo slabinfo
Name                   Objects Objsize           Space Slabs/Part/Cpu  O/S O %Fr %Ef Flg
...
task_struct               1491   12376           24.8M      721/25/37    2 3   3  74


I am not sure if even an additional 8byte would move the needle here.


Worse, it does not
> truly enable states to be nested: it allows the outermost section to
> store some state, but nested sections cannot allocate extra space. This
> is really what the stack is for.

If it's really just 8 bytes I don't really see the problem. So likely there is
more to it?

-- 
Cheers

David / dhildenb

