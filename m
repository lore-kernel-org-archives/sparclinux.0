Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DD734DB7F
	for <sparclinux@vger.kernel.org>; Thu, 23 Oct 2025 19:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761249180; cv=none; b=WyTce2lCwbS05Pz4cy+5RDqrSpK3ToExbqT8M/FNAU7tBNBuLb0crmx/aF1GT2TsdiajRlVN/BT1mvEBpfyECGChf760xUHF7rRMdh7T9DO2zaCZcnIHabV1l3JCICO4MS9GNPn+1+DEEcMmVqPUMNKcJVWSr8A41VnjQJKeflU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761249180; c=relaxed/simple;
	bh=0+MvlPoxAN1U1+vn/p62PDLkCn9a2D0s7BsJhmIos8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpeoBZx2x68v811aJtiWCdFSgqumc4qxexC6TtGNr2l0UeHaYDPAYh9EdkDMYyjfofDuUzZId8/RgMa1wVWuab6BUYTXZBqzhuESnUpJvUM5FZNiFToK40ZkxHD7l+y4JPKI8jtLI7ktRocO7RNb8nyRlOkLhAWIu0S55wJtio4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OrsR79zP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrsR79zP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761249177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lu8DXyr9e+174zCCLKyjaz62dq3PQM0ss4FpqXHktAg=;
	b=OrsR79zPxDTTcYjCpvym0L/LCuSjCZ19rXRX5x8xIg/IjiFD0Z+U1rgYVoQ52wuAFh3i5I
	YkUuNoQ6KaveSHE0yExl6xi8FkrL/HMGvz6wRae/OZlTy3CdzMGbVEa5aAh/ukn/KOI3R2
	71Fado/B76mpKrT7Vp34fQ9JgHCU1lQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-X80QSYH_O_-B29RaYBA6GA-1; Thu, 23 Oct 2025 15:52:56 -0400
X-MC-Unique: X80QSYH_O_-B29RaYBA6GA-1
X-Mimecast-MFC-AGG-ID: X80QSYH_O_-B29RaYBA6GA_1761249175
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ecdb10a612so710986f8f.2
        for <sparclinux@vger.kernel.org>; Thu, 23 Oct 2025 12:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761249175; x=1761853975;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lu8DXyr9e+174zCCLKyjaz62dq3PQM0ss4FpqXHktAg=;
        b=Linib9LkpwIFuv+7DO+z0it/DXg5N8IIjycIYoe6OK9/aKeaCa5v9rue7sRwCJIxfF
         FppJST1s6vo2wQThqp7bO+JFoQuUMS0BGhAJJZO+F+YQJUWhcYv+WY9qyL+Xh4Dy8yqy
         I7rp1IDeWXH4CFsbMuwVyO2edgWf02zC4Hvkn9xwKKXzLjVNgZpZ/DSihTfrWFSaJaS8
         0f3VnK1nRSTSRDvmO5Wv1S2of4XWZo9OZV8TAv0dQkbPjDTJfgLTrHyEk/PYjjBsXzr/
         taewJNl4dtOVE8nBerMoxDupuFaTANxfNE8KEuZP0IgAlq9/FEQZbrLSaDZOBv5O2lAk
         OTFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUqaRJF3CKVdik/cqvDd+a8qXIgzx9h5tLuZ9CQ5f7JSNk7plPuS+bslzAWzcT/66nJUOo23D0ma2m@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu0dE+EuA88RzPToZkN0IvE2bumNqmUmuDrZJAA7l1XP7DG5wF
	AJEbW1mm9X0k1M/Mp8GEl2GDwxJGewTZxPMkKdnrVwK5wW/5VzOFbXq0TPoSXEJIz2PdE/88zkT
	VIGaFBujKJfhZiOgE5UcYTvcalRnZDkhmSkGsCf8AufIDInXx0P7dVSbLLpr56OE=
X-Gm-Gg: ASbGncs8L6OjPhdYRxBf/sFn0ABGXP+aHt5t92Qz/YlyEbbYWg6lwOG20xp/RtmMXiw
	mF6mxR4SIMXps0I+EZGIaM44PxAWDEIbXRkKHEaky9KPn+MPzPSjH3ODVUhVgmqqf0RwheRhAh0
	vEA0Ue8uyfLbDZ/q+dYAO62tXGQFAj6oAW0kn6f3z5QoG1mEMEPD/9LuMjU+JuxAZpFE8Dt/9Ks
	yINmU/dzDxv4+d4e1I5jqTajPc66l/6ryFdA5sZU6TcB3tldDK2RWgIRgxk4KeQzFhI10i31JDU
	tWzNKLzrWRvo6jDB9hRMggWyCwzbp43wVk6AfD6CntztLv6fGSDk7EU3K7CdAwB/N3UtmY7cS+b
	fUhajifcJuZEufGqsb5mGt3fUDsSWGKo+Ihh6s0yofxu0eQ9HUcBkcQefgddX7mfJaB/BbC3v5U
	LGIoEd998CEmwPTgKCM/lr4l0lJJY=
X-Received: by 2002:a05:6000:2911:b0:3eb:df84:62e with SMTP id ffacd0b85a97d-42704d7e9f9mr18404405f8f.3.1761249174905;
        Thu, 23 Oct 2025 12:52:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7U9VemhLNzul4GpnpOHuDDlV+F0CKxszXYKlJ5dnYJh0XFPFjlnxCdm5Nc2+v3zIM+vRJGA==
X-Received: by 2002:a05:6000:2911:b0:3eb:df84:62e with SMTP id ffacd0b85a97d-42704d7e9f9mr18404377f8f.3.1761249174285;
        Thu, 23 Oct 2025 12:52:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897ff3f5sm5656361f8f.22.2025.10.23.12.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 12:52:51 -0700 (PDT)
Message-ID: <73b274b7-f419-4e2e-8620-d557bac30dc2@redhat.com>
Date: Thu, 23 Oct 2025 21:52:49 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/13] mm: introduce generic lazy_mmu helpers
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
 <20251015082727.2395128-7-kevin.brodsky@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251015082727.2395128-7-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.10.25 10:27, Kevin Brodsky wrote:
> The implementation of the lazy MMU mode is currently entirely
> arch-specific; core code directly calls arch helpers:
> arch_{enter,leave}_lazy_mmu_mode().
> 
> We are about to introduce support for nested lazy MMU sections.
> As things stand we'd have to duplicate that logic in every arch
> implementing lazy_mmu - adding to a fair amount of logic
> already duplicated across lazy_mmu implementations.
> 
> This patch therefore introduces a new generic layer that calls the
> existing arch_* helpers. Two pair of calls are introduced:
> 
> * lazy_mmu_mode_enable() ... lazy_mmu_mode_disable()
>      This is the standard case where the mode is enabled for a given
>      block of code by surrounding it with enable() and disable()
>      calls.
> 
> * lazy_mmu_mode_pause() ... lazy_mmu_mode_resume()
>      This is for situations where the mode is temporarily disabled
>      by first calling pause() and then resume() (e.g. to prevent any
>      batching from occurring in a critical section).
> 
> The documentation in <linux/pgtable.h> will be updated in a
> subsequent patch.
> 
> No functional change should be introduced at this stage.
> The implementation of enable()/resume() and disable()/pause() is
> currently identical, but nesting support will change that.
> 
> Most of the call sites have been updated using the following
> Coccinelle script:
> 
> @@
> @@
> {
> ...
> - arch_enter_lazy_mmu_mode();
> + lazy_mmu_mode_enable();
> ...
> - arch_leave_lazy_mmu_mode();
> + lazy_mmu_mode_disable();
> ...
> }
> 
> @@
> @@
> {
> ...
> - arch_leave_lazy_mmu_mode();
> + lazy_mmu_mode_pause();
> ...
> - arch_enter_lazy_mmu_mode();
> + lazy_mmu_mode_resume();
> ...
> }
> 
> A couple of cases are noteworthy:
> 
> * madvise_*_pte_range() call arch_leave() in multiple paths, some
>    followed by an immediate exit/rescheduling and some followed by a
>    conditional exit. These functions assume that they are called
>    with lazy MMU disabled and we cannot simply use pause()/resume()
>    to address that. This patch leaves the situation unchanged by
>    calling enable()/disable() in all cases.

I'm confused, the function simply does

(a) enables lazy mmu
(b) does something on the page table
(c) disables lazy mmu
(d) does something expensive (split folio -> take sleepable locks,
     flushes tlb)
(e) go to (a)

Why would we use enable/disable instead?

> 
> * x86/Xen is currently the only case where explicit handling is
>    required for lazy MMU when context-switching. This is purely an
>    implementation detail and using the generic lazy_mmu_mode_*
>    functions would cause trouble when nesting support is introduced,
>    because the generic functions must be called from the current task.
>    For that reason we still use arch_leave() and arch_enter() there.

How does this interact with patch #11?

> 
> Note: x86 calls arch_flush_lazy_mmu_mode() unconditionally in a few
> places, but only defines it if PARAVIRT_XXL is selected, and we are
> removing the fallback in <linux/pgtable.h>. Add a new fallback
> definition to <asm/pgtable.h> to keep things building.

I can see a call in __kernel_map_pages() and 
arch_kmap_local_post_map()/arch_kmap_local_post_unmap().

I guess that is ... harmless/irrelevant in the context of this series?

[...]


-- 
Cheers

David / dhildenb

