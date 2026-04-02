Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2558332F765;
	Thu,  2 Apr 2026 10:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775126882; cv=none; b=Qi1aZ2DD99D72T4/Xjm+aqmQO4S8S8pqMzeaYooX2FnyeR3eUz0ixd+PDfRRKD2S229PoIZP9JaA4SxVBkD5q7YLnb3+AY5byCYK4zaLXx7Aa8X5SbVruSjkrsFh9l58lbGJmpOTLKqn/V2FbHCSvxsIZDuNP0Zv2F1r/r6FNrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775126882; c=relaxed/simple;
	bh=B230Lbw6fdE5XbZzjmhRsROXtHpz0lHvjcVdYsqv3+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQWt6Nr37FWfzA1bhgeZJ9wm6ydWy6ARmHnJjKJ+TCcDJawpUs6lzNh3sEusPGjpECP0vZUqKN4OfdJAAAJ6HobNuJKFZ8rIUXvAoCGofJY+BK9NoZGogeaIr1PGdggGynBbbtoOgcIBG5DtZVYt/01T3FJ4Y9h3pxqmMhNY8rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fWHvfBdk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fWHvfBdk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WuSnxkIyTO13mUz+vZ1/ml/c/eqQ5D0dK9NUy7xy4Pw=; b=fWHvfBdkYBp1lDE/7yjJLeJyG4
	TDG024jO+otVJtwiymsQjjwAfzXysI0Ne/Hap+hOUQ6HF3At22XcXejbtpYlWZVb7GLO9iSy8lBz/
	xXoiPgVJTNjnS6NdQ+JrLTq5kguJS2cahxS6gs3sXaw3b07PcCyOKgqMNnJYuSMZkSWQ1zbwrH1lL
	oQvCfWFVfYg2y5n87Si+3p5rgef7vqX5HJwvSTsRp8czWpsWUtQti6XMSrgnlzRPw7jmDhnI0sbSY
	FLNqQFUUhtoZK6LgqB9dMKy1Plr2pBXtNoo1Rj1bEdri+YGju2kRuh4KtAyO/E8p9i0u4EW5ey6u+
	j2zCRXxw==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8FaH-00000002G2g-3cX8;
	Thu, 02 Apr 2026 10:47:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 53C6A30301D; Thu, 02 Apr 2026 12:47:33 +0200 (CEST)
Date: Thu, 2 Apr 2026 12:47:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>, Brian Cain <bcain@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] cmpxchg: allow const-qualified old value in cmpxchg()
Message-ID: <20260402104733.GZ3738786@noisy.programming.kicks-ass.net>
References: <20260402-cmpxchg-v1-1-4561e2c05d2c@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-cmpxchg-v1-1-4561e2c05d2c@gmail.com>

On Thu, Apr 02, 2026 at 02:56:01PM +0800, Hangbin Liu wrote:
> The old value passed to cmpxchg() is semantically read-only: it is
> only loaded into a register as a comparand and is never written back.
> However, the macro currently assigns it implicitly to a local variable
> of type __typeof__(*(ptr)), which triggers -Werror=discarded-qualifiers
> when old is a const-qualified pointer and ptr points to a non-const type.
> 
> To avoid this, let's add an explicit cast to __typeof__(*(ptr)) for the
> old local variable in the cmpxchg macros. This explicit cast suppresses
> the -Wdiscarded-qualifiers diagnostic.
> 
> The new value is intentionally left without a cast: new will be stored
> into *ptr, so silently accepting a const-qualified new would allow
> callers to store a pointer-to-const into a non-const location without
> any compiler warning.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---

Where is this a problem? I've never seen this. Also, new code should
probably use try_cmpxchg() anyway.
