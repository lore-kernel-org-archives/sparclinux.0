Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF323A9DAB;
	Thu, 14 May 2026 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778763505; cv=none; b=K6lXlbPB7xtVwiaIvE8XIMKPjaaWc/Mbdq+83hBCHb8/YRwEwzA5PMtodn4QoNjGtZChgnDoZI0PaLzVgczJnH80zR0FG2ENDmF1hsBtUFAnR/o/J8qIyFv7jhvRpKFeno0tiRDvqZl+RI40V5y1XoTcBNOh8I2AVJYubhfn1Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778763505; c=relaxed/simple;
	bh=5j0zLftrTYeR/dXYSD1cHEH4QFHCsXKqFp7+LkFOHPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PT/kn4EmsKlC/vSQ+VHt4RKDNQPKdEanMFbq1xrbq8owdWMVNo/K7E/5cI842tXqK+Od5iYCw14fvJzRRjRoj0OsARBrmArjH1R6jMCHOHae/8bnGM8xGHQvZ3B/1ujttDydSQxD2ZfRbOZ+MkK9VGNN+OgETdpRr4UG6RlBr74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+cycaDl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+cycaDl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31B9C2BCC7;
	Thu, 14 May 2026 12:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778763505;
	bh=5j0zLftrTYeR/dXYSD1cHEH4QFHCsXKqFp7+LkFOHPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a+cycaDlny3HX/qMikK6TftENRg4Vupep/m6zrXp6R96+6fbM9yn99j/N8iqsFrMA
	 4dTtCGFJElHoE1dX4nWnEoXvaddx2RhKnG/cTQPinisTBWqeabnWcVzy77V08QAzno
	 qQlAJt9ta1fQUQKd5mMIbH91kFyzA62J5d6ZnVGnILhGIl4Ph03ZmrTEjQpKBK+cdF
	 X6A17y22VLQoZ4czjMFlptwXpZTgNcDIdI+StYJn/FOJDdOQ6M/+IGrGbgfyJMQ8rS
	 P+hYbK+8jeWkVCpayp5c44CmabdfHlHBBFzhVF4ZVU9DGeaD5SNWtvw38Kx4kJtXZh
	 AiUPkGoQuEx0g==
Date: Thu, 14 May 2026 21:58:20 +0900
From: Nathan Chancellor <nathan@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Christian Brauner <brauner@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:\\b(?i:clang|llvm)\\b" <llvm@lists.linux.dev>,
	Koakuma <koachan@protonmail.com>
Subject: Re: [PATCH] sparc: Avoid unsupported LLD branch relocations
Message-ID: <20260514125820.GB1781775@ax162>
References: <20260514041908.874355-1-rosenp@gmail.com>
 <f8a58a8d567149f514f2f5f47af25905f254f72f.camel@physik.fu-berlin.de>
 <CAKxU2N_p7unDCif826jpTUtzs8=-ZoKw4u-Eg1UEM+4o+5Fbzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N_p7unDCif826jpTUtzs8=-ZoKw4u-Eg1UEM+4o+5Fbzg@mail.gmail.com>

+ Koakuma

On Wed, May 13, 2026 at 10:34:44PM -0700, Rosen Penev wrote:
> On Wed, May 13, 2026 at 10:03 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> >
> > Hi Rosen,
> >
> > On Wed, 2026-05-13 at 21:19 -0700, Rosen Penev wrote:
> > > LLD does not support several SPARC branch relocation types, including
> > > R_SPARC_WDISP16, R_SPARC_WDISP19, and R_SPARC_WDISP22. A sparc64
> > > allmodconfig LLVM build can therefore fail when trap table code and
> > > low-level assembly leave branches to global symbols for the linker.
> > >
> > > Use local labels for branches that stay within the same assembled
> > > object so the assembler can resolve them directly. Convert the
> > > remaining cross-object branches and tail calls to absolute set/jmpl
> > > sequences, which LLD handles through the usual HI22/LO10 relocations.
> > >
> > > Disable the unused sparc32 syscall trace entry points when compat
> > > support is not built, and request sys_llseek for the native syscall
> > > table so the LLD allmodconfig build remains self-contained.
> >
> > I would rather fix LLD than making such intrusive changes to the SPARC
> > code in the kernel. In particular, since this touches the CPU-optimized
> > memory routines which had been haunted by subtle bugs for years and were
> > only fixed recently.
> >
> > Is improving LLD in this case not possible?
> Above my paygrade. I use this so that allmodconfig succeeds.

We document sparc64 as only having support for clang as the compiler
(not even supporting the integrated assembler yet, although maybe that
needs to be updated [1]?) in Documentation/kbuild/llvm.rst, so I don't
think we should take a patch like this. As far as I am aware, ld.lld
work for sparc64 has not happened yet to make it work with the kernel.
If you need to test with clang, use CC=clang LLVM_IAS=0 with GNU
binutils (CROSS_COMPILE=sparc64-linux-gnu-).

[1]: https://github.com/llvm/llvm-project/issues/40792

-- 
Cheers,
Nathan
