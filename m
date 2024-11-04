Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F91D178384
	for <sparclinux@vger.kernel.org>; Mon,  4 Nov 2024 04:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730695826; cv=none; b=OX7xA1abX7pCtukVo4uZN29YavKqhShoWKfwQ7g7oGz3gY8lIZOdauJ9pIYXXzshn4FVCEbRVSKTyTJp5NWv0h5BKxR8at3olvJDxBlQW8WR357MEOYSkvzQy7Dyt1rcRPOwOJJp4sA+2uxxk47KyCJRXQ+nBucjrTY8N4anGwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730695826; c=relaxed/simple;
	bh=yHLwBvRcDmvZBD3Q2o8biW6+ZyYq54VMM35NculsqtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KX0qweYEd66lyE3xyKZg+hRq3UPgBLfQ4E4p3IFBzUNisFSdCMMC9EZ7gSIXHNwlDjJF4fISxnkngsJLQOm6wzqYStOSzdImFA7qZ5MW6Flaxdf+R8nj5Xe7s2WgV8ydTMVvSWKcW5b/KPXnPD1FS1noHdko3bhjQM/I2bS3vjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SWgK+I07; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SWgK+I07"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b15eadee87so295999785a.2
        for <sparclinux@vger.kernel.org>; Sun, 03 Nov 2024 20:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730695821; x=1731300621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xelsbw4CYPm0pAy0Wg832CMC7u06eSjN58hX3diMwfk=;
        b=SWgK+I07yOYt0VMvJrp8V1tWatT7l0GZGHvUcbfFY9XOrEXrq29WOiiFoOERhxojIC
         vks7mAumVQkjv0etl6NtH9QgA3nHzr3EcWjPDBIzQts8L2PeXmtqUdCN0s2t1Ao4RDpr
         cTtQjhO33lFRuSpQcehH06OqZ8rzqDJHurPKE28JyMM807KVP4C60ZgAfSAjN+zx0VC0
         sfK6tA/wQr506Nu9oGGZK9gk0lTe98EswrunX7o1rZp6chwbJooQsZwd3QqsFziW0TwG
         KrnCLqTRNDFoi8EAkPCuWP2Jf386Du4pS/VT/6qrsT6jY+mpHrWRUY7IinHF1RsKZEXs
         ftVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730695821; x=1731300621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xelsbw4CYPm0pAy0Wg832CMC7u06eSjN58hX3diMwfk=;
        b=UyB8IXWkvcAXNlKMOhBpVHrD2pCNjSM21TS6x7lBa69RGF68HgM+bneVDgROOJKkax
         NiTZYhVcPd9OMf3Cl9vVo/Q3U5x15JVxTDx8do4zE/066gDW5z8xqkq7IbIAPwLBRF0n
         YXdl1Oxc8WZpb4Rrrt6I2+WwIXi96kYGnzPhRia162R/+JzDChZ+ihCC2H/uvaSAXytG
         cym8WghQJ55RD0R5Zuk0DOd/JqOr/vjWpqlqeTzf3QbYrMdhMtEsJH45OcUEBy5HNI7H
         s+IYkI7FXqHF4m33vCHU/MqJUy2d2bUuZLMewI5gMYp3P6tz+MWCS4+lN6fHHhy/Zmkf
         twtA==
X-Forwarded-Encrypted: i=1; AJvYcCWNHoduXPEgqpYJZao6Ob+mTerA+/75JgKNj/SFHQ+rXoG0ujqejxT3qEdCv1sEjSdREPWo3kB5Ml7N@vger.kernel.org
X-Gm-Message-State: AOJu0Yz18zcFRgpq7QUmT3/yNS+78CrSNk0dM7FC/lm+LQqDLaie5fqL
	AKMX8R3Tw3Mxi2Yv/3YIIbpY/pllJ40/eVY+uc6op51A/3Z4Mx5nO/nVyMCZR3TjrW14YO0Fxuz
	WnZc8kHY+9qTw7Sgw8TJgb2KaTk4eub9l8EoL
X-Google-Smtp-Source: AGHT+IF2tDFS5vlJFQGEA8PSXd+4TNc7lauPgQRDf2fcZBAWgQ+PxfptvywKq5K3S+F5pPhyHSNjQzY8mD3d0dhW7vA=
X-Received: by 2002:a05:6214:5508:b0:6ce:2519:5dd7 with SMTP id
 6a1803df08f44-6d351af4ccdmr195294736d6.35.1730695820784; Sun, 03 Nov 2024
 20:50:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102175115.1769468-1-xur@google.com> <20241102175115.1769468-2-xur@google.com>
 <09349180-027a-4b29-a40c-9dc3425e592c@cachyos.org> <3183ab86-8f1f-4624-9175-31e77d773699@cachyos.org>
In-Reply-To: <3183ab86-8f1f-4624-9175-31e77d773699@cachyos.org>
From: Han Shen <shenhan@google.com>
Date: Sun, 3 Nov 2024 20:50:07 -0800
Message-ID: <CACkGtrgOw8inYCD96ot_w9VwzoFvvgCReAx0P-=Rxxqj2FT4_A@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] Add AutoFDO support for Clang build
To: Peter Jung <ptr1337@cachyos.org>
Cc: Rong Xu <xur@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>, 
	Brian Gerst <brgerst@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Li <davidxl@google.com>, Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, 
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

Hi Peter, thanks for reporting the issue. I am trying to reproduce it
in the up-to-date archlinux environment. Below is what I have:
  0. pacman -Syu
  1. cloned archlinux build files from
https://aur.archlinux.org/linux-mainline.git the newest mainline
version is 6.12rc5-1.
  2. changed the PKGBUILD file to include the patches series
  3. changed the "config" to turn on clang autofdo
  4. collected afdo profiles
  5. MAKEFLAGS=3D"-j48 V=3D1 LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D$(pwd)/perf.a=
fdo" \
        makepkg -s --skipinteg --skippgp
  6. install and reboot
The above steps succeeded.
You mentioned the error happens at "module_install", can you instruct
me how to execute the "module_install" step?

Thanks,
Han

On Sat, Nov 2, 2024 at 12:53=E2=80=AFPM Peter Jung <ptr1337@cachyos.org> wr=
ote:
>
>
>
> On 02.11.24 20:46, Peter Jung wrote:
> >
> >
> > On 02.11.24 18:51, Rong Xu wrote:
> >> Add the build support for using Clang's AutoFDO. Building the kernel
> >> with AutoFDO does not reduce the optimization level from the
> >> compiler. AutoFDO uses hardware sampling to gather information about
> >> the frequency of execution of different code paths within a binary.
> >> This information is then used to guide the compiler's optimization
> >> decisions, resulting in a more efficient binary. Experiments
> >> showed that the kernel can improve up to 10% in latency.
> >>
> >> The support requires a Clang compiler after LLVM 17. This submission
> >> is limited to x86 platforms that support PMU features like LBR on
> >> Intel machines and AMD Zen3 BRS. Support for SPE on ARM 1,
> >>   and BRBE on ARM 1 is part of planned future work.
> >>
> >> Here is an example workflow for AutoFDO kernel:
> >>
> >> 1) Build the kernel on the host machine with LLVM enabled, for example=
,
> >>         $ make menuconfig LLVM=3D1
> >>      Turn on AutoFDO build config:
> >>        CONFIG_AUTOFDO_CLANG=3Dy
> >>      With a configuration that has LLVM enabled, use the following
> >>      command:
> >>         scripts/config -e AUTOFDO_CLANG
> >>      After getting the config, build with
> >>        $ make LLVM=3D1
> >>
> >> 2) Install the kernel on the test machine.
> >>
> >> 3) Run the load tests. The '-c' option in perf specifies the sample
> >>     event period. We suggest     using a suitable prime number,
> >>     like 500009, for this purpose.
> >>     For Intel platforms:
> >>        $ perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c
> >> <count> \
> >>          -o <perf_file> -- <loadtest>
> >>     For AMD platforms:
> >>        The supported system are: Zen3 with BRS, or Zen4 with amd_lbr_v=
2
> >>       For Zen3:
> >>        $ cat proc/cpuinfo | grep " brs"
> >>        For Zen4:
> >>        $ cat proc/cpuinfo | grep amd_lbr_v2
> >>        $ perf record --pfm-events RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k
> >> -a \
> >>          -N -b -c <count> -o <perf_file> -- <loadtest>
> >>
> >> 4) (Optional) Download the raw perf file to the host machine.
> >>
> >> 5) To generate an AutoFDO profile, two offline tools are available:
> >>     create_llvm_prof and llvm_profgen. The create_llvm_prof tool is pa=
rt
> >>     of the AutoFDO project and can be found on GitHub
> >>     (https://github.com/google/autofdo), version v0.30.1 or later. The
> >>     llvm_profgen tool is included in the LLVM compiler itself. It's
> >>     important to note that the version of llvm_profgen doesn't need to
> >>     match the version of Clang. It needs to be the LLVM 19 release or
> >>     later, or from the LLVM trunk.
> >>        $ llvm-profgen --kernel --binary=3D<vmlinux> --
> >> perfdata=3D<perf_file> \
> >>          -o <profile_file>
> >>     or
> >>        $ create_llvm_prof --binary=3D<vmlinux> --profile=3D<perf_file>=
 \
> >>          --format=3Dextbinary --out=3D<profile_file>
> >>
> >>     Note that multiple AutoFDO profile files can be merged into one vi=
a:
> >>        $ llvm-profdata merge -o <profile_file>  <profile_1> ...
> >> <profile_n>
> >>
> >> 6) Rebuild the kernel using the AutoFDO profile file with the same con=
fig
> >>     as step 1, (Note CONFIG_AUTOFDO_CLANG needs to be enabled):
> >>        $ make LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D<profile_file>
> >>
> >> Co-developed-by: Han Shen<shenhan@google.com>
> >> Signed-off-by: Han Shen<shenhan@google.com>
> >> Signed-off-by: Rong Xu<xur@google.com>
> >> Suggested-by: Sriraman Tallam<tmsriram@google.com>
> >> Suggested-by: Krzysztof Pszeniczny<kpszeniczny@google.com>
> >> Suggested-by: Nick Desaulniers<ndesaulniers@google.com>
> >> Suggested-by: Stephane Eranian<eranian@google.com>
> >> Tested-by: Yonghong Song<yonghong.song@linux.dev>
> >> Tested-by: Yabin Cui<yabinc@google.com>
> >> Tested-by: Nathan Chancellor<nathan@kernel.org>
> >> Reviewed-by: Kees Cook<kees@kernel.org>
> >
> > Tested-by: Peter Jung <ptr1337@cachyos.org>
> >
>
> The compilations and testing with the "make pacman-pkg" function from
> the kernel worked fine.
>
> One problem I do face:
> When I apply a AutoFDO profile together with the PKGBUILD [1] from
> archlinux im running into issues at "module_install" at the packaging.
>
> See following log:
> ```
> make[2]: *** [scripts/Makefile.modinst:125:
> /tmp/makepkg/linux-cachyos-rc-autofdo/pkg/linux-cachyos-rc-autofdo/usr/li=
b/modules/6.12.0-rc5-5-cachyos-rc-autofdo/kernel/arch/x86/kvm/kvm.ko]
> Error 1
> make[2]: *** Deleting file
> '/tmp/makepkg/linux-cachyos-rc-autofdo/pkg/linux-cachyos-rc-autofdo/usr/l=
ib/modules/6.12.0-rc5-5-cachyos-rc-autofdo/kernel/arch/x86/kvm/kvm.ko'
>    INSTALL
> /tmp/makepkg/linux-cachyos-rc-autofdo/pkg/linux-cachyos-rc-autofdo/usr/li=
b/modules/6.12.0-rc5-5-cachyos-rc-autofdo/kernel/crypto/cryptd.ko
> make[2]: *** Waiting for unfinished jobs....
> ```
>
>
> This can be fixed with removed "INSTALL_MOD_STRIP=3D1" to the passed
> parameters of module_install.
>
> This explicitly only happens, if a profile is passed - otherwise the
> packaging works without problems.
>
> Regards,
>
> Peter Jung
>
