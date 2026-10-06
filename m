Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3FF3E3D85;
	Tue,  6 Oct 2026 08:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791275474; cv=none; b=g2vd3lUpYb64gNXcRQy3SepMux9nj7HP9Ye/DFcwzzWpOKH9FvqOCmUPckgloRUPPG4MFwdfRk/I545v7gbKDoyFrLAueA4efkwTfpP1V7YnYbV77B7RUhx+zvoJkpVHcYLCV4Vigz6UJtOrZmvCpY1VVBOJ1+ta3s4sSZMIdqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791275474; c=relaxed/simple;
	bh=dw6yOtBytyTKhgFHVNGniHejKQc81jawLaM9TdCdvIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CF1X9upHrzyBZ+70gDR8k2XtXVUMENZBTAVfP7J5ROgyiNr/8QXtNf4ZRiIc7lCPDCKfSncZZrcGuqtWK2kq/3shdcof7yuupHZkXNzl03vEhUvZH9OmpcAq8KHO9rRt9jX42TwkLW5deQv9UrzAFJDBW27y9gc/QmYNa1qKdfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuCxqu5I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuCxqu5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB831F000FF;
	Tue,  6 Oct 2026 08:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791275468;
	bh=ak8PJurRBhQp0IVCIZjKK7wM9FbodV5C/CtUgMGBgys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MuCxqu5I5rqjrk/Gtvq4qnv1aV46snl1PIh2jQpcXwuWpTqYvhF4yKe4yaav82Lx4
	 U3u83O8Vg/NnEMxV77Wb/Ol3foVx/7rxyrHcuro/YW5LZ/7tHrMQE0yK/15dm5Wd4O
	 n2j6wsP9JnYpowfF/AIW9u/s3LxqBgGjjbRowLoxpN9JaaELI20xgSbQlrq5elUMdO
	 jiBaVdIjd46NppDPhN6zxbVFfQUOi/Tm02Y+6PzHLHXFBuyIfKc82cZkvcFDonME0I
	 Rn7qO7oUXkyaAIO5yT2vTxb2lVcV4/2k8KkS0GgXbFybOlk05tEzKhZe7rfFtoC1YR
	 1+egQUxr4Of5g==
Date: Tue, 6 Oct 2026 10:31:03 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: Kjetil Oftedal <oftedal@gmail.com>
Cc: Rosen Penev <rosenp@gmail.com>, sparclinux@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Subject: Re: [PATCH] sparc64: Define p4d_page() instead of stubbing it to NULL
Message-ID: <20261006083103.GA3041473@ax162>
References: <20261005203930.246598-1-rosenp@gmail.com>
 <CALMQjD-udSokCKS07VFWauBQzac5BTPJqbORhskxgddsuX1vLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMQjD-udSokCKS07VFWauBQzac5BTPJqbORhskxgddsuX1vLw@mail.gmail.com>

On Tue, Oct 06, 2026 at 09:59:19AM +0200, Kjetil Oftedal wrote:
> On Mon, 5 Oct 2026 at 22:41, Rosen Penev <rosenp@gmail.com> wrote:
> >
> > A sparc64 allmodconfig build with LLVM fails in vmalloc_to_page():
> >
> >   mm/vmalloc.c: error: performing pointer arithmetic on a null pointer
> >   has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
> >
> > sparc64 defines p4d_page() as NULL, on the assumption that it is only
> > used by stubbed out hugetlb gup code. Generic code now uses it in
> > vmalloc_to_page(), ptdump and KASAN. In vmalloc_to_page() the NULL is
> > used in pointer arithmetic, which clang diagnoses even though the
> > branch is unreachable on sparc64.
> >
> 
> Has this been reported as a bug to the clang project?
> As it throwing an error on a rather obviously unreachable branch.

Technically the error part is self-inflicted on the part of the kernel
since allmodconfig enables CONFIG_WERROR. That said, while it might be
nice for the compiler not to warn in any case of dead code, that's just
not how it works for either GCC or clang (none of these should be
visible if that were the case):

  https://godbolt.org/z/K3nfW4n5f

-- 
Cheers,
Nathan
