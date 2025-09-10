Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F163230FF30
	for <sparclinux@vger.kernel.org>; Wed, 10 Sep 2025 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518682; cv=none; b=DVaFRza9KWzZ2KVm9HV9Wo32qD4sl7sGw2RZhQAaA8S+hlGlQX0tpEpKfAxkElcUrE8BC/0fVd6D8J+v2XQb+ipfELw6rykIbDQkf281aXjyDokcn0fz7wA6cbKcoovYMpm4Dj+izCm98ym/8DnCG4EEAwpG3U0WOYPTgzvGgmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518682; c=relaxed/simple;
	bh=DcqpRz8LUZmmCaYuGXzF+m+hJKxK2j9shhVMrKrmQOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMaGcIQsmAtRTkrbJtNTvchQwRYB2IgC4focGEYcyCByeafihZKUg3mVggeqoNlxWxRpoeFnDpb+NskeyOfWmZowKpSFiPyU0IhjnMdab/IHV4gTBAmddYRMqdJb3W9d9A4l5E2Zzch27SCCJbKLY1fOOr8e9oDHSDtTVEsVGQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eKMqzqh2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKMqzqh2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757518678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xC5R7eYl9Rwp0IenYxoNNT2Mrkq2ifbsmCTO4MCCq6w=;
	b=eKMqzqh2zsQ36w3mPs9dMI6+wm5PmBpcvBuUJ8+aiQd8+RcqOXtx3xd1XRNxLqOFr6UkhI
	kkvNaGlycizo9PO/whuHE5HOQPDaeMKYXg9uZgzSqk76nQ587eRn1j2uVpCYZSASSYbQag
	0kq59j5IzHGwNhV/3CQQSu3z+feygsw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-AG_W62AVMn-EtTA2s0LFIA-1; Wed, 10 Sep 2025 11:37:55 -0400
X-MC-Unique: AG_W62AVMn-EtTA2s0LFIA-1
X-Mimecast-MFC-AGG-ID: AG_W62AVMn-EtTA2s0LFIA_1757518674
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3e68a54dac2so406697f8f.1
        for <sparclinux@vger.kernel.org>; Wed, 10 Sep 2025 08:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757518674; x=1758123474;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xC5R7eYl9Rwp0IenYxoNNT2Mrkq2ifbsmCTO4MCCq6w=;
        b=jfahsxh55pRhiyXDYJ+XzdZ/qIzqoNGXELoU6RUmecnFcGPt0Zjk3l7qWS3p+Joyos
         +DI9VNoSoNE56BDVThgqeqTvMoBM+VFK8Ao8xMcu9oxknrXszC/2xsZvUugyozwMy0SB
         XHWRTJ8sbYpeoiYh83Qair9SHaG8tseslS1zrVBMBfZJCs8gV14XTfE7fWppioIlI/H5
         h1I1Ed+HwqVLvgVimWOf/TVyIT8hUhcabfFT+HTADLLQBP/WWHZUsIEI4QmC4EV6LphU
         IcxaSCWdxU6TF42UJVwnYNlL90FGVDNgv70ZvCpO8mwFgFa+7KL/E875P1I6CMDtLQ44
         r9nA==
X-Forwarded-Encrypted: i=1; AJvYcCUNtUuWCOJP7oQ/ZjZjzeXI15qi8jxwGmLyn9oxaDzreFiriHaEfpr+hFutDjNcs+eszWLXr7VpOsgQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzPPCxeER020Lp4xNsKrKycIT3pYdOwJhJyNTR5vDprKxI+bNxh
	A+8mvsSpGRK+f8TO1bS3KIsndGJwQF7td8H4EDqZOwXcjXSySdAjH2m1ziO6FSmMnbO+PIW6ojG
	MLOzTYDaE7J5xr9pY7RijLArIHEPFP9pl+em763k6Di+wdtdtp8nQyvgt/hAXQ1E=
X-Gm-Gg: ASbGncvIe90Tezf40lCWDLcDW/X7i2uVslCbafRWVdH/C4g3F1uQC2dBWict3ufAYTz
	ukshHp1SRh6g1JL/whAlOKvtDGOJTcMw342mcqatENtngibyidxv4LrtT3odsHYX7H3Eqcczmcm
	FCQFlDB/JehOcU4a/vrv957kMLn7TrlzHK+aWf97/ATDSeSMn8LGD9KCx8ToTSIJGIr2DN1whvV
	UJeKDvg4RNn0JZ6PtDAlJNqHOAekJ4qrUWynUoWe+FUAAwPj9AeOS3lS8p0BzEHBdX8ljPu2Mx4
	lR4CRDlBxyXgQLqsQc4Es7zT1NdNuFopXm1p36/p+Y/kmYRHb6pFu6VrhZANf1arjWoHoQRIQwt
	A0Kcb2fCfLArsK8G1WyC6WBKHxE9JnMAL4fI/Nkaf7i80xLnf6i8fuZEZJo/YhP7pMG8=
X-Received: by 2002:a05:6000:400f:b0:3df:22a3:d240 with SMTP id ffacd0b85a97d-3e75e0f032cmr41448f8f.4.1757518674356;
        Wed, 10 Sep 2025 08:37:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSanGWB8lh0ls+MFHggdlE9XrwwjBOuob47gN7Go2sD22cOkG0a4ZQLy4lN4pGQUVx9DuyJw==
X-Received: by 2002:a05:6000:400f:b0:3df:22a3:d240 with SMTP id ffacd0b85a97d-3e75e0f032cmr41388f8f.4.1757518673785;
        Wed, 10 Sep 2025 08:37:53 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f17:9c00:d650:ab5f:74c2:2175? (p200300d82f179c00d650ab5f74c22175.dip0.t-ipconnect.de. [2003:d8:2f17:9c00:d650:ab5f:74c2:2175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521c9cdbsm7733009f8f.16.2025.09.10.08.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 08:37:53 -0700 (PDT)
Message-ID: <ef343405-c394-4763-a79f-21381f217b6c@redhat.com>
Date: Wed, 10 Sep 2025 17:37:51 +0200
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
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org,
 Mark Rutland <Mark.Rutland@arm.com>
References: <20250908073931.4159362-1-kevin.brodsky@arm.com>
 <20250908073931.4159362-3-kevin.brodsky@arm.com>
 <d23ea683-cca4-4973-88b1-4f6fd9b22314@redhat.com>
 <ca2054ad-b163-4e61-8ec4-6f2e36461628-agordeev@linux.ibm.com>
 <e7acb889-1fe9-4db3-acf4-39f4960e8ccd@redhat.com>
 <2fecfae7-1140-4a23-a352-9fd339fcbae5-agordeev@linux.ibm.com>
 <e521b1f4-3f2b-48cd-9568-b9a4cf4c4830@redhat.com>
 <47ee1df7-1602-4200-af94-475f84ca8d80@arm.com>
 <29383ee2-d6d6-4435-9052-d75a263a5c45@redhat.com>
 <9de08024-adfc-421b-8799-62653468cf63@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <9de08024-adfc-421b-8799-62653468cf63@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> 
> Somewhat, but in the regular case where enter() is called followed by
> leave() there is really no complexity for the caller, just an extra
> local variable.
> 
> There are complications where we want to exit lazy_mmu temporarily, as
> in mm/kasan/shadow.c [1k], but this is in fact unavoidable. Chatting
> with Mark Rutland, I realised that to truly support nested sections,
> this must be handled in a special way in any case. To be clear, I am
> referring to this situation:
> 
> __kasan_populate_vmalloc:
>      apply_to_page_range:
>          arch_enter_lazy_mmu_mode() {1}
> 
>          kasan_populate_vmalloc_pte:
>              arch_leave_lazy_mmu_mode() {2}
>              arch_enter_lazy_mmu_mode() {3}
> 
>          arch_leave_lazy_mmu_mode() {4}
> 
> With the approach this series takes, call {2} is made safe by passing a
> special parameter (say LAZY_MMU_FLUSH) that forces lazy_mmu to be fully
> exited - and call {3} will then re-enter lazy_mmu. This works regardless
> of whether __kasan_populate_vmalloc() has been called with lazy_mmu
> already enabled (i.e. calls {1} and {4} can be nested).
> 
> On the other hand, with a pagefault_disabled-like approach, there is no
> way to instruct call {3} to fully exit lazy_mmu regardless of the
> nesting level.

Sure there is, with a better API. See below. :)

> 
> It would be possible to make both approaches work by introducing a new
> API, along the lines of:
> - int arch_disable_save_lazy_mmu_mode() (the return value indicates the
> nesting level)
> - void arch_restore_lazy_mmu_mode(int state) (re-enter lazy_mmu at the
> given nesting level)

Yes, I think we really need a proper API.

> 
> This is arguably more self-documenting than passing LAZY_MMU_FLUSH in
> call {2}. This API is however no simpler when using a
> pagefault_disabled-like approach (and less consistent than when always
> saving state on the stack).

Yes, a proper API is warranted. In particular, thinking about the following:

arch_enter_lazy_mmu_mode() {1}
	arch_enter_lazy_mmu_mode() {2}

	kasan_populate_vmalloc_pte:
		arch_leave_lazy_mmu_mode() {3}
		arch_enter_lazy_mmu_mode() {4}

	arch_leave_lazy_mmu_mode() {5}
arch_leave_lazy_mmu_mode() {6}


Imagine if we have the following API instead:

lazy_mmu_enable() {1}
	lazy_mmu_enable() {2}

	kasan_populate_vmalloc_pte:
		lazy_mmu_pause() {3}
		lazy_mmu_continue() {4}

	lazy_mmu_disable() {5}
lazy_mmu_disable() {6}


I think it is crucial that after lazy_mmu_save/lazy_mmu_restore, no more 
nesting must happen.

Assume we store in the task_struct

uint8_t lazy_mmu_enabled_count;
bool lazy_mmu_paused;

We can do things like

a) Sanity check that while we are paused that we get no more 
enable/disable requests
b) Sanity check that while we are paused that we get no more pause requests.

[...]

>>
>> If LAZY_MMU_DEFAULT etc. are not for common code, then please
>> maintain them for the individual archs as well, just like you do with the
>> opaque type.
> 
> I see your point - having them defined in <linux/mm_types.h> could be
> misleading. I just wanted to avoid all 4 architectures defining the same
> macros. Maybe call them __LAZY_MMU_* to suggest they're not supposed to
> be used in generic code?

Maybe look into avoiding them completely :) Let's agree on the API first 
and then figure out how to pass the information we need to pass.

[...]

>> Worse, it does not
>>> truly enable states to be nested: it allows the outermost section to
>>> store some state, but nested sections cannot allocate extra space. This
>>> is really what the stack is for.
>>
>> If it's really just 8 bytes I don't really see the problem. So likely
>> there is
>> more to it?
> 
> I suppose 8 extra bytes per task is acceptable, but some architectures
> may want to add more state there.

Just for reference: we currently perform an order-2 allocation, 
effectively leaving ~4KiB "unused".

If there are any real such case on the horizon where we need to store 
significantly more (in which case storing it on the stack might probably 
also bad), please let me know.

> 
> The one case that is truly problematic (though not required at this
> point) is where each (nested) section needs to store its own state. With
> this series it works just fine as there is a lazy_mmu_state_t for each
> section, however if we use task_struct/thread_struct there can be only
> one member shared by all nested sections.

Do we have a use case for that on the horizon? If so, I fully agree, we 
have to store information per level. How/what information we have to 
store would be another question.

-- 
Cheers

David / dhildenb

