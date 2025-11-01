Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9380D2F6917
	for <sparclinux@vger.kernel.org>; Sat,  1 Nov 2025 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761999305; cv=none; b=LgnorEETexMbnOrz1/x6XzJggXycJIOKFwKA/dnLIh26pae60HMuJRacW/fR6pAHogW5Pu5wwO+5NqMeC/wE4Yn8voy0Dwf7fOVcQIpClKP3nZOZF2PqKko9baC/ZKYBnQ7CGuBrTK4/nwLJM9hJOLZKe/OS639aWy3MZD3slns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761999305; c=relaxed/simple;
	bh=jy2jgJkMfkDGdMVffHZ/eEz56ufPSvFanLhBPvSYzZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KG/twySlhdV/Qjpee77q6k7D2p81IUqKZLHWv4Rl9iP31TgaJIgoskRJ3uIHlaJlP8k6dfeiPBHJAk8FxX5JXLxL0vSrbUVavviGZ6PHYtVauhNIfo4d1jdbH4wVBgIMsj7joKlAqXfKkNWV16oynDi2eOsU1S+qt+Yysa8tG+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fKZuXQk8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kn7tHRPz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKZuXQk8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kn7tHRPz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761999301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Wcrewv7OssaEm3gyvMk1iF/ClvQjL5UKQAK3UbLbS48=;
	b=fKZuXQk8rqZJ/qIysx25x3joyBTIxbXB8XcPFi4J9N2Yj5njYHqulAOsRv8iz09dipV9LP
	4J9HT7fN3PKAnu21VyLqhJLDFlpJyFJf3Yp6Vc4owm6inAA4ysdfUEsA8Ofo6Xkz/qsUjo
	GDmy51tKmV2b5sYfro/FmAi3rEkEG3w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-dImEIDRTNJGmSJeff47Fbw-1; Sat, 01 Nov 2025 08:15:00 -0400
X-MC-Unique: dImEIDRTNJGmSJeff47Fbw-1
X-Mimecast-MFC-AGG-ID: dImEIDRTNJGmSJeff47Fbw_1761999299
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47106a388cfso25500315e9.0
        for <sparclinux@vger.kernel.org>; Sat, 01 Nov 2025 05:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1761999298; x=1762604098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wcrewv7OssaEm3gyvMk1iF/ClvQjL5UKQAK3UbLbS48=;
        b=kn7tHRPzwBs86VPB6gm1pXhcdzYytHCEpV+4t0+zEyItEtG2ztqMAslJfHb/sXz/BN
         DW+f52HSHOvK4ADJTWchZoWS+HjB0miewO+V8cbaRCP8rMK5Eo12b5tkkmwNcq4DIInR
         cWatbKQPXsJ6cShOAy0NMds014Ye5CoByDXODIZXHdiqSlzcqBbUAPCaRD1iRS72zf0Z
         1LMP318h6n0u73LL7s4r4crMAVk1lyTeN5mElxYkvDaYWLZB3L2Jj2AWZVSxUBwRB/l0
         zfH4k1SrnwkysAutMm6stuiiorUmiSnDRshmhBv9U/FQOIAGpx5bHL0G65DU84fodRI+
         4QDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761999298; x=1762604098;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wcrewv7OssaEm3gyvMk1iF/ClvQjL5UKQAK3UbLbS48=;
        b=oaVP4TnKWZ2alYG5XqOKrNQtHcgKACzJ+5A83fksrcIp5ibdz4UKU/37TvxjynvKR2
         PtW3Umyaj6VxRO8wWG+38ahYx2FSl1bvNCSpptKRXhYvRAMa79jfrtzi1mhJpLRJo34I
         yjdfg8zLkZPjNMsImtj4N7uA1I0MuNV8UkplpcGwJEgYcBsS76be+kcUaJSt9QBFtRyr
         I1TGsLkAfLgVppKPoR3PZuceINzr1OvCZMJlEsQpy7X3Xxrv0w7FAHz4c2VnvZ5rAHHm
         aFs72q1aYPBPR0JgeD0KENmUqenRdcJUcH2dMhqQnT8uOjeIl1k9pBCVSUKOT4XDUZGd
         iNpw==
X-Forwarded-Encrypted: i=1; AJvYcCWpFyDaf3VrGF88zbfbuu7pDdJGOGHjbgjvUE+uJxZUuwe+YG9JG/7+JWBYyZsaV+4EtNT1ohMsRiQZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxBFsxuphEzXnwSHXZWfSgVhCUsuZFqyhgND7PS5nhrgSQHaiMB
	kcTHwwVV1DpzJWfNc339a5snLVVLMW+bW0MNoHfYmGy0Cge+UVHLXGCX2QVM3NQfBoRWpOcpFi+
	IT3Aaha4lmpOnA0UJFCFESf+9EkLRAnVFMU06osaTaQJzia/wtsa+J0ngbmzlcDQ=
X-Gm-Gg: ASbGncv/ojoefVAQsybncnOKbhfhFHarIGIV6Qy1m0B7RrW0aKQbq4upqLFTcQA31nw
	nn46hKUvxVXW4JKSNu4pMpHyCoBoLi0OovQWA9GsctGQV7LV9/cGjj68IJvIkR5uSU5x1u0mat7
	6qhEEt6jhdf3NY16skvlyNybIJan1JRp98p0rC/1A52z6Ytk2zGLTArsWk/+aHjXoZNL4ejphc2
	xT2WvtWvJD90L2VDFJjT2XysTaQoYLSLZsbHIpGz7I5oqzQBuhwGtAOVNZ8TVp+vHfZBAmwvalP
	nkSc6qKNnOfmk3wuEVjGif3mk4G3k+eVTc9X8L3UM1C1AGp8FrHkjOXqUipmswLlwdfHSFfSbSj
	rqJwCkEzJIVR+tcHFIjMzz8aLRYpb8vHGLOMbUIxgWR48/m+jbRJ8tdRi3r5yyS+aOF/OblYdXd
	cSR0bBcm5TXFXvYOxZkKhG13cEehA=
X-Received: by 2002:a05:600c:64c5:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-477308aad21mr78192325e9.34.1761999298487;
        Sat, 01 Nov 2025 05:14:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpoAFpg0euM+1PM4mK/KRSGv+bWD5NPrehon1oy/C0JEyB0MU730bCFNURR8O9btag493PXg==
X-Received: by 2002:a05:600c:64c5:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-477308aad21mr78192025e9.34.1761999298113;
        Sat, 01 Nov 2025 05:14:58 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c9737830sm2218179f8f.16.2025.11.01.05.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 05:14:57 -0700 (PDT)
Message-ID: <15f832f9-b95d-4b08-8467-21a27cbf8450@redhat.com>
Date: Sat, 1 Nov 2025 13:14:55 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/12] sparc/mm: implement arch_flush_lazy_mmu_mode()
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>,
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
References: <20251029100909.3381140-1-kevin.brodsky@arm.com>
 <20251029100909.3381140-5-kevin.brodsky@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251029100909.3381140-5-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.10.25 11:09, Kevin Brodsky wrote:
> Upcoming changes to the lazy_mmu API will cause
> arch_flush_lazy_mmu_mode() to be called when leaving a nested
> lazy_mmu section.
> 
> Move the relevant logic from arch_leave_lazy_mmu_mode() to
> arch_flush_lazy_mmu_mode() and have the former call the latter.
> 
> Note: the additional this_cpu_ptr() on the
> arch_leave_lazy_mmu_mode() path will be removed in a subsequent
> patch.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb

