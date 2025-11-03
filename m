Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990412D5432
	for <sparclinux@vger.kernel.org>; Mon,  3 Nov 2025 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185955; cv=none; b=XQp451KEFGYl86pT30SCOmCzg+zAFPoAIRdmYCxCAKsqKJGQPHBGuIEKh8+7GC5T6Lf3/a9cLotG02W6utppvrDxzP3kvI1nWoT1dKI4f4sP3GDxd4AsGD2t1nExGWWIRPlHc5i/5NuQuQIHrYEpIE6DuMcxLL9V/m5qUwwQ2Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185955; c=relaxed/simple;
	bh=JLZsTfOQxbmf1yQ6RbEFbJ/4JPPfHYrqTcg1BYiIM1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bay1EMD71fmChS1adDPZ/qXkXZwpeEgCed1CfE9rxnID+wsnjZmaf39CnXG2SjFGMBnMU8XnWFE/CeRuYxJL0EqZa9JcRBXTUkYedHuU1BjH+fmfRwfHw8zCo2OBNEdJLxBlkGC0F+b9Wv4HhTtdJPdwtxIcTT/iYEETaffzu9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I8WPIVXf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wk89wNlb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8WPIVXf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wk89wNlb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762185952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h7zqPFP4se4OIaFzLrGpOU2VTLQJoOSY+ZZS4O5etWY=;
	b=I8WPIVXfQ8hstwRzvy+5Mg0KF7C8NqbZsAaxFu8pXwPEf+YQtKL2P41CzhhJSLWq+gg9Gz
	f+goi73XTGqnZnVhEL0jhgOPpeNzSCshLIp0h3t1S5KsG1TSDlfZL939/3GvuJ7sHS676c
	0CVT8U+Euf0gNc9xr87UdlMCvEb6Emc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-VLpms7D6Mc-ITSllOiXVYw-1; Mon, 03 Nov 2025 11:05:49 -0500
X-MC-Unique: VLpms7D6Mc-ITSllOiXVYw-1
X-Mimecast-MFC-AGG-ID: VLpms7D6Mc-ITSllOiXVYw_1762185949
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429be5aeea2so1881274f8f.2
        for <sparclinux@vger.kernel.org>; Mon, 03 Nov 2025 08:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762185949; x=1762790749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h7zqPFP4se4OIaFzLrGpOU2VTLQJoOSY+ZZS4O5etWY=;
        b=Wk89wNlbqK7prn4mWjXdjR+xD+VafA4v8zYM6/LtDPVChB+8aUitsvpns34EnGc4Rl
         wfbrS+YegsVr/4YHq15OgDe3pCLJKtUaQLuGpiHtyg7S7IDmbNKw3ZHCq1d3xzDXPuQ+
         q7cJz8tdlC1wvn9VB7/EzmX97bgUYQoJczHE/SuQzALOQ3cXySnCYbyLRdvPoq8p9rJe
         KlruBUMZAVCTX2CLZ5bUNFDyjkm4P78o1Fadnga14mWYchwP34OL/yz6SpB8yV7A6MRb
         GZJKGDvx5R4ekcCcXKP70W6PL2jCg0LB/OgUfF/l1+g0jmyNSxDWPdyiFah8j8u9D5Gx
         v9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762185949; x=1762790749;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7zqPFP4se4OIaFzLrGpOU2VTLQJoOSY+ZZS4O5etWY=;
        b=mTiK/1/CxwGdaAOH1zxA47ikxJ+y/ZXxQWJlZblLwjeM01n1O+V2WgAmXCUdcy3fiF
         OKPOUwY3fVo33l+r3UTexRJERrKK25uNkfOhQp+bI9RTTmm0G+er9UNlJDi1agz4R12O
         TWcE96wl0LnxjXJvP78i/o0fI8KUopqlbqS+ZDYXkvCXtkATZ0AVpUav3CDuvYKyxBRm
         dzxVdiJBRieYV2V5H8KFwaBdO/qsjataiVZxpLhjCAd8n9YCfg1WKZpVdBw3YT2v49mW
         X39jCBlhexqi3EYxk6lrxglMwvOiVMw264BMPlz3XuuP/V6GlnFnlT2sUHgCkn8A6lXN
         ShaA==
X-Forwarded-Encrypted: i=1; AJvYcCU6axAJjokcs9tHMiTyJVCwJPctnxJanWcZidcvB7si/n28FVzvGtBx5NPklgVkqP2fcLuSAxFVk0Rl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1g1QJL/E2gjrcw4aJpiW4bqR2Ub1BAF7AgA+g7xU/T+TD8pqR
	6T6R0GbyfKwC+tc6FUpqnXfStSILN57W6PWVVuQof4I2ehlhZobGl4O2sM/lhnDADLzfxTFbp2b
	v5yawCIm+wQxLIoKU+kiYt6gA/1szVbyR6HsyQUg21tkTtrFxFI8F6lYyq+O2P6I=
X-Gm-Gg: ASbGncs1wPqYYtLi/wkQlFCANR754tbEFL40T6heF0CTJ5IRJ2lsGRBi7oqqH1hoC0K
	jgYptInng3m2X69Nf9+7GDg0z2VN++J0dBfqfXlUuaCPzVf5lIVJn5B0fbFFXx876W/T+W5t4+i
	cGnRaib7cd82pzcJ2t1o/kynUBMOt4jsuPn7+C864PkCnUj/lzj4z3nNbI6vQGhC72Si4W+IWnF
	aOKAzsB53cK2T1R61iivuGG6W+f+luN0Dk5QAI4Og8aIenJGFbUyb5DbsMdE10vOIJYGB+v2UIg
	lhnoir2icBsm0WnwLdIkwAsMEjOPjnKrVXD/bNakYyPJwgTcStSXlqZZOuGuZAIqnFcr0q3IP4c
	Fcf+lUfbhapu3l1+bOMhoi0Xwb4Y4p5cawH1chAwLy3bFpPHv8buRfNmjdm59aZP1mlH1eutG+E
	1L2w+CwrlPgo6JT6SRF1cJSG+gW9Q=
X-Received: by 2002:a05:6000:2411:b0:427:928:789e with SMTP id ffacd0b85a97d-429bd6d583dmr11477158f8f.61.1762185948307;
        Mon, 03 Nov 2025 08:05:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFc7QNXPV2goDccZBoudQ7Gvk8PWg7e8ZaWNXwQcsQ4X2jdmxCnoJTtoWX7k3mSPaCwOvUqEA==
X-Received: by 2002:a05:6000:2411:b0:427:928:789e with SMTP id ffacd0b85a97d-429bd6d583dmr11477100f8f.61.1762185947708;
        Mon, 03 Nov 2025 08:05:47 -0800 (PST)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c102dfd2sm21748638f8f.0.2025.11.03.08.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:05:46 -0800 (PST)
Message-ID: <05e2062c-1689-44e7-9cc6-697646ca075d@redhat.com>
Date: Mon, 3 Nov 2025 17:05:44 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/12] powerpc/mm: replace batch->active with
 in_lazy_mmu_mode()
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
 <20251029100909.3381140-10-kevin.brodsky@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251029100909.3381140-10-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.10.25 11:09, Kevin Brodsky wrote:
> A per-CPU batch struct is activated when entering lazy MMU mode; its
> lifetime is the same as the lazy MMU section (it is deactivated when
> leaving the mode). Preemption is disabled in that interval to ensure
> that the per-CPU reference remains valid.
> 
> The generic lazy_mmu layer now tracks whether a task is in lazy MMU
> mode. We can therefore use the generic helper in_lazy_mmu_mode()
> to tell whether a batch struct is active instead of tracking it
> explicitly.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---

I suspect you were not able to test this on real HW. Some help from the 
ppc folks would be appreciated.

LGTM, but the interaction with pause/resume adds a bit of complication 
on top.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David

