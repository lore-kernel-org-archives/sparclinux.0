Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2C23793AA
	for <sparclinux@vger.kernel.org>; Tue, 16 Jun 2026 19:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781639936; cv=none; b=OI5cvQ+EQpEhpOHNpUlpDb4eeuNIq/WsfmYyyLl2Md+XjBO387lfaJqaL0crcXoNi4p7Qk7KIt12zN4PMjgZ/H+mCtOVw0ToQJWHknm8lpuHjNAWUZc9xPUyXXUiwOn92yzP4YQF545FMVzkj/FqL2WajuqMi93ZmKIn3cdjlR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781639936; c=relaxed/simple;
	bh=BBO/04v2BmM6b235NKbqhyJ0da2WEH+508y8Lf0vfuI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kP8aT+z0GJie4/bE8I6f72LzKl/6bJWcfUqgETWDIpkOvqtxM4ILn6u75AjC2vj/Z0pzozF997aw74q3igztDZTonzL8p4XPJtSrQ5+38slOnJiLMweRUQjFMIXmHggV9EjCzfuGqyM9XWmUg8KblTfgLxjxaxaPlwl61s+EtCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMXmj4v8; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMXmj4v8"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-460662fcb4eso3448793f8f.0
        for <sparclinux@vger.kernel.org>; Tue, 16 Jun 2026 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781639933; x=1782244733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXZOSYUXeUZ9EP20mMZdKUAZCycX6LDoycPd1XgDjzY=;
        b=MMXmj4v8yu9rEWlckDAFQy5Ep37672vLQA0XsWboaz691Wc8mhYRifdRJC1w7iZCMT
         N5gvqmpPdS1prsUlLElUjcWqsOIk2odXYg1aQsd8QtV5r2yrph0agWf7diVybogQsIgU
         WnbtneN6TinTmFvV/jONV6Tx3GwbDXGGjLuap1gTPn8YxWX1it882armemN4owV+Dt5f
         zTCwBWrhCF0TcPnZIKEmztAH8zfgeO5Kz9QYfXoprMRlD8Fx/l+iXMBxg4/iNxQZSth7
         W9ry/KYRanJ0TO+yc7aRmtYQH0XGBQcQ155VQT3HILLktoaSSHpwMttgJs+xoc3JWgqe
         Y5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781639933; x=1782244733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aXZOSYUXeUZ9EP20mMZdKUAZCycX6LDoycPd1XgDjzY=;
        b=D4ZDQ7F0pAMLoRC/YaupP5w804mqME7I190tQPMGFHpbYo1QCL7uOgrhtHgdAh86jW
         YUcfcA4hnFB/yqxOPRU+CppIXcFFKzEGlqNIC4xXC34fjC/jP8U2aG9usReTialLdSIf
         ZkwAxVyBcwqkB4LIon/7ZiJIJ/ltb3hZ41qX7KjUh6EQRjEcrovTNg6okIIy9Sh2ZoTB
         7lbubNFNVRvQBJqKRjHF+uJU010+NMx7i5hMU/tWczawMSMVOCXzFT9T/4A7gr16r3t9
         J41DXPwHCrRiyLgoeKLxsvEaeKD6s84R2oIUGw9XIByaOf/AM6vRkdLvVlpcPmGBNgWi
         +sJQ==
X-Forwarded-Encrypted: i=1; AFNElJ8LcapwDTawSkJcTL8/RJbpwY+P6lQlQ6CP8vYgZ9jLMIdy68HE4wBXNRb0NP1DW2TKhalSIU3oMNfB@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzzb0BXo9nDF4IFT3piuT+lPdL9pS+HPoKWqEBVyTKvc4ghU4N
	HgHcFfdEMnjXvOScOqc1vPuhAQYFa+l+hyg8Pytv4sLpUMZtLx/Vp+O0
X-Gm-Gg: Acq92OE/7FLnXRerkLbeS4B/GR4DZFjccAnM2gICqzi+7ige3ZVmdwmAX8COnLLZkIT
	zAGN0ucRW1CfLjNnqhE1GamajH1alFg8tqXgUxnXy6QG4iCMDeutcaLmK2h8BVzqjNHDLQef+p/
	Vr8gH6WvRop+iQoIb3yNqkO/JUK3ErY5YoniWZoxl1bYeUbjtSd0DBW2pWa27YtvnF1u1+7HIsY
	YmrcbgScJBmK86KEUKstpjERM5ueIb+ua2SAnG+7D4Q8I85HyiPbKWzA0k5ptvt6vfWlZLnVbCQ
	laJVWCDRJz/2SK+t3i3ZOvPa16smKfFiC4zF8mdRTWUqUH3+JbRv6gmqPbZBS7ajj4f1jEokCYl
	/KZeQ4d6KKtpu5Nkm5CwA0lm37j0q4qlixz2nCsho8XVbYBYTrnoaEJ4x0XpG/YZT2G+Qdj+334
	MW69zqysXr3ChgQlb7vMnXeJfhgBaofa/TebN3Iq72I344D7T4bwVkZ2vCkx8N
X-Received: by 2002:a05:6000:25c2:b0:44d:1338:46b4 with SMTP id ffacd0b85a97d-46235e98c8bmr1642582f8f.9.1781639933566;
        Tue, 16 Jun 2026 12:58:53 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f4f6sm50956932f8f.16.2026.06.16.12.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 12:58:52 -0700 (PDT)
Date: Tue, 16 Jun 2026 20:58:51 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andreas Larsson <andreas.larsson@gaisler.com>
Cc: Tony Rodriguez <unixpro1970@gmail.com>, davem@davemloft.net,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 andreas@gaisler.com, thuth@redhat.com, regressions@lists.linux.dev,
 glaubitz@physik.fu-berlin.de
Subject: Re: [PATCH 1/1] sparc64: unify thread stack sizing and add explicit
 32KB stack
Message-ID: <20260616205851.428ca70c@pumpkin>
In-Reply-To: <03111ac5-0055-425f-a7f2-54d4f2bb4988@gaisler.com>
References: <20260519075809.8993-1-unixpro1970@gmail.com>
	<20260519075809.8993-2-unixpro1970@gmail.com>
	<03111ac5-0055-425f-a7f2-54d4f2bb4988@gaisler.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jun 2026 16:18:33 +0200
Andreas Larsson <andreas.larsson@gaisler.com> wrote:

> On 2026-05-19 09:57, Tony Rodriguez wrote:
> > This patch restructures the thread=E2=80=91stack sizing logic into a si=
ngle
> > if / elif / else chain and introduces an explicit 32KB kernel stack
> > for SPARC64. The previous implementation relied on nested conditionals
> > and PAGE_SHIFT=E2=80=91dependent behavior, which produced 8KB or 16KB s=
tacks
> > depending on configuration. SPARC64 requires a larger,
> > architecture=E2=80=91specific stack due to its trapframe size, register=
=E2=80=91window
> > behavior, and deeper call paths.
> >=20
> > A reproducible failure case occurs when usbcore is enabled: USB hub
> > enumeration (usb_new_device(), hub_port_connect(), PM/QoS helpers)
> > allocates large on=E2=80=91stack structures and recurses through several
> > layers of device=E2=80=91model code. Combined with SPARC64=E2=80=99s tr=
apframe and
> > register=E2=80=91window overhead, this reliably exhausts a 16KB stack a=
nd
> > results in early=E2=80=91boot panics.  A 32KB stack eliminates these fa=
ilures.
> >=20
> > The new logic is:
> >     SPARC64:
> >         THREAD_SIZE =3D 4 * PAGE_SIZE (32KB)
> >         THREAD_SHIFT =3D PAGE_SHIFT + 2 (log=E2=82=82(32KB))
> >         THREAD_SIZE_ORDER =3D 2 (4 contiguous pages) =20
>=20
> Yes
>=20
> >     Non=E2=80=91SPARC64 with PAGE_SHIFT =3D=3D 13:
> >         Retains the existing 16KB stack behavior
> >     Fallback:
> >         Retains the existing 8KB stack behavior =20
>=20
> No, not to my understanding, see comments below.
>=20
> >=20
> > Signed-off-by: Tony Rodriguez <unixpro1970@gmail.com>
> > ---
> >  arch/sparc/include/asm/thread_info_64.h | 28 ++++++++++++-------------
> >  1 file changed, 14 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/inclu=
de/asm/thread_info_64.h
> > index c8a73dff27f8..6b12a2b66385 100644
> > --- a/arch/sparc/include/asm/thread_info_64.h
> > +++ b/arch/sparc/include/asm/thread_info_64.h
> > @@ -99,13 +99,20 @@ struct thread_info {
> >  #define FAULT_CODE_BLKCOMMIT	0x10	/* Use blk-commit ASI in copy_page */
> >  #define	FAULT_CODE_BAD_RA	0x20	/* Bad RA for sun4v		   */
> >=20
> > -#if PAGE_SHIFT =3D=3D 13
> > -#define THREAD_SIZE (2*PAGE_SIZE)
> > -#define THREAD_SHIFT (PAGE_SHIFT + 1)
> > -#else /* PAGE_SHIFT =3D=3D 13 */
> > -#define THREAD_SIZE PAGE_SIZE
> > -#define THREAD_SHIFT PAGE_SHIFT
> > -#endif /* PAGE_SHIFT =3D=3D 13 */
> > +/* thread information allocation */
> > +#ifdef CONFIG_SPARC64
> > +	#define THREAD_SIZE (4 * PAGE_SIZE)
> > +	#define THREAD_SHIFT (PAGE_SHIFT + 2)
> > +	#define THREAD_SIZE_ORDER 2 =20
>=20
> As far as I can see, given that this header is included by
>=20
> #if defined(__sparc__) && defined(__arch64__)
> #include <asm/thread_info_64.h>
> #else
> #include <asm/thread_info_32.h>
> #endif
>=20
> the code above is the only code that will ever be compiled, while leaving=
...
>=20
> > +#elif PAGE_SHIFT =3D=3D 13
> > +	#define THREAD_SIZE (2 * PAGE_SIZE)
> > +	#define THREAD_SHIFT (PAGE_SHIFT + 1)
> > +	#define THREAD_SIZE_ORDER 1
> > +#else
> > +	#define THREAD_SIZE PAGE_SIZE
> > +	#define THREAD_SHIFT PAGE_SHIFT
> > +	#define THREAD_SIZE_ORDER 0
> > +#endif =20
>=20
> ...this code dead, where the else branch code already was dead (but then
> in two separate else braches).
>=20
> I'd rather see the else branch here and the else branch below cleaned up
> by a separate patch with a fixup tag for commit 15b9350a177b ("sparc64:
> Only support 4MB huge pages and 8KB base pages.") that as far as I can
> see should have removed the else branch. The else branches was to use
> only one page when the page size was _larger_ than 8 KiB when that was
> an option.

That whole logic is impenetrable.
Why not set the 'desired thread size' in kB, then work out how many
pages that ends up being based on the page size, and finally get the actual
stack size.
I'm not sure, but with vmalloc()ed stacks and 8k pages can't you have 24kB?

	David


>=20
> >=20
> >  /*
> >   * macros/functions for gaining access to the thread information struc=
ture
> > @@ -127,13 +134,6 @@ register struct thread_info *current_thread_info_r=
eg asm("g6");
> >  extern struct thread_info *current_thread_info(void);
> >  #endif
> >=20
> > -/* thread information allocation */
> > -#if PAGE_SHIFT =3D=3D 13
> > -#define THREAD_SIZE_ORDER	1
> > -#else /* PAGE_SHIFT =3D=3D 13 */
> > -#define THREAD_SIZE_ORDER	0
> > -#endif /* PAGE_SHIFT =3D=3D 13 */
> > -
> >  #define __thread_flag_byte_ptr(ti)	\
> >  	((unsigned char *)(&((ti)->flags)))
> >  #define __cur_thread_flag_byte_ptr	__thread_flag_byte_ptr(current_thre=
ad_info())
> > --
> > 2.53.0
> >  =20
>=20
> Apart from the above I agree with David Laight that more investigation
> of the situation that leads to this problem would be good. Granted,
> sparc and sparc64 in particular is a bit special with its stack frames,
> but among other arches it seems to be uncommon with 32 KiB of thread
> stack unless KASAN is enabled.
>=20
> Cheers,
> Andreas
>=20

