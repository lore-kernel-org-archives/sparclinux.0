Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5DB3C4B83
	for <sparclinux@vger.kernel.org>; Sat, 11 Jul 2026 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783772968; cv=pass; b=Eu26prDu6hFeMlcDPcxR4PiHJ0hmJDcInE6GcL/+u3J+v2kB7NszzmCDYxCt5vzj1V/j+y+Tns0z8MFr5mm6upnenPI+lInG3Yr9R8g6Jfg7A1u/z/6CBg1ywgtFR3OYpc5zFN1ojiU5NR/mj3NU2PSX8NWgNiWoXlVoux4bSnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783772968; c=relaxed/simple;
	bh=lgplXt8OmmYK0O5s0vGlPCfavq5E5GB8C7ljQ3QichI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PfjSMY4/cKeMDZ44GcXdaCdKqUAu2L6XiLewWQJHJhwGvRDmr39z7eqSc69sE6YIXOL/jO9SZrQAt7HaOM1zkKR8WxPBY/jzaSI3VZAydZvYvdkj6pXMSvN3JIu1zliH/M/wV6ViNxmLM/5/Y4tTzbbeWX+tKB1waXVnfzf1vyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhVAsJnP; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhVAsJnP"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69a5ecbbfb2so2734949a12.2
        for <sparclinux@vger.kernel.org>; Sat, 11 Jul 2026 05:29:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783772964; cv=none;
        d=google.com; s=arc-20260327;
        b=R40DoMOJ/AtN6JYQAzM729J6CvVQ2UvfT+bXswVTST7HSlPsZbCBBWN31RcnzT1eGL
         8B4AnRlaG4txJhtuBRreEMFhGwXVxwmhg/pZ4WSGLTWiED2hE2Fq7tLDQk2SGoKh5PTa
         j4rQmPRQgYDaj+coYK2thFLDwL/9pIKQ1U5MkOiXl/et86ag9cdOJsQIzNTogzRZwOsI
         rdlGVCP0ipev+lN+xhdBkbjabp1scmkeWBmlOZKx2r+v/qY3JlWZxtBgZxl3XUhBUSQa
         g25r8yq8l3YEWhKHGh+wmaRCMud5sNFATN/eKARIuzqX7yOvHMOSWuVzDD9G+T0W2c00
         Rqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
        fh=EP2V7u8LUf/3dX7d491d5zBwzzN0w2vhTyfUTo/lfHo=;
        b=nl2ymhhYtlUfMcltnz9woJf7WdZCNEcLFyG3hyZI0naS94I56JYMYCTZb3gWMeK6IQ
         nTl0SAaIYvNZW7ucyiwqTxo6/RR5YeCgyTDd90VRFoz3kP4d9NuFAThhkXUsW1qp+sBe
         DQz+gZ3gvIYO1WLCuOTjzCg0QuQD9s+Do7VN/DMGZE2j3hyxf8VBjRp7W5KneVzHsMjB
         X9IpkHv47et+ji/X4Z0PJtxuHcYvXKnkp9qToTw9CAP9vM85uIQIZk3TWxE07xf9DqkA
         QDDIhFFFXHueDBdnFCQ7Xa8uZY7DYROF9NmUCDOzezqPsFYL04Mr+su3NyuFBVCbN3Kv
         vvDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783772964; x=1784377764; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
        b=KhVAsJnPccLQtlT6BW0pZOI6M33Kq5peNIi+brKc9mXt9N7FYBNxZiwumx0gXF4fIo
         sAO6rzobNlVEoIHs9Nr5Ud7Pqw06Wde6xz1P1K2kPK3YZyfFF/QcLy13zXrkpb8v6zCE
         wa1FryKea8CiALQ/FW+b66R5gxrKvaJKvQ5Z1BuPJv6JghHzUORCw6XB09TKL/k9s/1r
         i0N8avEwa/AHjCgBU1q0AZKoEW1/H84E5Jz1kEDp/nKMXzLRh+UDioLCoc7tRKEjgsZq
         3/2AvXjdSUp8fEKFVNQm320lqiCV3PxeKpLmb2suZXyxqugmSpsqzHjcuuYpicZfDTox
         leNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783772964; x=1784377764;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
        b=cAoBfdtBgl1xRhSj34CcWOUk56Z7NOZAyHMmPTPrkVqKB8M7UMI+wc6ug55oJkSwn9
         Q+bUTZjCF44KMxXevlLCqfXtT3Gc2Hi+F16rijYGpXMjU6862CPNL1WEO0vxnG1MvMnZ
         ZwOfy1xFXFpxvQy3W+T4+1JEVsMvgjHhP3LaIPdfFEYyXS/JlnngPxB0c9/aqmn+Y2gM
         MIIo8We5RdsWpfIuep7b5t2S3V5T0yoyrkDVd1UOQNefTrNWuxHI4bqMiNGDP2FW51oH
         QMnhhGu8Dnt1YewojvEdrfJPjQ14lObHfPQEq+lNV3cbmy5iMlYHf3T3vTUT3mHfWeMb
         jlXQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro4JXkMg5o52yrpu4BoQSeeLky7YPabiMhxKvzxm2ssHl2Mdp9m8L+MToCQWIfmjjun7xXc6uOYmUKm@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw5hJaHkKG+AjbX1OrPmcVmZd7wVz/W0nONZ1fLokRgGAwKdiw
	LGWxAkSQH+++6MQHCuP39KDRywYXrfnb7Wpl89iUlmsJTRL1x5KQwKqr79RrUBPnwF5e7UfDgI3
	6tgsUyezmtkcds8iizkZCrIxo9PwGNAw=
X-Gm-Gg: AfdE7ckORHckPeeJWndhXh9u8xm4i4g4j5GB6CFC1BxCBUiKd7ra3Ea7CMyALKvYWP6
	V4DMTD0zh7w0pm8wQRoXdrZpdnyWx0hu00snLxSrqgeUwrzc0aovqiawQD8c9T0SKqpYKswV5jx
	Plrs9OthSPvnxfufCBpxJQiVDJ+3CNiTrK1jaL17ono1I+yMm2LEtN61vvErcVMQm61cV1vZCM5
	h3iOketQyoRc6YeBiCS3pngZ1JshMTnZJWms0KH86PgrcVIHzpDyJS2CUpbsvLV4ocC0upAJ/Sq
	J37app2CHShlJQ6n998wmQy9bGw1ffdQUf4y2xMaI8In8xjjWjvQTsaj7MqsQv4=
X-Received: by 2002:a05:6402:3512:b0:699:728e:48b9 with SMTP id
 4fb4d7f45d1cf-69c5edb9cb3mr1210325a12.0.1783772963919; Sat, 11 Jul 2026
 05:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707181957.433213175@kernel.org>
In-Reply-To: <20260707181957.433213175@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 11 Jul 2026 14:29:12 +0200
X-Gm-Features: AUfX_mzOlRB8ana7x7qPQc4frMU9J060tNH0Z2GPCNvL1LYqDKQBjM-XzHbrvno
Message-ID: <CA+=Fv5RpgQ-UeGAT+VcLufte2gAp0H=J5GqZEFR_SuQsmnzy=A@mail.gmail.com>
Subject: Re: [patch 00/18] entry: Consolidate and rework syscall entry handling
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, linux-arm-kernel@lists.infradead.org, 
	linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> With that all architectures using the generic syscall entry code follow the
> same scheme, apply stack randomization at the correct and earliest possible
> place and skip syscall processing depending on the boolean return value of
> syscall_enter_from_user_mode[_work]().
>
> There should be no functional changes, at least there are none intended.
>
> The resulting text size for the syscall entry code on x8664 is slightly
> smaller than before these changes.
>
> Testing syscall heavy workloads and micro benchmarks shows a small
> performance gain for the general rework, but the last patch, which changes
> the logic to be more understandable has no measurable impact in either
> direction.
>
> The series applies on Linus tree and is also available from git:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-rework-v1
>


Hi Thomas,

Thanks for the series.

I have an Alpha GENERIC_ENTRY series posted and planned for the next
merge window:

https://lore.kernel.org/linux-alpha/20260706170019.2941459-1-linmag7@gmail.com/T/#t

Only its final patch intersects with this work.

That patch removes Alpha's architecture-specific syscall_trace_enter()
and syscall_trace_leave() implementations, so the Alpha changes in
patches 11 and 12 will disappear once the GENERIC_ENTRY conversion is
applied.

It also currently uses syscall_enter_from_user_mode(), so I will need to
rebase it onto the new entry interface introduced by this series. I
expect the integration to be confined to the final GENERIC_ENTRY patch.

The Alpha-specific changes in patches 11 and 12 look correct to me.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
