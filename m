Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C5041D228;
	Wed,  7 Oct 2026 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791366113; cv=none; b=aWUXvuJkI+C4OVk+suleC6Qq6bENZRvYJC5XjovEGK73qarnG75zg/Im+ylabPc0kEeG7P78x2NwKQzf5QDi6ORd1bHuqEkc52+/sG0kmU+88fywgaPQMYPbBmuu3WrTGnblcMMtKKFO/iWliMSY//jGOERmfc2a3A0whZoLABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791366113; c=relaxed/simple;
	bh=WK9vhPgzSth+kJw3yIz3GCDJcb2aZvBnFXRqEEdiY/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+G9XrCDnZVOabrmQdY2LSlRVxZqhaPBz6YXt8/gDJ71HDud6XmcvaQY7/4Ilu3Q2AG0OXkmJkIdmzyH4oEoRZ53OOQ+3ID5u2rtsGkx0EYI74DWWYId80TWe5ZwIrI3b3ExtFsefaxxqkJgE4fdz+mPKarISmfr55QR2BQL1VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfI59p1C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfI59p1C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B413A1F0089B;
	Wed,  7 Oct 2026 09:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791366105;
	bh=dg0m5pCV+kHWbFQxgfAVP5N/SaUbE4+F9mJpEm2Zr9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZfI59p1CCXGQBkUuHoUrJGA8YsBmBzORm+uLYregJRivh0ufO0WJ88BL+Vw3/JF3A
	 JYtkz4iOv4TDC7CFVECfQ1s6bTKircJ8Uz4ZNPMJJ7vilIVX2OJx/Uj7Xxn6cthqnF
	 xjJCgW+/AQq6Vs70U3IQIJTkroLwft+ri4z7hRdLykSTgNeAOhOXBoBjv9B3OCJGq4
	 dXPlMHGGhOYMJ1PlRgOQahvVH7KwvKEj1rEQ6MENRF3WaIFZcdUGRy2FomBbxosqYl
	 ex6qehdY2BjJ+wevdoDuQ9AFIFNXejHJp4l0yF0bo6EwKLtkAonigeZynerNbqMNnZ
	 9Ciok8D8KAbwQ==
Date: Wed, 7 Oct 2026 11:41:41 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: Kjetil Oftedal <oftedal@gmail.com>, sparclinux@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Subject: Re: [PATCH] sparc64: Define p4d_page() instead of stubbing it to NULL
Message-ID: <20261007094141.GA1527675@ax162>
References: <20261005203930.246598-1-rosenp@gmail.com>
 <CALMQjD-udSokCKS07VFWauBQzac5BTPJqbORhskxgddsuX1vLw@mail.gmail.com>
 <20261006083103.GA3041473@ax162>
 <CAKxU2N-ZE7dwiGzVgxDYFvm2R0BE0nah2WehGcjpym=Kq68dYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKxU2N-ZE7dwiGzVgxDYFvm2R0BE0nah2WehGcjpym=Kq68dYw@mail.gmail.com>

On Tue, Oct 06, 2026 at 05:00:30PM -0700, Rosen Penev wrote:
> LLM suggests as an alternative:
> 
> /* sparc64 has no p4d leaf mappings, so this is never called */
> static inline struct page *p4d_page(p4d_t p4d)
> {
>       return NULL;
> }
> 
> Not sure how to proceed.

That seems like a more reasonable fix to me, as it is still obvious this
is not supported while hiding the NULL value from clang's frontend that
emits the warning. It could be worth a comment that it is an inline
function and not a macro to avoid the warning but I guess that is up to
the sparc maintainers.

-- 
Cheers,
Nathan
