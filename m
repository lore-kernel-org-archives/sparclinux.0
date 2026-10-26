Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793042306;
	b=JcwdA1eIGzMx1IHnagja81Iqx1OBQovhNetpIlAMon8o3sMqSLAxyg8QlnG1pJxJVVPH
	 ZbhBCE7xW9bTnpJ7K5BbZNNTLqKXwfS1nj+btHcUHs+Td5ge+Rhgr/OWZDtTLs6zgiVZu
	 3ibhXbtQPT8WDwbt1rLvUVZU4hzZR3pEfNShJ7is9P3IEGKJ6+EgQmFvKBvMDXo+9w9qs
	 0AaxUVEPvETvfQLAF81Fni+5j+gRMyhsPAg4/6LBGd6ScB3mlMxq67cc5dkcuQ6gnONn3
	 mztZQ+PtpalEBfkMNBTLATK5hVbT9uT0y8fkyYX4AmG/f0pQs9pqWBa+3piueMgJ0qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:From:
	 To:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=cGD8W5Iwqa3vtO+g7S66ASNM4WO54+pVAVq203sNFMQ=;
	b=ePnqmX6Khw1Vr4UnN8HW0r/uXWOjaZW/xRJPTJh/foS3EjNrQisDMbhQrQSYQpcT8Ch3
	 nYZ5+PzCKz9IzEsLl30wyhXMwfZkAJON31oG0i3HBN+qZ5ARC8CeDzll0+faomlp5ogH2
	 0N7Rjcmu9ZkkZZMWdyhdd/yo2gSk8gyNeiLi65K4DdZeVxvMTMkyHOZ38LBNvlOTVJ/F+
	 DGwsWlqew/lyEioFPzliLxrkKZyneitSIUHyHIG/obaDFXMXXVinUJ+aH9DejDuc0mmRy
	 ieov98TQ7CO3K+iMittuay9ldi2RkXO00XRwMz9z/RYNsItxiA3IElV2d4xbw/wh3aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XaiZ8X0b;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2181160A2603
	for <sparclinux@vger.kernel.org>; Mon, 26 Oct 2026 19:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2181160A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XaiZ8X0b
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35f1f76ea84so5641707eec.1
        for <sparclinux@vger.kernel.org>; Mon, 26 Oct 2026 12:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793042305; x=1793647105; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cGD8W5Iwqa3vtO+g7S66ASNM4WO54+pVAVq203sNFMQ=;
        b=XaiZ8X0bioidF10IAlSN8+QN62juwzsX/5+1MBvz+jcTxMh16TijzxD8hO1XxhrH2v
         G2qHzFB02Y4tWliymH3Fl8sEja8nxhjW+gLUfvVXyQHigIsA7ra2UoAgSlX8g+Uu5LJw
         HDZsi+XiAxYZUI6XicNF85MV04ShF5c/kGe7jMZFrkZ9CR2KIFqieyK81Rd4AlnqzLa7
         CbKfMqiyXJ+nZVqdYVOoq/alQZz+nO/A49vvNnbj3DAulLVsz7+pfVt5FeDzP+R/geiX
         4gtBPAm2GaLc3Z6DWZJLSNl52jrTM0f28qZ7VrMYswpr/pozKEq7+2ISQ5GZ8oH+HEI3
         pLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793042305; x=1793647105;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cGD8W5Iwqa3vtO+g7S66ASNM4WO54+pVAVq203sNFMQ=;
        b=QRsbskcc8QrnWtl+8C1+KQAx8095W0wxkRj7GVaIMHRj6Q0obA4LWkTC2X3+jABBNv
         l797T2HU3nxVJ4RorugkFoJ7PEaoeJctwCMistK4uNBzFXcujwPukflbwJH5rio50Kyn
         EuXwCEE+OW9PVmxzFPxtCPQ0idRoemRlZea8JPf0YZ9Bp7vZa/tEw5GL6Mfuty/Umass
         wTTWe5hIaIWw+++OohU8ZjiJFTKCv0IrC82yrxQX3L8BFr8iZpVE7UoO6zGv/G807Svz
         SQumFaJaKB8/TlKAGT775+TgLX9RGXTOlfB43ooLO+6HdYCvtS7qoeKCoiJgJa2555ew
         ictw==
X-Forwarded-Encrypted: i=1; AKwUvBwJU5CRAAU9ZfihaSTcjtCs5Oy77RtFyd6HVA6b0KJykdOQA/rBuyBnca61V4pa+YnFyfGuc0RAXz8b@vger.kernel.org
X-Gm-Message-State: AFq9FYLtlw5PdhU4NhgGiD4rHBMlpgp5AOd2kf4X9cHvp3ffCKMtR4sQ
	VdpIDHFs59cyCwoJg6T4EIx2zs3Iv73f23scd0Q8apNQ/YxezivUt48aAghz7vvi
X-Gm-Gg: AYBFou0U4NzrAQGsT6GljJQaeopQMq9eCLD+sFtuLejsf6XjEXypYDswQ92k4mssUiO
	zjeEyNQiIqKVdeWUev92yubBiXTykmdOlxS4MtlRgJKNwKk4lBM+3oILIDTZaCrebz9hg00Az1Z
	9eH2SSlMAyPBct0BqoXJwzLzaJstDrhyuSN6bxlfC1mh8I/dTEbHdEHyqpPboqZRTYywn+mcXro
	Zf+k4lX4zCHrj1vzhs4AY+4DIzl02rvgRPy2hbhIAYhPrt1DcD+nZUpinBhiRVIAY6M4Rz8oHr6
	PGjF2VHxX2U+ZP5CkJH0SL0Yt0vj5DsUbvs9amajgSWKsdYFtjv0sN+j7kjXdNSpozUWfZpC+Fo
	tPuZump5SEm5Gl1OulsU2e+POSDoXqMWxZtgejJVFD/NYGxDXORsQr/1q7iNyxr8L31VK9AxQfh
	d0UBXYowc/wZqpC4HaCOWC1qKMIKG4akpu+5by+96L4dvrscMxOt8YGRO8XOwbaumM7tb9cu4WV
	rM6KR0FDcd/WIIXZv2XWKClDm8qqM60fbn+DT9XF59+AyX7QTWUVCU7u5vh3jk1ZHOxDL5vDOSQ
	EYdw2wosttTPjmvZMM/wTLH5GJoZIakh4LpAjg==
X-Received: by 2002:a05:693c:88c1:10b0:367:5e31:ce29 with SMTP id 5a478bee46e88-369e84fe37emr11058609eec.20.1793042305050;
        Mon, 26 Oct 2026 12:18:25 -0700 (PDT)
Received: from [192.168.21.192] ([24.18.106.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a005c0188sm13789851eec.9.2026.10.26.12.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 12:18:24 -0700 (PDT)
Message-ID: <dcf2c329-9268-488a-8b7a-79419e49293c@gmail.com>
Date: Mon, 26 Oct 2026 12:18:26 -0700
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] sparc: populate sysfs cache topology information on sun4v
Content-Language: en-US
From: Tony Rodriguez <unixpro1970@gmail.com>
To: Jan Engelhardt <jengelh@inai.de>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Stian Halseth <stian@itx.no>
References: <X-TH#1.20261018222723.43442-1-jengelh@inai.de>
 <CANmkgULrJwKSuwQhZjgL0-zWgMYWgOZLhseDXGtp_XwjcAayow@mail.gmail.com>
In-Reply-To: <CANmkgULrJwKSuwQhZjgL0-zWgMYWgOZLhseDXGtp_XwjcAayow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/26/26 11:52 AM, Tony Rodriguez wrote:
> Tested-by: Tony Rodriguez <unixpro1970@gmail.com>
>
> Tested on both SPARC T7-1 and S7-2 systems; the lscpu output is correct on both.
>
> A) T7-1:
> A1) lscpu
> Architecture:          sparc64
>    CPU op-mode(s):      32-bit, 64-bit
>    Byte Order:          Big Endian
> CPU(s):                256
>    On-line CPU(s) list: 0-255
> Model name:            SPARC-M7
>    Thread(s) per core:  8
>    Core(s) per socket:  32
>    Socket(s):           1
>    Flags:               sun4v
> Caches (sum of all):
>    L1d:                 512 KiB (32 instances)
>    L1i:                 512 KiB (32 instances)
>    L2d:                 4 MiB (16 instances)
>    L2i:                 2 MiB (8 instances)
>    L3:                  64 MiB (8 instances)
> NUMA:
>    NUMA node(s):        1
>    NUMA node0 CPU(s):   0-255
>
> A2) lscpu --cache
> NAME ONE-SIZE ALL-SIZE WAYS TYPE        LEVEL  SETS PHY-LINE COHERENCY-SIZE
> L1d       16K     512K    4 Data            1   128                      32
> L1i       16K     512K    4 Instruction     1    64                      64
> L2d      256K       4M    8 Data            2   512                      64
> L2i      256K       2M    8 Instruction     2   512                      64
> L3         8M      64M    8 Unified         3 16384                      64
>
> B) S7-2:
> B1) lscpu
> Architecture:          sparc64
>    CPU op-mode(s):      32-bit, 64-bit
>    Byte Order:          Big Endian
> CPU(s):                128
>    On-line CPU(s) list: 0-127
> Model name:            SPARC-S7 (Sonoma)
>    Thread(s) per core:  8
>    Core(s) per socket:  8
>    Socket(s):           2
>    Flags:               sun4v
> Caches (sum of all):
>    L1d:                 256 KiB (16 instances)
>    L1i:                 256 KiB (16 instances)
>    L2d:                 2 MiB (8 instances)
>    L2i:                 1 MiB (4 instances)
>    L3:                  32 MiB (4 instances)
> NUMA:
>    NUMA node(s):        2
>    NUMA node0 CPU(s):   0-63
>    NUMA node1 CPU(s):   64-127
>
> B2) lscpu --cache
> NAME ONE-SIZE ALL-SIZE WAYS TYPE        LEVEL  SETS PHY-LINE COHERENCY-SIZE
> L1d       16K     256K    4 Data            1   128                      32
> L1i       16K     256K    4 Instruction     1    64                      64
> L2d      256K       2M    8 Data            2   512                      64
> L2i      256K       1M    8 Instruction     2   512                      64
> L3         8M      32M    8 Unified         3 16384                      64

Corrected the lscpu --cache output to fix the PHY-LINE and 
COHERENCY-SIZE fields, making the output easier to read in the email.

