Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5479355C1B2
	for <sparclinux@vger.kernel.org>; Wed, 14 Oct 2026 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996846; cv=pass; b=icA+dQM3b6lsPHPAN3SDbSMHopF3nhAzZzavuCgL+SccspfVgCgkKDDj2jHQc6uip0eRcqWtqVaRNqo/yCzbqpMMlxzbbs+kWzrrHCGigo8umBQzPwBam4Z6/IfUTbnBjnQBcjCSPUtNSzfPxf/EBkhBs5TS5kg3T5Ii/5MROgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996846; c=relaxed/simple;
	bh=I3Y0U9d+Nkll0pfd537lAkdCtWdZSZn60epcX76cqCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJP/tkMTho/FpVxOp9EyA1Ds8V4XkTVkY7wBCdc/0SdlDLBqyH/kRC9ZSu6Zi4y7/z+8nb4z/qWJVGignB5RO6anm/tLie/pNXxvpacMUAwu61JAK9sdplzSX48HYKgKuzLfXndcGi5guyxVZJCQTSbCtqBd7Jg3OugmrjPZu9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnkqZ8CP; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnkqZ8CP"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6af9a90e4bbso4667633a12.0
        for <sparclinux@vger.kernel.org>; Wed, 14 Oct 2026 09:54:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996843; cv=none;
        d=google.com; s=arc-20260327;
        b=BM4rXLO3Qs/QQI7jOPr+fHNymUh7lu0zXrvTdT65YjefB8NYWQ7pkFBOA3n4omNt7L
         ML2jqULVUlxbzln/x/FXlW6i6HzrrDbcH5St5HkUpQU2TX8+YEfbnsbJ6LvbC3Xt2tWZ
         jWdh1/Ibd/eQsUm7X/AymK9CkARNtv4Zx7vN48W/f1+/FsztFjADdLdHFbAkV7hHs5Mt
         wYr9zRG1NkIzOzgbV6IuOsZsTzAvvw3jijXATu8Yrq5kMTNTKG6E9K6eSWndA5PQFe3B
         YNeybfayS/9brhPJREtbrDUemeiG++iYIbLLIAH2reYUJmTvK9RK7qUYEtjJ/ZN8WBRi
         wrCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+F9IeTlxRgN2/qbGE0mzkiygL5YNuqfvZdlqx/Or3SM=;
        fh=t19MCIL1Lrh7yvy6wpXe7+cE75CwOfF3CHfORGIiqhc=;
        b=UipzD0SyWJzs1XVtPBl5ZKaqbTgXaPE6pBxIKcjtbCZNqUHxOefGK5UG+j5/w6By3o
         E/qNf2JtStJ2AbGwO2qBtj++8ZrVKFrp75k0SwqADydMJpeHD1uSWwDCQufKtiLw9WgN
         QavPuFIduo27s2Bi29ZHFg3a51aJXXrDgQP0oR2biKzn7bTDdZdqp4SBGdQbW/9F1mg6
         j9oZOA23S9ufni0Kr+qnjqxJVI6I0/s6m7Xl8AV4Z5GDFyhfBfC/iTUJPuTPb04BDwNn
         28/E5V233VbD7xBFRxz6lpcIzK80EXZtbZw2SMMT+6ret83LmkBKOnI3cKCIzUvBMYIm
         8jLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791996843; x=1792601643; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+F9IeTlxRgN2/qbGE0mzkiygL5YNuqfvZdlqx/Or3SM=;
        b=NnkqZ8CPRKC/gCdLyimCqQ2LsXu0eiw4g1AZwN7w2ECrHGgJXgu88ZoxdzUAr+GP+j
         ngza+ahxsJtMTd3Gsck8NqFaQMvbMVVr2HYLxiAFi7FeOkec0/KHhIRBhUp3XEyTjrhZ
         XgfsXFzRxJkSmaM/KUFqumgZ+6gtrSBxEyLwijtypz9GEke2j63j6CyXQASOY8E/gOcU
         P8Fk71t278565XIRCsfDkotxrf45EAvHGVbjI/gpKm0eFmjNggAHpbU5GFOyrmxfEznH
         XKLX11CbNofwLJA0euKCGt79oNtTznYeKeF3ZVFM3Ep/iAUHHbtxoNRNX3RB91sRrMAD
         Mq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791996843; x=1792601643;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+F9IeTlxRgN2/qbGE0mzkiygL5YNuqfvZdlqx/Or3SM=;
        b=AtTb0k5Q1W/pfMhIkla6S+IS0o82AOt7GjdOme8WeyR2yV7SmdCxBkv7nC/LUFI9HG
         KbIKl7rjeXo0NMjxpEJTRvk1axYrIJCUe/f7WQZyPwdfJHdbB/uz2ppbeujy1klx1Zy4
         d+5TlJNbZKDjZx2kEcRDt88unZhbSrDFLB8+V8fKGASLtcsRiw8xijawo7OV/xIyNCF+
         KLirKFz6O09e5os87cmVa6YVqO+PXaKygkTueKcQv2wD37M4DqPnJ4PgOGUQ+8Pz87rY
         NdZPd128Mjr/DiL2Kjn26IWlGirbthNd1vxoL0mqXmNTJ7pz0Fhert53PGhWR9H0iEua
         0OmA==
X-Forwarded-Encrypted: i=1; AKwUvBzREoLIGkFIc9ssmEgF+/nXP8tXyeWHsKkdOnbpybZluN1RB6RfI3r9zLHdB4pvYz4o11PsGBR6ShJH@vger.kernel.org
X-Gm-Message-State: AFq9FYJcStPurAbtfJ8iY3ubQ7GWHvs8vVFzrIkfaSPFRIFIXYk5SBDj
	v+avBCI8yQQmQRppBxuKAYEcBvGrNtRIz1nEzuuwqpqSIVeQJif+em+prP07TqSG8ODpjZMJVA+
	hZnK3DXkukhX6zGZU1MyJIzfsHoXSsA8=
X-Gm-Gg: AYBFou0y0up07FVB2tDXhxquLWcW8e3vTBRZIGfLQcE7zp3VsIXKt2kmjtRuF8zzMv8
	Kc5M0CKbzT4O5QzEk3xdi1xQbaWf2qfD+p+DP/aAnsNk14EXn7A2tmj3CBwQf7ULAG+w3Hruxca
	lQ+2EvzlNdGE//E4pmqCGW9HLc+utchyDDYVCxLsFH7pJwdy9mNDyJs8FgE+ALXsjJgSepHxyO+
	LyzCDRwT7rZMqtKcHqjlBSGN9TVTqDtKESTDXIPgEdhKl5i1Zt/9M6b5zh8vzk4vjRyfxYY57/m
	RGDR9pKxStKbxlm/c12m+m6iCZHjQR/t7jOCH9csfdqGUPVWXbmPpS3GtA6t5ROXCXG02DADH4Y
	4MLngrygeStwUwfFRi/rtx1K2tL4sy3gu/sOyilyGtg==
X-Received: by 2002:a05:6402:4486:b0:6aa:f630:f846 with SMTP id
 4fb4d7f45d1cf-6b17c26a90fmr13938672a12.31.1791996843244; Wed, 14 Oct 2026
 09:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014133431.8003-1-ludwig.rydberg@gaisler.com>
In-Reply-To: <20261014133431.8003-1-ludwig.rydberg@gaisler.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 14 Oct 2026 18:53:52 +0200
X-Gm-Features: AclHuK9TLvgiu8pYEXVwGaLOF66o-uRXsc9jGTrvXgaMGrNaXMoKMLMJO_l4JHs
Message-ID: <CA+=Fv5Q_xcnwq0jjJ1RMw8DniNG9jwAuhODTGSPcpaw7G9SSng@mail.gmail.com>
Subject: Re: [PATCH] sparc32: Fix pgd lookup in vmalloc fault handling
To: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Cc: Andreas Larsson <andreas@gaisler.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, 
	Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ludwig,

On Wed, Oct 14, 2026 at 3:40=E2=80=AFPM Ludwig Rydberg
<ludwig.rydberg@gaisler.com> wrote:
>
> Check and synchronize the level-1 entry with the PUD accessors instead
> of the PGD ones. SPARC32 folds the P4D and PUD levels into the PGD and
> pgd_present() always returns 1. The PGD accessors therefore skipped the
> synchronization and the handler dereferenced a PMD pointer derived from
> the missing entry (seen in this kernel panic running v5.10.194):
>
>   Unable to handle kernel paging request at virtual address ff780000
>   PC: <do_sparc_fault+0x20c/0x3c8>
>   Caller[f0007ed4]: srmmu_fault+0x60/0x70
>
>   do_sparc_fault+0x20c/0x3c8:
>     pmd_present at arch/sparc/include/asm/pgtable_32.h:193
>     (inlined by) do_sparc_fault at arch/sparc/mm/fault_32.c:358
>
> Fixes: 7235db268a27 ("sparc32: use pgtable-nopud instead of 4level-fixup"=
)
> Signed-off-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
> ---
>  arch/sparc/mm/fault_32.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
> index 86a831ebd8c8..f9befdbb3e72 100644
> --- a/arch/sparc/mm/fault_32.c
> +++ b/arch/sparc/mm/fault_32.c
> @@ -276,21 +276,21 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs=
, int text_fault, int write,
>                 pmd_t *pmd, *pmd_k;
>
>                 pgd =3D tsk->active_mm->pgd + offset;
> +               p4d =3D p4d_offset(pgd, address);
> +               pud =3D pud_offset(p4d, address);
> +
>                 pgd_k =3D init_mm.pgd + offset;
> +               p4d_k =3D p4d_offset(pgd_k, address);
> +               pud_k =3D pud_offset(p4d_k, address);
>
> -               if (!pgd_present(*pgd)) {
> -                       if (!pgd_present(*pgd_k))
> +               if (!pud_present(*pud)) {
> +                       if (!pud_present(*pud_k))
>                                 goto bad_area_nosemaphore;
> -                       pgd_val(*pgd) =3D pgd_val(*pgd_k);
> +                       pud_val(*pud) =3D pud_val(*pud_k);
>                         return;
>                 }
>
> -               p4d =3D p4d_offset(pgd, address);
> -               pud =3D pud_offset(p4d, address);
>                 pmd =3D pmd_offset(pud, address);
> -
> -               p4d_k =3D p4d_offset(pgd_k, address);
> -               pud_k =3D pud_offset(p4d_k, address);
>                 pmd_k =3D pmd_offset(pud_k, address);
>
>                 if (pmd_present(*pmd) || !pmd_present(*pmd_k))
>
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> --
> 2.35.3
>
>

Hi Ludwig,

Tested with one and two CPUs under QEMU: a test-only helper cleared
a vmalloc level-1 entry in the calling process's page table, flushed
the TLBs and accessed the allocation. With your fix, the mapping was
restored correctly and data verification passed. Reverting only
your patch caused a fatal trap in both configurations.

A non-injecting regression test also passed on a dual-CPU HyperSPARC
SPARCstation 20: four processes completed 128 vmalloc/fill/verify/free
cycles in total, with no new kernel errors.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
