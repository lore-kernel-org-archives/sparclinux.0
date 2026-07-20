Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B864071DE
	for <sparclinux@vger.kernel.org>; Mon, 20 Jul 2026 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784584879; cv=pass; b=P5Gi8d7PHO4pRo0hsJTEC1CXfJfpil7c/LfCKXAQS3u4l4GKpdpiviY8xHWBTJdCBqO75jp7bJI1e9F+lo95UB2r/+eVeCq9HoYV9fvKpl8z/oC/uyhfu5nMDj8mJBOJbzwL26dDtoN7z31KJR3wpFAV7byS81lawv4P9BwvktQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784584879; c=relaxed/simple;
	bh=j/7Pu0goIzrDPISYd7UGXNeACZWMCvQbsT7AmxUh2RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7fkT10uo8fQfVOzj+v4+GU4sdVC1rhfoFUs56ELFFldLuQ3LEGw4xwrtqdXITmSZbHzbkCr/VBufMVNXSfQlecAsCtgz4IVxjqg/b2HVOLmjP4ItjxvtO5PitEjHZ7XMgDtrbTV09mBQDmhpvjPSGjqDhHDs72k1tWu1zZMnXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMey3lva; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMey3lva"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-698a9f11776so12016611a12.1
        for <sparclinux@vger.kernel.org>; Mon, 20 Jul 2026 15:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784584875; cv=none;
        d=google.com; s=arc-20260327;
        b=FBTkqWo28Y+yUE6LX243vMUsPwwHTp1vkiYHUyV2EyDnXJT0sXyk0zfms1TjFliThI
         BYX+xMoNXw9HLZXyZ/4LUXjG/dCnLTmj5i0zxeTP5mTlS3XZwOjgfgCXL1/cPBpJkyxG
         FU9Y6ScI3K++OKj2AU278FNKERk2o/slkAIptFpkL9r+uqpIDos3bQ5tGo0Mf5+1mV0b
         1zOt4srjiDeIPl2aCrnSSiS86ZPd3rzA6zNJAK6i9AW8o1VI8rZcShmfM9Sbom6N15EU
         gaZM79HDx5Ouf7Rswl++Q6/UmmanH3MapNdZlVwUlsY9kGBTiSqUqEf8ILbeL2vod4eU
         /KUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OFKHaLiuiIMT2s5Bf3SZwWbn7++lylaBZHxfNpeM7Fk=;
        fh=U3++WKFSdiZfkyEQWb6Z8HZW0EJpJKs7ZB3pZ2z2/IQ=;
        b=h/Z5k8zMe6vagefC7AwE8yUHb87zhwpZcZ0LDBMpXyga2L06YSUrWMDK2/r2tg2s8l
         Jmm8RN5u4tZ8r1kxRtODWuyuI2j2Fg8s92wtMMHPP8DJsaetn1Z1eKSszL0JS5++nQFI
         iL1NCUdAK3BbTFbPaTBhk29zZDYRp85/zq4UZYCeynS4kWUGjULu+3/6nC/lAqlItyrR
         EZ2ZAMmIyn8F/JWwGzRUxcgrmBSdg2CRGRiXOpkpgHs3rI9TYkEpwZRzIvD10bDPrQYf
         myyLoB6qRRuCKSrsuGS5Bh3YrBJWAFppHC9obWOpZvNBDdJkiSIh4iX3slvKuHyTWP4g
         cS6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784584875; x=1785189675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OFKHaLiuiIMT2s5Bf3SZwWbn7++lylaBZHxfNpeM7Fk=;
        b=ZMey3lvahqP+YPW9LamnWQzczRxQiZ4wg9gw2Nu7P3y1v17JUAuMM/AR3JTiQFFKU8
         d9noasqw2G++q5S+mCeWeywDA5kpg8MuVxJjECyua9/y3jlOjzMIOYlRYZqO13STHgxR
         WQ87V1/rMYJN18KwPy7Kt1f4oO1hp7OTlSg/lmBFsB1gkADDpu+GAYd81uYxtDWFgDYj
         g7E/fCVHIhWUawA3wQ30Wot0eYDovRLDP5gkADBspVyzhS4siR8fFKxsvW3/xg6aPXXq
         4tTUNL4YjCh2lps4QkQgZ6MAQbSDaAHnlH759VBDRh1kPBksK3QYu64fJW2a6dhpi8jy
         qpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784584875; x=1785189675;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OFKHaLiuiIMT2s5Bf3SZwWbn7++lylaBZHxfNpeM7Fk=;
        b=hS0pz1Ea5n/lOXHh0EPX5BtbluyUGFWRGr8zr5rK6aYkx7IeKGQjeE8vP2NSnwYw9E
         5mRx7uzep6WnL6IHPj5UNM8q7nXlwZmNWq6oQzGRdxCCK19jooJp3kVqwHPXAFoo0WxZ
         GpT6YA3lxWzX44lq5rubw5VypvkrgqBnn7HBbF+717ocSkgeYbLL+wM56Rx2ACZ7kIez
         5WjL8UTS6LrLUsjenUGH/EiskdDDC9FHqxdEA1tKQ7tDBTaHCQNVauoOvb/9dDOSTJ2w
         FF0WHw5aLCLGekrUb7QrzSlR/dC0O55AjWzAv0YH+9BrTN8SKFhn3culhAWmx+ImfVKm
         9JRg==
X-Forwarded-Encrypted: i=1; AHgh+Rr6bt/5sz/mepYkrsJI/8NqEpHICN8JFyFpN0X8X/2F4P6AkfTCntcXhtxXRqbtp1zsEpIMTDvFSgZZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ZA0MXVY2PiLeSjIsKKVP4Nmkbr5UMuMd2WkanceRTSG9qc+o
	ExIfFuEcEUWJi7QaOP6WbqjDix5vbB/Ho/N+OhGzAI2lgy1j237d+vugnenYtOFlp1rrFmSHGQ+
	lMKMjXkn5GQGCln3XAOZUpZNt3OiM9q8=
X-Gm-Gg: AR+sD13L143Gt6IBYQrc2c43dz4dw5aFN71hGCYOGHbNZ7u+vP+qfJnYlw2GaMAmkPJ
	dMZ4JmyYTqRR5fCHkKxhh2W7ZkcIzQ56TsjGM7orK/NphvXBZJeZwSd3+1LtI2j1mkoijVr61nZ
	Q7OqFm40r8JVJY0l5zt1xdbX3x7pgCqhI2Ref+2RzObMPN8PyeLxjBmeawqpW+7kj5VgJ7v74U9
	7WuuIHCzsvjsO6VOYQb9wKSxKeIovF2arwNojZBvwhqENxMMlYm7UrR9m4MG29U/eLCf5GF+0E7
	tPBJE66OO8N+HTIEYQE624BAFSvCYNM=
X-Received: by 2002:a05:6402:2356:b0:674:5b2c:d42c with SMTP id
 4fb4d7f45d1cf-69e6525c770mr6536246a12.3.1784584875096; Mon, 20 Jul 2026
 15:01:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707181957.433213175@kernel.org> <CA+=Fv5TDNH8+JAojV9_W36kUkEE68uiA00FQ7i0vJunebqs1sA@mail.gmail.com>
 <87wluplb6k.ffs@fw13>
In-Reply-To: <87wluplb6k.ffs@fw13>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 21 Jul 2026 00:01:03 +0200
X-Gm-Features: AUfX_mw5696pn_wiz_LjCaJHiFU9IchwhNNUbBWmuIdhtqSFIK3TJnj9-atYCBw
Message-ID: <CA+=Fv5Sd5+-K3-MOiEc2N8z_5CoLQPVPUwjiugSj3u8cBWJXXQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

Thomas,

On Mon, Jul 20, 2026 at 9:21=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> w=
rote:
>
>
> Similar to what Peter and me suggested in the related discussion
> vs. s390 which has a similar issue, you can just have a dedicated
> syscall_return member in your pt_regs struct, which is preset to -ENOSYS
> and operate on that. You have an unused padding entry there which means
> it won't even change the size.
>

Thanks, that makes sense in principle.

One complication is that my Alpha GENERIC_ENTRY branch already reuses that
former pt_regs padding slot, while keeping the pt_regs size and stack
alignment unchanged. The extra syscall-entry bookkeeping I needed so far li=
ves
in thread_info rather than adding more fields to pt_regs.

So the padding slot is not free in my current branch. I can still look at
whether a dedicated syscall_return scratch value would be cleaner, but the
tested version currently handles this by setting the default -ENOSYS result
only on the no-dispatch path, after generic entry processing, and only if
ptrace/seccomp/BPF did not already provide a return value.

>
> You were on CC for the V2, no?
>

Sorry, I must have missed that.

> The whole pile including Jinjie's seccomp bypass fix is in
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry
>
> and is targeted for the 7.3 merge window.
>

Great!

> If you want to base your stuff on that for 7.3, I can add a tag which
> makes it immutable so it can be pulled into the alpha tree.
>

Yes, please. There is still some ongoing testing/review of my Alpha
GENERIC_ENTRY series, but assuming it is ready in time for the 7.3 merge
window, an immutable tag would be very helpful.

Magnus
