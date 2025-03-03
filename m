Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705A01EFF9D
	for <sparclinux@vger.kernel.org>; Mon,  3 Mar 2025 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991931; cv=none; b=Mco6X2Bvm7Ha6RhSjnKVHogw43j9k/xgqdmJrvqZ9+xLyUBUyDHadEx45UyMDJTFz0wotkCy4ajSUFqFbOTAsJNxVGSVK/+ICE2tf7uGX+L7NIaAZbdxdHoEjPZVZdd+2AO++A5nArSDCahGJfJUiGSpjQNoDgtlkbkx2wbDea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991931; c=relaxed/simple;
	bh=ADaSFdz0OaQQDH4JkFJQ/We+kOUWVf10zyDiFzjjGag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J3+44pHkDT8KJjdQrUFaMDNOJEei9bJT2xJSZVgmJoTfX5VD+9D0E2V3lAQ3G/fAHr5uUTH3uUgq3U0P5L6v7WdpDAH5bNB/F9UUG/6GEVHeATGQRXhhxZzzrmUd79FSWdHqB/FMA+2gnhNzynP6IOICCMdOiCB0Wh08NjUyIVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ch0B7EVn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ch0B7EVn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740991928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AD0BhRUSKUKI9Ce/AzRts0lu/YIF74G3wU8/3/wY5qk=;
	b=Ch0B7EVnNUwmpgbaRRTpYgublMZMDGr8ZDFmF1QKmSXDi9SIp9sUE1RjziV7tMJh5uYhen
	ep43hwGpv3M6T3Yq3DWB8cF/s2ku7AK8BZDoYEyCdzbqOX94suLjAy4Ur8tGbipVzqudQG
	GdZIgbpotgmsy0/Qjoyu0MhG6gPo88Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-50Yh5DugPmeWpu3MJ8ov_g-1; Mon, 03 Mar 2025 03:52:06 -0500
X-MC-Unique: 50Yh5DugPmeWpu3MJ8ov_g-1
X-Mimecast-MFC-AGG-ID: 50Yh5DugPmeWpu3MJ8ov_g_1740991926
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-390d73c20b6so2773558f8f.2
        for <sparclinux@vger.kernel.org>; Mon, 03 Mar 2025 00:52:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740991925; x=1741596725;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AD0BhRUSKUKI9Ce/AzRts0lu/YIF74G3wU8/3/wY5qk=;
        b=r/chsqDP4MiU0lUBacBx22iPo0qAizmWHMvY1nYq4+bqfqobcuDk/+M4TtPNpOxAsL
         aFg1oJ+9rc6UQ5oCax1gpktrMV7/03vPZ94cEPgSYPyzbBk283yXhW+mplAUq0akTZGe
         NGdS7X0/mvsFOBZHNajkQ+G9armLm2QdEMYg5Q8zAy/+PaYQNyLlN+u7E/jeccdsS33+
         ag8+UMH+2OZPg2rgDASCcCjXLO+Ri16TZMRrzjRdM3s/duvM+Bqauneawtlzd/xBukVC
         gFmkbhM77BuY3MThCAHj7ezXi7nBuu8LYa3d/PCrSYNHi8PSJ+oDw4ozDvdCs8GragT6
         P0IA==
X-Forwarded-Encrypted: i=1; AJvYcCUGqCF6wQpD3xJ7vQyLUABFHIGxGeMYZEmnpbtm0nyLgYqPfRMqUV0jKOT8iSYNcgURCST+JimDlL5f@vger.kernel.org
X-Gm-Message-State: AOJu0Yxci8cgsTfbUvEPsQK0n9qwPfiSnOrw9RbveDshjVaeAZQhFFxA
	ZCfnjCRuv5pUjEumqVg5MrKHaoiG4NNPZXtUgNjs95yij27VAv/zF1DaJfK9HvAAwJauF8XjVKm
	Yy1FMkfJQgKkz3c7SSybqohPyPvGzd5d7J3M2RS5hovm+t2knEXdavaDaUwM=
X-Gm-Gg: ASbGncsk7rcfesZCDnG/bHcbeFvfSGAQ18dXpg7Adz4+FHHc2QfaZG4rB0/SdyRni+3
	oKmfeQIIOaAadj6P9U874JlExwq8pqyAkXePXAeoyeKZ9ThJ+fAnJ8y86+inasqShydXLpKCaUF
	n86uIXn4BWXzx9+yHK+Ux0wRh4q8KY8+S//TXlfUUzbJjVeBgNAL5KWfoAN0/Sb935KRmaBro6F
	SPjlTMxJqbORR4FkhFRQW2qJPtluONwMUMSQJ4i5hfepl5451H2cXAgj/d8E91T0qx+xUNHUpkI
	2V+fDg2bQ2nBUKMpbsJVU+7Mn/sf0YVHMIZDj1ZUkgFxGUWLRmkh7NG2ERTjwQP6MLaGhgxVeyL
	cQFeJkPsPcA8QUMAPx0bUBMDhr5czsP4yraeBnOWKb/M=
X-Received: by 2002:a5d:6d89:0:b0:390:f88c:a689 with SMTP id ffacd0b85a97d-390f88cadabmr5755542f8f.47.1740991925673;
        Mon, 03 Mar 2025 00:52:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3sqppN55tl5C45qFk6psMYLYRvi/O7tktf2gORA/1QEyfox9eLasRdl1uBOhQIOjNr4hTpA==
X-Received: by 2002:a5d:6d89:0:b0:390:f88c:a689 with SMTP id ffacd0b85a97d-390f88cadabmr5755517f8f.47.1740991925267;
        Mon, 03 Mar 2025 00:52:05 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:9600:af27:4326:a216:2bfb? (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485e13fsm13623429f8f.100.2025.03.03.00.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 00:52:04 -0800 (PST)
Message-ID: <0db13472-d056-4e41-a42c-f4ca60483176@redhat.com>
Date: Mon, 3 Mar 2025 09:52:03 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] sparc/mm: Avoid calling
 arch_enter/leave_lazy_mmu() in set_ptes
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
 <20250302145555.3236789-4-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250302145555.3236789-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.03.25 15:55, Ryan Roberts wrote:
> With commit 1a10a44dfc1d ("sparc64: implement the new page table range
> API") set_ptes was added to the sparc architecture. The implementation
> included calling arch_enter/leave_lazy_mmu() calls.
> 
> The patch removes the usage of arch_enter/leave_lazy_mmu() since this
> implies nesting of lazy mmu regions which is not supported. Without this
> fix, lazy mmu mode is effectively disabled because we exit the mode
> after the first set_ptes:
> 
> remap_pte_range()
>    -> arch_enter_lazy_mmu()
>    -> set_ptes()
>        -> arch_enter_lazy_mmu()
>        -> arch_leave_lazy_mmu()
>    -> arch_leave_lazy_mmu()
> 
> Powerpc suffered the same problem and fixed it in a corresponding way
> with commit 47b8def9358c ("powerpc/mm: Avoid calling
> arch_enter/leave_lazy_mmu() in set_ptes").
> 
> Fixes: 1a10a44dfc1d ("sparc64: implement the new page table range API")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   arch/sparc/include/asm/pgtable_64.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index 2b7f358762c1..dc28f2c4eee3 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -936,7 +936,6 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
>   static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>   		pte_t *ptep, pte_t pte, unsigned int nr)
>   {
> -	arch_enter_lazy_mmu_mode();
>   	for (;;) {
>   		__set_pte_at(mm, addr, ptep, pte, 0);
>   		if (--nr == 0)
> @@ -945,7 +944,6 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>   		pte_val(pte) += PAGE_SIZE;
>   		addr += PAGE_SIZE;
>   	}
> -	arch_leave_lazy_mmu_mode();
>   }
>   #define set_ptes set_ptes
>   

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

