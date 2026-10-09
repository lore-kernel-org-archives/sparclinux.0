Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CC63C1090;
	Fri,  9 Oct 2026 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791573186; cv=none; b=HnxSkflqAkgCHzbzfUBQ1UUl/KECaAm5yX4So2bVfyXDiuzuj0eluli8yW1Hl1FtyXGxuuJGTtwi6kmX/fTJhV2YnSbwqioVRBglUkjTHUQCJJ166YR+OVCuzuF1eXhDFkhXBRa3KciuCwHgklyIlbdoJVkW8+9bF3MqXEQhidU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791573186; c=relaxed/simple;
	bh=FTmXxDnu4ebQkUB8s+BUW8Xv2kMFgl+iL8t8jjbcHrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYshdxscAzhGJZ4zjyNZmhvK5HRBytI6tRIWfLM7wIQFNfyXHgTPaxRa/8XsdJ40UG7w2YLQYA5VuQymKT360J4zxODUTpusci5QnPm4J4jNRXL1Z7ufpH/xjYgdL/7OUN5wkTxI1viIi5dbBlW/Q/IhCYMc1v73YREUZ7SL06Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZuyzr46; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZuyzr46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528FD1F000FF;
	Fri,  9 Oct 2026 19:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791573185;
	bh=2u1cXCERdLsgzncvcrG53a7KuzeCS3BJ/VeVg8AlCq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nZuyzr46OcKv2dA9ZDmLQ76fJnFIZsBhwdFvcgzFZzGauRvid+xysVjnsU2jOLlt6
	 0w/x9QflWzbg5zh2Rw5cc27X894b90mByCyEwtnVlBkJquPGGyFF3L73Xxs91Kbms0
	 KI4rTreld9SACxRHIYVDqMDiAxkKg1Y7FZ7Gbpsf50dqWjbZyzMiQHdKGjVVwTiy9/
	 RaIw+vvtSgKPGE4Hv15m3c/3kEDUwGGbwgA4uNwK2tYJKXq2Sj40i8yxGet9b9iqqs
	 V9Z4+g8VNMSngRGtud9Wya6KguHPlGyatKCrepiN9LxtKuWO4IPTa9OM/3/8+sz1Zp
	 ko+Hn3qcV9OCA==
Date: Fri, 9 Oct 2026 21:13:00 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Subject: Re: [PATCH v2] sparc64: Define p4d_page() instead of stubbing it to
 NULL
Message-ID: <20261009191300.GA757048@ax162>
References: <20261008191711.223236-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008191711.223236-1-rosenp@gmail.com>

On Thu, Oct 08, 2026 at 12:17:11PM -0700, Rosen Penev wrote:
> A sparc64 allmodconfig build with LLVM fails in vmalloc_to_page():
> 
>   mm/vmalloc.c: error: performing pointer arithmetic on a null pointer
>   has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
> 
> sparc64 defines p4d_page() as NULL, on the assumption that it is only
> used by stubbed out hugetlb gup code. Generic code now uses it in
> vmalloc_to_page(), ptdump and KASAN. In vmalloc_to_page() the NULL is
> used in pointer arithmetic, which clang diagnoses even though the
> branch is unreachable on sparc64.
> 
> Define p4d_page() as a NULL function to silence clang's warning on an
> unreachable branch. sparc64 has no p4d leaf mappings, so there is no
> functional change.
> 
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: use a NULL function instead.
>  arch/sparc/include/asm/pgtable_64.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index 35a217bf6e5c..54e563eb0efd 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -851,7 +851,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
>  #define p4d_clear(p4dp)			(p4d_val(*(p4dp)) = 0UL)
>  
>  /* only used by the stubbed out hugetlb gup code, should never be called */
> -#define p4d_page(p4d)			NULL
> +#define p4d_page(p4d)			static inline struct page *p4d_page(p4d_t p4d) { return NULL; }

Huh? Why did you keep the macro instead of replacing it with the static
inline function wholesale? This should have just be

-#define p4d_page(p4d)			NULL
+static inline struct page *p4d_page(p4d_t p4d) { return NULL; }

no?

>  #define pud_leaf pud_leaf
>  static inline bool pud_leaf(pud_t pud)
> -- 
> 2.56.0
> 

-- 
Cheers,
Nathan
