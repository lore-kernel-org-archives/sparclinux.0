Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6254C83
	for <sparclinux@vger.kernel.org>; Thu,  7 Mar 2024 03:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709780742; cv=none; b=aAvasWQh7W+ZSwLYkXRvI5lTQc94YDpzHet43rkl37V5iU3E9Z3+r9rBsToisgN9lDAd9G/iSYREE0uooPxcjqHFl0eVKi/pHHHdxp6wCCaZp+Lq92iW+DjFsTcOtw4Ao1gVNcB+prz5xgxcWcFvby0WJKqs+XlVWC6NYKsLPrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709780742; c=relaxed/simple;
	bh=aTfnNVOzuTStvs0tdoETXdWCW8y9BVUMXLGNAwHRpZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMaX2+zMu7LdSvbK7wZU3JGYC2cB864zqr7ISRCiHhLIo0jTo+n3qCsY/zZWAdu2wuhFoW6m55dU4HzYftYuDTSRgl/MdQkLPYsAE2ggansLCkfW7cGEXdSYFpOwnfcWcfUqSjv7MuYc3b4f1+3I4mkFhdDrlyRfIPurCzH7/QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GVtYZ27h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVtYZ27h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709780739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PkR96+oCUTcXVjSNgBM5A0Wxc2Bmtn+g3wn0Jg6Nemc=;
	b=GVtYZ27hOned6302mTfm4cRb4FJ6q43zFKebqHzBlOk8RNEhYDXJeGGKqJiF6BKU28r5Ep
	SoKAyyZHrEHk5HnnjM+F37CE1yZsO4ADVqZ6p0py9F0H1Qt2e7jIwWGEGijD2D+6HpTdd4
	SHVaChCnVTm63r/x+orBBOdWlUBaM74=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-vM2SwN0DPWGo7A3WMBPrNA-1; Wed, 06 Mar 2024 22:05:37 -0500
X-MC-Unique: vM2SwN0DPWGo7A3WMBPrNA-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6dbd919aba8so112072b3a.0
        for <sparclinux@vger.kernel.org>; Wed, 06 Mar 2024 19:05:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709780736; x=1710385536;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PkR96+oCUTcXVjSNgBM5A0Wxc2Bmtn+g3wn0Jg6Nemc=;
        b=UQeHHIW0udYYbBjyYoAMhJ4HQ91pyw3XN714OHt3NZaxV3hnh9ThsW53iLBt5I0hfd
         iocNwt7WRfLhUpITerzyRwpIfS9yoQ+gBw8xKzwIqQFg9MLVP4dGyHa711h7/jA0VtFv
         itp5j0lbj25CoBaUNijfrB9Q28QASWBv4BizCmtFbr6D5os35d1jxmAr/B9Ol0cPuOsV
         qFsrWHQmyzL6hn6LKQYJt+1n0AqojYbdwRLoQCh5WeXPqYfoDcORp6SloHIpSG8J5NdN
         C581H0qAlb22wXrBacPRzplMGcxxbOSj2RqD6S7wPUHevuVG3QQnEXwq/3Q5v9R2yV/T
         DMlA==
X-Forwarded-Encrypted: i=1; AJvYcCVTp0TEkaWJ9bZjIsD55OJidHRQhp7RPb3t3y41IqwmNy4vUB5eibNQdY99MR9mMEhvpvNqXwjP0QpeO6I6n87K0xq7A/UXYMDwog==
X-Gm-Message-State: AOJu0YxvoZlqQ731iPsxK9VfmRo96nz4/zs3EsHDvmVDRxpGh53BY9B+
	uoVi9oDgDRGaiOnRZSgZy1RnT1vtqhRUXepGWleMT6Qq7Da/FVgNcLgfEth1L9lfYmzLGhzycbe
	KEL8LC/hDow1+DkYYLbkYrEuNHPnf+gE2i87PIxvnHIpho8QESjPrsW4aVdg=
X-Received: by 2002:a05:6a00:cce:b0:6e6:c6f:dc7e with SMTP id b14-20020a056a000cce00b006e60c6fdc7emr1026108pfv.3.1709780736635;
        Wed, 06 Mar 2024 19:05:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkCBHVN9ZAc+1XyRReKazlag268zheivJJl2EtGptHK/Yo1IMFuR7cjV0MKh9sysGGci92ug==
X-Received: by 2002:a05:6a00:cce:b0:6e6:c6f:dc7e with SMTP id b14-20020a056a000cce00b006e60c6fdc7emr1026089pfv.3.1709780736228;
        Wed, 06 Mar 2024 19:05:36 -0800 (PST)
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n11-20020a056a000d4b00b006e65720e892sm568324pfv.94.2024.03.06.19.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 19:05:35 -0800 (PST)
Date: Thu, 7 Mar 2024 11:05:21 +0800
From: Peter Xu <peterx@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, x86@kernel.org,
	sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Nicholas Piggin <npiggin@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH RFC 09/13] mm/powerpc: Redefine pXd_huge() with pXd_leaf()
Message-ID: <Zeku8SsorvytLJGe@x1n>
References: <20240306104147.193052-1-peterx@redhat.com>
 <20240306104147.193052-10-peterx@redhat.com>
 <87v85zo6w7.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v85zo6w7.fsf@mail.lhotse>

On Wed, Mar 06, 2024 at 11:56:56PM +1100, Michael Ellerman wrote:
> peterx@redhat.com writes:
> > From: Peter Xu <peterx@redhat.com>
> >
> > PowerPC book3s 4K mostly has the same definition on both, except pXd_huge()
> > constantly returns 0 for hash MMUs.  AFAICT that is fine to be removed,
> > because pXd_huge() reflects a hugetlb entry, while it's own hugetlb pgtable
> > lookup function (__find_linux_pte() shared by all powerpc code) already use
> > pXd_leaf() irrelevant of the MMU type.  It means pXd_leaf() should work all
> > fine with hash MMU pgtables or something could already went wrong.
> 
> Yes I think that's correct.
> 
> 4K Hash MMU doesn't support any hugepage size at PMD or PUD level (the
> geometry is wrong), so pmd/pud_huge() were written with that in mind,
> ie. they are hard coded to return false.
> 
> But it should be OK to use pmd/pud_leaf(), they will actually look for
> _PAGE_PTE, but it should never be set for 4K Hash.
> 
> See eg. arch/powerpc/include/asm/book3s/64/hash-4k.h:
> 
> static inline pmd_t hash__pmd_mkhuge(pmd_t pmd)
> {
> 	BUG();
> 	return pmd;
> }

Good to get confirmation on this, thanks, Michael.  These explanations also
look better than what I wrote, I'll amend the commit message.

> 
> > The goal should be that we will have one API pXd_leaf() to detect all kinds
> > of huge mappings.  AFAICT we need to use the pXd_leaf() impl (rather than
> > pXd_huge() ones) to make sure ie. THPs on hash MMU will also return true.
> >
> > This helps to simplify a follow up patch to drop pXd_huge() treewide.
> >
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> > Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  arch/powerpc/include/asm/book3s/64/pgtable-4k.h | 14 ++------------
> >  1 file changed, 2 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
> > index 48f21820afe2..92545981bb49 100644
> > --- a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
> > +++ b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
> > @@ -8,22 +8,12 @@
> >  #ifdef CONFIG_HUGETLB_PAGE
> >  static inline int pmd_huge(pmd_t pmd)
> >  {
> > -	/*
> > -	 * leaf pte for huge page
> > -	 */
> > -	if (radix_enabled())
> > -		return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
> > -	return 0;
> > +	return pmd_leaf(pmd);
> >  }
> >  
> >  static inline int pud_huge(pud_t pud)
> >  {
> > -	/*
> > -	 * leaf pte for huge page
> > -	 */
> > -	if (radix_enabled())
> > -		return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
> > -	return 0;
> > +	return pud_leaf(pud);
> >  }
> 
> This doesn't actually compile though.
> 
>   arch/powerpc/include/asm/book3s/64/pgtable-4k.h:11:16: error: implicit declaration of function ‘pmd_leaf’; did you mean ‘pgd_clear’? [-Werror=implicit-function-declaration]
> 
> etc.
> 
> To make it compile we'd need to relocate the pmd/pud_leaf() definitions:
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index df66dce8306f..fd7180fded75 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -262,6 +262,18 @@ extern unsigned long __kernel_io_end;
> 
>  extern struct page *vmemmap;
>  extern unsigned long pci_io_base;
> +
> +#define pmd_leaf pmd_leaf
> +static inline bool pmd_leaf(pmd_t pmd)
> +{
> +       return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
> +}
> +
> +#define pud_leaf pud_leaf
> +static inline bool pud_leaf(pud_t pud)
> +{
> +       return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
> +}
>  #endif /* __ASSEMBLY__ */
> 
>  #include <asm/book3s/64/hash.h>
> @@ -1436,20 +1448,5 @@ static inline bool is_pte_rw_upgrade(unsigned long old_val, unsigned long new_va
>         return false;
>  }
> 
> -/*
> - * Like pmd_huge(), but works regardless of config options
> - */
> -#define pmd_leaf pmd_leaf
> -static inline bool pmd_leaf(pmd_t pmd)
> -{
> -       return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
> -}
> -
> -#define pud_leaf pud_leaf
> -static inline bool pud_leaf(pud_t pud)
> -{
> -       return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
> -}
> -
>  #endif /* __ASSEMBLY__ */
>  #endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */

Thanks for the help, I'll fix that.  I'm wondering when syzbot will start
to feed my series into the testers; I do still rely on those feedbacks on
compilation issues with such treewide changes, but so far I didn't yet
receive any reports.

I've also attached the new patch directly here in case of any further
comment.

Thanks,

==========8<===========
From 9e75aef2141170f241577e7786aaa4bbbfd93360 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 6 Mar 2024 14:49:48 +0800
Subject: [PATCH] mm/powerpc: Redefine pXd_huge() with pXd_leaf()

PowerPC book3s 4K mostly has the same definition on both, except pXd_huge()
constantly returns 0 for hash MMUs.  As Michael Ellerman pointed out [1],
it is safe to check _PAGE_PTE on hash MMUs, as the bit will never be set so
it will keep returning false.

As a reference, __p[mu]d_mkhuge() will trigger a BUG_ON trying to create
such huge mappings for 4K hash MMUs.  Meanwhile, the major powerpc hugetlb
pgtable walker __find_linux_pte(), already used pXd_leaf() to check hugetlb
mappings.

The goal should be that we will have one API pXd_leaf() to detect all kinds
of huge mappings.  AFAICT we need to use the pXd_leaf() impl (rather than
pXd_huge() ones) to make sure ie. THPs on hash MMU will also return true.

This helps to simplify a follow up patch to drop pXd_huge() treewide.

NOTE: *_leaf() definition need to be moved before the inclusion of
asm/book3s/64/pgtable-4k.h, which defines pXd_huge() with it.

[1] https://lore.kernel.org/r/87v85zo6w7.fsf@mail.lhotse

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 .../include/asm/book3s/64/pgtable-4k.h        | 14 ++--------
 arch/powerpc/include/asm/book3s/64/pgtable.h  | 27 +++++++++----------
 2 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
index 48f21820afe2..92545981bb49 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
@@ -8,22 +8,12 @@
 #ifdef CONFIG_HUGETLB_PAGE
 static inline int pmd_huge(pmd_t pmd)
 {
-	/*
-	 * leaf pte for huge page
-	 */
-	if (radix_enabled())
-		return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
-	return 0;
+	return pmd_leaf(pmd);
 }
 
 static inline int pud_huge(pud_t pud)
 {
-	/*
-	 * leaf pte for huge page
-	 */
-	if (radix_enabled())
-		return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
-	return 0;
+	return pud_leaf(pud);
 }
 
 /*
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index df66dce8306f..fd7180fded75 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -262,6 +262,18 @@ extern unsigned long __kernel_io_end;
 
 extern struct page *vmemmap;
 extern unsigned long pci_io_base;
+
+#define pmd_leaf pmd_leaf
+static inline bool pmd_leaf(pmd_t pmd)
+{
+	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
+}
+
+#define pud_leaf pud_leaf
+static inline bool pud_leaf(pud_t pud)
+{
+	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
+}
 #endif /* __ASSEMBLY__ */
 
 #include <asm/book3s/64/hash.h>
@@ -1436,20 +1448,5 @@ static inline bool is_pte_rw_upgrade(unsigned long old_val, unsigned long new_va
 	return false;
 }
 
-/*
- * Like pmd_huge(), but works regardless of config options
- */
-#define pmd_leaf pmd_leaf
-static inline bool pmd_leaf(pmd_t pmd)
-{
-	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
-}
-
-#define pud_leaf pud_leaf
-static inline bool pud_leaf(pud_t pud)
-{
-	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
-}
-
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */
-- 
2.44.0

-- 
Peter Xu

