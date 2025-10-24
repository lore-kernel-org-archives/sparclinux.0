Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D5A3148BD
	for <sparclinux@vger.kernel.org>; Fri, 24 Oct 2025 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312228; cv=none; b=B5pwXWeCnjQqIEeHYGf6d0D8/0A9mClnYXjRTQQ+A1nsP6EF3mebIIhyKO9EhdmPxJNZhsIjLymhBWFF8pYker8XUacfW/zs5vzXJYAXUNTH+g5edGOV8KObH8oFWwo58+vViDhulMBdIvkU9hJP1vcvxqRn5vgU26Ku2GzU9ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312228; c=relaxed/simple;
	bh=u5ZdO92I797sGerRYUrQbODv8LVQgH+CM8JGzauFsEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNaIjlBHXhNsxqJ4TdbhPpMOIPymlJ5bQA/+yzpbQp7FHadmqMTb/MRhED9HUOuUxpIfRyH9dOdWe9hgy7YY1UwuFHKe7KGR55OaMwywtLtzzob5ZOe8ZNaIEhOhTR3/IHhVjwEwtk3IGEwdVo1dRPwRlz2rzjvnNQrWXltuyFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GBJupbqV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBJupbqV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761312225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9pZe05cqV5Y1PIBh8vBXPAYdFpy0cqXi9nRKa9E+n1Q=;
	b=GBJupbqVqUAUdDvfwoVXHEQvNxQNHPtqjlL0UvRrgEmCgrXPFUeEHJnCb/xs8Crcnw3FZk
	gUtMYd+FtPyTRvLNjApCbsiuZVIHD5552ZcCMNN4rJjdlqu4BJo+i1M80DJlvgHqETkMYz
	XsSVkcVh34thyORxxUUFDy0C03HtDs4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-NpnfhHQKMHuBbp8F-UEKag-1; Fri, 24 Oct 2025 09:23:44 -0400
X-MC-Unique: NpnfhHQKMHuBbp8F-UEKag-1
X-Mimecast-MFC-AGG-ID: NpnfhHQKMHuBbp8F-UEKag_1761312223
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46fa88b5760so7234845e9.3
        for <sparclinux@vger.kernel.org>; Fri, 24 Oct 2025 06:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761312223; x=1761917023;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9pZe05cqV5Y1PIBh8vBXPAYdFpy0cqXi9nRKa9E+n1Q=;
        b=l/7JLQx4RlIH5W6FKFJgfxW+qOw3Z1oTxrqc66fg69TZTFNgIHXCZdqmrW9OvOy+10
         cMeQA6Z1XzbB+p2EByMk5PNRbwQBvVVvMJ68HoK2BeBxhV/u3P1fw4lOdDXn9uOwa5h8
         QavPp9WxSkllt5OCjRvTz4GiVS0wuvuX0E9lLVrG0Cemn6b8IOdxkNg64y8Gvc/HPHjo
         0GgiC4YCW4BgBEEv5fuL7yZywgpwipz2ucRA6gcRtT1zYw4s1uIb21mJW0uP9RFiLy62
         8vIk9bbMq+SUPVp2fUcwTQaVOIejjpD6m/i7aFEZDrm0chewDs7CHclZU14GUO12jRbX
         XoEw==
X-Forwarded-Encrypted: i=1; AJvYcCWw73MyVwFD2SQpmrS1VW0MLHBcqiMSj+GiXjoO7eu5zXYo/fEgqvCq8GCZmCBVw4JdoJrGOitVchnT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1yQkZAA/I7QawlcWAlkLqjkXdarsCHszKBKrIMgKfVmtZOZM0
	bnarxQIokhbZo+uvmj5eIdUOO4mUwKvOv6JCAU8Khz7MXAluxVY8HnyFilNEnQDcmrEXvlHiipJ
	jibcbXuvDv9Su74Y0d3tZHDZaVwD2ORqpWlXqHQaY4V/ywwnxEt6An0/bNLIKmnw=
X-Gm-Gg: ASbGncsSTPymdmu5xlUT6OqKKFPyxnf+7h09iVKxRN4k38vFR/L2GUsKhqw2saxkZ7p
	kd8VNmaTt4r33a6UdHlB8E3mTZmTdyiZGKPjXRxm0f5ROLDt0dC+j1lNP8I8sXRSN5bkX0Npxv5
	o0h+QFuIC05jfa3oTKDPVOddMl5igQ9PYplSYyX5hkZKy+bcDZVpU/iDyjLsJ5+LOtXvH41LZTZ
	M2dZVOprqwDd00R/XnLtkOY0ZfvCK7oMZdbIl8KuGPEkrFF85Efcb2kOZLnL7MpEYcee8nGnq++
	4QJjfpX1D/OuyJMBaL9tvWZsw8Zy0UL9NWDM94VZbOLO3ivviaxlDrpV11A3zPeyIIUBnLXDlE9
	yGfQgQRipOCA3GcNwEnR3EmoATFeUTa69YbmGNWS4NJ1jIWIZBtHqPZsIEoU/ECTBeNB5a9JRWi
	wZNfJ65F5m19gragkApOu7+hHrXBw=
X-Received: by 2002:a05:600c:1d9b:b0:46e:38f7:625f with SMTP id 5b1f17b1804b1-471178771b6mr180789545e9.10.1761312223050;
        Fri, 24 Oct 2025 06:23:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtGsLBVTNfj/FZoaJq9YDf0YbzbT70oZVwx4vja/yfyCx4XWjsWfYr2kPeTBeEcFsrMCFiZA==
X-Received: by 2002:a05:600c:1d9b:b0:46e:38f7:625f with SMTP id 5b1f17b1804b1-471178771b6mr180789265e9.10.1761312222639;
        Fri, 24 Oct 2025 06:23:42 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898ec1dfsm9461004f8f.43.2025.10.24.06.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 06:23:42 -0700 (PDT)
Message-ID: <af4414b6-617c-4dc8-bddc-3ea00d1f6f3b@redhat.com>
Date: Fri, 24 Oct 2025 15:23:39 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/13] mm: enable lazy_mmu sections to nest
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
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
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251015082727.2395128-1-kevin.brodsky@arm.com>
 <20251015082727.2395128-8-kevin.brodsky@arm.com>
 <2073294c-8003-451a-93e0-9aab81de4d22@redhat.com>
 <7a4e136b-66a5-4244-ab07-f0bcc3a26a83@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <7a4e136b-66a5-4244-ab07-f0bcc3a26a83@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>> + * currently enabled.
>>>     */
>>>    #ifdef CONFIG_ARCH_LAZY_MMU
>>>    static inline void lazy_mmu_mode_enable(void)
>>>    {
>>> -    arch_enter_lazy_mmu_mode();
>>> +    struct lazy_mmu_state *state = &current->lazy_mmu_state;
>>> +
>>> +    VM_BUG_ON(state->count == U8_MAX);
>>
>> No VM_BUG_ON() please.
> 
> I did wonder if this would be acceptable!

Use VM_WARN_ON_ONCE() and let early testing find any such issues.

VM_* is active in debug kernels only either way! :)

If you'd want to handle this in production kernels you'd need

if (WARN_ON_ONCE()) {
	/* Try to recover */
}

And that seems unnecessary/overly-complicated for something that should 
never happen, and if it happens, can be found early during testing.

> 
> What should we do in case of underflow/overflow then? Saturate or just
> let it wrap around? If an overflow occurs we're probably in some
> infinite recursion and we'll crash anyway, but an underflow is likely
> due to a double disable() and saturating would probably allow to recover.
> 
>>
>>> +    /* enable() must not be called while paused */
>>> +    VM_WARN_ON(state->count > 0 && !state->enabled);
>>> +
>>> +    if (state->count == 0) {
>>> +        arch_enter_lazy_mmu_mode();
>>> +        state->enabled = true;
>>> +    }
>>> +    ++state->count;
>>
>> Can do
>>
>> if (state->count++ == 0) {
> 
> My idea here was to have exactly the reverse order between enable() and
> disable(), so that arch_enter() is called before lazy_mmu_state is
> updated, and arch_leave() afterwards. arch_* probably shouldn't rely on
> this (or care), but I liked the symmetry.

I see, but really the arch callback should never have to care about that
value -- unless something is messed up :)

[...]

>>> +static inline bool in_lazy_mmu_mode(void)
>>
>> So these functions will reveal the actual arch state, not whether
>> _enabled() was called.
>>
>> As I can see in later patches, in interrupt context they are also
>> return "not in lazy mmu mode".
> 
> Yes - the idea is that a task is in lazy MMU mode if it enabled it and
> is in process context. The mode is never enabled in interrupt context.
> This has always been the intention, but it wasn't formalised until patch
> 12 (except on arm64).

Okay, thanks for clarifying.

-- 
Cheers

David / dhildenb

