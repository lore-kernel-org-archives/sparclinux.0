Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFECBA21
	for <sparclinux@vger.kernel.org>; Thu,  8 Jan 2026 04:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767845408; cv=none; b=kKa6JUNZJtpCXgDstixY498mgG6TsNuwNsrH4kzrmxDe11HSDcmD6jK0rd+0gjc0xYQ40HHVtuuYPM6pWZl+WHSLvv0dE4a0Zt9XxFDphwvsXG48GdG0Pqbhsb/WZXqcLDVfetY9vMnN6JCNJQgmZvnskmitfJNweK3jSkqDZ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767845408; c=relaxed/simple;
	bh=EpVfcDPQ5tvvWmjPAb0alVXp8D2aw1sjVxS73dMYTuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5NbOZdh0+Obk5CdR0w/3BSOFVmkVK9pf17QoJtCp9Qztv4ydOSY4d+zAsz+8OISOHrFZH0LdUTX2P/vk0F23pbykp3LvzMYUWlC6hjemH8t4CeSpJLiiKpVwlnYFVM4l6ZQdWSQ3oz8Fh8kXQa19mq0osrj4w3qG6w4Q8vv4Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cx3f9emh; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cx3f9emh"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-944168e8c5fso1340687241.2
        for <sparclinux@vger.kernel.org>; Wed, 07 Jan 2026 20:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767845405; x=1768450205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LmM6ehlWdWJ6KDGXGbQV7OhRBapAye0Ge5k72n2kA68=;
        b=Cx3f9emhLvFOe5Mr/2RPWnlzHe5ph9TYiZnyH5nkhPVglznGAxu+byju2UkloDkgiE
         AGmcGQwBsTLjV5jZoraJ6kDe/WYK6pkoCNJ/gO2Q5cxwcK8DCcH3HtWU7M9LfrVhClQ+
         UFKsuT3CpiibeXDlx3+6lUFa44vc80Jrs2BjZjqPTFI5IZ/gQCz9HZMG3/UD+lKogaT4
         hj71NegomVrGkpEzIEu02cSZM3FekCbfsFGxDGZySU8QkCfuzQm0c2JyvDfpJGUtzxIN
         HJkwVuuZcbFnukDoCsI0KS39xnCGIQOokwt+/Lg1Xg/GMmGGXsprzMjKGFNEs4aAMh5/
         BKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767845405; x=1768450205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LmM6ehlWdWJ6KDGXGbQV7OhRBapAye0Ge5k72n2kA68=;
        b=BGrDS/S4mykBSepIxGUomAX6fT2Iuys4t3hWnYAHpUwZfPxiSTdf4rnRllcGaezQT9
         lM3uSBfhcAdYhWl38wjxNYByhwaKJY8BEAFMw02sXweka8D4z7Lg90ALWa7WOUHfel6S
         Nq9S4/MjHqFOWBRYBQzwPLZxO2ChWHdvYEemXHkerxBU63tSqZ8V0Czs/ctmzCJFdQkq
         +JwnxltSaOguXhkRW0FpvcNdYXCM3sXrZ93yW3Iojfw+aBQRJdr2K8opE+uVzHZlaQX/
         IjocfnP55y9JYUhODgBMjkjBQodor3gh1Nr8t4JAkUmHyzX5STmsEUCkpIcYDJiqi8qY
         Ur4A==
X-Forwarded-Encrypted: i=1; AJvYcCXwiQteE9w39hykh1rM+N8YkZsF/WAf1CuuVqMze1ERFKtZ0sEGDGq1Iqs5ooCBn4t6HcJ+wIXQOs92@vger.kernel.org
X-Gm-Message-State: AOJu0YxPRElpf5vYbaDuhNwgqW/kx/fX6gBoqWB9wDYLZtvN+kkhrtMZ
	Sq8MzMesXOhd1Yi7dVFU5ciBMG7oUZ+acb8+nqiOdNvKmbgF3HOiOtTt9F11Sbna
X-Gm-Gg: AY/fxX6XNlghXYOhf+PzLyWl+MfETOkoQ86QWd/UwyUXe5FyIWqKR2m1264HjW0qdlt
	Tk81CHgMf4ktorcknO9tcSrB6XYljmxt77f90YCS59EMaZoLUdT4A/7A3nV5ToMffu1lxhV94Gn
	tZGfsmbEuprxttby9MIZdYHROQ7ypm3EWmwDLbWGCNYtvnY5vSe0RT7/Uu8y6XXok/de1MHcfSW
	1xUoPbxBkkN/YRVmQQWGVrbMOmA+NJfxuF10R+SBcR1kMOaaHQtd0cDo6UiHxKTgRRV7ZzPnVuC
	EPvGpavqUgkPGae6JXZhKbgpm5g0iTehrdbErLHG34TlQ0gZN4NMHu3JW9E1+/dUpkRmEqMHTAE
	YNmFBC583euz4qaK2vLcxlQnZZ4QuOSecY4CFMRlV3zH/JNMUEq+nnJql3oRX0DzqGuIblbJTX/
	UMD0ZEB4dKYqICRhoO1kw=
X-Google-Smtp-Source: AGHT+IEB1LNTFlrPb+jcREkk5sKdys2DwRYUxfkYu64MLXUtH4B+YCOuboycYqblRdviAUDJwGzL4A==
X-Received: by 2002:a17:90a:c88b:b0:34c:6124:3616 with SMTP id 98e67ed59e1d1-34f68cdd6bemr4185279a91.27.1767839464598;
        Wed, 07 Jan 2026 18:31:04 -0800 (PST)
Received: from [192.168.2.226] ([114.92.45.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7c6f4dsm6226851a91.8.2026.01.07.18.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 18:31:04 -0800 (PST)
Message-ID: <3bc5964f-b4a6-4792-a3e3-beeeb986b12a@gmail.com>
Date: Thu, 8 Jan 2026 10:30:55 +0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arch/sparc: fix unused variable warning
To: Matthew Wilcox <willy@infradead.org>, alexs@kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 "open list:SPARC + UltraSPARC (sparc/sparc64)" <sparclinux@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Zi Yan <ziy@nvidia.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>, Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20260107104145.51416-1-alexs@kernel.org>
 <aV5xv0PfUvdc5QFE@casper.infradead.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <aV5xv0PfUvdc5QFE@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/1/7 22:46, Matthew Wilcox wrote:
> On Wed, Jan 07, 2026 at 06:41:44PM +0800,alexs@kernel.org wrote:
>> From: Alex Shi<alexs@kernel.org>
>>
>>     arch/sparc/mm/init_64.c: In function 'arch_hugetlb_valid_size':
>>     arch/sparc/mm/init_64.c:361:24: warning: variable 'hv_pgsz_idx' set but not used [-Wunused-but-set-variable]
>>       361 |         unsigned short hv_pgsz_idx;
>>           |                        ^~~~~~~~~~~
> Looks like it's been unused since introduction in c7d9f77d33a7 ?
> 
> As such, why cc all these people who have absolutely nothing to do with
> it?  Use your brain, not a stupid script.

Thanks for the feedback, Matthew. You're right—the script was too 
aggressive for such a localized fix.

I used scripts/get_maintainer.pl without enough manual filtering. Are 
there specific parameters or workflows you recommend to keep the CC list 
lean for trivial cleanups like this?

I'll be more surgical with the CC list on the next version.

Thanks
Alex
