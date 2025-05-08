Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ED6224B16
	for <sparclinux@vger.kernel.org>; Thu,  8 May 2025 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746707131; cv=none; b=T2+ZCrGmSpzGTUtmU7AZbqtd7NmfYP1Auv7GsUZAhZ6UL/aojA3xFSmIKGRxUpTD1dzu+LkkI4muhepvJVldf09a+k4/dr+nbma1pbCkIZsgag5FUqxooxrulbubjcbxjCXxG3S7kV1DPMHTsqfw3xofdBTnfDttCfFF/ormIn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746707131; c=relaxed/simple;
	bh=GSPlMkE9xl1CKG6+aR4Lnpqmp6kkUaBOsXBjm7FdCs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJeB/dxPK/TKa/pJBlt5ByshO5aB/Ckn0b0+JPP13K9LKQea6DqDzxgrQnBqKzzpzNeR4jZiNwHDqwco5J5qmzlb1zCmeWiFtDRQZbbh7I7ky20kT9fNsKyfjDhb/iC+NUALVEVxDWdqhyViXG2LXnQzy2bCkcd4+5kcdDhqYBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ONaTa7mk; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ONaTa7mk"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30bf1d48843so7880181fa.2
        for <sparclinux@vger.kernel.org>; Thu, 08 May 2025 05:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746707126; x=1747311926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SGXUIdTFQac7mJFRH+e+84EpMzV6neC01o/VEUKascg=;
        b=ONaTa7mkd9jVBDhTxOiNjDB9oo7ZjFFzBT97onAVuG9S+UwGeCqO4hXZK/nqbJUC5t
         2yJo4mux/6GIOUCviWK0mKOKdELAH4WroXckzdLgoeA5rmJ9Vq3E7TZrudMSm4/XLMSU
         We0MQ/50Ns1jLNJ1iFHhLDLCobMR3pRT7CER365RgfcCCqK8pTxwLAVzHwOrcAfmrnQ3
         p55KROtV+WfTFr2ua2Su1IXybLXufIrUacbo2ZwHgI97BYK6FDd2/vSDIXqjm9ApLE/e
         zGp0bwKQ9lPRKEKvymtb7m/acWfQ8mZ/3YlUcbNuGnYsvDhvWBDj/BS03V+9LKduDxhs
         jkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746707126; x=1747311926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGXUIdTFQac7mJFRH+e+84EpMzV6neC01o/VEUKascg=;
        b=VTUhPZa70sLEZsEvArg7eFAKZItFRIDsjMFWmmq2PPCbLAcoy7YxcqJrnYsGYXTBZ5
         dkZqwPdPS0UhtlIbnwAkvVOSC3ffDbHraeKgLCyMG+pFHAV8TRTHKdR8xxlhwkSUxMig
         pXs5eNQdKg3Rcz28ZdLfMBY9SM0WNeMxKpx1d6rlZ3D+kUWWRErHucRzAq5A4QAuPxAg
         7b0D9mAbP0Mwwh97KJ1ialDkQaUB4FOH2K4pvnzmBhGgOJgmsLVoD7xPC1bskk4XR71u
         M3waMobGTH0tXMbE35A1FERubRBvQl6BHPEfUpa+0VflQLxNXLz3jWMmhDKXoLrOltqa
         JAig==
X-Forwarded-Encrypted: i=1; AJvYcCV3i8AVqqhOzyAiR8r0w9nkD2nzUlWr0Oq6Dx/TJbuK1uYzc39CrPrU8nsa6AYHyHJIARWmHa6zCYSa@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy3tCkCXIw1K+u3pmry7P7wRPAreqGkVinOkD+HsHMXi5OAM+m
	dYw5z/fnfMa3JqWRmva8eNly0rqdYWlIS7/gSRiWwzRCZfV/J0GpRN9wVxkpRa0NHjw8d52qJuM
	XdTxzRM41gc+o4Pdf3PyRgHha03ZVXK/CUVNV
X-Gm-Gg: ASbGncslTAA5+r5ubXo11BPVNaC1/rLrX+8xi3pQar7mDpDnw3RjuhKpiubJzmHO8Gc
	HUAavRPYltHq01Pw+rhPI10KK6T9pvTukFkPmVfqq5+Y2/+55Y8hPHGvwk6SaBcDSp4qB1zsjaG
	0YBAcjPX9dGZStiWFPPbI4pCvsM/UsfXIVo4MkDG1g7E7XUolj8xqD
X-Google-Smtp-Source: AGHT+IHELJP6PjDmjgnoQ+DcewZezMvkPDTBk3DlAEgOIW2HtUu14uSoRBVrm2tBSd/cEMjU36ADUjG1Ap9y8UFRrr8=
X-Received: by 2002:a05:651c:b11:b0:30b:f006:3f5 with SMTP id
 38308e7fff4ca-326b87dacdfmr7793251fa.15.1746707125568; Thu, 08 May 2025
 05:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507180852.work.231-kees@kernel.org> <20250507181615.1947159-2-kees@kernel.org>
 <CANpmjNPcYPvnQzMT3p+Vc2=EiEbR1WnykUEjuYc0bH2HOFi6HQ@mail.gmail.com>
In-Reply-To: <CANpmjNPcYPvnQzMT3p+Vc2=EiEbR1WnykUEjuYc0bH2HOFi6HQ@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 8 May 2025 14:25:13 +0200
X-Gm-Features: ATxdqUEOMWVMkXbvXQaHqruZq4t8-pmXFLrRyvMg5ohXOpGrzDC1z300bwlcEE0
Message-ID: <CACT4Y+betRmieWEHBdEf=gOLhWiNVRH5CSDeN6ykBtoP1GrzLA@mail.gmail.com>
Subject: Re: [PATCH 2/8] init.h: Disable sanitizer coverage for __init and __head
To: Marco Elver <elver@google.com>
Cc: Kees Cook <kees@kernel.org>, Alexander Potapenko <glider@google.com>, 
	Aleksandr Nogikh <nogikh@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	kasan-dev@googlegroups.com, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	sparclinux@vger.kernel.org, llvm@lists.linux.dev, 
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 May 2025 at 14:23, Marco Elver <elver@google.com> wrote:
>
> +Cc KCOV maintainers
>
> On Wed, 7 May 2025 at 20:16, Kees Cook <kees@kernel.org> wrote:
> >
> > While __noinstr already contained __no_sanitize_coverage, it needs to
> > be added to __init and __head section markings to support the Clang
> > implementation of CONFIG_STACKLEAK. This is to make sure the stack depth
> > tracking callback is not executed in unsupported contexts.
> >
> > The other sanitizer coverage options (trace-pc and trace-cmp) aren't
> > needed in __head nor __init either ("We are interested in code coverage
> > as a function of a syscall inputs"[1]), so this appears safe to disable
> > for them as well.
>
> @ Dmitry, Aleksandr - Will this produce some unwanted side-effects for
> syzbot? I also think it's safe, but just double checking.

I do not see any problems with this.

> > Link: https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/kcov.c?h=v6.14#n179 [1]
> > Signed-off-by: Kees Cook <kees@kernel.org>
>
> Acked-by: Marco Elver <elver@google.com>
>
> > ---
> > Cc: Marco Elver <elver@google.com>
> > Cc: Andrey Konovalov <andreyknvl@gmail.com>
> > Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: <x86@kernel.org>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > Cc: Hou Wenlong <houwenlong.hwl@antgroup.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Cc: <kasan-dev@googlegroups.com>
> > ---
> >  arch/x86/include/asm/init.h | 2 +-
> >  include/linux/init.h        | 4 +++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
> > index 8b1b1abcef15..6bfdaeddbae8 100644
> > --- a/arch/x86/include/asm/init.h
> > +++ b/arch/x86/include/asm/init.h
> > @@ -5,7 +5,7 @@
> >  #if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 170000
> >  #define __head __section(".head.text") __no_sanitize_undefined __no_stack_protector
> >  #else
> > -#define __head __section(".head.text") __no_sanitize_undefined
> > +#define __head __section(".head.text") __no_sanitize_undefined __no_sanitize_coverage
> >  #endif
> >
> >  struct x86_mapping_info {
> > diff --git a/include/linux/init.h b/include/linux/init.h
> > index ee1309473bc6..c65a050d52a7 100644
> > --- a/include/linux/init.h
> > +++ b/include/linux/init.h
> > @@ -49,7 +49,9 @@
> >
> >  /* These are for everybody (although not all archs will actually
> >     discard it in modules) */
> > -#define __init         __section(".init.text") __cold  __latent_entropy __noinitretpoline
> > +#define __init         __section(".init.text") __cold __latent_entropy \
> > +                                               __noinitretpoline       \
> > +                                               __no_sanitize_coverage
> >  #define __initdata     __section(".init.data")
> >  #define __initconst    __section(".init.rodata")
> >  #define __exitdata     __section(".exit.data")
> > --
> > 2.34.1
> >
