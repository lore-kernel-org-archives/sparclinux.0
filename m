Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B7A1F1521
	for <sparclinux@vger.kernel.org>; Mon,  3 Mar 2025 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991906; cv=none; b=IP6CymDSVtzELcb9YSmx8TDL1S0MBB8UpTPHz72EqC6gNTzQpW08oDZ35UtbhgUyrvpgoKxsRIJ1hnWK4Ur7wz0kggv/W9Jj5i4Gy2lnn3XgEuba8VE7fVnd8gMb+PtuiDouPomzGE2fycjSIfO4B3REXcS6mWNHTzEN4X7ZLKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991906; c=relaxed/simple;
	bh=K2F9EW+qiAEiFc0wnbOIq8DzI+iuGYeb0zxsjfA4rl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCU0l8f8VynTQYafzZxTJCZW7awDnwqZ0f+Ryjad9JGpyxAxp0PAcQJ1N7ve1SR5iEXAUO8HKZArIQl/MUv0C9K2vY8ettY+pEyqsUaGlHFRQmH+87loAhpey0V+UJdnDklz4JNKMyYjl3pjqlA0Xx1qE1Trn7lRyiFaEaEUALo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QUoiugZ0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUoiugZ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740991903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PqwL+v3kSKyO1WWdOm3Dn4wn0YpaEHuXEacsy1CmEn4=;
	b=QUoiugZ0fGJhoerEjgAilebXVtRUAy2dvaXL7kZo462V08akpR54iOxPyrW3EUTHXqeOL4
	luaBP/NwIDuMe94C/rjsC2+CbSChQo5bi2TPwGf/cd3YoMZUkZ61h5PSh/QDkDVsKL2y0z
	smRKIFSX3035uXgxEM8u9yaK8Y0aXeI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-yVkHXVMiPdK2EFj2os5cbQ-1; Mon, 03 Mar 2025 03:51:37 -0500
X-MC-Unique: yVkHXVMiPdK2EFj2os5cbQ-1
X-Mimecast-MFC-AGG-ID: yVkHXVMiPdK2EFj2os5cbQ_1740991896
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3910cd78330so163395f8f.1
        for <sparclinux@vger.kernel.org>; Mon, 03 Mar 2025 00:51:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740991896; x=1741596696;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PqwL+v3kSKyO1WWdOm3Dn4wn0YpaEHuXEacsy1CmEn4=;
        b=N4pjl4EHYtGyzbCKRSTk1Q0cG6ClucZWvLkoH6liCkw0wjYWy7MbE22URjEOdM6ojU
         FMMr/1OW/RTVqG6/IkMhxar1nH4lqJw7WqJ2nVImohwb+XxEJYIK/k36MOMunC8/rVcm
         /t/oGyk3QPrsDs7e9kqOAH9t26ze+9UBEAdzkyCuCcsk9pz3BF0EXx45+UEKGD1qejKV
         q1E+6SLfboxmMXjJwdSFxN3aNSS7Ry9fCdZR4kv03spJFBwWFIJG30VoTDqC43zzwW0g
         1jZX5blzVb1NTHViSHjZWyDTU2XaQgdFAc7AFwjxQGv1KUVJpK2Bx2ZdczipTNFbrrl+
         X9Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUyUDdtAxFaL9irp6vxj/X0Mwz0miilSrpQel5p69JWpAdCVP46k0Ezz0fs0FwtwDTBAGfjJsmAuKvO@vger.kernel.org
X-Gm-Message-State: AOJu0YzOQRG8Aapslys+togEcesAu5zjG3KVMvnVvwzXD+uhPrxGkfUF
	E0CbqxxuVqpVDF3hromzl250Ddd7cEeWtdxDo914uFMdiuCqNFTQDR//tg6pYwZBkYXL8p5auzz
	Mv2h1vhlQ0m85lp7R1j+g/bVSroo7BoAWUPuXqf9cpBLsFKZfCSlv0ovpvm0=
X-Gm-Gg: ASbGncsSsoW1jJVssZO/wBxun7KMlcy7NszPoOLnslDzi5LqSg/wWPx2dO8gqBXcq+h
	IDUKt/lk+O9SYZXPyorhC4r3JiKLKrfIq2q8zOd2abIgqHbORvgikcPBCZPqH5FSh8Rw5buFGDb
	uiM/chaw4W3PoC6jYRdfHZG8uxWquUcxo7A4mZ2NAiUl3k0VtQ5BqJDpozLG3l0m34f7/lGjUJb
	Wplyq6zoRWV3i67n/QY0txCmWSqPobisId+4tqfuMzotKB2SUJe6yNi8r5tpa1XzEwiLvQCc2hT
	tqXNWwJiV8YOLZwnUJL7fsXuEwnbHi8pNDrpOctgvOemvQ3x9/0qUsrs4ohsTK691AYT+UxPZ/2
	4UwjhGArt76qHceGaeg+HTrWB0H3gQD/5w4uIC47AtIQ=
X-Received: by 2002:a05:6000:1565:b0:391:9b2:f48d with SMTP id ffacd0b85a97d-39109b2f8ebmr2190201f8f.33.1740991896370;
        Mon, 03 Mar 2025 00:51:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiqrTykXg+NUm0kAtziKqLGECEKRMnAI63MS2I3V/WDMW5AEnsAxTN6b4wA0iNetJkZ/Gt5g==
X-Received: by 2002:a05:6000:1565:b0:391:9b2:f48d with SMTP id ffacd0b85a97d-39109b2f8ebmr2190184f8f.33.1740991895948;
        Mon, 03 Mar 2025 00:51:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:9600:af27:4326:a216:2bfb? (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844a22sm13875701f8f.74.2025.03.03.00.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 00:51:35 -0800 (PST)
Message-ID: <4af46304-cf25-4c4a-8e4a-3a566193ca62@redhat.com>
Date: Mon, 3 Mar 2025 09:51:34 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] sparc/mm: Disable preemption in lazy mmu mode
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Juergen Gross <jgross@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20250302145555.3236789-1-ryan.roberts@arm.com>
 <20250302145555.3236789-3-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250302145555.3236789-3-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.03.25 15:55, Ryan Roberts wrote:
> Since commit 38e0edb15bd0 ("mm/apply_to_range: call pte function with
> lazy updates") it's been possible for arch_[enter|leave]_lazy_mmu_mode()
> to be called without holding a page table lock (for the kernel mappings
> case), and therefore it is possible that preemption may occur while in
> the lazy mmu mode. The Sparc lazy mmu implementation is not robust to
> preemption since it stores the lazy mode state in a per-cpu structure
> and does not attempt to manage that state on task switch.
> 
> Powerpc had the same issue and fixed it by explicitly disabling
> preemption in arch_enter_lazy_mmu_mode() and re-enabling in
> arch_leave_lazy_mmu_mode(). See commit b9ef323ea168 ("powerpc/64s:
> Disable preemption in hash lazy mmu mode").
> 
> Given Sparc's lazy mmu mode is based on powerpc's, let's fix it in the
> same way here.
> 
> Fixes: 38e0edb15bd0 ("mm/apply_to_range: call pte function with lazy updates")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   arch/sparc/mm/tlb.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
> index 8648a50afe88..a35ddcca5e76 100644
> --- a/arch/sparc/mm/tlb.c
> +++ b/arch/sparc/mm/tlb.c
> @@ -52,8 +52,10 @@ void flush_tlb_pending(void)
>   
>   void arch_enter_lazy_mmu_mode(void)
>   {
> -	struct tlb_batch *tb = this_cpu_ptr(&tlb_batch);
> +	struct tlb_batch *tb;
>   
> +	preempt_disable();
> +	tb = this_cpu_ptr(&tlb_batch);
>   	tb->active = 1;
>   }
>   
> @@ -64,6 +66,7 @@ void arch_leave_lazy_mmu_mode(void)
>   	if (tb->tlb_nr)
>   		flush_tlb_pending();
>   	tb->active = 0;
> +	preempt_enable();
>   }
>   
>   static void tlb_batch_add_one(struct mm_struct *mm, unsigned long vaddr,

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

