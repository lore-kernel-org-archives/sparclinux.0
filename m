Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E779628506C;
	Thu, 14 Aug 2025 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755211216; cv=none; b=uDoC2Ou8AeCqRyYd9aJddHR2UEBNA4LNUmWIbJYrx8hq7DNEbNVLfRZd9r6x/L75B3X+HzUbuAo986uV2DsLhuptggdnFV/rLKWX5ewEQkx1FDuBM8o+N6/QGRueyuSdVbz3OFT3Hgl2fT1cO4fdSeR/ihQQxvZ/Mae3zmsKG3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755211216; c=relaxed/simple;
	bh=pTLMkLB6wXhhCVQ7joRQHX/DusPVi5mmr45iiA3nAKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fx1TTBy7uHXyjWho6fRL5PqPbZXr3nA9eOtR9CgTMU2eW20rjUc4zuJGS68SpBjIBUJes1l3lIBvJx4HBwbZMhBPixCnYsYuJu1csg4Zg9n5yDBrORne1+Ptj7J6gCYEGQrid+p3j1zUWp8ELmmt3bKehedWDrbyVCbDQ8Ukn2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=op5tjY+0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="op5tjY+0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91533C4CEF1;
	Thu, 14 Aug 2025 22:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755211214;
	bh=pTLMkLB6wXhhCVQ7joRQHX/DusPVi5mmr45iiA3nAKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=op5tjY+0coe42xZgSn92vSu4DWmxRe2EW19/jIEcpM3SHJsBeYKlvD3o15LLjjJRj
	 mSVHNMt8fwx3qWYWv7hHHyZH3KQxkfffk7SkIPsU0UefSZBkQDX/+iEexNYUv0p8fV
	 6zDTmh2m1RRSxCHk7wFrg8gu9u3ww8F93U1LfHPMuhppSsVwovAxyCkE1CjHDEjd6y
	 L27IJlSY5y38SpfmZxKJo928EwrFlBhRhxNgKn4m9u6HP6JDyuI5079dxGPb4QpqQH
	 zM33yH7IupG/ILxbKJuYAnF0r5se3Sy0DVqIj9jf+yEZ8Ukqyu7ZgTM/qDMg8PLQ6B
	 OPIXTUzHlvaFg==
Date: Thu, 14 Aug 2025 15:40:09 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Koakuma <koachan@protonmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] sparc/module: Add R_SPARC_UA64 relocation handling
Message-ID: <20250814224009.GA2217114@ax162>
References: <20250609-b4-sparc-relocs-v1-0-aa52631735af@protonmail.com>
 <20250609-b4-sparc-relocs-v1-1-aa52631735af@protonmail.com>
 <L-bOu33R0ouNodufTRVlvyqOoz0SGuskQ_bqQ4X_xBkw91w4XmezvmkG0p6Ith-rsFIKYSkQWHUdMJ_G0lyYJhtg18c-mfWWjPKiI_Or6cE=@protonmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <L-bOu33R0ouNodufTRVlvyqOoz0SGuskQ_bqQ4X_xBkw91w4XmezvmkG0p6Ith-rsFIKYSkQWHUdMJ_G0lyYJhtg18c-mfWWjPKiI_Or6cE=@protonmail.com>

On Sun, Aug 03, 2025 at 01:15:02AM +0000, Koakuma wrote:
> Koakuma via B4 Relay <devnull+koachan.protonmail.com@kernel.org> wrote:
> 
> > From: Koakuma koachan@protonmail.com
> > 
> > 
> > This is needed so that the kernel can handle R_SPARC_UA64 relocations,
> > which is emitted by LLVM's IAS.
> > 
> > Signed-off-by: Koakuma koachan@protonmail.com
> > 
> > ---
> > arch/sparc/include/asm/elf_64.h | 1 +
> > arch/sparc/kernel/module.c | 1 +
> > 2 files changed, 2 insertions(+)
> > 
> > diff --git a/arch/sparc/include/asm/elf_64.h b/arch/sparc/include/asm/elf_64.h
> > index 8fb09eec8c3e796a9a79aa0a7877842ceb7ea6d3..694ed081cf8d99adf70be25e5dc0e30a45f70398 100644
> > --- a/arch/sparc/include/asm/elf_64.h
> > +++ b/arch/sparc/include/asm/elf_64.h
> > @@ -58,6 +58,7 @@
> > #define R_SPARC_7 43
> > #define R_SPARC_5 44
> > #define R_SPARC_6 45
> > +#define R_SPARC_UA64 54
> > 
> > /* Bits present in AT_HWCAP, primarily for Sparc32. */
> > #define HWCAP_SPARC_FLUSH 0x00000001
> > diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
> > index b8c51cc23d96944037494f13d2d65a43bb187729..6e3d4dde4f9ab33040b300c40d5fd5d0584e166d 100644
> > --- a/arch/sparc/kernel/module.c
> > +++ b/arch/sparc/kernel/module.c
> > @@ -87,6 +87,7 @@ int apply_relocate_add(Elf_Shdr *sechdrs,
> > break;
> > #ifdef CONFIG_SPARC64
> > case R_SPARC_64:
> > + case R_SPARC_UA64:
> > location[0] = v >> 56;
> > 
> > location[1] = v >> 48;
> > 
> > location[2] = v >> 40;
> > 
> > 
> > --
> > 2.49.0
> 
> Ping. Is there anything else I should do for this?
> 

This seems reasonable to me, sorry for the delay in commenting. I would
expect this to go via the SPARC tree but if they are too busy or
unavailable to pick this up, we would try to route it via Andrew Morton.
Is there more work needed for the integrated assembler other than this
series?

Cheers,
Nathan
