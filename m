Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2655E47ECCB
	for <sparclinux@vger.kernel.org>; Tue, 19 May 2026 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184950; cv=none; b=qffPFfgR2gwEHWsPRyjiJQ1FtXFxdLFZ1Y4XpY896i2YSxaxCupX9PD0+tKZgha41ddO/bv8VlmCnFQS7Cm5StaBPROzmQgVptZpL1nG2tYHGjQUDjvZ8G5vlYePPHBFH+7PyS6tfVc1/0YouTjPtSIUCWVBYX+nPMTsnZngs/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184950; c=relaxed/simple;
	bh=M7i+L/yg48jVw5kyal978n+1Wkllzl2xuJ6g2ROgz8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rv+qcYLin4Hf2/OUoMDVlJ3Q9XVQjdnRL/VuGPYT1429VYv9QdHbwfk6EWk3SRe/m3drucQ+JFJhv5TY4yoUkzzGQbWhIcR5H90UTwyEV8wdKtVKTLBgE4ASNVzsc98nXAT4eI/burixh+g9kwwWNOYmDvVZfNN2Cr41qcgGdEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrN7cNkd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrN7cNkd"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48d146705b4so36371625e9.3
        for <sparclinux@vger.kernel.org>; Tue, 19 May 2026 03:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779184946; x=1779789746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQqlGnc/jDs+MXoZVL796rxuKZbHr/asBBcZ0ydezGs=;
        b=HrN7cNkdz+8y8QJiVZ0XEHAD3pc0g8FWxhbb5VrF7WFaOJshlnEX9R93RBUgx2YleX
         SaQ4BGqUm5kZooRyvdV4X8M/vRrjxYoAS+Tx0ymlPm/YfT3iC1CrinYZT0cdj01rAVqW
         Z+/JSn9suCy23hzuhQmRPOR42hfc3ZpjMwo3FZNDBGhWMZ/+aJ0gP5M9sHWNBN1LPIQM
         yXjrzg0mjK3dgUTMfEXYhMcteyIKMj6khhi86Nd63s+oZ5iSY/7FAdF41EHt1/YCkCY9
         YtRE3AgHr2XwOfQdb7LwXTJrethy0UB1mA/vidWexnXArO76fv8v6c7s3wqtaceKZ7UV
         hGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779184946; x=1779789746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nQqlGnc/jDs+MXoZVL796rxuKZbHr/asBBcZ0ydezGs=;
        b=Iys8gTubb6NwR79k2fM1RlWLYzrPLZxvK37KmE7VjuvOTt6EAETKDN3l3+8AI724TB
         AViMkzAc1oco/qdm1VwM+Ivnu7ihDXd9LBt4FR+tpWVJrIVtAJoig9EhNZX81uqRXjGf
         JEYq5YtCFk8r4os8uWhKdXqFTI+kBRz6QZqAM+ftYGET3I9vHEqFlJ+9zGR3fvstA6Tj
         tnpI5RfxXLPfRW59NKCk8b2AM7zA08h6fiJlQHooHBplSioYDd8r5+niAMPJOQuwMXsK
         wsgBb6uJzhBZncQDWmi+2JtnPdDLET6Mu5MvNSAzB7xCuxHETbnZCvv6PJ9zjoNeAbxO
         XZ2Q==
X-Forwarded-Encrypted: i=1; AFNElJ9ebcjdrsY9M8HomCaKLyhadZuA7I009M0wf4N1nkn2ZPuVXjClUq8U3vZALpnPPWyzpJi6uVY69k6p@vger.kernel.org
X-Gm-Message-State: AOJu0YwbczEpZR/0Fg+rgnmV9GrryOFtx1DSyHPyOZYFKDTzgNutyJiQ
	2CfDBPy+OgDOYnSxCAvtTRA5Cfwnj6VBIA/6rk5K9MpGqryXKfA3H91f
X-Gm-Gg: Acq92OFGU1Pre3+ot984GxOKCyKdZSH1n25IcQ4cUFavuv6+0Noi4y4r721opt7zo6p
	EOCxLl9w+tv7AEs5BYX6OweA96cPTlGV5AOhV94oNa5lUJvINI9oK1WP2z+4qo2d84Ks1E9A5ns
	Cfu5vALtDA/ykfPyMrRW5EVs8shlVLqBfcQnGV/tVN8O06pO74tefnKIRnds/gY1HJ9SVWM4h3S
	YKrI/cB/UyIScom4dVO1O7D8G2hpqPyd6oX9wWB3D8bHVhNescxwKUx+20UAyWwlU4Nc6x5kO7w
	gAahfBSTaE8FidrE5iI7isLWgFRbaRwmDNRjAD/MR7rAXgNcTLHJd/8eGfGzWilfL6OVHf6733z
	BSqxmDTTRNnnDXBbuh6LBxrzErhcQJEVCEPRrwuuIjTSZmeTAcreZG6Skwcl7yjqhlq55vLUE3c
	1M5atfkXco/yj9XJQREEtm2Kwy/WLxNxUErIbeZ5bMuGVfysca1Uq3RhPTvjsLsDbk
X-Received: by 2002:a05:600d:b:b0:48e:8741:fd42 with SMTP id 5b1f17b1804b1-48fe60ee64amr222114445e9.12.1779184946374;
        Tue, 19 May 2026 03:02:26 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febf86db7sm155106115e9.6.2026.05.19.03.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 03:02:25 -0700 (PDT)
Date: Tue, 19 May 2026 11:02:23 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Tony Rodriguez <unixpro1970@gmail.com>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, andreas@gaisler.com, thuth@redhat.com,
 regressions@lists.linux.dev, glaubitz@physik.fu-berlin.de
Subject: Re: [PATCH 0/1] sparc64: unify thread stack sizing and add explicit
 32KB stack
Message-ID: <20260519110223.5aeb88e3@pumpkin>
In-Reply-To: <20260519075809.8993-1-unixpro1970@gmail.com>
References: <20260519075809.8993-1-unixpro1970@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 19 May 2026 00:57:54 -0700
Tony Rodriguez <unixpro1970@gmail.com> wrote:

> This patch fixes a reproducible stack exhaustion issue on SPARC64
> that occurs during USB hub enumeration. This regression may have
> started sometime after kernel v6.12. With the default 16KB kernel
> stack, the following panic is triggered early in boot:
>=20
>     [   25.528399] Call Trace:
>     [   25.528403] [<0000000000433cd4>] dump_stack+0x8/0x18
>     [   25.528419] [<00000000004297ac>] vpanic+0xdc/0x318
>     [   25.528429] [<0000000000429a0c>] panic+0x24/0x30
>     [   25.528436] [<0000000000be2280>] __schedule+0xa8/0x7bc
>     [   25.528445] [<0000000000be2b60>] schedule+0x24/0x4c
>     [   25.528452] [<0000000000be6970>] schedule_timeout+0xc8/0xe4
>     [   25.528459] [<0000000000be3318>] __wait_for_common+0x78/0xf0
>     [   25.528466] [<0000000000be3550>] wait_for_completion_timeout+0x1c/=
0x2c
>     [   25.528473] [<000000001005e2f4>] usb_start_wait_urb+0x68/0x128 [us=
bcore]
>     [   25.528502] [<000000001005e468>] usb_control_msg+0xb4/0xf8 [usbcor=
e]
>     [   25.528518] [<0000000010051180>] set_port_feature+0x44/0x54 [usbco=
re]
>     [   25.528530] [<00000000100530f0>] hub_power_on+0xc8/0xe8 [usbcore]
>     [   25.528543] [<0000000010054fd8>] hub_activate+0x12c/0x644 [usbcore]
>     [   25.528557] [<0000000010059438>] hub_probe+0xdd4/0xeb0 [usbcore]
>     [   25.528570] [<0000000010062360>] usb_probe_interface+0x234/0x26c [=
usbcore]
>     [   25.528585] [<0000000000a10a40>] really_probe+0x1ac/0x3b0
>=20
> This is caused by large SPARC64 trapframes, register-window spills,
> and deep call paths in usbcore. A 16KB stack is insufficient for
> this workload.

Increasing the stack size for all threads seems overkill.
That stack doesn't even look deep.
I suspect there are large on-stack buffers in there.

Unfortunately the traceback doesn't print the stack pointers making
debugging hard.

-- David

>=20
> The new logic is:
>=20
>     SPARC64:
>         THREAD_SIZE =3D 4 * PAGE_SIZE (32KB)
>         THREAD_SHIFT =3D PAGE_SHIFT + 2
>         THREAD_SIZE_ORDER =3D 2
>=20
>     Non=E2=80=91SPARC64 with PAGE_SHIFT =3D=3D 13:
>         Retains the existing 16KB stack behavior
>=20
>     Fallback:
>         Retains the existing 8KB stack behavior
>=20
> Signed-off-by: Tony Rodriguez <unixpro1970@gmail.com>
>=20
>=20
> Tony Rodriguez (1):
>   sparc64: unify thread stack sizing and add explicit 32KB stack
>=20
>  arch/sparc/include/asm/thread_info_64.h | 28 ++++++++++++-------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>=20
> --
> 2.53.0
>=20
>=20

