Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943B53E487
	for <sparclinux@vger.kernel.org>; Mon, 12 Feb 2024 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759078; cv=none; b=SjnKXJje4sdBdo7Oyd1GVM4gbzscce7T7i520iyay2Bi1v0uDeE8F+6hcqXGvw0Zn0QNR2WB9UsPl11asJQx3Uq2V0no1wpNb3bM5pCXlasiI6IU/U7DB4Iu9kMTrEvzKyHQjQkoMAKGo8iW7M6tlzBpzcUUhfCP8RTROnUfAFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759078; c=relaxed/simple;
	bh=GVcvskxTIt41wEfoeApaQbSRCrQbGTRT5nSZz5rFFBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EerEZS93JNPfvR6bWGXgPoPRtrSVFKVJTg05B72khZljy4mNkqR5QZIH/qs2RtPcDa/5z9A3a5nFxs+dYiy1Rxvv2TWTX7r0AZMe7q/tpRe5t68+sq5600vRIFX+AQ7mxZ9hCmtGCTOQqCkXUVvOIUbdblHmvBavmNWv8za/OSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kes3B6CH; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kes3B6CH"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e0ac91e1e9so1081771b3a.3
        for <sparclinux@vger.kernel.org>; Mon, 12 Feb 2024 09:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707759077; x=1708363877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GVcvskxTIt41wEfoeApaQbSRCrQbGTRT5nSZz5rFFBI=;
        b=Kes3B6CHVkOsbZqyFvectpym0gLDNCDXer6D30SIUcwYzO4kdYB6d4RfimNEYmYCbW
         0Aog+RAb2lM6BB5E4zDBIdGc7yOBf0Z6j+9AurLzyTSwQAwuaeBMm+dBMYNRHWWVC+bV
         TVQEGcqX38jc8+79GeBUHhVvYnefnYc/ZaWEkiR2W3bVfL0WhPXpdEJ8DF+vMnJ33qoU
         1erUdIt50o9i2YXe4WnM8hlk760kSnYrYYc8EzMjz4uxW+fE1x2aiKe7mWnaCiDlazrc
         U61thIFANl8iU64qCB/2ynp5hzY8ETRAN9yGue64E2tA9eSjv0dTy94Iosn5oEqyE1eQ
         2Z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707759077; x=1708363877;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVcvskxTIt41wEfoeApaQbSRCrQbGTRT5nSZz5rFFBI=;
        b=ChjOOsjZ2vA+7TaokbnhRnGNx+v1LbxCTQJRA1PKcPwX1Lz+yKnUXmCxicEi1cCVPl
         9DaYM0hLtb4z0z8k4JYeTX1scIjknApRk/ye42/ZnRNsc3JJtcQOzVIXzMQo2eZOulM3
         1O32cXDzVFbe50peaKJcehIrTFKnmKJ2NUDXrwgUMLKKIyn8P8tMpoQISgRhaTr45W2g
         rDylNQi4YHVDc9uyQUxCfwaoZldux4Zm24Q1FxC5QHgr32M8P64FM1z5uZ7i3k4Rz/Es
         aDx74rGLGBT/lTlBY6lDD5nI2UYSAz0PHLlE7tLJrVp/H2YXdvdxnj6rsXbYTez+Q/3l
         pZVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeXPhkfe6pwd5HzH4ZNVTbDcNMFLOke93eZEqEpG0V2aFlBzwEGUJdkjEAJKYZiptumFwtAFHikEgREKS9Sve6lsaFHweQ/J43Fg==
X-Gm-Message-State: AOJu0YzgJDo05NCwAZLVPEMEYDIVTF245lGaW93a9IXaiQxJUeLS1QOW
	nktbtKdWQVyjggXK1yWb7bKZhiyYHdueVq3+3MGdRKyJwq3ijqKb
X-Google-Smtp-Source: AGHT+IFrq3oFIFki+V7TgTaR9mZJFMOx/lURPNuZjMGOjpobkCr1xq4Ap5R2s4xhbzgKXoyV2hdY5g==
X-Received: by 2002:a05:6a00:17a1:b0:6e0:3ce8:bcec with SMTP id s33-20020a056a0017a100b006e03ce8bcecmr8036376pfg.22.1707759076809;
        Mon, 12 Feb 2024 09:31:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWZ7zVnJEmDJjyRVBtJsvE/d7gFJ0cnfGK6Y3osji9ypyq/EcC8jwn7XxTZFJ59JZq3cEaJ2AyXanpN/fpzi1yMCYWfmRO23teHxxYYB06ZTii0oSoyi3OBLWwYs7Wvx9bQRztCh7oh/6qrqy/YWyh3VJaNE7VuWhQNlA6dl4vvWAu0U/Q7r1nvQVrk76Z633XUQmF94aKhDmwqKHk4iotVd2pTHPub8VcPjNaJrZgyRpdt7/xkEAHyRw9oWYc=
Received: from ?IPV6:2804:1b3:a7c0:378:a95e:7d43:370e:1d4c? ([2804:1b3:a7c0:378:a95e:7d43:370e:1d4c])
        by smtp.gmail.com with ESMTPSA id y192-20020a62cec9000000b006e042b50c39sm6240060pfg.144.2024.02.12.09.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 09:31:16 -0800 (PST)
Message-ID: <9d466551-dc73-47ae-a73a-d2bd4a5f19af@gmail.com>
Date: Mon, 12 Feb 2024 14:31:12 -0300
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
From: Adhemerval Zanella Netto <zatrazz@gmail.com>
Autocrypt: addr=zatrazz@gmail.com; keydata=
 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
 C+trQg==
In-Reply-To: <48af8a12516ff0db379addb07daea58722c8ea1a.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 12/02/24 13:32, John Paul Adrian Glaubitz wrote:
> Hi Adhemerval,
>
> On Mon, 2024-02-12 at 11:01 -0300, Adhemerval Zanella Netto wrote:
>> It fails on the two different sparc64 machines I usually use for glibc testing as well:
>>
>> azanella@catbus ~ $ /lib64/libc.so.6 | head -n 1
>> GNU C Library (Gentoo 2.38-r9 (patchset 9)) stable release version 2.38.
>> azanella@catbus ~ $ uname -a
>> Linux catbus.sparc.dev.gentoo.org 6.1.72 #1 SMP Fri Jan 12 15:00:51 PST 2024 sparc64 sun4v UltraSparc T5 (Niagara5) GNU/Linux
>> azanella@catbus ~ $ ./more_clone_attack
>> effective FP in clone() with waste 0 = 7feffee09f0
>> this is 318 64-bit words above the next page boundary
>> clone: Bad address
>> Problem detected at 1 pages distance
>>
>>
>> azanella@ravirin:~$ /lib/sparc64-linux-gnu/libc.so.6 | head -n 1
>> GNU C Library (Debian GLIBC 2.37-15) stable release version 2.37.
>> azanella@ravirin:~$ uname -a
>> Linux ravirin 4.19.0-5-sparc64 #1 Debian 4.19.37-6 (2019-07-18) sparc64 GNU/Linux
>> azanella@ravirin:~$ ./more_clone_attack
>> effective FP in clone() with waste 0 = 7feffa3ae50
>> this is 458 64-bit words above the next page boundary
>> clone: Bad address
>> Problem detected at 1 pages distance
>>
>>
>> And I see similar failures on qemu as well.
> Thanks for the confirmation. I was also able to reproduce it even on Debian Wheezy
> with kernel 3.2.0 and glibc 2.13, so it seems the bug is very old.
>
> Do you think it's a kernel or glibc bug?
>
> Adrian
>
I am not sure, I was leaning to some clone change in recent changes; but since you did

see on version as old as 2.13 I don't think it is related to glibc clone implementation.


It really make me to believe it is something related to kernel because running the regression

program under strace I could not trigger the issue; nor by trying adding a printf just before

clone call.

