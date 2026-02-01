Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799BF1DF751
	for <sparclinux@vger.kernel.org>; Sun,  1 Feb 2026 22:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769983306; cv=pass; b=DepbA4H5eXbCgr46MxkMynfP7RLjnHL2w7guS6uHMwdspxYlOlzHCu52w8Hc9tB+zh2cRrUSYx/6gspLDCvC5IWPHgx+r0FgsnLKTYN19IWhnBx35GVSv3lR6nOP1ZGnkrpwVp7ESruj3LVPFTU26gPxKbOmE4EisctxMQa39hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769983306; c=relaxed/simple;
	bh=wl7Jk6JsU5yKG4duQoEsXxxYC+OIwiJhzlKIg8HfxyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QoP5pBJyOuam4sAHnbhHKemdYS2wKOADevHwqzvOi3Q/j05va+k8w5OFEHVREF28uZvQYnoVq02+8VeHtfiVQxxPKeBZ7eiY/9yeNWfH01okL0l6U6Zf+PS2OqhSjJhxtopOAToEtgfZs2/GMg1aulnIPCAFLVeSNUMkZKl5uOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUP16xwB; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUP16xwB"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6580dbdb41eso5832183a12.0
        for <sparclinux@vger.kernel.org>; Sun, 01 Feb 2026 14:01:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769983302; cv=none;
        d=google.com; s=arc-20240605;
        b=RKMR4k/5uyJWNUg4+iIKNX6aAmlMs4WO031MlRU3Qe6Jcuwo7FlGkvaHh+JqyIeR03
         +N2nIrsaTyhMmAJGNs1Fx1kL1L+WxwZHSrnRXYgO2Ua5Z3e4brTG2c677PnMUYnva2qu
         4RrvR10fPKWXrdKtWIJ1OBfSmGqSX9h+SThs5+IF+9SGRvSGHsvOzYICVXNEVbOr/aAB
         8UOymYFknAjYvlzwZ2G3d0aWVqJbGiilEyptaa9eWVupohxTZOIUvODUQJew/QrxeuE6
         dc8cjqBe47/7qriM64G0wGcHGEzGN8fbNtoLKbRQ4f8tMv+q4oLsirIrshKBRdIoDCcD
         Snew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nxxXeMZ2Mj2NhEcakAGevZjWJ8Zk/OwUaMBA61xjWow=;
        fh=MPlq+OHoljNPzWlzBOEIZnJ9LvvpIZArq5uN7tN755E=;
        b=WuWUjIstvwvlH2rzpePqZqoW2sO67O32dzmD6tXtzj3RdmNd0WPwC1IuPqXtIDNTkl
         AQusDIy7FBP+IsR25jcDYcmGm9v5tR+Q7jNaSlz6rMimT/+CLI1PIkelT+xXPGHgDb88
         JFfqiXv0rdFlQyaRWK9CA5dl2zRl1dIGyH5ecDYKmHBKbkkFbASltw0OJAuAhLNcn6xJ
         Uzt3llITMbAYDKE6i2v7EAgNo2QfojeZhh26R0xV0Wq1xdeWD30+wsK8SXMHiHnnUTN9
         2BJ/rFfe7d9Y4VhzsZT2bT5GeLc5JFdweKGpMWN7cYwl6VWyeblGQIs1eoA8VQjO5ipI
         Xy9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769983302; x=1770588102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxxXeMZ2Mj2NhEcakAGevZjWJ8Zk/OwUaMBA61xjWow=;
        b=YUP16xwBByuCeANUpL+tqGPZtwW0ekBJQXjxvYHrQ+BVuJhzXlLPUbdngsjT9o0vf6
         uYUmzrEUKPWDyYwqImODBU03rkq/5q2r1ZRse77/5jbzZ2ZbdPfRWoEgDFXi7tvZQDib
         KKiwOMyTyPNTlE6DbDFUXbRkge9P5LbCelPWFufvSIQsld51sSM4Eb+aQDvPUDu+HqZ5
         c/EuzGYP26bua1tM6AhlMjxuishxSbB0C/tRmJtMEllP01kG1m4La3rFduj7FChnHhy9
         DMXci+K0JH5BarH9OsbnSb+egVIt1mbKSHqf6Rg3thvWSqfOWPIJWg6A+uJuZWSkOoYT
         3FYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769983302; x=1770588102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nxxXeMZ2Mj2NhEcakAGevZjWJ8Zk/OwUaMBA61xjWow=;
        b=YVZXlcyW7763V/8FKC5xa6bKgTpF6qlVibmf7L+hLiIzCImDK5EkPHq8ztqUMi1vox
         h7rj6XTf0JLhdHEm9WS2KHwfyzKrD0tsrPcb4g274tG11Mcdr9rjmgJcfKWikOaj3T5l
         OUCz0Q0Q6L/WRShoeWACBl61Xb4165Ft+HwY5BHcZ7OWMZ01F/PV56a3+xDH2ySCxC6Q
         1XH4iFwBP4H6il7WhDkXWpaos1lRYdcd0aMeXcYxH4E7s6AJS2fM2nyMLqHayO0xuD2Z
         ycMxNpGXM8D0Gk4HrYp6YCgj9PsCrVl/HPykcVdX9GPcT5P6K+Wka+wkVVw9I0J3aPAF
         UQlA==
X-Forwarded-Encrypted: i=1; AJvYcCUqRE9fJY9pJXKlBvxEeBBQpHdH2ZYVLEUDmO8kOTuTU+KLcpijG2OK8GT7Sm5bfaZvSfQNATcYGuVs@vger.kernel.org
X-Gm-Message-State: AOJu0YzoTBs8xXa3+h6cit5DnwLKQM14fGsn7bmpvF+oJe4izaswFfWg
	y6cuEOS9ToST7bZQtdXiziMSSnY50kkoORmnLAXkxFk95v9je52jY5jB/Pl0BtowfntKcW/SjDS
	lbRPBLwySFlr7+O1gUD1oJnNDMBu8160=
X-Gm-Gg: AZuq6aIegyKANIF6/S1nUzoMYFMHjBUHRmr90ivxjuGDURvPoChaZEvnj2CXVw4JiQ3
	Ws1xgh7eLTpuh67reyZDHNdWlLfsAUKQeRdpN5OyNDcMb0GHqoopl9N2/aJUpdiI+D7KRs53XjB
	rV/QcPWaodpt8ktP9q4UapQmUzeDHgIJT85YwIgmMxWI03Uvcvjft5U9kipK0WF4fxdYBF6fgrH
	ckir9H5DHpcCDM3ekuUf+1PnZyAEqxTujuXJ3DWRLnZk30QYluVybVwSDqA+B+1xU1dMUMle8IJ
	iehD8xdmulD+nZkPPjFBO4Tg9p08
X-Received: by 2002:a05:6402:90b:b0:64c:9e19:9858 with SMTP id
 4fb4d7f45d1cf-658de58d61fmr5598076a12.22.1769983301701; Sun, 01 Feb 2026
 14:01:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769515122.git.zhengqi.arch@bytedance.com> <3380f40a89b73c488202c85f9a8abf99fb08543b.1769515122.git.zhengqi.arch@bytedance.com>
In-Reply-To: <3380f40a89b73c488202c85f9a8abf99fb08543b.1769515122.git.zhengqi.arch@bytedance.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 1 Feb 2026 23:01:30 +0100
X-Gm-Features: AZwV_Qj9VNkT5OuGD6ka3IvGbnZ780_iMCZkDjCZeudKZ-RrGhxplhYBmunMjcY
Message-ID: <CA+=Fv5RhxvyxKr2t+pHd1tbGrK57P-+b3pGe1nVaK_OLiFt2wg@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] alpha: mm: enable MMU_GATHER_RCU_TABLE_FREE
To: Qi Zheng <qi.zheng@linux.dev>
Cc: david@kernel.org, andreas@gaisler.com, richard.weiyang@gmail.com, 
	will@kernel.org, peterz@infradead.org, aneesh.kumar@kernel.org, 
	npiggin@gmail.com, dev.jain@arm.com, ioworker0@gmail.com, 
	akpm@linux-foundation.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-alpha@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-um@lists.infradead.org, 
	sparclinux@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 1:16=E2=80=AFPM Qi Zheng <qi.zheng@linux.dev> wrote=
:
>
> From: Qi Zheng <zhengqi.arch@bytedance.com>
>
> On a 64-bit system, madvise(MADV_DONTNEED) may cause a large number of
> empty PTE page table pages (such as 100GB+). To resolve this problem,
> first enable MMU_GATHER_RCU_TABLE_FREE to prepare for enabling the
> PT_RECLAIM feature, which resolves this problem.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/Kconfig           | 1 +
>  arch/alpha/include/asm/tlb.h | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index 80367f2cf821c..6c7dbf0adad62 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -38,6 +38,7 @@ config ALPHA
>         select OLD_SIGSUSPEND
>         select CPU_NO_EFFICIENT_FFS if !ALPHA_EV67
>         select MMU_GATHER_NO_RANGE
> +       select MMU_GATHER_RCU_TABLE_FREE
>         select SPARSEMEM_EXTREME if SPARSEMEM
>         select ZONE_DMA
>         help
> diff --git a/arch/alpha/include/asm/tlb.h b/arch/alpha/include/asm/tlb.h
> index 4f79e331af5ea..ad586b898fd6b 100644
> --- a/arch/alpha/include/asm/tlb.h
> +++ b/arch/alpha/include/asm/tlb.h
> @@ -4,7 +4,7 @@
>
>  #include <asm-generic/tlb.h>
>
> -#define __pte_free_tlb(tlb, pte, address)              pte_free((tlb)->m=
m, pte)
> -#define __pmd_free_tlb(tlb, pmd, address)              pmd_free((tlb)->m=
m, pmd)
> -
> +#define __pte_free_tlb(tlb, pte, address)      tlb_remove_ptdesc((tlb), =
page_ptdesc(pte))
> +#define __pmd_free_tlb(tlb, pmd, address)      tlb_remove_ptdesc((tlb), =
virt_to_ptdesc(pmd))
> +
>  #endif
> --
> 2.20.1
>

Looks good from an Alpha perspective.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
