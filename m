Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370A37F;
	Sun,  3 Mar 2024 03:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709435354; cv=none; b=Cl+p/cBE/8Lc+ja496VPzsm74DX2dxFLiiar29clIQiGKhJO49zk4XZ9FFg3XhB8iRU3l+ULlHKw2jxsLgVxs6pZwrS0oYuodUKePH5tPKDmRW+WfuYwf1pLKwNsbrBFMM2282V/ZwUJinFYzdAScUEUR2ME6tDJuOgyEZng6fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709435354; c=relaxed/simple;
	bh=U9vFa7R1cZbTVY8TgC99jtc/yq8v79DPan1lLC0trv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7ITw9Ax+8VLpYAe0XD7mtMvHGlHdVZ0F7wbcnrF6gNVio3OAZJrS3sJneXH5wCT7O8ARjca8iDXbx+ORmDF6d1b7ESOrKAf50bSQMvOZCC20w0QWJvFtEqhYEBl3UwJKEROYLuPjfVwIvj3soJQsfMXQTnHddJuOFGY5xzPrOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nG19RN6e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nG19RN6e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6928C43399;
	Sun,  3 Mar 2024 03:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709435353;
	bh=U9vFa7R1cZbTVY8TgC99jtc/yq8v79DPan1lLC0trv4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nG19RN6eG/zQjq7qxI33DDNUEgfaDVVRF5NqoVIkofd4hjPY83KMTm6bcam4zpO+7
	 ggx+P9lWwh8oBX0/y1WWQuXVxGFnPV9Ma8t7c5un0Si2XdKA0ocxMfo/3HftDk+LVB
	 IFyugzC+/VHTvtRVwK3gTUNFbJiMfTU9XVId3s7KsxOaQucgYju8EB3EoLMlR43DvJ
	 I4MpkjWk1W0+lhkXb055GKDnpWenLxeFTDXiE4E+TGtWFQQHc8w6m+KXxjeSW/5Ok7
	 gnDCTJT/JvH736w91sf1tqFgejGd1Un1f42HOdzcARYVIFmE9zuf8m3x+xFr4Hnl7B
	 CJWjpxQvgABCQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d23d301452so35728911fa.1;
        Sat, 02 Mar 2024 19:09:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXc7mcf20vFb13lq+m2rGV8z8qBdcFDm0n6MSpgbxVb5YF+VgIDT3w+RSTSRoHv7COaYh8Et0p1FDTlIIj8g8Z+pCubCv8gsMpt6UQWLuvlL4pLg+7KPGxYDVar+LEeXBymhRWlZE=
X-Gm-Message-State: AOJu0YwBY4tclgDlkSXjnGtzygOZx0Tmp4Oy0lJfjqEWuRSiWU0kvTqt
	jQUyzD9Q+YFj7Jl5rYfnBq+gBCNtHfJeeXmySVZSLwwCi+mj4XOpn+tpS/j9fg5KhSvHaTi19WB
	keZ93n/xiNP4NrYOPHDtLBlwJ1pA=
X-Google-Smtp-Source: AGHT+IGD78Wt0ncu+3aqMeWqNCB8JI7FP0zctiNsiIeugXcEmHUGawXXLZN7+mt4gVmwoSw/0oiyjgdsn/WF8N7af0k=
X-Received: by 2002:a2e:bc26:0:b0:2d3:1172:c07f with SMTP id
 b38-20020a2ebc26000000b002d31172c07fmr5072878ljf.17.1709435351907; Sat, 02
 Mar 2024 19:09:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226190951.3240433-6-rick.p.edgecombe@intel.com>
 <20240302001714.674091-1-rick.p.edgecombe@intel.com> <20240302001714.674091-3-rick.p.edgecombe@intel.com>
In-Reply-To: <20240302001714.674091-3-rick.p.edgecombe@intel.com>
From: Guo Ren <guoren@kernel.org>
Date: Sun, 3 Mar 2024 11:09:00 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTjfW4DG8WaVrVopxQsak6X9YPnUXG3a-XWs2C=-vjxxg@mail.gmail.com>
Message-ID: <CAJF2gTTjfW4DG8WaVrVopxQsak6X9YPnUXG3a-XWs2C=-vjxxg@mail.gmail.com>
Subject: Re: [RFC v2.1 03/12] csky: Use initializer for struct vm_unmapped_area_info
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, bp@alien8.de, 
	broonie@kernel.org, dave.hansen@linux.intel.com, debug@rivosinc.com, 
	hpa@zytor.com, keescook@chromium.org, kirill.shutemov@linux.intel.com, 
	luto@kernel.org, mingo@redhat.com, peterz@infradead.org, 
	sparclinux@vger.kernel.org, tglx@linutronix.de, x86@kernel.org, 
	linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 8:17=E2=80=AFAM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> Future changes will need to add a new member to struct
> vm_unmapped_area_info. This would cause trouble for any call site that
> doesn't initialize the struct. Currently every caller sets each field
> manually, so if new fields are added they will be unitialized and the cor=
e
> code parsing the struct will see garbage in the new field.
>
> It could be possible to initialize the new field manually to 0 at each
> call site. This and a couple other options were discussed, and the
> consensus (see links) was that in general the best way to accomplish this
> would be via static initialization with designated field initiators.
> Having some struct vm_unmapped_area_info instances not zero initialized
> will put those sites at risk of feeding garbage into vm_unmapped_area() i=
f
> the convention is to zero initialize the struct and any new field additio=
n
> misses a call site that initializes each field manually.
>
> It could be possible to leave the code mostly untouched, and just change
> the line:
> struct vm_unmapped_area_info info
> to:
> struct vm_unmapped_area_info info =3D {};
>
> However, that would leave cleanup for the fields that are manually set
> to zero, as it would no longer be required.
>
> So to be reduce the chance of bugs via uninitialized fields, instead
> simply continue the process to initialize the struct this way tree wide.
> This will zero any unspecified members. Move the field initializers to th=
e
> struct declaration when they are known at that time. Leave the fields out
> that were manually initialized to zero, as this would be redundant for
> designated initializers.
>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: linux-csky@vger.kernel.org
> Link: https://lore.kernel.org/lkml/202402280912.33AEE7A9CF@keescook/#t
> Link: https://lore.kernel.org/lkml/j7bfvig3gew3qruouxrh7z7ehjjafrgkbcmg6t=
cghhfh3rhmzi@wzlcoecgy5rs/
> ---
> Hi,
>
> This patch was split and refactored out of a tree-wide change [0] to just
> zero-init each struct vm_unmapped_area_info. The overall goal of the
> series is to help shadow stack guard gaps. Currently, there is only one
> arch with shadow stacks, but two more are in progress. It is 0day tested
> only.
>
> Thanks,
>
> Rick
>
> [0] https://lore.kernel.org/lkml/20240226190951.3240433-6-rick.p.edgecomb=
e@intel.com/
> ---
>  arch/csky/abiv1/mmap.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/csky/abiv1/mmap.c b/arch/csky/abiv1/mmap.c
> index 6792aca49999..7f826331d409 100644
> --- a/arch/csky/abiv1/mmap.c
> +++ b/arch/csky/abiv1/mmap.c
> @@ -28,7 +28,12 @@ arch_get_unmapped_area(struct file *filp, unsigned lon=
g addr,
>         struct mm_struct *mm =3D current->mm;
>         struct vm_area_struct *vma;
>         int do_align =3D 0;
> -       struct vm_unmapped_area_info info;
> +       struct vm_unmapped_area_info info =3D {
> +               .length =3D len,
> +               .low_limit =3D mm->mmap_base,
> +               .high_limit =3D TASK_SIZE,
> +               .align_offset =3D pgoff << PAGE_SHIFT
> +       };
>
>         /*
>          * We only need to do colour alignment if either the I or D
> @@ -61,11 +66,6 @@ arch_get_unmapped_area(struct file *filp, unsigned lon=
g addr,
>                         return addr;
>         }
>
> -       info.flags =3D 0;
> -       info.length =3D len;
> -       info.low_limit =3D mm->mmap_base;
> -       info.high_limit =3D TASK_SIZE;
>         info.align_mask =3D do_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
> -       info.align_offset =3D pgoff << PAGE_SHIFT;
>         return vm_unmapped_area(&info);
>  }
> --
> 2.34.1
>
LGTM, that's equivalent.

Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
