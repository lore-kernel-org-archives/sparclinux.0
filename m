Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D284CC269
	for <sparclinux@vger.kernel.org>; Thu, 24 Sep 2026 21:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790283769; cv=none; b=rkgD+JpsBko6KG94Ptlf7787nO6huX+2nXvqFaxnTcJ8DiyFScMinMwAoD/9JQ4bWsQ5/4nSDckdCY08KDzOLDsgLV4I6LNngL714soR+Gj11zmIawt3sjIZO2rinci5Jsy4cKtvR6+DrI5rQeil1A9X+WaI8D8z8ThgzsL0BRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790283769; c=relaxed/simple;
	bh=dhXOoH73I8DK39cQunRBznrql7IyNj1kyFFWEwRYmNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e9m7JNVM4jewnlH/9F+FB5/2Jbi0Qt3KuwXmWBMuuSQXo5781HPeLXQDxU6ixyR4qxblxID0MvpWcBP5qomuwgI9xo5UFxFlWnxWebBDE2PSA59tqUjAXhlEGZSIFGEz5XJS5LISokf0hYGnx224Xr2QsJjksZt6UaLR235XwKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gre+hySW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gre+hySW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436B41F008A0
	for <sparclinux@vger.kernel.org>; Thu, 24 Sep 2026 21:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790283766;
	bh=XoiJXxM6i/kbsQEIiuA+nIFj4EQ8kOYLlbyqdsm+xTc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Gre+hySW4Jcz6RHQZXjSedwjaQRk3V5Msvma829u3XUHKWLJTnz4sDzashDTfOPN6
	 VtK+wv0V9y3/FM/D5kxsa5vcWpRHSox3YmpUShUhKSeIeNpsKMnWY+fhui0WfNi9qX
	 AjzSbiuGAPcQ+2ueHQ33MCPcKhiIGtgJQ9ARiZ6XOOFqLnizMdkory1LoOgcXGDB0D
	 0Rz6YPypeeH2FNrlJc1tauCxBWyNb88Oa6bxM/avzQl5IOEGdIuywI+yrI/KoE1pbY
	 IVgOj379nXeMFK4EhWBUVwCoQpObxwGscSax+dBCPxYsYoTHWll87TXwTuNoB/ybZg
	 QFymTZx0RE+zQ==
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910cc46c4so22160285a.2
        for <sparclinux@vger.kernel.org>; Thu, 24 Sep 2026 14:02:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy32l/E6HAWssnuBgVXicxlc6T2NiWd2o12C/0LABbqtrYmVd1A+DCEchKQF/8umbn5HjdbqUw8WTjH@vger.kernel.org
X-Gm-Message-State: AFuF++k1sAguQerh+HyPUnG0KVFnbUsS3de3IrFXxFO7hoiAmpL1w1My
	yWlqSArof2UFh7CWHmQILqafIyksT7uc5+h5cL0H5/Sf3Q7hCJVy2U2KcVL2Tv7Xka9xTRMoODR
	PZZK5zjedCCYEmLqiY9XroNqftP/opO0=
X-Received: by 2002:a05:620a:4612:b0:93c:234e:d10 with SMTP id
 af79cd13be357-93c43b86557mr105850685a.11.1790283765486; Thu, 24 Sep 2026
 14:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924131106.1730494-1-dev.jain@arm.com> <20260924131106.1730494-4-dev.jain@arm.com>
In-Reply-To: <20260924131106.1730494-4-dev.jain@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 25 Sep 2026 05:02:33 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yVhXF+-gOrOB+JOK6nZt19SA=LT+gXpmaMpErg6Ra5NQ@mail.gmail.com>
X-Gm-Features: AclHuK_dkYU1S8LfF7mhgKUW-YMPRJkOty82Eqfv1olkQu1iouCk5LG5Qs9Q-x0
Message-ID: <CAGsJ_4yVhXF+-gOrOB+JOK6nZt19SA=LT+gXpmaMpErg6Ra5NQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] mm: move anon-exclusive batch helper to rmap.h
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	hughd@google.com, chrisl@kernel.org, kasong@tencent.com, davem@davemloft.net, 
	andreas@gaisler.com, riel@surriel.com, liam@infradead.org, vbabka@kernel.org, 
	harry@kernel.org, jannh@google.com, lance.yang@linux.dev, 
	baolin.wang@linux.alibaba.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	baoquan.he@linux.dev, youngjun.park@lge.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, pfalcato@suse.de, jgg@ziepe.ca, thuth@redhat.com, 
	sparclinux@vger.kernel.org, ryan.roberts@arm.com, anshuman.khandual@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 9:11=E2=80=AFPM Dev Jain <dev.jain@arm.com> wrote:
>
> In preparation for optimizing large folio unmapping, we need to reuse
> the page_anon_exclusive_batch helper in rmap.c and rmap.h and obey the
> existing use in mprotect.c .
>
> Therefore, move it from mprotect.c to rmap.h.
>
> While at it, change return type, start_idx and max_len to unsigned long
> type for future proofing against THP support at >=3D PUD level. Also
> shorten expected_anon_exclusive -> anon_exclusive.

I really think the `expected` prefix makes the semantics clearer, so I
don't think it's necessary to remove it.

If you really find it too long, maybe just use
`expected_exclusive`, since we're already in the anon context and
know that it is definitely anon.

Another option might be to make `*exclusive` an output parameter.
Then we wouldn't need to call
`expected_anon_exclusive =3D PageAnonExclusive(first_page + batch_idx);`
in the caller.

 static __always_inline unsigned long
page_anon_exclusive_batch(unsigned long start_idx,
                unsigned long max_len, struct page *first_page, bool *exclu=
sive)

>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Otherwise, the patch looks good to me.

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  include/linux/rmap.h | 17 +++++++++++++++++
>  mm/mprotect.c        | 18 +-----------------
>  2 files changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 74cca0e3c7264..62ef511a6175a 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -106,6 +106,23 @@ enum ttu_flags {
>
>  #ifdef CONFIG_MMU
>
> +/*
> + * Get max length of consecutive PTEs pointing to PageAnonExclusive() pa=
ges or
> + * !PageAnonExclusive() pages, starting from start_idx. Caller must enfo=
rce
> + * that the PTEs point to consecutive pages of the same anon large folio=
.
> + */
> +static __always_inline unsigned long page_anon_exclusive_batch(unsigned =
long start_idx,
> +               unsigned long max_len, struct page *first_page, bool anon=
_exclusive)
> +{
> +       unsigned long idx;
> +
> +       for (idx =3D start_idx + 1; idx < start_idx + max_len; ++idx) {
> +               if (anon_exclusive !=3D PageAnonExclusive(first_page + id=
x))
> +                       break;
> +       }
> +       return idx - start_idx;
> +}
> +

Thanks
Barry
