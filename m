Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050263C6A6
	for <sparclinux@vger.kernel.org>; Mon, 12 Feb 2024 18:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707761287; cv=none; b=fBk3U9kKJbxxObbuasqau0yuiIw+VwvjXeh5RkdCHIozpA46Z5NRoQWnH6YL8L3oTi7FtiQorF00ZTGuynio5IukDBfKG7+ZSvFIW38TIKKF+gtD5H/VM5KGdL7eoUFw8PJbGdqqMbV8q2F0cuRIHT6kz5vuRT8vEOP6E3gDD1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707761287; c=relaxed/simple;
	bh=yS6+a2LOUZr/wQ5O9TGiaRoyv1KW9p7x/LFJAReUFUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAkEkH5N823gGMHrtXt5LY8SGxvLeyjwWTPCIuyuFU9papNxsnE6OBhy+UsuwDP+KdA5/8pBck3RMPCzCWDcuHZntjH8fphfTrkfCdYbRAVwaeKAMUHzBjq7eQV+OgLXWFzjRnH2sJ/JtJ+vnwSThXcVmuQvxggXkJceQMPY4pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOyZwigh; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOyZwigh"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e09a890341so1369551b3a.3
        for <sparclinux@vger.kernel.org>; Mon, 12 Feb 2024 10:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707761285; x=1708366085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yS6+a2LOUZr/wQ5O9TGiaRoyv1KW9p7x/LFJAReUFUc=;
        b=nOyZwighO8rKKyaan3YnOUkDTdpzzsVi9fLx25zI4dkH4HISMVGcnJ8/0nIErnjMLx
         PiytAT5OxESZTmaG4m2vN6hlQ76Z8wa5laCrb4k4B+Ds3KGeukZI5Lv89TakxBNFCSja
         k0/Bgc9Za8oOFLO6mqqunQbj5yrZqvl+YwSvtWlOMYA7zMFMJ7+rKB2Pn0rQGkDUTmrk
         xpF76xjOdjwViOvhnogi3mMTfVr/HYMIxttHaNUokP8aX7VxlyeArLoDdsnVgzI//wS4
         t1W9mupbSPg5gXC+Ioa8nBONXTScvVRhs17FRwEJMTy8T/0TPbmAAT35SX4P926NDQ35
         aLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707761285; x=1708366085;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yS6+a2LOUZr/wQ5O9TGiaRoyv1KW9p7x/LFJAReUFUc=;
        b=a1ISIm0rMC9HjUaWPTJ4ahVkSidMXXW36sUoONftXCHErbeFC3tz0jRrl2pcMpDVAe
         tYWAufQfHjuKJRLqgsPOW+RhH3b1GEs7R3k4Ij5Xsk2dA10q5a5FXvbWr5SO/6M9Eb9F
         T3mrB5T69kCXTV77RNecQItUoP3ZciyIzj57+MCzi2M6Ej9bQOaavMBcuKq/HB7huN9a
         uMSWi+aXQ1hkwccb/3TODuS7aDkvMVdF8sfN0Jga7Aaf8305Ogh+8CAqBEp1MPfmzf/X
         p46LI9/2f+uDDaLowzLL/qjUTos9ckpI2ws+o7GA8jiiGbTTJzDmDKyH6LDIhWED/NDs
         DrPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjiponRouxUallQc+TCrV2ZgBqR4nhKl5/veHZoAqr+nbzYQYfPJlyzTvtmd2v35JELclfYd/Mo+WNpI92JD3ICmilx20PcbziuQ==
X-Gm-Message-State: AOJu0YwCOJJ7KHXhB7mo/4J5we/1w3BVU0Hx/N0t+eQxDSaKZ89agWzE
	viO9gfk5hA8V+NzHQ/hIWEP/7QH5y22m6bHPKKDmmL/zKjJPNpYQ
X-Google-Smtp-Source: AGHT+IEqFAbfB3hEVYf0Gp8WVJUMi/fz9P12KmIA6dvmWFYq0VBn5/+e0RbDPtnlltsjcO9p1KKOug==
X-Received: by 2002:a05:6a20:4e18:b0:19e:c777:5c61 with SMTP id gk24-20020a056a204e1800b0019ec7775c61mr3439905pzb.22.1707761285112;
        Mon, 12 Feb 2024 10:08:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVe5oL083w14ydRO2zIR2DSe3A8bUNYD4VOA2vmHDqKeOnwjJzpvnZ/4jBhtRE6fOgGVuzxCUgmHC3ijQ4IlYzX2SKwxSRWqUilbtffAMhGWef7DbxONwdRFQOjsPvAYHqZP6s9G5lXvv3whxGL12S/1d69tjXa+YFipwDZE88IANbVZnjHDzUyzulCtPwajdBqL11jRMVNfuhmMe5WeTuKtrWVXB7ZaEu3jRkc/ekh6W7DYlMC1twP12FJmq8=
Received: from ?IPV6:2804:1b3:a7c0:378:a95e:7d43:370e:1d4c? ([2804:1b3:a7c0:378:a95e:7d43:370e:1d4c])
        by smtp.gmail.com with ESMTPSA id f5-20020aa79d85000000b006e0cfe94fc5sm3398980pfq.107.2024.02.12.10.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 10:08:04 -0800 (PST)
Message-ID: <2c586b93-0dbf-46c1-8d93-2db99b9757bb@gmail.com>
Date: Mon, 12 Feb 2024 15:08:01 -0300
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Reproducer for the posix_spawn() bug on sparc64
Content-Language: en-US
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
 sparclinux <sparclinux@vger.kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "David S. Miller" <davem@davemloft.net>, Sam James <sam@gentoo.org>,
 jrtc27 <jrtc27@debian.org>
References: <fe5cc47167430007560501aabb28ba154985b661.camel@physik.fu-berlin.de>
 <3ae4130c-c5aa-428e-b819-44cf2daf2af1@mkarcher.dialup.fu-berlin.de>
 <ec6254ce82d8ea5d9d3e73680c98b42f06d0930a.camel@physik.fu-berlin.de>
 <e44d6030-b7dd-4caa-99b6-87409988a76a@gmail.com>
 <48af8a12516ff0db379addb07daea58722c8ea1a.camel@physik.fu-berlin.de>
 <9d466551-dc73-47ae-a73a-d2bd4a5f19af@gmail.com>
 <060d813c250d45e7c9cfa3acbb39de95ea031661.camel@physik.fu-berlin.de>
From: Adhemerval Zanella Netto <zatrazz@gmail.com>
Autocrypt: addr=zatrazz@gmail.com; keydata=
 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
 C+trQg==
In-Reply-To: <060d813c250d45e7c9cfa3acbb39de95ea031661.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 12/02/24 14:40, John Paul Adrian Glaubitz wrote:
> On Mon, 2024-02-12 at 14:31 -0300, Adhemerval Zanella Netto wrote:
>> It really make me to believe it is something related to kernel because running the regression
>> program under strace I could not trigger the issue; nor by trying adding a printf just before
>> clone call.
> If I understood the problem correctly, according to Michael the issue related to the stack allocation
> which means that running "strace -f" will let posix_spawn() work properly in this case.
>
> Adrian
>
But what I am not fully sure is what ptrace/strace makes the testcase works as

expected, since the only think glibc clone implementation does it to allocate a

stack frame on the passed stack argument and issuing the syscall. Afaik, the value

passed on kernel, in either case (default, strace) would be essentially the same:


$ setarch -R strace -o log ./more_clone_attack
effective FP in clone() with waste 0 = 7feffffe590
this is 178 64-bit words above the next page boundary
[main] clone(0x100000009e0, 0xfff800010002fe80, ...)
[main] clone(0x100000009e0, 0xfff800010002fe80, ...)
[main] clone(0x100000009e0, 0xfff800010002fe80, ...)
[main] clone(0x100000009e0, 0xfff800010002fe80, ...)

[...]

No problems found

 $ ./more_clone_attack
effective FP in clone() with waste 0 = 7feff81a590
this is 178 64-bit words above the next page boundary
[main] clone(0x100000009e0, 0xfff800010002be80, ...)
[main] clone(0x100000009e0, 0xfff800010002be80, ...)
clone: Bad address

Problem detected at 1 pages distance


So from userland point of view, which is the requirement regarding stack argument?

