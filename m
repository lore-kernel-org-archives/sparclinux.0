Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FA41E0083
	for <sparclinux@vger.kernel.org>; Fri, 24 Oct 2025 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316937; cv=none; b=FvRpBkbqD2qLrqQmGuF2tnKRdNIjGspyV2soutAkUbt0H8x7LISLUxV86xf6FBu4xUCvpVLH2PnNBewjBXTapi/Ea9K9NnCaV8w6UsXjGgVCNA9aE5mRtGuZhSeOjv61IBhpTm9mEsG4Ps3tIN4PqE/8L7Y7F3gT6ZD8Umlvwe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316937; c=relaxed/simple;
	bh=l2EZw87VFqVJzZnNo/fYFjBF8SqRb8rubT+mIBMWFtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bB7jM/Kl0ijdIh8vank0HToql+rRnlgVyWrZ7NInIHAsBOMq53PSXAJaiLZGo0pGinIUcysl1hWLBLevRS7JB4Sc25DmGFI4Q3HeZExfulO+xR9OMgK0RW68Z9srhpINZHGi40USSZi18JB1lqCmCE6Wj3LFSBe0cb2HG2zOQtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=afWfOESk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afWfOESk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761316934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zuMO3Gm17MlJedQR/JASyV8PKolk4umw1nTXePw16OU=;
	b=afWfOESkDtwzZGo5pJQet3VG9cTO8tHC6nwtnUSbHnQCxnd/HlMR2cIApLL+Uwa+PxXcjz
	W37bi6MvfgCmAfN/4tb2YmpA/N1HCCnpCo/lXLmjdZ5NazVIotlX7gYZ/oz5NMF8o7xnGt
	zR14fWmmgnCkUjZ1edWTe67axk80fZU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-JaVEaDDQNYuWf3WldLYsmQ-1; Fri, 24 Oct 2025 10:42:13 -0400
X-MC-Unique: JaVEaDDQNYuWf3WldLYsmQ-1
X-Mimecast-MFC-AGG-ID: JaVEaDDQNYuWf3WldLYsmQ_1761316932
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-472ce95ed1dso13921335e9.3
        for <sparclinux@vger.kernel.org>; Fri, 24 Oct 2025 07:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761316932; x=1761921732;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zuMO3Gm17MlJedQR/JASyV8PKolk4umw1nTXePw16OU=;
        b=wVUxbsnPPDuZCZinqx7qsOtEKQZ09q6YRVZ0hWEF3wknFBMBZ6DYzrXtwSjAAanMUz
         7njsI3ejJpD/1HGhY8IpFS4jvgkqKGLZlxNXtp4zo6ZjoAnUeiWvhra3nchulR8dSAoH
         4QjkFswkoivOscMvXL6EkamTE5L5GO4AHsWAtxMSe6FCfFqoN9V7Dz48ZNoA5atl0Wn6
         +GSJVm2xvUsq1UvDyqBVRCZRb/RiOTGYKDkVX2xlgmt/7eO8FbkuaYY6mM7A9ALZpiwn
         rj6b402y5004LOAycPeZtrrKkBA0IKa0MSDSKy3ycw/RJHJY0AApkZYQXZe/wnRrf35B
         K8YA==
X-Forwarded-Encrypted: i=1; AJvYcCW1581aCKh3zQaSxTzrqW7pA6UgQH9AuzBEz9ZEH19nibyETaySoZn1zD96QlwFvhWwij17XHLqyNNj@vger.kernel.org
X-Gm-Message-State: AOJu0YwmtAuoGxyZ7J3fqyRtcQ/PYKZj1Pwh/ETFe0vjbRCKV7AQ/yq1
	lRyaucGDr0uYi0wLcdNGWXfHuxIOPxOEh9b7kx8JCeFBJgTs5FIKzAfjtarWKRA9vFXd6jJHOh6
	m0GNi5Wq0NzV2iG4GKN+eBz/N1LOEA0EGxMz6IWvz2jqVI4DBD8Gk5WI3/BGwpHA=
X-Gm-Gg: ASbGncsf+3W7mEyoY+XUFSImBPOTGVbFvyGMzj2fN+4iQRSHQHxaHJweUpnqzlbedSl
	XlLk1vd3QH7Sjqp+QoSpcqii2zQ1kDuEkfXcsEyY80JA3Ws78upd1eVosGl6UASlQflb4tBRCK1
	jk3+qpIdFlAUvg5YLPHnUH7RFuw3K0GOgxKGvJ5ffKDDqgmTRjAJdWsA0xqKdT0BI2meUA65zMf
	VK1X9P8V2pddEvQCA9+41006uMZVW4EhPhjqvAMWwVP13UAJdSCXKq3rb+0LTZaS8qIiNPmRojJ
	Vw1SHr962X0b8ZSDf+uH3hqsgblPM7DoAczlrnMVAYZ2TGnnrmYMYZaT3fokt2NMc/ZiCcUm6En
	p6ns2443F21KHEIAIfwW86WnLHqt1kcN9jwveefiwieUr3gtdrvjftiTIO3SM5Lbz05OyIZG3kA
	5BloHKNXCvcAy/fWTdPF7m5ApLLYk=
X-Received: by 2002:a05:600c:a4e:b0:46e:711c:efeb with SMTP id 5b1f17b1804b1-475cb02f5b9mr48174175e9.25.1761316931737;
        Fri, 24 Oct 2025 07:42:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVhLeriCo5qSkw1pxItKV2BmVweLyKW9vHw/E1IK25wn/MrmDSTPV2yNrI2gB0tW1RttofMw==
X-Received: by 2002:a05:600c:a4e:b0:46e:711c:efeb with SMTP id 5b1f17b1804b1-475cb02f5b9mr48173845e9.25.1761316931347;
        Fri, 24 Oct 2025 07:42:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf152absm113608615e9.9.2025.10.24.07.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 07:42:10 -0700 (PDT)
Message-ID: <5d5a85ec-0213-4af3-92a9-c02bb13da073@redhat.com>
Date: Fri, 24 Oct 2025 16:42:08 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/13] powerpc/mm: implement arch_flush_lazy_mmu_mode()
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
 <20251015082727.2395128-4-kevin.brodsky@arm.com>
 <60c55686-87dd-46d0-884e-80f7d423663b@redhat.com>
 <604f26cb-46c6-4533-8110-0b174eed821d@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <604f26cb-46c6-4533-8110-0b174eed821d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.10.25 14:09, Kevin Brodsky wrote:
> On 23/10/2025 21:36, David Hildenbrand wrote:
>> On 15.10.25 10:27, Kevin Brodsky wrote:
>>> [...]
>>>
>>> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
>>> b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
>>> index 146287d9580f..7704dbe8e88d 100644
>>> --- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
>>> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
>>> @@ -41,6 +41,16 @@ static inline void arch_enter_lazy_mmu_mode(void)
>>>        batch->active = 1;
>>>    }
>>>    +static inline void arch_flush_lazy_mmu_mode(void)
>>> +{
>>> +    struct ppc64_tlb_batch *batch;
>>> +
>>> +    batch = this_cpu_ptr(&ppc64_tlb_batch);
>>
>> The downside is the double this_cpu_ptr() now on the
>> arch_leave_lazy_mmu_mode() path.
> 
> This is only temporary, patch 9 removes it from arch_enter(). I don't
> think having a redundant this_cpu_ptr() for a few commits is really a
> concern?

Oh, right. Consider mentioning in the patch description

"Note that follow-up patches will remove the double this_cpu_ptr() on 
the arch_leave_lazy_mmu_mode() path again."

-- 
Cheers

David / dhildenb

