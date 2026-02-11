Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2732F352F9C
	for <sparclinux@vger.kernel.org>; Wed, 11 Feb 2026 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770840874; cv=pass; b=CuAkTId/mcK7lx/egJ6ep/OnhH7KYgmoXcofWWp3lzgZGqsg9Ny7pd+Mt0ZklJgKRKqUecVf4uaiMRJxSUleuga0cP4wh+DDsBU/hQHCTKm9ULlztA5gjzJBzsnYGxtTd+2o2/c0qZyKwtsF7qHxDxvjBVAHxKYh7m3lU9/V34o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770840874; c=relaxed/simple;
	bh=XTU0SZsxOmJ3FoM/DLxyJrm+s5UGvDwm08Uhn3BjVVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJzoftSCTuqK4OcmIZC4C9JYELXlr9nWh9t/Zvb+2eorOK4mCZHdoWWm+I9iy8B1dtBGDRv9HeFN1//9JI+FzLG5NFp2RkKxsX9tvp8CPji2sNqxk+4yS4c7ohoGVrn60IbgBkZjx0fc8bMcHfdNjQgQl9HOTT7M1tI2QwIiK18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+BZmpwx; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+BZmpwx"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8ea3d15580so781117766b.0
        for <sparclinux@vger.kernel.org>; Wed, 11 Feb 2026 12:14:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770840872; cv=none;
        d=google.com; s=arc-20240605;
        b=il6Oq4HlEsZ946lfQo8dVcgtVOX8OVpJ2uEs8c4ct05xlaGL/Y75pgeLccAfcysB8m
         VXVM8aG9A2h9NNv/lP/AC/3L9zH67jt1wRE9JlA2LIbx4tuLP4oB7/vuS3JxLzUsQh56
         /ZAyLuUIeshlyUC95YWdZUptEshT2/bBSo+4yxuvjRR6gfOn+4FqVoUVi4z+tksAsNUt
         sQOk2ALF7JGqiA1exl3wJAEUZ6Hr6gOZyqOToG0P/+n0gOLK6yDY5PJqF/98ioAfS37Q
         jHj3Bn5oBNrN/VRZqlN4gP6F/7MEvstKHxCIncg1+26s+ttnWTMxX2PyFUxhmM9dTncJ
         iVIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=28hr9LjidhOb4+7vDtUZiT7dYr2nuAMqMlceW5mXuOg=;
        fh=/+JPRhf+WNv2OLWxxaF9AxMqi0och3eZxiKFkMomZQw=;
        b=iN2i6JJO+T0me3DGzYjDtdhvU5L/HyigtWvbTjw62+usQn3uhIsRWiM+SK0/wzwRo/
         pEV4a9kyAooUhqTlytjW0K9mS6nGPZSlQIyQEi4AW+zo7HMQ8HP/Es76NTeJsMEYnlhG
         wX1hBIafCPm85vwlASawk80yj4tCyKGB5w0XooFjJ2mCBmOL3b02VgNzVJOy6h+czSPL
         HF6ZUOi+DbiliC2Ci1nmrTsLCRVQs71xdXGjgSVdfSslSwdV0kS68hNthp+47u5cAjeK
         Rzd0EGUJ3Cql5j0H/O6ngsmHjV9qBSAVS2bd8hT1j+1zZnRd67oJ2SBcT83tIxbPkdFm
         3GZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770840872; x=1771445672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28hr9LjidhOb4+7vDtUZiT7dYr2nuAMqMlceW5mXuOg=;
        b=U+BZmpwxb0B+eJodBh5iYdwN9Lzp7irxUy8fs3NOdprJYIHxQZLf/1DzGuf6k2n3yz
         Bqv+t2b1ZZRzIznR4S0yQr7i2zx3aJqBieQ1f86k9HMjZFj/dfEHLBDtaTstMxv7EWQp
         YR9FxsBl0x40sGnnEMgNJdk0CxJBPCHqbOMyVk+DgEw5LuRp1PdLZs4NxAuyIfavGkqE
         LFRnlEdLPJoEs/JMEJ/a1hofx+sOOfaNGsIheA42ud+8y1lVeOPJX3kdVH82vSf/u/+k
         zej+c/QXWftNS1FLxD0wQx3seCFayTJlg1jmS/KXwiF3nbQTYjzTTR1tNBX14sdhNgpO
         QKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770840872; x=1771445672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=28hr9LjidhOb4+7vDtUZiT7dYr2nuAMqMlceW5mXuOg=;
        b=XuWZl5C1iJljqcmp1w4BQot3hzFoWaZuZ4iCcZvl3BV2R4qbQhGAOA3XH580TFRGT5
         3SrFAVXMrlkB62/LAARSLSgDzJArNjQix7zXxIMge/xSj8rsKzZ8GJ4w8i94VS2UwaK2
         EsuLIHnMJ0FFj1Tpf+zGCPf3wz8Lz1cP4JdSZWvOX6a7bvoa1YUfNJPEd6LJoIatIutx
         6zQ5XgcRB7VkW1rxq5MDTg7fCh6A+WAzOzlp2Gs8+zDmhr9mjlsnDQJbg6etisqhf8XC
         FXBtDQcfSzEC7Nuu1xWocmmkwjtN+YdJ020vqsJAOJw/kyZT9XIJof2lL2YM2HEAPtYn
         q8Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWs4TpkSF8FzsZgH0O7GAE014LH5gVjlNjktrazL7UAvBcmcQmE1YJulveUIC4sU5F5wUO4ZDk8MoWi@vger.kernel.org
X-Gm-Message-State: AOJu0YxQixyQNNrZASvW+qdx2T2TivT2QerGief/KdR7HZvFTzxvGLWG
	bAgxuOASAoOqdXiHqSIAuYDUessTNrj4+1gKo9WbbdmpCzgZqi9GT11ZaFKHspBx2BAbZNtUO9w
	p/T//QdbWHVp0gNGdoGPZ+90PtsE04/A=
X-Gm-Gg: AZuq6aJzvKUpbA2WFS5cn0MR83HoDO8vzqDvzcrKCjwzJ41HeKybYujj1RkIsYlCHaO
	F9HEHQPxF+cGj58ox9lJxHGd3hFW0pN5ASjC4TetYJ1bKrX/9/lz4OkzeWU+CJa7sHGde2Igl83
	jSS6+0ODZIACBTJ9M5Ykmumx/TT80LdozVxzC/7Do0d3Vn6P1BIdX8aUueJSOGbWwXkSESK6rpz
	tW9lIvhcOXijqgumDktB9ueHSG5HbaCbm3OMEEfD/tfXhxWbq1UdoIt/XLoXzeQo7Cm0QZg8B64
	91ZM7fvwtS5w9MMmWGrMBiNXhU4Q1Xsj+uZm0reNsQ==
X-Received: by 2002:a17:907:a08a:b0:b8e:64e:1ed with SMTP id
 a640c23a62f3a-b8f8f72d91emr17643566b.50.1770840871149; Wed, 11 Feb 2026
 12:14:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211103141.3215197-1-rppt@kernel.org> <20260211103141.3215197-4-rppt@kernel.org>
In-Reply-To: <20260211103141.3215197-4-rppt@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 11 Feb 2026 21:14:19 +0100
X-Gm-Features: AZwV_QgdPAvH3hw0825YIt93LQPupYFvh_AV-2zMkwGhubC87cSa2iVxpdoZwag
Message-ID: <CA+=Fv5T07oBJweU3tURD4Nuh7VRWovsf0zjHtA1nDAVNmO=D2w@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] arch, mm: consolidate empty_zero_page
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andreas Larsson <andreas@gaisler.com>, 
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@kernel.org>, 
	Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Richard Weinberger <richard@nod.at>, 
	Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, Vineet Gupta <vgupta@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 11:32=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Reduce 22 declarations of empty_zero_page to 3 and 23 declarations of
> ZERO_PAGE() to 4.
>
> Every architecture defines empty_zero_page that way or another, but for t=
he
> most of them it is always a page aligned page in BSS and most definitions
> of ZERO_PAGE do virt_to_page(empty_zero_page).
>
> Move Linus vetted x86 definition of empty_zero_page and ZERO_PAGE() to th=
e
> core MM and drop these definitions in architectures that do not implement
> colored zero page (MIPS and s390).
>
> ZERO_PAGE() remains a macro because turning it to a wrapper for a static
> inline causes severe pain in header dependencies.
>
> For the most part the change is mechanical, with these being noteworthy:
>
> * alpha: aliased empty_zero_page with ZERO_PGE that was also used for boo=
t
>   parameters. Switching to a generic empty_zero_page removes the aliasing
>   and keeps ZERO_PGE for boot parameters only
> * arm64: uses __pa_symbol() in ZERO_PAGE() so that definition of
>   ZERO_PAGE() is kept intact.
> * m68k/parisc/um: allocated empty_zero_page from memblock,
>   although they do not support zero page coloring and having it in BSS
>   will work fine.
> * sparc64 can have empty_zero_page in BSS rather allocate it, but it
>   can't use virt_to_page() for BSS. Keep it's definition of ZERO_PAGE()
>   but instead of allocating it, make mem_map_zero point to
>   empty_zero_page.
> * sh: used empty_zero_page for boot parameters at the very early boot.
>   Rename the parameters page to boot_params_page and let sh use the gener=
ic
>   empty_zero_page.
> * hexagon: had an amusing comment about empty_zero_page
>
>         /* A handy thing to have if one has the RAM. Declared in head.S *=
/
>
>   that unfortunately had to go :)
>
> Acked-by: Helge Deller <deller@gmx.de>   # parisc
> Tested-by: Helge Deller <deller@gmx.de>  # parisc
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/alpha/include/asm/pgtable.h          |  6 ------

> diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pg=
table.h
> index 90e7a9539102..12a3c5f8ece8 100644
> --- a/arch/alpha/include/asm/pgtable.h
> +++ b/arch/alpha/include/asm/pgtable.h
> @@ -125,12 +125,6 @@ struct vm_area_struct;
>   */
>  #define pgprot_noncached(prot) (prot)
>
> -/*
> - * ZERO_PAGE is a global shared page that is always zero:  used
> - * for zero-mapped memory areas etc..
> - */
> -#define ZERO_PAGE(vaddr)       (virt_to_page(ZERO_PGE))
> -
>  /*
>   * On certain platforms whose physical address space can overlap KSEG,
>   * namely EV6 and above, we must re-twiddle the physaddr to restore the

This looks good from an Alpha perspective

Acked-by: Magnus Lindholm <linmag7@gmail.com>
