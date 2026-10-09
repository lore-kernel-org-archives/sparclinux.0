Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ECB3B19D8
	for <sparclinux@vger.kernel.org>; Fri,  9 Oct 2026 21:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791581640; cv=pass; b=GWxWr731SzsLuSPhQkGbVgfV7tQBrv1zcGmCbkEkJ4Cz2h/oehhQwd6b1EZPEkN8pBXqi4Hq0gd/f63XS9VxdZaIzPRgNOGjPg6zpUx+UNU6/xjQQpWo22qR7IcTuHfi8YURdA4ShooSursaY68M6oEMG/uPS1KdhRc0LRVFud8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791581640; c=relaxed/simple;
	bh=OvQ55FXoErnNKhvc+Qxa3QvWr6A3gB3Z0YvB4C+COTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwgETojpnWPT1r2YYUKAhe5XuQ0fqT1nX8VxP06o3FpJqPdm2Hq8EEGhLTN+W7nP/+ck8JwzbWrpdPpjQwTNdxaeKQA2G25qhRYX4aVKMnVtj2f9B01DklMZxaBBSNl5svY6d/xgrjdqx6r1u6CMsYGgJLYFGw3hPSSW18+za3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oZAKLnFz; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZAKLnFz"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6afa651700eso251133a12.2
        for <sparclinux@vger.kernel.org>; Fri, 09 Oct 2026 14:33:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791581637; cv=none;
        d=google.com; s=arc-20260327;
        b=XwR4hQQdZQDSzNJRc0gvlTTw+QBXkyhyslyeiiVFJJimJcKTmtVTt1a/Ddz5taY9Xg
         Hf1FUmiQv3mu2EtuHmitN6jBJ3BXDu2lA1FukM8DuUl8322KT754dZomXfHDy98yQ151
         z/sgFH6FnriU45QnQ70Pv+BajL18rI5ApPByDc6/Imsz7tHsC0pooImL7x9yCWjkOKPN
         AkSumjF0iiqtBossUGLrnjyyUO8cq3AL+F/61zncCO071f5D4MmYWZ/5IyT18PDAb4AJ
         SKKA573j9AzmNt5045J6dbnb+ZhQCKIIHebn73dQgX9EfQMmlkOGXvTRn3aGOCJUOy2P
         wFGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sK8/6wWnGfCrSRA2b4se/1dVCFxfL1CUU24jZL0PDDs=;
        fh=nFXX65c/8QRhbOcs+1evvkMHi5klUTfg1HtSe/fTmxg=;
        b=CA4IMRyUvi7viJXa0CVjZHpk/yRLPtNqr16++eNSuoHkoxcKNqSLm4Ej8kfW8gYr55
         +rB1ObUq88lXabQfitboFwShNrpK1boHcZpFx/vCup7P1d8w0AEE+wtNk6fdkyjdCPc2
         BVzTA13mu46Z0ReMkbmkDrQZJKqva5dGJqN4hHPQe/aIE8iC7zCEYP0OeqAFTpg1gp1x
         SqVpCUnoVwK7Es9XMmF9Kp2gvhe4O4J+L5+m3f48CW0SF1F65xWsxoEdpyy/MymIf4g+
         G3nkwwlj+42JUHafOrWXtZ0Vn5VQFMpIcrRYZ/pp3C2jmCaqkJEHhwpYHku0Y7Krt7ut
         Cg5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791581637; x=1792186437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sK8/6wWnGfCrSRA2b4se/1dVCFxfL1CUU24jZL0PDDs=;
        b=oZAKLnFzvM+lXau8YvTXKCwfibrLC4NJxDf5NJ5k0TBn5ybecNYXbF4s/ge/gDMqPd
         giRi5vnL1WFdQHivOGwnnebamzZ2TS7H5cBTAMFbiOvZxAYGUIgOG+k1o9+pjQq7UApJ
         GkArWJByEMnG7jrXYPXWE2aEXJ9Vk4Gr/yO+3r9wIII9MOiGScpFVI120sv1r2SmYRMy
         EZcT41bFaII1Llb42BqnjJ7LbL8rbdGNrPqOG8lJoC+Q54PmGrA7XLcj/QrlORPN+Kgh
         BE4Fpj5CxFGdmD7ZZ0zVOGHnrtT9NAVXiKCwaW80Ax098EJZv8cvnm4MgftmaGbknlub
         GH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791581637; x=1792186437;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sK8/6wWnGfCrSRA2b4se/1dVCFxfL1CUU24jZL0PDDs=;
        b=r8c+RResK8+W8Z4BFHTsqn/G9wyD/G5jeWBA8Rs8j/b4NacnCe0McokHmpLHhVvmv6
         /6e6oA8ycoEezA2AH8Zj2RFm1GyeEbZcUcCN5YnnoY5zxd5nBSU8rvbFu5NGcGKnchG4
         ClA9isgLb2xCEft0LXImj64meP703gh+unmEDCBLbnIVV8U0fNuQe8HEhCy3S5LPl9cF
         rRNeZQSsMCu/D8uTMnYzLqt8IMYGAb4VgWiEwY9Z9MRucMIs69FLtbdtPwIxdqQIcXyk
         3/yVgaA6uY9uVTUKHAVWE0FA5VfFLKkZn28pcG+QmKO8noeUvtPa6aRrS0C1iUorzPwy
         C2iA==
X-Gm-Message-State: AFq9FYL4MDbPCCSyAh6ddtKnNEOlCpit/FCovdnFNLAAVral0OZQvM3F
	sqUGfIJu3uekQ1IrSjAcnLuwqiMsz47xGQDggkoLoPATWXEsCRIoUdUh5P7JxIceKZCds51LTQ3
	+CgdWATvECOiuVi5aPSI4dzeaOMcVlSE=
X-Gm-Gg: AYBFou38+oi/HBrSPIIzmQDxW35tvLSVaxxKp/EQTvEeT6pKuWNGFr371FexZWsBU3L
	MCX3xY1caAqk6W0X+8rplA0isTxQWZdKw1JptWtTbLT569eKGoWHTHLhVfxHlqGMgEORr4F1YCu
	0k/y0a73HxaHc/vxgarQErorwnwHtcRiuY8o0S+uRadGeuC2TdO1Tt936LOR9XWZIJBbpbvbmT6
	RN+M3hcp+OUEUprivZOK3V5rHErRxVHVkc9n/Oc2p8FlcWWXR1ikYtjtqmfca04qEmvu2w4A4bj
	+xXKOz+RtFT6xmy4mdh1aci7AYCqSx1Or42JmxvZ1cqW4wZxtJjETaR6WEeHel3E9DFT7TRWPve
	CLobQlHCpjFeqqFgalL1WeEVG3bScqVAHLQ4wlD3iEdO8Ur0mrgUBtcF2d8Wd1IE/sxI1jff5lQ
	DC337ChM4nbVCUZOica5t7jQXat3HPkTZN66qZWgbotzyg7Q0VQfmjg+yoJ2d3yb1Hfw==
X-Received: by 2002:a05:6402:3548:b0:6ac:8dce:5a75 with SMTP id
 4fb4d7f45d1cf-6b17c254712mr2711939a12.23.1791581636975; Fri, 09 Oct 2026
 14:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008191711.223236-1-rosenp@gmail.com> <20261009191300.GA757048@ax162>
In-Reply-To: <20261009191300.GA757048@ax162>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 9 Oct 2026 14:33:45 -0700
X-Gm-Features: AclHuK8MlV0tZcrPlLYVGSOF_atGwGV-YpvAht_KJ3XEVfnjWvLiyx6HZPct2Ig
Message-ID: <CAKxU2N9iJahKnVJWTHvh0jaEEma1RuthMW_C7AbvHV+4y_m-=w@mail.gmail.com>
Subject: Re: [PATCH v2] sparc64: Define p4d_page() instead of stubbing it to NULL
To: Nathan Chancellor <nathan@kernel.org>
Cc: sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 12:13=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Thu, Oct 08, 2026 at 12:17:11PM -0700, Rosen Penev wrote:
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
> > Define p4d_page() as a NULL function to silence clang's warning on an
> > unreachable branch. sparc64 has no p4d leaf mappings, so there is no
> > functional change.
> >
> > Assisted-by: LLM
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  v2: use a NULL function instead.
> >  arch/sparc/include/asm/pgtable_64.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/a=
sm/pgtable_64.h
> > index 35a217bf6e5c..54e563eb0efd 100644
> > --- a/arch/sparc/include/asm/pgtable_64.h
> > +++ b/arch/sparc/include/asm/pgtable_64.h
> > @@ -851,7 +851,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
> >  #define p4d_clear(p4dp)                      (p4d_val(*(p4dp)) =3D 0UL=
)
> >
> >  /* only used by the stubbed out hugetlb gup code, should never be call=
ed */
> > -#define p4d_page(p4d)                        NULL
> > +#define p4d_page(p4d)                        static inline struct page=
 *p4d_page(p4d_t p4d) { return NULL; }
>
> Huh? Why did you keep the macro instead of replacing it with the static
> inline function wholesale? This should have just be
>
> -#define p4d_page(p4d)                  NULL
> +static inline struct page *p4d_page(p4d_t p4d) { return NULL; }
>
> no?
Was not thinking. I sent a v3 and actually tested compilation this time.
>
> >  #define pud_leaf pud_leaf
> >  static inline bool pud_leaf(pud_t pud)
> > --
> > 2.56.0
> >
>
> --
> Cheers,
> Nathan
