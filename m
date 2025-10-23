Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6052C0F83
	for <sparclinux@vger.kernel.org>; Thu, 23 Oct 2025 20:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761249756; cv=none; b=ViajZGlN40B43eZZuhtQGgM2AjYp0V31LvMhC545V/lWl4Ro1l7ks9M1G3aj7+2mWoqw62QhO9QWYtch2mT6sqtUnL7QP41ziwWBdyZMtoQFd/nM+54rT3HvrwafGGcP4J9+47JwwPiVRRxdmNQQKvx58bQUL/Qef1SGwweDCfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761249756; c=relaxed/simple;
	bh=gqYyJRYTyw1c6geq3zHKwBnJ5/1lEskxou871hP1uWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txQIYD0B3rWfqG+4hWZGKQiwihcemRBrcsqE5lf/PzXjqwluBGp9svPyD5QgW+/FiGwARKzuhoK3NT3SGqNznuskX/dk8DHGigaka/oNmBmIm0ZQEdwolgvFr9DvZ3YBek+EffgYN+UC09SnvH+04dButB2JNPlcyO7kQ1No2So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E2XGvs29; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2XGvs29"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761249753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=y4TTOO2cgFz3W+ccXXdCSitozQat0wJ24BVv7Ue1CUk=;
	b=E2XGvs2959tlE5Irc7FxY3Kz5vPem/jgKlW0/qAtNOKQNCR7NELGDJD5+ix/sm5Wg5mvwn
	13+Lmht31QdnUsafjOImbOL+Z8hv2Zvt00e8tq4dx4AEGR+SaT0QBgKqVQyxly/I26eep4
	z+ae2Ga4vUDp3pIdJ69F8W7oxv7Tzdk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-kXXB9TOZMzaTwFWH5yXZ1w-1; Thu, 23 Oct 2025 16:02:32 -0400
X-MC-Unique: kXXB9TOZMzaTwFWH5yXZ1w-1
X-Mimecast-MFC-AGG-ID: kXXB9TOZMzaTwFWH5yXZ1w_1761249751
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-471168953bdso14435705e9.1
        for <sparclinux@vger.kernel.org>; Thu, 23 Oct 2025 13:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761249751; x=1761854551;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4TTOO2cgFz3W+ccXXdCSitozQat0wJ24BVv7Ue1CUk=;
        b=lQsm1najx+qQAhSjYYc4fcVfRGDm0HQF/85vC8+iCTj6mlRGBfgcAEUs3SdZ9OO2wv
         cvaSlDcpXIBldXb1bt+2ZblUrTeRUG5TYYhiXjy37nGEKwy/qdi+2EcOfzbH+D+Qx7pB
         A5O9F6yNUPY3vNdUtkfVuzVGboZtkp71sepI5ZaAin3JygcGgkGYljkZrVnRaOXUOZWe
         0N27q35x8fA53gmznGAUGnW5JltF3GSN20BpgUOF1Q80JCDB1pVIUAHZUfahBO6kLHLU
         Kh8yw6gelIq5YL8r2EuvBEJKQZlkzgp7l+Q6nOiOFB7uTL/AateT3L9jtAuQ/SsExnF4
         iqyw==
X-Forwarded-Encrypted: i=1; AJvYcCU7ybrfVDEf4pzUPhdBSq0hIqNS+L8wIkW9EeFWCZwbnv+H3ek74ukFQrkTXqYGkdKMIwI55FXiX187@vger.kernel.org
X-Gm-Message-State: AOJu0YxR4yJ6rjOMqEWSe9BL+gexs8jZ6khl6Qzuyoknbj0gpDuoruOs
	42lqTrA0Quqt/D5rxvVjBJ1f261R+xqTMlNY2PDvwmDLa1yCkDBBsgSZ9cHhhjztSTTrDAVufqx
	jFJjiTQC11oyMGl1InVDGsHda6aD/iPBLsaROtyVlh/FK7lDFMPpFaieYYIj51L0=
X-Gm-Gg: ASbGncvpLJsGt0nx01tOX8zSBIXtVsUDk7ShiV2Pc7Svwep8HS2NjUcluGmtrZ7/8Bp
	TNyXuFIqjH2ho8B/N6mcLzxkgvliOe/crQJtTELct4t0NRYvZch7IU/fwGMY0TRiH/YZ12NYkgl
	Jb3EdnuubrD3mTI3+ahCacZP/4Fyj4BnGeSHp+VjB9IFrB+nNy5yRE82U7qDkrqgOXyPIkSEP49
	XC1C/AOtRHn75Dss9No6RhcR7JQZhV1vveqY58i8LfdRrLh0h8zTze9tpKXlMNRXGq48fG8he8Z
	K+5Flh41D6DnB0gePfd1+qfpe5lH7fSN2Nt8ZYYRfGsHhVS8UGJhUAbhMBo9e+KA/KiytZIjW0P
	FbqV98aaf7PtYlwElo/ZHIS6rqDAGv/1ByJGMhWm3k/39WKBrrZNfA9pmCH3XkRkA4Fh6Plz815
	vVI972ROexupSRDxCFb5JaBU8OjzI=
X-Received: by 2002:a05:600c:1f13:b0:46e:3b58:1b40 with SMTP id 5b1f17b1804b1-475d24125f6mr1089515e9.4.1761249751037;
        Thu, 23 Oct 2025 13:02:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMw+Op04CJGmhD/YPV6zz3oVUY6+u4w9wry9vJKgjouN71r54k9F5kFdt15tjjDg/5cU58MA==
X-Received: by 2002:a05:600c:1f13:b0:46e:3b58:1b40 with SMTP id 5b1f17b1804b1-475d24125f6mr1089255e9.4.1761249750674;
        Thu, 23 Oct 2025 13:02:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caea0468sm54964965e9.8.2025.10.23.13.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 13:02:30 -0700 (PDT)
Message-ID: <8d5243ec-3edd-49a6-ab51-16643a709d84@redhat.com>
Date: Thu, 23 Oct 2025 22:02:28 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/13] powerpc/mm: replace batch->active with
 in_lazy_mmu_mode()
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
 <20251015082727.2395128-10-kevin.brodsky@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251015082727.2395128-10-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.10.25 10:27, Kevin Brodsky wrote:
> The generic lazy_mmu layer now tracks whether a task is in lazy MMU
> mode. As a result we no longer need to track whether the per-CPU TLB
> batch struct is active - we know it is if in_lazy_mmu_mode() returns
> true.

It's worth adding that disabling preemption while enabled makes sure 
that we cannot reschedule while in lazy MMU mode, so when the per-CPU 
TLB batch structure is active.


-- 
Cheers

David / dhildenb

