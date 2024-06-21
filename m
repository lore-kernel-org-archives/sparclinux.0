Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD378C1E;
	Fri, 21 Jun 2024 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718996028; cv=none; b=tu1yG56hH3xDK4AsgMYiL6TTcJ1ly+CHUP0euHcXsbK1jhk8zqMAjs1lE8m3IRT2ZPmaQPhbVvbDPxuQdDNpkUru5m9BgYc2+kUI9WOf2wYqzSe41IdrpZdbrky1bYeIWJqNWskVcDWMfAI2ORoOsE6iwIJQUlNRRuozmZjrNmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718996028; c=relaxed/simple;
	bh=hm5f2+i7cXJarAwmiNoIflF+PrKQZDZQu56AYioULBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5+E7TxoPnlDcPRX8kdJD56/uViTVdZSuSOAsO1lz7iYUPf7CMaYaKnWfOlkGW92BTjAUuPxHFLYEwkUvt0JBIq9YfH0UZ9B+JtLaH3ELI7pR0dHvZLJFIYXgRABjJ4JTZnxXs/rRRhoUhJTABeiqCPFVOkgpC/rJe8ZvzpSHjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcwVBeeG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcwVBeeG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409AFC2BBFC;
	Fri, 21 Jun 2024 18:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718996027;
	bh=hm5f2+i7cXJarAwmiNoIflF+PrKQZDZQu56AYioULBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JcwVBeeGy57t2forSPBBIiNj8kTQyzytn8dXe1VDM00TY5CeINfsetk77T90jLHmm
	 1WL6mGvBf3oTdG5f0ZStU9iCBRFMdybWYufqdwANHiMb8v430U/ZVDn7KebeImZK7Q
	 x+/TubCx/983MpznrKEW9sT4kgEfLPOWF9lYp+a4JUGbzSe2MW6MV1GrHrpWmbL4wl
	 Gf2pM5aK4Avmpw6kMIJ61Xo+IjoMcf+T7wFZRp2VjicUyQfOT0iNSjuX8Dcbn6Sfr9
	 Zl8bUcfJV0hzRNPxIOQoSls+IrVFPl9+IJ3p/GOjjztukmkYq9j4cnCmHgKYNztNqB
	 itr9RDInrPG1w==
Date: Fri, 21 Jun 2024 11:53:45 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: koachan@protonmail.com
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, glaubitz@physik.fu-berlin.de,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] sparc/build: Make all compiler flags also
 clang-compatible
Message-ID: <20240621185345.GA416370@thelio-3990X>
References: <20240620-sparc-cflags-v1-1-bba7d0ff7d42@protonmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620-sparc-cflags-v1-1-bba7d0ff7d42@protonmail.com>

Hi Koakuma,

On Thu, Jun 20, 2024 at 10:56:00PM +0700, Koakuma via B4 Relay wrote:
> From: Koakuma <koachan@protonmail.com>
> 
> Remove flags not supported by clang and make sure that all the flags
> used are portable between clang and GCC.
> 
> The reasoning for removing the -fcall-used* ones is as follows:
> 
> In the (normal) 32-bit ABI, %g5 and %g7 is normally reserved, and in
> the 64-bit ABI, %g7 is the reserved one.
> Linux turns them into volatile registers by the way of -fcall-used-*,
> but on the other hand, omitting the flags shouldn't be harmful;
> compilers will now simply refuse to touch them, and any assembly
> code that happens to touch them would still work like usual (because
> Linux' conventions already treats them as volatile anyway).
> 
> Signed-off-by: Koakuma <koachan@protonmail.com>
> ---
> Hello~
> 
> This changes the CFLAGS for building the SPARC kernel so that it can be
> built with clang, as a follow up from the discussion in this thread:
> 
> https://lore.kernel.org/lkml/JAYB7uS-EdLABTR4iWZdtFOVa5MvlKosIrD_cKTzgeozCOGRM7lhxeLigFB1g3exX445I_W5VKB-tAzl2_G1zCVJRQjp67ODfsSqiZWOZ9o=@protonmail.com/T/#u
> 
> The changes are removal of various `-fcall-used-*` flags, and changing
> `-mv8plus` to `-mcpu=v9`:
> 
> - `-fcall-used-*` flags should be safe to remove; the compiler will
>   stop using the registers specified as temporaries, but it is a safe
>   change wrt. the ABI. Assembly code can still use those registers
>   as needed.
>   It does bring a theoretical possible slowdown due to the compiler
>   having less registers to work with, but in practice - in my case,
>   at least - it seems to not make any difference with daily usage.
> 
> - More trivial is to change `-mv8plus` -> `-mcpu=v9`.
>   This should be safe too since the kernel seems to require a V9
>   processor to run anyway, so I'm changing the flag to one that is
>   portable between GCC and clang.
> 
> Also, as stated in the thread, building with these changes still result
> in a working kernel, at least for Sun T5120 and qemu virtual machines.
> 
> On the LLVM side, the effort for building Linux/SPARC is tracked here:
> https://github.com/llvm/llvm-project/issues/40792

This is really awesome to see, thanks for sending this patch!

I think a good amount of the reasoning below the '---' could probably
make it into the commit message as well but I don't have much of a
vision there, maybe one of the SPARC folks will.

I saw through the LLVM issue above that one other patch is necessary to
fix an issue in the vDSO [1], which I applied in testing this one. I
noticed in applying that change that you appear to be working on 6.1,
which is fine for now, but you'll need another diff once you get to a
newer version, as we stopped using CROSS_COMPILE to set clang's
'--target=' value:

diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
index 6c23c6af797f..2435efae67f5 100644
--- a/scripts/Makefile.clang
+++ b/scripts/Makefile.clang
@@ -10,6 +10,7 @@ CLANG_TARGET_FLAGS_mips		:= mipsel-linux-gnu
 CLANG_TARGET_FLAGS_powerpc	:= powerpc64le-linux-gnu
 CLANG_TARGET_FLAGS_riscv	:= riscv64-linux-gnu
 CLANG_TARGET_FLAGS_s390		:= s390x-linux-gnu
+CLANG_TARGET_FLAGS_sparc	:= sparc64-linux-gnu
 CLANG_TARGET_FLAGS_x86		:= x86_64-linux-gnu
 CLANG_TARGET_FLAGS_um		:= $(CLANG_TARGET_FLAGS_$(SUBARCH))
 CLANG_TARGET_FLAGS		:= $(CLANG_TARGET_FLAGS_$(SRCARCH))

With those, I can successfully build a kernel with clang that boots in
QEMU :)

  $ make -skj"$(nproc)" \
         ARCH=sparc64 \
         CC=clang \
         CROSS_COMPILE=sparc64-linux-gnu- \
         LLVM_IAS=0 \
         mrproper defconfig all

  $ qemu-system-sparc64 \
        -serial mon:stdio \
        -display none \
        -no-reboot \
        -M sun4u \
        -cpu 'TI UltraSparc IIi' \
        -m 512 \
        -append console=ttyS0 \
        -initrd sparc64-rootfs.cpio \
        -kernel arch/sparc/boot/image
  ...
  [    1.788544] Run /init as init process
  ...
  Linux version 6.10.0-rc4+ (nathan@thelio-3990X) (ClangBuiltLinux clang version 19.0.0git (https://github.com/llvm/llvm-project a083e50f53f0f9eb9ad0c5b65f3c627cf97043e6), GNU ld (GNU Binutils) 2.42) #1 SMP Fri Jun 21 11:36:18 MST 2024
  ...

Consider this:

Tested-by: Nathan Chancellor <nathan@kernel.org>

[1]: https://github.com/koachan/linux-clang/commit/c0114bfc7a4f64bc4d3e63eca6582ec827a8e2a2

> ---
>  arch/sparc/Makefile      | 4 ++--
>  arch/sparc/vdso/Makefile | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
> index 757451c3ea1d..7318a8b452c3 100644
> --- a/arch/sparc/Makefile
> +++ b/arch/sparc/Makefile
> @@ -29,7 +29,7 @@ UTS_MACHINE    := sparc
>  # versions of gcc.  Some gcc versions won't pass -Av8 to binutils when you
>  # give -mcpu=v8.  This silently worked with older bintutils versions but
>  # does not any more.
> -KBUILD_CFLAGS  += -m32 -mcpu=v8 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
> +KBUILD_CFLAGS  += -m32 -mcpu=v8 -pipe -mno-fpu
>  KBUILD_CFLAGS  += -Wa,-Av8
>  
>  KBUILD_AFLAGS  += -m32 -Wa,-Av8
> @@ -45,7 +45,7 @@ export BITS   := 64
>  UTS_MACHINE   := sparc64
>  
>  KBUILD_CFLAGS += -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow
> -KBUILD_CFLAGS += -ffixed-g4 -ffixed-g5 -fcall-used-g7 -Wno-sign-compare
> +KBUILD_CFLAGS += -ffixed-g4 -ffixed-g5 -Wno-sign-compare
>  KBUILD_CFLAGS += -Wa,--undeclared-regs
>  KBUILD_CFLAGS += $(call cc-option,-mtune=ultrasparc3)
>  KBUILD_AFLAGS += -m64 -mcpu=ultrasparc -Wa,--undeclared-regs
> diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
> index 243dbfc4609d..929140facabf 100644
> --- a/arch/sparc/vdso/Makefile
> +++ b/arch/sparc/vdso/Makefile
> @@ -46,7 +46,7 @@ CFL := $(PROFILING) -mcmodel=medlow -fPIC -O2 -fasynchronous-unwind-tables -m64
>         -fno-omit-frame-pointer -foptimize-sibling-calls \
>         -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
>  
> -SPARC_REG_CFLAGS = -ffixed-g4 -ffixed-g5 -fcall-used-g5 -fcall-used-g7
> +SPARC_REG_CFLAGS = -ffixed-g4 -ffixed-g5
>  
>  $(vobjs): KBUILD_CFLAGS := $(filter-out $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(SPARC_REG_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
>  
> @@ -86,7 +86,7 @@ KBUILD_CFLAGS_32 += -fno-stack-protector
>  KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
>  KBUILD_CFLAGS_32 += -fno-omit-frame-pointer
>  KBUILD_CFLAGS_32 += -DDISABLE_BRANCH_PROFILING
> -KBUILD_CFLAGS_32 += -mv8plus
> +KBUILD_CFLAGS_32 += -mcpu=v9
>  $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
>  
>  $(obj)/vdso32.so.dbg: FORCE \
> 
> ---
> base-commit: 92e5605a199efbaee59fb19e15d6cc2103a04ec2
> change-id: 20240620-sparc-cflags-e7f2dbbd4b9d
> 
> Best regards,
> -- 
> Koakuma <koachan@protonmail.com>
> 
> 
