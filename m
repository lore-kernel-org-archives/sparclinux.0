Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2524C2F5A16
	for <sparclinux@vger.kernel.org>; Sat,  1 Nov 2025 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761999289; cv=none; b=QzrD0vuurpjTGrq03lcozzbL8BhqCw5eVkJk1bB/pqdOx3GOItkoh4ETaDhIO0PSEBz9oojp0GL1QMLIpjkO8KVQ+Cb0CsZo6lzXCafnTsv9o4zgn0h9QZDr9ah8ZRJlZDPe4SKt/2Es1SsFCIA4K4uRrA/ewJM0Ul+wPbZZvCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761999289; c=relaxed/simple;
	bh=jy2jgJkMfkDGdMVffHZ/eEz56ufPSvFanLhBPvSYzZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMfjrM6RFvMfy/19P9oM2qAHexnyXxKuafHVUkxM5cm/uIgQTz9mZHAfWBz8TTSRqAg/4JU+/ljjK7p+9LKbQRVIkCX1+IAhacalTpo6mH08In8hN+eAZqg0I7i3R24qEuMA9vti9ZdhqXcB20guLzrPSeROmx7l5P/cWYjXNbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I5s+LJuj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tTonvGR6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5s+LJuj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tTonvGR6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761999286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Wcrewv7OssaEm3gyvMk1iF/ClvQjL5UKQAK3UbLbS48=;
	b=I5s+LJujy807p09M01y7bbwR77hghtjGqVcUfTYCe6756sWnWbyhfw7Bse9KFnHs++fOdr
	0ho7H2mIq3BhaHBaX16Y44n8GcJ+rUwxhPnPSawSMAuwOmQwLqG3O1fZUisbzPyuEOWC6+
	flIaBZP3P6ZKrhcu9q6YmCl1ngS6riE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-3LLkS7WnP0qCeOz5z0_1_Q-1; Sat, 01 Nov 2025 08:14:45 -0400
X-MC-Unique: 3LLkS7WnP0qCeOz5z0_1_Q-1
X-Mimecast-MFC-AGG-ID: 3LLkS7WnP0qCeOz5z0_1_Q_1761999284
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477171bbf51so13764405e9.3
        for <sparclinux@vger.kernel.org>; Sat, 01 Nov 2025 05:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1761999284; x=1762604084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wcrewv7OssaEm3gyvMk1iF/ClvQjL5UKQAK3UbLbS48=;
        b=tTonvGR6XAikxvVrzkb5UQGIQjR9FP/ansXBtzL87UvcCS0Jv1LmSRXhB2cXjlNDSL
         FA5Pw9W2lm8O58lFhg0dra2wYp2y9v0L/P5Y/XG/6LaHl1ZcKwmO3CA1/XrDCoa/njET
         DJNJVoxY9Xevl5egVqyJT+FcdojTv/cLK9ZI3qJS3tDrCuIdfbm1bckfX4/BhmILKvgP
         28YZiaV0VMuRUBwgBhIINd2BIvZZhb/kVls9CuDdDOrs8EsgEQOOWUWzDivHStKPt2s/
         /JS8psP2M/+qNwGOxtPfXgwvWKCENI8yx4+3UnwD7GbkxlpuzobD4GyDaEIr9VW4/5ff
         capQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761999284; x=1762604084;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wcrewv7OssaEm3gyvMk1iF/ClvQjL5UKQAK3UbLbS48=;
        b=NXoAFpeNqtJ1azDnl0Ii1fVoRX74bXp29xtjrZbg4Ha5sUo3n2jAkY160LfqhSmtBC
         9SqHcUd6QGyMFPPxb8g0c04ttkRO1JFpFv1n3j6JKUpLY4NLqTo7GywR7DSATjM7bHLV
         LcApP5iuZYZO/uBPsCbmxH9xkgI2hU53VyIqj22rEcC0eL3aeBcQK9AzBdT21XfN3DbD
         Wz5VzQkVQia7GHJq3T2eWg6srmalDo6nxbkUQhyD3ie2klcd+NDqJzW4BitcexzMlXJF
         BqKPehrUFNuJV7z3oRhYEzspguqQjToMCjkU6SSHjLH4xyUn3P879SbLIEpqxuEVaKSQ
         BQrg==
X-Forwarded-Encrypted: i=1; AJvYcCVaCQgaYApBE/spyvnnTt0+CoROcGjUyc2JPn7iXogQie4+0jqFWEKB3t/bQDqisJcWBjK7PdyB9muK@vger.kernel.org
X-Gm-Message-State: AOJu0YwFn/Awp3z7POxRW5xSf8Wks3kIq4/UZ+gdUlOxWsGgsRbA+vub
	+OQ5hGOAfdTcqtIuiqZnR0nGdTZaQOeQO6qmnIdI1NnoB6MtwxD6kNstEKEvGid8rD+1lnLxmCg
	diG9Vw6mSn43HSsGSSX7/lubkpdvP8e2BVpV9Sy7+FhAw3PYK5oBN69BDrul6AcY=
X-Gm-Gg: ASbGncs6mAsMfkACX/N6xsdznVYz6OMXzXcxRHsTmjpjd3qITht7dh3yAh2VsXk8hSh
	BYkrYlldOtfLFsHO3ESbv0PfGPeY5lZCAm1amq/m5CuwvW/uTKVjgvh9H8OSsdi0tmNm+jAz2ti
	FPoFgXWercpzrGnZrKfxeW4+qMdTUdXw2hdym1h4Gsjl0D5hetlktIcIzsR2PcsmXTtxnDv2iEt
	7jDMdues5ZIOB406ymLmQ85UcOZpTmq+tTRtstwmkhy/+YOzCP5EarQCjHwShLYGOUYP4Iw20Cj
	fz1GQuLYxrX0Z4MdDY5vW6blDyVQef9UIgExS3p01luQ3mJXASS7n0m11eSV03Ejhx4mxt5GTal
	BMkyaOyh26xdlJMU+lqLt2iViLKTBUavF3w9Smvah7Pt5tAJqGHxx1PsYAUkivjEpV8Yv8afMfY
	L2bOWBzdhlV6Nx6lF6kK6rJbjRDNc=
X-Received: by 2002:a05:600c:a0b:b0:476:57b4:72b6 with SMTP id 5b1f17b1804b1-477305a6db5mr69965035e9.8.1761999283756;
        Sat, 01 Nov 2025 05:14:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFQqut/W+Hh2058Mo2KRwgSobvPqBB9YeSBGPmcQlX0YmXFdyt0oSxc1X9BsoNgscSeoohIA==
X-Received: by 2002:a05:600c:a0b:b0:476:57b4:72b6 with SMTP id 5b1f17b1804b1-477305a6db5mr69964795e9.8.1761999283199;
        Sat, 01 Nov 2025 05:14:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c110037asm9428834f8f.3.2025.11.01.05.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 05:14:42 -0700 (PDT)
Message-ID: <c2859944-734f-4ba0-8b49-e0df23e1bdbf@redhat.com>
Date: Sat, 1 Nov 2025 13:14:40 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/12] powerpc/mm: implement arch_flush_lazy_mmu_mode()
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
 <20251029100909.3381140-4-kevin.brodsky@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251029100909.3381140-4-kevin.brodsky@arm.com>
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

