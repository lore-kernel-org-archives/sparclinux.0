Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F52A4279FE
	for <sparclinux@vger.kernel.org>; Fri, 25 Sep 2026 05:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790314244; cv=none; b=n8YwA1lYviY0O8eXYkCrFVIjfUBKVd5j4NPwEqpmuCrjlOG3UobrWKl1PXFyHL6R70KlBaaYFwf6a7yGZm8N0ak9kJUJxmlga3GJd8t4ww3h8IOpmavjphue/L7wszcn5/M9FJsDOFEuNjEhLnuA7xsOk7/gL65j0IQQhNP50Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790314244; c=relaxed/simple;
	bh=woF2v9CO+9k+xhnEELF3zVy7m1Qb3HiAIZRwyEAKx4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqdQ3RykT8zgE9C5rSqzsa4YSfZQrTVtuX6XOmbP6GImVcViYd2VdEkHWx6Y32pG1WzVIRIjFr5GgozlTbpRAXHefy3jAwV4Xfb2a625xN2OalZzJkan2b03diXTARwbrm3a6HQri8idVzoitawGOgIIQ57J94/jecTQOvEomnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ry/Y5+Pf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry/Y5+Pf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350361F000FF
	for <sparclinux@vger.kernel.org>; Fri, 25 Sep 2026 05:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790314243;
	bh=iuVHKe+kHLV/jSPQ1Sp6pScTLQ6GybikNB88F+4NQpg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Ry/Y5+PfANKwSQTgSVoDL5I+uLy8o36yMTd2gy+Za+L5Cd/3XCvw3W4UGquRJzNbw
	 gf6GqCeb5B2Jw351T1sF2n/3jRFB485C0145Zb77rZE95qZvZwDTDCZewKSG9rOKG7
	 lRWDEF7ylcdTJn0lEgYPtj+rmwsqMxCxzxvw1aTdiPXDxqYF4vgvIAGtjhvEwT6+/5
	 QeebibFLhMY6m0zXulDSt9L/8TGyq4qtbu1AmHlbvHBhAN+hOLgpJ2xttXi18jd38h
	 ye7NqjFSnrHip6YILT4lJcmNdKabLwlKSu4GfRbmAIBvoT7zbX8qxDQktK9JElG+CA
	 mCWsQuIiJo2DQ==
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910ca5aa8so45819585a.3
        for <sparclinux@vger.kernel.org>; Thu, 24 Sep 2026 22:30:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzHrT7GYmzEq3SNhIXC+u7S80imJkIgQs8ImHUXY9hfgsCk7V5n2ksPWk5boPqZbM70AGmriD0BEyMm@vger.kernel.org
X-Gm-Message-State: AFuF++mAO1wQz8tC2KzQvOZBzayxNKuyVPv1utWWvXR8buTEcYXbL3yc
	l9wVq/9+cYE+g7+cnJOG9VbTpsJj214GaDE8S8uYDu/+up63EPCgGedq1OCN+bzxUS5Ydu5FUuD
	D/XAF2pF4dybvfQWKl5SguTzu45eGo8U=
X-Received: by 2002:a05:620a:2945:b0:93c:b10:7243 with SMTP id
 af79cd13be357-93c43b61d03mr262098485a.5.1790314242069; Thu, 24 Sep 2026
 22:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924131106.1730494-1-dev.jain@arm.com> <20260924131106.1730494-5-dev.jain@arm.com>
In-Reply-To: <20260924131106.1730494-5-dev.jain@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 25 Sep 2026 13:30:31 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yDZypOxjwmAY_usM+v_OJahShz-_uRSAiUZUAzv14VRA@mail.gmail.com>
X-Gm-Features: AclHuK8jj4BEC2ZukHa7pkW7xEBHFBfsvYex5BDejOLunxBiVqvO5dSgOHCPAnA
Message-ID: <CAGsJ_4yDZypOxjwmAY_usM+v_OJahShz-_uRSAiUZUAzv14VRA@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] mm/rmap: Add batched version of folio_try_share_anon_rmap_pte
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
> To enable batched unmapping of anonymous folios, we need to handle the
> sharing of exclusive pages. Hence, a batched version of
> folio_try_share_anon_rmap_pte is required.
>
> Currently, the sole purpose of nr_pages in __folio_try_share_anon_rmap is
> to do some rmap sanity checks. Now, clear the PageAnonExclusive bit on a
> batch of nr_pages. Refactor the function such that the clearing of the bi=
t
> can be done at one place without duplication.
>
> Note that __folio_try_share_anon_rmap can receive nr_pages =3D=3D HPAGE_P=
MD_NR
> from the PMD path, but currently we only clear the bit on the head page.
> Retain this behaviour by setting nr_pages =3D 1 in case the caller is
> folio_try_share_anon_rmap_pmd.
>
> While at it, convert nr_pages to unsigned long to future-proof from
> overflow in case P4D-huge mappings etc get supported down the road.
> I haven't made such a change in each function receiving nr_pages in
> try_to_unmap_one - perhaps this can be done incrementally.
>
> Add two WARN's: check that the batch is entirely exclusive (for PMD
> callers, need to check only head page), and that there are only
> PTE/PMD paths converging into __folio_try_share_anon_rmap.
>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

The patch looks correct to me, but it seems a bit hard to follow
because of the `pinnable` handling.

> ---
>  include/linux/rmap.h | 56 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 39 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 62ef511a6175a..91b5763ef466f 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -723,17 +723,23 @@ static inline int folio_try_dup_anon_rmap_pmd(struc=
t folio *folio,
>  }
>
>  static __always_inline int __folio_try_share_anon_rmap(struct folio *fol=
io,
> -               struct page *page, int nr_pages, enum pgtable_level level=
)
> +               struct page *page, unsigned long nr_pages, enum pgtable_l=
evel level)
>  {
> +       /* device private folios cannot get pinned via GUP. */
> +       const bool pinnable =3D !folio_is_device_private(folio);
> +

If we make a helper that does:

for (;;) {
     ClearPageAnonExclusive(page);
     if (--nr_pages =3D=3D 0)
               break;
     page++;
}

wouldn't that allow us to avoid this ugly `pinnable` variant?

Then we can make a much smaller modification, which should
also be much easier to follow? No?

Best Regards
Barry
