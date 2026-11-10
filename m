Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273682;
	b=F7gHrxm3MOHBm7UgjPV6ZIVOP53gpNUE3dmyJw4wkOqxIK9XQ7/uxcIXyp8UrVA076NH
	 ytNUMINniZEZ4hkn4WLa0qlJximZi8qiAFojmq4+lm7VKBb2Zr/5MHos5t7QhVTfGhvY8
	 lcUlPV8Hwdavmv4HVuP3Onex2gLrcbNrQVfWljkN0UQU7QTgCUyrJO38wQnn4X4+QJM5m
	 83lQiuR9giE6mM2yRAtdxEOh4q6H+dBGrhu2ucANkCSTnGKfKstCB4lPVpT1tukUswWsx
	 IfVUBCYn20t24tTIz2R1/tiwT9ValTrUZsAZrmJDYlv0uXfJlIIG0VaLCgI88R6LuXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
	b=RZJVDcsh1o64/961ImjsKFTUoJPdpP9zwNfy3EmCqeGekQUGf7kZ2cw7Ve2yC1Q4+8vE
	 7+qcLt8xHEZ69B67irAsoBFX+nARkKQk4Q+0hfJ8wiFTaoBvaDOz/Ic3F+SeAVdVuR3+M
	 1QMlS1MdL/Jy4xO2qALhdFY8V2XAjc3rQeEx98soXgl95u6+fO7yTNC129rRtzOJmSZ+I
	 HAy0mhPSCr6WeeqxVtBmLzhX7m6rQShlH0I2Rdl88WQieUlfGkEgOnv1Ci3peAYfr1LLv
	 9IKDMW0ScM3Euvnrfv4sAIfznvS84NObW537H0yzTt9oCqpDUArxOvR88tVFA6jLFpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=cRegKcAN;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B38606A321
	for <sparclinux@vger.kernel.org>; Tue, 10 Nov 2026 01:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76B38606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=cRegKcAN
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b577addee9so2037343a12.1
        for <sparclinux@vger.kernel.org>; Mon, 09 Nov 2026 17:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794273680; x=1794878480; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=cRegKcANAzuhN5uDFW569OXdZwb6gMtXkNC/10z7VU6wE2Fu6yj8VJJnAbNzHxJxRV
         OYYTyJV8PJKjJwt65ReIFr/5xjetM3YE4o/s05RWg/YApoVU3wx+brhEDlaC7uKu3O2j
         Tqk4s5AOzt8ZniVR2F6/Gz8CAmdG9w8k7m5NI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794273680; x=1794878480;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=tuQn/zBpDBhp0OuRgD7RZpy0fstDdrJO3ZKWZT4xoh+AEkCgRrkMPdk81c9QaVrgEy
         rO4XN04ZufKhSshGtOAY5CHhmKLqRfUlumA0ihjsVnxHC5pLkamQQocksza+JC5vJTlf
         d3/nR8RYGOrjnj8Vx35jlD8butRMzvOJRFCpLNI0DkyaflpQuK5DE9h0Xzl5i4s9/Prx
         eVeIlCQBScBr5E3y3jo0VPd5x+SNLYLmxh8uRX+WyHiNT3GDtct1beCND5VfJeoivZ7m
         vphyc7t4ZIKZmggmq+3D9hXSFZ9TXKzw85deTf/tqEsGEBy30GCyePgMhdrfpjQQsjVW
         CyOA==
X-Forwarded-Encrypted: i=1; AL+hErEg5C1sULnA0p5Jeo7dRuInQEUuhD6R0IcKRpqq6ikR1eHy+4vUFK85xE7EsZpKEX0G+75hPzSZM2/A@vger.kernel.org
X-Gm-Message-State: APuU4Z8kfT9C4yTCII98waTKZOwbGLVPSsGgfPpGb5BiRWs8uMRuw7Ne
	GJocdP/KMiBBwU2F8yYKruPBL+/hjVE8QCa6m9Z71zVo1/IMxxfdJ6QFee3AXSSLuuYgUuguwAM
	iGf5KU2lIgA==
X-Gm-Gg: AYBFou1IA4MfOLLO8BVT1CwJpiYY0yj6sC53FZ+5BXgmAmtCBMrX5srlU8P9jVFN/Fn
	LXkyUSAYA1C8Vtm5z4E3j3sSFDnZ/M2+EgFxufDRrkfhWibSELefeenc5ou7/ATrgQxtFCMvt5G
	IpOOWaiCddJ6A4eJgeHthmzVzn6YbbCCJPYnEmslVzGX8QMIEwLlwOM244ZYEjUQrsKzhHXFgZm
	LTdvw5C7rYLwyZn91LNVEpR25elgtp3cInSiO42qKa4fKheo2K9tkLx+j7eiDWH3Q1i1BYo5+t3
	I5aOlBTaB7KIQuR0rvkjAa54oK/FYs+7aPlvg/BeRUGZj4L8G2mX/2iC7+1hUHZ77GDdfdXOSh1
	ymyXtodihx1NJfYysz+7H2irZF4CFAQO6akgYUYVF3OtXpAYb5PorHgjR3EByw9+5YZJbp4B7Bm
	e5rfiVjqo9r0DgzNJD4iB5lODfzNv19dqUtXLQqqX+ko19U7cTzJSHSIXkrfHb8cqOAqrdb6P8f
	owZ+7aDooZVd6YyC8Js9bwuj1jXTLo4p2cudVP+Hwx3bKUAKf7VYtJzSMXnO+OP/m9Ulc0jEtAL
	6X1IM6amJtsr6Br/e/dpNKfdalW8Zy5NTR2/7G9IUhnB9QMgFLraYLzMpt4G9bMhzrBPQTEjtWw
	2hg==
X-Received: by 2002:a17:906:f5a4:b0:c34:e9fe:82ed with SMTP id a640c23a62f3a-c50496a40a9mr70990966b.28.1794273679937;
        Mon, 09 Nov 2026 17:21:19 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a693e82sm40841566b.83.2026.11.09.17.21.19
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 17:21:19 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b587538a37so2142609a12.2
        for <sparclinux@vger.kernel.org>; Mon, 09 Nov 2026 17:21:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGC/S2X+lucDdBBkJoJM83fFgt83aCUsaKVlF4BOp4r9kCeuW9cESnwh8BsaLi21ak0bmpoZviDoZO5@vger.kernel.org
X-Received: by 2002:a17:907:9451:b0:c41:1750:59a2 with SMTP id
 a640c23a62f3a-c50495dfbd5mr87253466b.12.1794273275844; Mon, 09 Nov 2026
 17:14:35 -0800 (PST)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
 <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
 <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner> <20261108185953.28054fb3@pumpkin>
 <alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk> <20261109214558.0d9d5228@pumpkin>
In-Reply-To: <20261109214558.0d9d5228@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Nov 2026 17:14:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
X-Gm-Features: AclHuK-x8jcOOQUqd2amGoGEAKER9jIFGaeL4LxxWAd0cGV7dz_RR64PtDogpPU
Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
To: David Laight <david.laight.linux@gmail.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Christian Brauner <brauner@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> Just that the cast would have to be:
>         u8 *foo = (u8 *)bar;
> where 'bar' is 'char *', and I don't think you need a cast there when
> char is unsigned.

.. and just to clarify: 'char' is always unsigned in the kernel on all
architectures since commit 3bc753c06dd0 ("kbuild: treat char as always
unsigned") back four years ago...

            Linus
