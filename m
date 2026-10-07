Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CB4547041
	for <sparclinux@vger.kernel.org>; Wed,  7 Oct 2026 00:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791331244; cv=pass; b=OOcQG4GV6kNKwnwp1a5VWzp+j7JNLN4XACEUzo/IEaqPKJ85WCCiOUqunXgAwlnuJkQiYp9mxl/7SILDhhRYRmbsg3daQLHbMUHwA5tC0i1H5mC8TO6Tgj9sfSP8fhsccrGP2wx3lWyDadFZkEc167HhrfIJPABQqokBZ/8yg2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791331244; c=relaxed/simple;
	bh=PIdZWKk7UsAxCtN4qvwS3WBKKGf+fKTzUBUtZtSSqJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rl4E7piLp01LlG9Iyj2Jb1DL4DMVdi4iZ6wyRRNFMsj/gDBk5+nx5aODHphxHJh2mu0mWiIX36RB27TaABD9V7GeJQ0H/+9cvVZbzlQNMT/+OjUAN/99/WjBfQU+GD3+tbh2vlLOKrYzWujkI+fgNxunFjX4Rf6zM5I0/U0mWdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPfKB1ya; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPfKB1ya"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a9e5ba741aso1821441a12.3
        for <sparclinux@vger.kernel.org>; Tue, 06 Oct 2026 17:00:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791331242; cv=none;
        d=google.com; s=arc-20260327;
        b=sZL6nJ9p90baJtkZvkMHX3c4mpA1BOZ7YKDt6aMD7YnO/SJt36iI/caQoaXha/Eqe/
         +m88qlN+LFjcN9qAAoJcSIv2O4JtP4DT+fRu5o6y/bK20PeGlThR4keDy/cLp1i1exyV
         3npVXNn12SU2CcyksuECPx9XKqThzqgCHJhoVUF27K0HDKseiBI6OPf+QwVv703qkZr/
         fS6XTwpilRnghCET7oFhfGWnSCqcmFfIv+KhiDmeETuDbCWH1Y6BMQGs4/FOyILFq66i
         v7Wb754jHshDoxvt9Z9gX7dkMFa8jVEGVzgdxmQp88UR/q/ev8qGlVTCsL0QvPvhbsjl
         P06Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NCYMrF1COiQ5G1aO6E9q5ZQQkQbwsyS+9CvbT88FRDo=;
        fh=F8Dvryru7a5nu034uWpSPPX9Oe2SBArFbUeThblDMWY=;
        b=HHZX+Y+dlKbPDZhJXfSi6fzaSDiUxWRBoAmEoM4pQo0l/ccRH8oyKSc/zzXDsZgZ5k
         pK9Xh/33bVuNB46h8ycO20QodH1JHnCgtavbNF5/T9qMd4uL7TB4xvEDNcomkJQcRphb
         wtxm0MlApN9MvNY9fG/4IbLJCCjEV/6JLYlR+3OIbhZDK1IzTLrdLoStWOxOU2n5yHn0
         z0MFCmzez+B9aum0rp9JOkfDnaZmIFVn1Lm6CJDplizm1nJS1Nn/VHkT5c+DuavH7WTE
         rbP9luJxbK1SEITCfBn78jFnrLKXfET4qwPPvRqPFB5JippuuSKnoqfIyWY+7/XK+99K
         YykQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791331242; x=1791936042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NCYMrF1COiQ5G1aO6E9q5ZQQkQbwsyS+9CvbT88FRDo=;
        b=RPfKB1yavWSPrFr+K5MqdHP7qWRSOE8zIAPMcPJliLCBmrRSuBfSmGr2bmIpgQDHgP
         cnvzz8I6viQZwdK6FnGCCcvVk0Cqz4UvJYTuPzdBvuKkWPt0KirRpTiYZ/rqDgRBzYgh
         Ap6ecDHQ0ji++OSYrz1hwfAvYVFfzwvM27h2MSWy/W3fieG1/diG65qEkSK3SEFPjTfP
         b7kaEQfZEY/LWK7N27YvwGjSI0ph8bokrPVYtFhLTPba2LrkVknjEt3ow+t35tBo5a3m
         /mxOczSA6Dt4S0a359iYSbeKlFuyMvj6oye4FVYpzAxxhKZLDTqpS51dOrKqBwZ4cazA
         UECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791331242; x=1791936042;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NCYMrF1COiQ5G1aO6E9q5ZQQkQbwsyS+9CvbT88FRDo=;
        b=FhIndYcdviTWJ3C5SShoJNFtdQdA5DXyZmrW+0cOLNiY6Gb25yZ7ZX3VO4EAtazQ6v
         7bw+12yUt1SDop2UFILcySfAhxIM4HFQxiM/LJtXj0gNEUBnA7MTclXsGjor25MWy7f5
         DjsZ79HUsvvaVmYb1svabt6YRY0vACrHoSAOfJysr+iB9wW+Kq+ooxzYndYRyq1b2+5t
         wKl0ZcSaebFZk4I0XHwRntDwkNiZN+rNbfWYVjIb8NM+SPr6hLr7hFAm6xHRGhNXfF58
         aYcwI5xu5iLcVYltkEUUbyRBnMyEGpoeokVIKN8rtrQ46BCrMKcUhBPLDzhg79rq5Ct6
         qUlQ==
X-Forwarded-Encrypted: i=1; AKwUvByufGPx0xbTn35W9nb0MeJvGXgDWHpdD64WTgcdhreer6tNeFhqszpgKqEAvCUXY9Zz40drUFjCZgJZ@vger.kernel.org
X-Gm-Message-State: AFq9FYJxNhFqBQuBzLkn7e6+15CmRlzxc6oOKYzS873IMkPzL+qdidsb
	C3axRmgUNqum/YMU9r9AFSOC55zlWVtTvMZ660K/P/FunxQY6pmTWqqPTBj6EQ0q1HfoNXaYVKQ
	zac5gC3mBYnyEgawAZ1nGqJzLr5ECBmE=
X-Gm-Gg: AYBFou1vhnnDq5PMxwg8EtiJ0HCNmeMHX1PEI9f9RXojyTuFHV5dOJC4RUUybJjt39W
	nkB9IYAX384eVDP1GrBy/0/k4WFCK2hSrCtqiCsdU+yhN3ytpI93eM633j+7GMAi41pUjsaFVjQ
	2xnkC87E56ovP8XqSIIcHo55J/2KTfohrKZZ1xjyfjsf0Ne7Eude6ra5CRZYjlQPSblviJvX/Gt
	rNHnlbVSK/L7To8KWK0eAqlCc8JQJtu/KR3RKzJxCJFGu1kwvwIgjNaGHFwHBK/6BQapvCdv1pa
	cWaos46fPiAB3aDc20ZIkWYndBCIveE/Yl9Ntozao8Z76BVD67eBUA9CgmxZqFVcVQ8ePz5ci1N
	honkL7hp5Q9k8NzFapVePdtqMmPlmWsNpso0968VHCmeFpeQeczFDOVOSQZ0rESjpZZildPGzlI
	tSI1aq8FNvfirWSNLYLp3p39DDtUGuCxn7EgX0xxoadP2I4PKLXYNVxG7p8zImfyZxGA==
X-Received: by 2002:a05:6402:13d2:b0:6aa:fc60:60d0 with SMTP id
 4fb4d7f45d1cf-6aff47a079cmr524195a12.33.1791331241682; Tue, 06 Oct 2026
 17:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005203930.246598-1-rosenp@gmail.com> <CALMQjD-udSokCKS07VFWauBQzac5BTPJqbORhskxgddsuX1vLw@mail.gmail.com>
 <20261006083103.GA3041473@ax162>
In-Reply-To: <20261006083103.GA3041473@ax162>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 6 Oct 2026 17:00:30 -0700
X-Gm-Features: AclHuK9oSm_T0yaj7kOWt6PgPFJ1d7MNcK17mxS5H3gv7-Ov32c6fYi7L19EGq0
Message-ID: <CAKxU2N-ZE7dwiGzVgxDYFvm2R0BE0nah2WehGcjpym=Kq68dYw@mail.gmail.com>
Subject: Re: [PATCH] sparc64: Define p4d_page() instead of stubbing it to NULL
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kjetil Oftedal <oftedal@gmail.com>, sparclinux@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 1:31=E2=80=AFAM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> On Tue, Oct 06, 2026 at 09:59:19AM +0200, Kjetil Oftedal wrote:
> > On Mon, 5 Oct 2026 at 22:41, Rosen Penev <rosenp@gmail.com> wrote:
> > >
> > > A sparc64 allmodconfig build with LLVM fails in vmalloc_to_page():
> > >
> > >   mm/vmalloc.c: error: performing pointer arithmetic on a null pointe=
r
> > >   has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
> > >
> > > sparc64 defines p4d_page() as NULL, on the assumption that it is only
> > > used by stubbed out hugetlb gup code. Generic code now uses it in
> > > vmalloc_to_page(), ptdump and KASAN. In vmalloc_to_page() the NULL is
> > > used in pointer arithmetic, which clang diagnoses even though the
> > > branch is unreachable on sparc64.
> > >
> >
> > Has this been reported as a bug to the clang project?
> > As it throwing an error on a rather obviously unreachable branch.
>
> Technically the error part is self-inflicted on the part of the kernel
> since allmodconfig enables CONFIG_WERROR. That said, while it might be
> nice for the compiler not to warn in any case of dead code, that's just
> not how it works for either GCC or clang (none of these should be
> visible if that were the case):
LLM suggests as an alternative:

/* sparc64 has no p4d leaf mappings, so this is never called */
static inline struct page *p4d_page(p4d_t p4d)
{
      return NULL;
}

Not sure how to proceed.
>   https://godbolt.org/z/K3nfW4n5f
>
> --
> Cheers,
> Nathan
