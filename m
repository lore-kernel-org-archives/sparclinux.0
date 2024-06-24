Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A8D1A01B7;
	Mon, 24 Jun 2024 20:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719260090; cv=none; b=R4uSLv7/10kI+T3nZst7Vp28ALfU0S5hjKpZbLQjT3XoQ7gBF0dw4C8QlPcZZfF8sl1g9/hVhawG6vNqDjA0XcROadiu4DmefBtYlJSn83S3nVZVN5wDEbgjfrrkLYzlqDAb1jFsnJgaz4XytcHqn5ZYScy3yvSw1Wy6SAN60Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719260090; c=relaxed/simple;
	bh=B7G4o+wl4uVsOmOk5mkRzYTclrWJ1qPeYOyEfL5YUNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HihgAvXUE2zMnqReZJD20UljoxvOBMmstHvnWLuTSWnm4SvvQ0Sej2xmQ3GSEHj3k2pg4kyTgMEwZCNvPPubpxI8a7RHq3fyuqd743XdM1Q4wR2oJgUhzFQwdhrIHRI1INpRvLfP33NJELbk99dhEREmQuJyUSNdeQ8r5WMisCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuFvNqsB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuFvNqsB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD15C2BBFC;
	Mon, 24 Jun 2024 20:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719260089;
	bh=B7G4o+wl4uVsOmOk5mkRzYTclrWJ1qPeYOyEfL5YUNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nuFvNqsBwAJtlu4pr/J7euof725uBNi2M7AwbpWG+GLkXBxGcxi4M4b0bSxKclnZX
	 OVGOsA+MXgga4gPerliU6Kaw2x/QrA6zXG50VYbq48Fqy1eUvNxf3iKXW1sr+DLYf4
	 iqHq69B0OaV1VNTvklt9o7C5NZ0qufAAvwJl0AHg3q00g3ta3c2ZRHUoK3+YhPyp2L
	 Sz0ulQ6AmLS1sf+kyvbfm/Xz+LDDoRpGaOQdTN31nUkRs1BuDDHaCUGWLTgHBM67BL
	 HDtx89T3wCoxd67+IPDu1RlPBvwfM3PZHWkxB1/TLpOJ2unp6CbEF5MJxPV1vdx5MM
	 k/5NDuyZN7kAA==
Date: Mon, 24 Jun 2024 13:14:47 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Koakuma <koachan@protonmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, glaubitz@physik.fu-berlin.de,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] sparc/build: Make all compiler flags also
 clang-compatible
Message-ID: <20240624201447.GA774138@thelio-3990X>
References: <20240620-sparc-cflags-v1-1-bba7d0ff7d42@protonmail.com>
 <20240621185345.GA416370@thelio-3990X>
 <e26PTXUXEz8OYXmaeKn4Mpuejr4IOlFfFwdB5vpsluXlYiqDdlyQTYcDtdAny_o4gO4SfPeQCCN2qpyT6e0nog5EaP3xk2SeUPTrF54p1gM=@protonmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e26PTXUXEz8OYXmaeKn4Mpuejr4IOlFfFwdB5vpsluXlYiqDdlyQTYcDtdAny_o4gO4SfPeQCCN2qpyT6e0nog5EaP3xk2SeUPTrF54p1gM=@protonmail.com>

Hi Koakuma,

On Sat, Jun 22, 2024 at 12:18:17PM +0000, Koakuma wrote:
> Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > I saw through the LLVM issue above that one other patch is necessary to
> > fix an issue in the vDSO [1], which I applied in testing this one. 
> 
> Mhmm, I did not submit that yet because I don't feel fully confident
> with it. I think it should probably live in include/vdso/math64.h
> as plain C code instead of the current asm version, but I don't know
> what is the proper way to check the current environment's word size.
> Is checking BITS_PER_LONG enough, or should I do it in another way?

Yes, I believe that is what BITS_PER_LONG is there for, you will see
other checks in the tree for that. You could also reach out to the
maintainers of the generic vDSO infrastructure to see if they have any
ideas or suggestions for integration.

> > I noticed in applying that change that you appear to be working on 6.1,
> > which is fine for now, but you'll need another diff once you get to a
> > newer version, as we stopped using CROSS_COMPILE to set clang's
> > '--target=' value:
> > 
> > diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> > index 6c23c6af797f..2435efae67f5 100644
> > --- a/scripts/Makefile.clang
> > +++ b/scripts/Makefile.clang
> > @@ -10,6 +10,7 @@ CLANG_TARGET_FLAGS_mips := mipsel-linux-gnu
> > CLANG_TARGET_FLAGS_powerpc := powerpc64le-linux-gnu
> > CLANG_TARGET_FLAGS_riscv := riscv64-linux-gnu
> > CLANG_TARGET_FLAGS_s390 := s390x-linux-gnu
> > +CLANG_TARGET_FLAGS_sparc := sparc64-linux-gnu
> > CLANG_TARGET_FLAGS_x86 := x86_64-linux-gnu
> > CLANG_TARGET_FLAGS_um := $(CLANG_TARGET_FLAGS_$(SUBARCH))
> > CLANG_TARGET_FLAGS := $(CLANG_TARGET_FLAGS_$(SRCARCH))
> 
> Yeah, I was working with 6.1 at that time since it's the version
> that my distro have installed for me. Now this is more of a workflow

That makes sense. I do think you should start working off of a more
recent version (ideally at least mainline) for your future revisions,
just so that your patches can be applied with less friction on
maintainers. That can help your patches get picked up quicker :)

> question, but this means I should submit a v2 with this change
> merged in with mine too, right?

Here is what I would do:

1. Either keep this patch the way that it is or break it up into two
   separate patches (especially given Adrian's other review comment):

   One for removing the '-fcall-used' flags, with the comments about how
   it does not impact the ABI and the registers can still be used in
   assembly if needed, perhaps with some benchmarks with any codegen?
   Might not be strictly necessary since Sam did not seem opposed in the
   previous discussion.

   One for changing the vDSO from '-mv8plus' to '-mcpu=v9' (if this is
   still okay).

2. Add another patch with that diff above with some notes about what was
   tested to justify allowing this now.

You'll end up with either a two or three patch series. I would send this
series to both the SPARC people that you have added here along with the
Kbuild and ClangBuiltLinux folks, which you can get from the output of

  $ scripts/get_maintainers.pl scripts/Makefile.clang

or use 'b4 prep --auto-to-cc' after crafting the series, since it
appears you used it for this series. For the cover letter, you can add
some commentary about what was tested and request integration from
either the SPARC folks or Masahiro, depending on who wants to carry the
changes, since they should go through one tree atomically ideally.

If you have any questions about or issues with that comment or any other
aspect of this process, I am happy to answer or clarify as necessary!
I am in the #clang-built-linux channel in the LLVM Discord and
#clangbuiltlinux on Libera if anything comes up.

> And thanks for the feedback!

Always happy to help get more people involved with the kernel,
especially from the clang/LLVM side :)

Cheers,
Nathan
