Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419112DCBF8
	for <sparclinux@vger.kernel.org>; Tue, 13 Jan 2026 10:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300874; cv=none; b=WmDtLf0knDANKGGulDTqqmV9ayaqfDmNU2xQRoDv4SbBwKoJaCBsQ9Jxn8TWoLkrpKHskRsOm6g10Z+NRm8M+O65Bd81KCozJUvyQU6ZkWMy41Y3JWO1Ta0IWCAFBwV9pa4SX/KiunDUrwAN+v2b1i4D/XfD7rP366i2vbjwIEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300874; c=relaxed/simple;
	bh=39NtxAeqpXvhawaLycQSgS8a7QXmm9U/xmb9EyW+PGc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RROFKQeRnfXMgYl168qeWyx1Uhewda19wThIOU6D6YRBh4qByH+z8wdjkwScCzvJoZHxgHYBXg4hK/Q+uEpzTth+4Va6fgBtH6Hc3nDxCB4kY2mFv0QfJ/WxdRUwrL1yqnr7MkXZOYSIM0x7dGNSEuAnZ+9biNW5de5SYZCNQhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6Dfb3Kb; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6Dfb3Kb"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-382fa66fa9dso50922531fa.0
        for <sparclinux@vger.kernel.org>; Tue, 13 Jan 2026 02:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768300871; x=1768905671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VgnN5gtqEe3Q1O0kTTet9lBrugKrM6JP8dsQeWrl1xo=;
        b=H6Dfb3Kbjch5jiK7RHwA/bUaEvMroNySyUYOMLoJTQL3jnpiTtfboNiog5F0hfchv7
         JoWZ7Mxkel8yNkDlBaTdhbU6iKUBg21k/srMnmTLYlCguO8gTA1SUkoZsTyKEQdUz3vu
         4RQT6yE+4RpgpjILz7E9QA/SXEbpRS3sqvy8oSh4XYuHe0byZiuuCWcPc3TRetKuhki1
         2DMsLQoBVTOZ4GiYl5oa0KfSuYy88vn4fN2/ItrwKpNsoejb/WBArpuiJ3gqQSdStbt9
         b1kcW+InBgFOdTjp1hzlsspn900P8mOHRut1wSaFpdTsIIFBUZ3aVtVI7SUL1H+bjd+i
         HqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768300871; x=1768905671;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgnN5gtqEe3Q1O0kTTet9lBrugKrM6JP8dsQeWrl1xo=;
        b=dlc2+htZ0dvcrwiwl7LLZ1XbxYqtIGkjYNx/D8f2r7FrkZ3T08qYnmIAzeR/bssFFM
         HkxExrrAqcjwJR0ShSXmQLn4t0yNtAUXRZ8NeaDSGxj1VlJB49xSBkGWk6Qv+5z3HS03
         rJ8BhAS1ifl1uookZZbAny7gGSxM85fqrvYdSW0da1X/6J9dE2yxMr2sHQaGQ3+WH9Rx
         pQT3d9IMGdxhQ99W+sHo2Q+zeJleZqQLdBo6OdM3T5unormqu3ZaFI+G1aMAZ0KQ/ts9
         WTbf86lGpPIS6KV3y/6ps4WNgFCeldHqdMBPwhBbUxd9oUtIM7kR7JJOKjR3hDoQ9Win
         pqow==
X-Forwarded-Encrypted: i=1; AJvYcCVYrmOfMtzIlPsrLg+P9AZtwvGKcOI7i9qEb+zfW9MMwCwaNTM1dxOzn+7rSN/nbiyWrNMWBn/wNy3J@vger.kernel.org
X-Gm-Message-State: AOJu0YzLiBeVPFmBjZZPMN9iM6M6XB8MokrMfJjfQLTmFW29iYoT4UOE
	aJy9hv0NScaNagLvO9JUhntjFdmEliN8dfW6gJS3UgQJgK66EJfMWji/
X-Gm-Gg: AY/fxX7XXcT+xTSvmB2QoD9gC7i+KW7wCHBpikubavYm9YuRFpC22+QTtkRDeQ5M7r+
	TCGgS8GLOeOXEwTLlwfvrg2LCFwmX20mDV2VE0wONkjEa0jR0m7yAm3DaK22nWS5WdY0PlZWfrl
	NeIklkuNthicndYWFHuRTOZazmPjjrbGj1M4frdVN9TloqVu8xjiuCm2VwCgbaM49Dh+lt6ab9O
	Mug48jKIsYxxRKX7hMCv6hsT3QxbykDwkcdb8vY9LW4Ij3y0AFP+n9NISvfsWXvXf4tygLxwL4X
	oo4CTnsOocU1x/wuk549yvqS810c1TK92XrWVX1v94ijf6+v8eywUbOqRSpS+H3TP87J0ZzmCZS
	CETYe8OJnQKWcpfjab5/JjRWiintyHV2JTOLiL+TfHvlXFEnZfZalQ1OFP1bDZKd2egJrJZs5un
	EPSz4FR5JaEiz3OPHpqg5nQV6w/veqvFUWjoYSBJTlt0cFcc15qCHY9H5Wbg==
X-Google-Smtp-Source: AGHT+IEOoK2sWcGzQ5k4NJjsFR/RmdeWAB9vvZrFfNJ0u+S6dsEFK74/fdYnqiqEV2XmHMt6sJ390w==
X-Received: by 2002:a05:6512:138b:b0:598:e851:1db3 with SMTP id 2adb3069b0e04-59b6ef05760mr8236951e87.11.1768293628066;
        Tue, 13 Jan 2026 00:40:28 -0800 (PST)
Received: from [172.20.10.9] (mobile-access-c1d2ca-216.dhcp.inet.fi. [193.210.202.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b72f3ae82sm4416299e87.71.2026.01.13.00.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 00:40:27 -0800 (PST)
Message-ID: <f861a1c6-7ec7-477c-bc42-f9aaf6724bed@gmail.com>
Date: Tue, 13 Jan 2026 10:40:22 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/29] arch, mm: consolidate hugetlb early reservation
From: Kalle Niemi <kaleposti@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: Alex Shi <alexs@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>,
 Brian Cain <bcain@kernel.org>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Jonathan Corbet <corbet@lwn.net>, Klara Modin <klarasmodin@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Pratyush Yadav <pratyush@kernel.org>,
 Richard Weinberger <richard@nod.at>, Ritesh Harjani <ritesh.list@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Vineet Gupta <vgupta@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org
References: <20260111082105.290734-1-rppt@kernel.org>
 <20260112142323.495fc43e662e7d276b0fa371@linux-foundation.org>
 <86b974d7-cabd-4913-b5f2-5b62b520e023@gmail.com>
Content-Language: en-US
In-Reply-To: <86b974d7-cabd-4913-b5f2-5b62b520e023@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/13/26 08:50, Kalle Niemi wrote:
> On 1/13/26 00:23, Andrew Morton wrote:
>> On Sun, 11 Jan 2026 10:20:34 +0200 Mike Rapoport <rppt@kernel.org> wrote:
>>
>>> v3 changes:
>>> * fix empty_zero_page initialization on arm
>>> * fix ZONE_DMA limit calculation on powerpc
>>> * add Acks
>>
>> updated, thanks.  I'll suppress the ensuing email flood.
>>
>> Kalle, can you please retest sometime, see if the BeagleBone Black boot
>> failure was fixed?
>>
>> Seems we haven't heard back from rmk regarding
>> https://lkml.kernel.org/r/aVrUDeSkqqY9ZCtS@shell.armlinux.org.uk.
> 
> Hello!
> 
> I will test this v3 patch ASAP and reply results here.
> Collective sorry for the delay; I have been busy!
> 
> BR
> Kalle

Hello!

I tried this patch by cloning 
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=hugetlb-init/v3

Boots succesfully on BeagleBone Black!

BR
Kalle
