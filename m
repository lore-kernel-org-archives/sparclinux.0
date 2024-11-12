Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419CF189F37
	for <sparclinux@vger.kernel.org>; Tue, 12 Nov 2024 05:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731389952; cv=none; b=FT8GEiHrM6PvoIKvDhPzHlyN3IxisD33/lSvABnGuXc6JGMYYr+APnJ1fUlp0hGF8F4MekfAtHkkig+myTowUM0gOipsH2SoQ2JOHUM6hS11HHeTcsTJuhBcPBiPqXaRSWTXFrwsLNJ5CWzPgeoKUVGzZ464hZ1Tsz+r0Ut/2NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731389952; c=relaxed/simple;
	bh=uPqiSb8byFUHmsowxYv/8nM0c5ourBGwRMRpZWMY6HE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1seALFjnh//LTLyM0wqRi7r9RoEv7ErqK8uaZwz03Cbd9IODBotTYDGID5I4Jj3uObl5xO8hu1kEIRqxmJ/vfxnUhj7oFoIYsfPSy4cv41TrJcQ3V1+sYqvO+z9dVAAnBF3AyNs/LKgHFXgqoLOLAuOYRjDZL/vY6UIZdVg/Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qH4ebDfP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qH4ebDfP"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c87b0332cso76645ad.1
        for <sparclinux@vger.kernel.org>; Mon, 11 Nov 2024 21:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731389950; x=1731994750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55eFBaAwUzqb5NuE4EUBIHlElwP7vcU1g64jX0opSSs=;
        b=qH4ebDfP6ijqYgnuViO6dxQZ1g5HT0JMc6WfG7oeyAReFbvJmPewjIBI8zXgjP12n+
         4hR9BaHgXwuLNsunJ7vWkt0k/ogRKxc3zsmX7NVYWuYuZ2JaIM5aLJPd8D78F7JSBQ2X
         MM1Ns9wop/HsMXVq6O3WgJwiLbvoHYqY74xSb2TO9FPOUZ9Q1bXtHQAB73/he06JPma9
         BznC2rCQHEHPJtyUtzRUkYwsf5GpSMDYQeIN2RHOlhciQVSTVJPAAOYyyEEuP2iFV/XK
         1Gd67jbVXblgwcBEyxfrMjiwPyPwPFoNGeoiFcD6BArPXaHGzD7GNKr2grz5bmSL51uP
         VjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731389950; x=1731994750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55eFBaAwUzqb5NuE4EUBIHlElwP7vcU1g64jX0opSSs=;
        b=JpPYRpqCzpMFvHvVcfDGrsp4HkrgEauLP7tPoXeRDozt0fka43QNJ+iDYk6qJhj4mR
         y9VyB11y5kqrLzPN6GYtoFwkmGX1LIgRjfL0UmKCBnfcU27zFk/PtlaV0GbtOkCO/zP+
         JzFtBXMPKPIsbb8o3q358Ovuk7vkrkKnonBoRzcd6i2IvIFBNss/aAjyynMhRiDe3Sos
         ZUzxnKtqtTuV8kQFzAp/rm657BI5PtnHc3MaJEoXJko8wH17/4Uwb77B59e70AElAkIM
         Tta3b8L2U3kktTSEOwYsv67uFu/wXLStGj5fwNiKUTs+ELNZ8/sPJFB/kKjh5/eb7rYa
         wdtw==
X-Forwarded-Encrypted: i=1; AJvYcCVzAA6InG/zaghlfF1aWVT3A2QLjFn1RtUbTij9QMV72/WtLGLSASFCRfv6djNLhEl9uFe6ArFEJkXP@vger.kernel.org
X-Gm-Message-State: AOJu0YwBarA+SFQ3iahg0UbndpaFj8nC74U1lt+0P+20uRbBdsuYeNiq
	C6xnBJ+yS2dnb+C11SGp+KRDfL6DUdYoz9y+v4nXNyYABXvPgph1UsTYXjYQZKmpRKXqqs3/89b
	OrDEPEnHH32FymWNAwPqM2auHi0pPA+ltycwx
X-Gm-Gg: ASbGncvL3/LJgrzyYBqvtviLCsXd1cQA3QIr8w/qZSbj5euDTytnktjHCoZ7HChPnwO
	BQkWb7RXPDmRvGwtCFfLrr1/lUrh07ZZ7fSVyYM9J80P2hK7wFL7M6THNo+o=
X-Google-Smtp-Source: AGHT+IFsphJ8eFdvWIvqWQJAgfm/UGMVMERlMSqtsqzVfe10VnOKJwtxRF+0T1N3Dqc2Vm4wT9mbQhx6mGE7tRGz4Fc=
X-Received: by 2002:a17:902:d2cc:b0:1fc:548f:6533 with SMTP id
 d9443c01a7336-211ace77d55mr809315ad.3.1731389949340; Mon, 11 Nov 2024
 21:39:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026051410.2819338-1-xur@google.com> <20241026051410.2819338-4-xur@google.com>
 <44193ca7-9d31-4b58-99cc-3300a6ad5289@gmail.com> <CAF1bQ=ShjoEQZGPjDoy_B6wZdD_jr-RevVXwEDPA_-o-Ba0Omg@mail.gmail.com>
 <e7cd2746-0ad8-452f-aa12-e3a37e8a9288@gmail.com> <CAF1bQ=SYeeKLUTfbqw-KH1rHJCj_CfJBuk+mZUrnnb7aDjRV2A@mail.gmail.com>
In-Reply-To: <CAF1bQ=SYeeKLUTfbqw-KH1rHJCj_CfJBuk+mZUrnnb7aDjRV2A@mail.gmail.com>
From: Rong Xu <xur@google.com>
Date: Mon, 11 Nov 2024 21:38:57 -0800
Message-ID: <CAF1bQ=R18HLC2vjCGj+M=VYidrVzz3RT=U8cckXgpgrxc0kG0Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] Adjust symbol ordering in text output section
To: Klara Modin <klarasmodin@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, 
	Breno Leitao <leitao@debian.org>, Brian Gerst <brgerst@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Li <davidxl@google.com>, 
	Han Shen <shenhan@google.com>, Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Wei Yang <richard.weiyang@gmail.com>, 
	workflows@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Maksim Panchenko <max4bolt@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Yabin Cui <yabinc@google.com>, Krzysztof Pszeniczny <kpszeniczny@google.com>, 
	Sriraman Tallam <tmsriram@google.com>, Stephane Eranian <eranian@google.com>, x86@kernel.org, 
	linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I compared the System.map files from Klara Modin. The linker script is
doing what I expected: relocating the unlikely executed functions to the
beginning of the .text section.

However, the problem is with the _stext symbol. It belongs to the
.text section, so
it is positioned after the unlikely (or hot) functions. But it really
needs to be
the start of the text section.

I checked all vmlinux.lds.S in arch/, I found that most archs
explicitly assign _stext to the same address as _text, with the
following 3 exceptions:
  arch/sh/kernel/vmlinux.lds.S
  arch/mips/kernel/vmlinux.lds.S
  arch/sparc/kernel/vmlinux.lds.S

Note that we already partially handled arch/sparc/kernel/vmlinux.lds.S
for sparc64.
But we need to handle sparc32 also.

Additionally, the boot/compressed/vmlinux.lds.S also the TEXT_TEXT
template. However,
I presume these files do not generate the .text.unlikely. or
.text.hot.* sections.

I sent the following patch to Klara because I don't have an
environment to build and test.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.=
S
index 9ff55cb80a64..5f130af44247 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -61,6 +61,7 @@ SECTIONS
        /* read-only */
        _text =3D .;      /* Text and read-only data */
        .text : {
+               _stext =3D .;
                TEXT_TEXT
                SCHED_TEXT
                LOCK_TEXT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

If Klara confirms the fix, I will send the patch for review.

Thanks,

-Rong


On Mon, Nov 11, 2024 at 2:39=E2=80=AFPM Rong Xu <xur@google.com> wrote:
>
> In the new System.map, we have:
> ffffffff81112400 T _stext
>
> This looks wrong. It should point to the beginning of the text, like
> ffffffff81100400 T _stext
>
> I'll do some debugging on this.
>
> -Rong
>
> On Mon, Nov 11, 2024 at 1:32=E2=80=AFPM Klara Modin <klarasmodin@gmail.co=
m> wrote:
> >
> > On 2024-11-11 21:43, Rong Xu wrote:
> > > Thanks for reporting this issue!
> > >
> > > I'm assuming your kernel build enables dead code elimination and
> > > uses the --ffunction-sections compiler flag. Without this patch, all
> > > the functions
> > > -- I think there are only .text.unlikely.* and .text.* are grouped
> > > together in the
> > > final vmlinux. This patch modifies the linker script to place
> > > .text.unlikely.* functions
> > >   before .text.* functions. I've examined arch/mips/kernel/vmlinux.ld=
s.S, and
> > > haven't found any obvious issue.
> > >
> > > Can you send me the following?
> > > (1) the kernel build command
> > > (2) System.map without the patch
> > > (3) System.map with the patch
> > >
> > > Best regards,
> > >
> > > -Rong
> > >
> > I don't set -ffunction-sections explicitly but it seems to be used when
> > I look at the .cmd files. The build command is nothing fancy, I just se=
t
> > ARCH=3Dmips CROSS_COMPILE=3Dmips64-unknown-linux-gnuabin32- and build w=
ith
> > make -j24.
> >
> > I've attached the System.map, built on next-20241111 as well as it with
> > this series reverted.
> >
> > Regards,
> > Klara Modin
