Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709C7C7EE22
	for <sparclinux@archiver.kernel.org>; Sun, 14 May 2023 18:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjENSUd (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sun, 14 May 2023 14:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjENSUd (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sun, 14 May 2023 14:20:33 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD5F1FDF
        for <sparclinux@vger.kernel.org>; Sun, 14 May 2023 11:20:31 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b99489836aaso10178852276.0
        for <sparclinux@vger.kernel.org>; Sun, 14 May 2023 11:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684088430; x=1686680430;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/w8Ik+B9LqquAVc24RATG4RXaBZs1t11jn/s3N/obhU=;
        b=3hM1VI6NWGWu8nKjmz4E776n6/tfMkoFz07qqIrs1oaapPZVpFGqRfLcsrD2Q9+aIl
         lVkR5CaBLhkLbvj6PetC97KquetslVNm4ewYDv3VlmeuHTS81B9LSL8mS5hv5NNIrJ5k
         qfkEuu9pgy+dtpTd6GHTh0Gi0u67Y0T46ElzOPo7riZGmKUfHA7vSk0Zmd7HgvGJHxab
         DqbZyXByDthzzyzxr91aGkpWgNkslpXmOPPlerkZVQyLnPVqgNtVTmJy+exwCn44tZ+/
         VxkE3CJ7HkShwyo4XrVtp449lbAR3UPOjv88P7k+8G1RfjN7YRQ6k8XKtpgdfILs4FOB
         5kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684088430; x=1686680430;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/w8Ik+B9LqquAVc24RATG4RXaBZs1t11jn/s3N/obhU=;
        b=EO6i6A+lBDyw47FhTRc9K67pYgk6SPLn7tj4MYaWNavsRDAHfbVFw9O5tt8E7GCN9H
         xGNf365tnPw8EvzCkPNL+OSZ/1sz1O5aSyzm89sby7go7tprUsoaa6a8t8YfEnhOf/bj
         AXAyQ/7tbMvEGwus18fAP9nF3WAbdiSH3Pd2YdojjOZFaL89E0m0vXTfOMQGtXo5e3W6
         k8iRK8hpW4NW/hnRs/HGFVvxmi9ZTbsgiEhhF9cfE/hW4g0r8cplO+zdr6wRwEm1NaaF
         rK72V74n6YNoI27SFMAU86GK3vxJtzCcopPs0k2MYj2btXHIkxl/Obhmhl7/EgLE91Xz
         w/dw==
X-Gm-Message-State: AC+VfDyCW4sqWmNhpJsFyJcyzIXtXbW7wThnyFxNg9s/rmSejwujGdGV
        YrElh3+PHm5r+Db+dES9XbsQ4A==
X-Google-Smtp-Source: ACHHUZ4uC/iK9slyVYAwsZbskAJfVUMUdzJpIRbgKgSPhKsknTzzPntrNJG85XVm7SRutl/ig2uJ2g==
X-Received: by 2002:a25:abe5:0:b0:ba1:b539:a39a with SMTP id v92-20020a25abe5000000b00ba1b539a39amr27412446ybi.6.1684088430350;
        Sun, 14 May 2023 11:20:30 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 192-20020a2503c9000000b00ba73c26f0d6sm1520144ybd.15.2023.05.14.11.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 11:20:28 -0700 (PDT)
Date:   Sun, 14 May 2023 11:20:16 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Helge Deller <deller@gmx.de>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 08/23] parisc: add pte_unmap() to balance get_ptep()
In-Reply-To: <ca4ac780-42b0-4818-bd84-e1a4acbb28dd@gmx.de>
Message-ID: <6de39db5-d9aa-b35a-1652-8bdf90e7df72@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com> <44ebbf90-5fbb-2815-17c7-fcfe3c87d78e@google.com> <ca4ac780-42b0-4818-bd84-e1a4acbb28dd@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Sat, 13 May 2023, Helge Deller wrote:

> Hi Hugh,
> 
> On 5/10/23 06:52, Hugh Dickins wrote:
> > To keep balance in future, remember to pte_unmap() after a successful
> > get_ptep().  And (we might as well) pretend that flush_cache_pages()
> > really needed a map there, to read the pfn before "unmapping".
> >
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >   arch/parisc/kernel/cache.c | 26 +++++++++++++++++++++-----
> >   1 file changed, 21 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
> > index 1d3b8bc8a623..b0c969b3a300 100644
> > --- a/arch/parisc/kernel/cache.c
> > +++ b/arch/parisc/kernel/cache.c
> > @@ -425,10 +425,15 @@ void flush_dcache_page(struct page *page)
> >     offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
> >     addr = mpnt->vm_start + offset;
> >     if (parisc_requires_coherency()) {
> > +			bool needs_flush = false;
> >      pte_t *ptep;
> >
> >   			ptep = get_ptep(mpnt->vm_mm, addr);
> > -			if (ptep && pte_needs_flush(*ptep))
> > +			if (ptep) {
> > +				needs_flush = pte_needs_flush(*ptep);
> > +				pte_unmap(ptep);
> > +			}
> > +			if (needs_flush)
> >     		flush_user_cache_page(mpnt, addr);
> >     } else {
> >   			/*
> > @@ -560,14 +565,20 @@ EXPORT_SYMBOL(flush_kernel_dcache_page_addr);
> >   static void flush_cache_page_if_present(struct vm_area_struct *vma,
> >   	unsigned long vmaddr, unsigned long pfn)
> >   {
> > -	pte_t *ptep = get_ptep(vma->vm_mm, vmaddr);
> > +	bool needs_flush = false;
> > +	pte_t *ptep;
> >
> >    /*
> >     * The pte check is racy and sometimes the flush will trigger
> >     * a non-access TLB miss. Hopefully, the page has already been
> >     * flushed.
> >     */
> > -	if (ptep && pte_needs_flush(*ptep))
> > +	ptep = get_ptep(vma->vm_mm, vmaddr);
> > +	if (ptep) {
> > +		needs_flush = pte_needs_flush(*ptep))
> 
> ^^^^^
> One ")" too much and lacks a trailing ";"
> Should be:
> 		needs_flush = pte_needs_flush(*ptep);
> 
> With that fixed the kernel compiles and boots sucessfully on parisc.

Urgh! Indeed, thanks a lot Helge: I'll fold that in.

Hugh
