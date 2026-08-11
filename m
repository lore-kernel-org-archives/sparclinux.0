Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89F13B14BA
	for <sparclinux@vger.kernel.org>; Tue, 11 Aug 2026 06:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786430999; cv=none; b=d/6XdBVUhaDpeOMvSa0QnOEUkTrQeKJaMB7hsixUzlVQJOE0JjRxviGM2C2okZyfC7X6M+MrkjYMa/r3UzDqVctvjjO4bPWyEbGIcciTOKt/6CbizSGUSmi5A6Sg56Oit7hvxSRjDWc0sS+NeCXtwN/txa0QSjYR6ICjbWx/2BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786430999; c=relaxed/simple;
	bh=tZZLV6eyiwcGv5N3oyI6rD0AMUqGK1dWtQ5SUdhqr2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfFUKXDlAVtriqVhP1qBaOUaxNKjYCeWxJqPx2CbJVZ1LSDpVbPwSsXkF1NMxylfaa61Xf3kdZic+QSy5rTG73Wwp2m7cxsp/McM7XeccDWoFc6tVitue74YUNAOtxymbIgH2/CSgiBoxsvQP+K6Zw/oCL+U318l5xv3scNHQ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9667ea2fc22so528500241.2
        for <sparclinux@vger.kernel.org>; Mon, 10 Aug 2026 23:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786430996; x=1787035796;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0iZRfAdzYvTsaTTh/J3ab87cNtJMKi7JiQC3Jqumorg=;
        b=WNnAX0Wtk4Ys9RKeOUGVMFeZFxXlAF9c3krT0ycMfLeHiXSGOKspqK5WuUZD+Xn2p9
         snKmdSLsiDyRPMrpfPf0g1BI5nEQYBo8bAM6cj5sw3rfQIYLLKJuIiqOMeUsi6sXBwke
         Kf76Mc7JUv2XQkmV+vfY2mkQVTQ8GlAgFStgo8mo1eOBsXTGr3d+vxqZ2tNi+zbUlSVJ
         n/on4o/Oy3cRHR/11CDibIE/WG5CISguoC7N37p/BR/hb42XrdH4uOHz0Wn4yxE6ci/f
         Xdo2KcTJGtAGaWDW0kTBAKx05FKMsg2YTR7ePykoqyI7WWKLnpdGnnLEiapylUnLy3eM
         oQWg==
X-Forwarded-Encrypted: i=1; AHgh+RpoPal3illQZ/wgRtAAQuEuc/w8KQ7HgQtgslDdmS+LPSiDiyClLpxGcXEIq/IKw3qKE/WAfpcQ15p0@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj/2x2qERgjbahZMBP5Czo7AxF/ZQ1vJHlrEqRco8W/8YEem0M
	tK15Pkgv4Pj5tsQO43X2rwwEsnDJH4G2XRXMKWYY19aIbPPD5l6GoCNbqWIWdM72
X-Gm-Gg: AR+sD13yp6DNWN2VzbmCh5H4NsZVXJO7VHbH5kXhaQWCElUXN4O2mxc3nhRrgXK6CPJ
	6FCQ4WqZi9/C20k2CE4MQgi22VsWsJCQTS1juTH5p0YZAtxhL2UZcZnrOHkgjOc4Yph67FJRu49
	oMsKegHlhCu+nW54a5MPr4SryV3RvuiH6qZMHWDeldgMIpRwQ/oGa9khNKoxy0eAB48dhukkUYq
	wYnivtApDy+aymeEReilWomi6siCw5Pv+DbtQqIlLYt+g3iv1bo3RmbrWdiWTM5a/VyfzarzVI+
	O28msX1zJXNO5xL9NNSUE4440O52Rmzo85Awl1+y2R3EEsfdXwpFPAtJV+pD5AmlxYX8f9m8Afi
	ir8V2t55yZAkFv2AMN1lVM0+dNcHPLhNWUgMKwNKCk19RhibX5+PiFfObjCtaOz5DC0wSJZmERV
	cUYEWkfDbzGJmdwywz7aMOiaqMCmNPczTdd//AIEq+O2u4Lvpbv/lGFlLNVVx0DEBJprWXeQRdT
	SC4Cv73bO6gyFedDR03ziIkVA==
X-Received: by 2002:a05:6102:54ab:b0:745:7f23:a876 with SMTP id ada2fe7eead31-76b54a7a66cmr336022137.1.1786430996609;
        Mon, 10 Aug 2026 23:49:56 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97a366fb079sm112442241.10.2026.08.10.23.49.55
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 23:49:56 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-74ac3ea9c60so675602137.1
        for <sparclinux@vger.kernel.org>; Mon, 10 Aug 2026 23:49:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RphUF1Lbjp4/5JQOuSkA12s3sssmXDeRnaZJUmBp+8Eg8XlLRhQQGHrxRzbKZbc+nkfMYPUZCbOBjFe@vger.kernel.org
X-Received: by 2002:a05:6102:c4a:b0:738:ecd7:1984 with SMTP id
 ada2fe7eead31-76b54a7a17fmr283026137.3.1786430995503; Mon, 10 Aug 2026
 23:49:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811042119.3652929-1-anshuman.khandual@arm.com> <20260811042119.3652929-7-anshuman.khandual@arm.com>
In-Reply-To: <20260811042119.3652929-7-anshuman.khandual@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Aug 2026 08:49:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXfpkpYzZWGVb0fQrdn3uYHU3pyCkyAX9o2ux_Jj=2ByA@mail.gmail.com>
X-Gm-Features: AUfX_mwgji-OqM2d70As4nCfmG84npBMa5IuhuEcV5XEKzcXYS3fe_Pqx16lD20
Message-ID: <CAMuHMdXfpkpYzZWGVb0fQrdn3uYHU3pyCkyAX9o2ux_Jj=2ByA@mail.gmail.com>
Subject: Re: [RFC V2 6/6] mm: Drop pxd_ERROR()
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Anshuman,

Thanks for your patch!

On Tue, 11 Aug 2026 at 06:22, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> pxd_ERROR() has been used in generic mm just to print the page table entry
> in pxd_clear_bad() before clearing those out with pxd_clear() later. These
> pxd_ERROR() macros have been provided by all platforms which basically did
> the same thing.
>
> Make pxd_clear_bad() use recently added ptval_to_str() instead for printing
> page table entries thus completely dropping dependency on platform provided
> pxd_ERROR() macros which can then be dropped off. First move all required
> helpers in core MM into a header file which could then be used else where.

Oh, the "x" in "pxd" is a wildcard?
Except that is not, as it does not match "pte" ;-)

> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

>  arch/m68k/include/asm/mcf_pgtable.h           |  6 ---
>  arch/m68k/include/asm/motorola_pgtable.h      |  8 ----
>  arch/m68k/include/asm/sun3_pgtable.h          |  7 ----

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
