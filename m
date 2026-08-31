Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321D2381B04
	for <sparclinux@vger.kernel.org>; Mon, 31 Aug 2026 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207501; cv=none; b=P63qUFgmIkO+D9R2LT25a00VEd398FSm8unTubc0/jxaNnTWADlhMfw/nxDBwZzUWI0RZqHnhDXK8iBidRsUaSN6lMZ/6nQXJ/QN6ocmhT6UzbaD398KAMUV4wePegQmMSYfT+Y31XOzXdYEVBVgFAx7jHWXluVWjE/UhZQsJKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207501; c=relaxed/simple;
	bh=o4qQdmso+7jbXfBITogLWM6RoF+x+AIWAvNaFOvCHxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3J1kvr+DdlrN67n447jemm3p6lkWLRtJt5TtvjwBGYWdBZAzUeKg7pNYkCDnH8f2jIj4yJko/nHUmg4Lgbf5jmltTaRU25z7UJZ3CLJ0Tuyz3Y6oCjROGH5AO/KS/LNKgyn1hooRt01KsUx9cqOZPws31l2ojH6yMNN3p+TdAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INxwvYPk; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INxwvYPk"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-853c07a76adso4159416b3a.0
        for <sparclinux@vger.kernel.org>; Mon, 31 Aug 2026 13:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788207499; x=1788812299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gJshX3L9F+nGxdNG5KJuqcT71hdUCxKC1U3uQESPtUs=;
        b=INxwvYPkAD/gHPnXwMHlCZbWtQDDkvks4nAeazUIibpZopKq9esDdZtsUQe3vaeAAN
         ejXZmjD7fYOE0xxINt8Zeq7pqSyRONLf1ph61lIKfd2z8FCuqrm9S+CiWv70Sr9n9jhZ
         kSrRimu4ByYZzZlO1iIWQaTVXzTrO1R4BLq/YVpY+/rXrhCoVkpUAe888BmdPgElvTtN
         k4hACU7Cv9A2LVmRJfv9e907T2HUjVeF5pMkgWB/uBH1MxE1t8L0mD0uD247EQ9uBfMN
         M06P/a9//jMPuNfjY7HoFoxtU//YMlsX5Rej83zSb/dYazw196OPmdNUq72ZnMs68Wb+
         TIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788207499; x=1788812299;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gJshX3L9F+nGxdNG5KJuqcT71hdUCxKC1U3uQESPtUs=;
        b=M1UULzxjiQnU2vh8Tj9aQC34EwT34DK/Vf3QxrkAb16dUMqbP/az1FwW1iQ6OtTZjY
         Vx+ZkFHctyBhQ5ru3JXbXXwzIfqMWF2dpcT2eGtwwnhEqyOuDDMJFDRMqFUmH384o96e
         l7IuNId7VhljoG8mQYcwS4eiIfg5Wi4vB+YrccrbHD3i/eJ6/dsgSun+R8DcEF6kOlbJ
         lh9ysLn7tuK2VThNVIlT2R1gSnH7koMC2LC65+ta3a+SrHMsV4unjrBFPf4+WASn1LVg
         MAgWjNd9N0fBUvrC7NcL9gtFU4D0fa7KMmz9sZ2w2Jl3/kMKWnoa6EZde5NNUz2otfZX
         QqIg==
X-Forwarded-Encrypted: i=1; AHgh+Rpk5C+dfc9pgE9UAOHyPSk+JaiHt14rm9Y/4JCGqyHvVhBqmyo5Zy9BhBP/QX04AIMnDnnEkCeKgBkq@vger.kernel.org
X-Gm-Message-State: AFuF++lB4g3dox3PbWe3+eyRQC6g9zb5FHNwtdfPnzogzQ0j6GgaYQmc
	9NHYPDU2fycms9bdQhjJR96MVh5QLgzJIOvCVylFfwow7KRgm1ghaivV
X-Gm-Gg: AR+sD136tFaMF86+eEb/boD84KNNIJ20SGLtphdtYFc00S0+lDEqfpPDyQzSTN0XGWV
	Xdom9HMeQWZSUY2uByoVJE/creZFLk5foZz7yeyKNBbeq11AvwhFo/2zZRNdOlxvQ4VUdE4coU3
	ORC1/pAfH9GfBPOzZxgbV9tYmqKOLUFVf6LeDtIjm3KA+GoLEmCjyCG62n09ZG6TXfF+iVLcVdv
	pbDoSoLaiby0fGoNskSKTb1cw3cR/U3PIhaBFdHMhNcB8hHOSVfTguDpAGg0mih+ayZltEPJKCw
	JOCVrEZqvgiCD/Gp80uOP1OT2XyWpZhq8XAvwdCWL1cP9LPWvk4Hg/VIhTKflsvU3E09mOaafwy
	WyFfnVkYARtUzKD5HHa08m408Gp1Wh+uv3LCHQUJ0e9yuAXzrmNzKneDXokKyD2HMoxYm+lJABQ
	se+kehulSBsDQYakehK4iKklwYBtP7wRhSE3j6Gb/1l5owDzitwTkG8rV/hXDo8KjGp++ueeyJQ
	8fn2GWun3notN0gIGI7nK//
X-Received: by 2002:a05:6a21:6e88:b0:3c4:46ca:334b with SMTP id adf61e73a8af0-3d267b60e7emr49750171637.9.1788207499237;
        Mon, 31 Aug 2026 13:18:19 -0700 (PDT)
Received: from [192.168.21.192] ([24.18.106.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9e3cf8sm34915143eec.24.2026.08.31.13.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 13:18:18 -0700 (PDT)
Message-ID: <b46209d5-e518-4289-9b3a-5854a2512278@gmail.com>
Date: Mon, 31 Aug 2026 13:18:07 -0700
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2] sparc64: increase kernel thread stack size to 32K
Content-Language: en-US
To: Stian Halseth <stian@itx.no>, andreas@gaisler.com, davem@davemloft.net,
 sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, david.laight.linux@gmail.com,
 glaubitz@physik.fu-berlin.de, thuth@redhat.com, regressions@lists.linux.dev,
 nroach44@nroach44.id.au
References: <20260519075809.8993-1-unixpro1970@gmail.com>
 <20260831172928.3082853-1-stian@itx.no>
 <afaa8ced-0717-4d62-8ea6-4ecdbf489694@gmail.com>
 <680606d594645568c21afcc552558882c4f59a96.camel@itx.no>
From: Tony Rodriguez <unixpro1970@gmail.com>
In-Reply-To: <680606d594645568c21afcc552558882c4f59a96.camel@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Stian,

No problem at all, and I appreciate your honesty and for reaching out. 
It’s best to get this addressed as soon as possible if you have the time 
to work on it—I’m currently swamped with other tasks. Overall, I don’t 
mind if you take over these patches, and truly appreciate your 
assistance to the sparc64 community. Just please continue to give me a 
mention in any patches related to this work, since I spent a 
considerable amount of time debugging, researching, and validating the 
fixes.

When I last tested on 7.0 and 7.1, both of my patches worked:

A)    sparc64: increase kernel thread stack size to 32K

B)    sparc64: Fix comparator problem with timer interrupts

I was able to debug and validate these issues on S7‑2 and T7‑1 hardware. 
I’m not sure if others have reported similar problems on T4 or T5 systems.

Regarding:

STACKTRACE: hub_event():entry: 31856 bytes used
STACKTRACE: hub_activate():entry: 31680 bytes used
STACKTRACE: usb_control_msg():entry: 30768 bytes used

This was a set of debugging code inserted into function hot spots and 
scripts to measure stack usage at runtime. It helped me identify trouble 
spots and gave me a better idea of where stack consumption was highest. 
At the time, I wondered whether it might be possible to reduce the stack 
size of usbcore and the Nvidia mlx5 functions on sparc64, but that would 
be a significantly more time‑consuming task. I may have updated my stack 
monitoring script since then as well.  It’s also been a few months, so 
I’d need to refresh my memory on the details.

If you have a quicker or better methodology for reviewing stack usage—or 
any general suggestions—I’m definitely open to seeing them, along with 
your config and exact procedure. And if you need help validating against 
S7‑2 and T7‑1 hardware, I can try to allocate some time to assist.

Best regards,
Tony

On 8/31/26 11:54 AM, Stian Halseth wrote:
> Hi Tony,
>
> You're welcome.
>
> I saw it was stuck, and wanted to push it along. Looks to me like a
> proper fix that should be included.
>
> PS: Don't want to take any credit, this is 100% your fix. If you rather
> want to handle it yourself, let me know :)
>
