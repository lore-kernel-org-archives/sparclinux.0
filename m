Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC6CC7EE24
	for <sparclinux@archiver.kernel.org>; Fri,  2 Jun 2023 14:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbjFBOUV (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 2 Jun 2023 10:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbjFBOUT (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 2 Jun 2023 10:20:19 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C219419B
        for <sparclinux@vger.kernel.org>; Fri,  2 Jun 2023 07:20:17 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3980c92d8d6so1826128b6e.0
        for <sparclinux@vger.kernel.org>; Fri, 02 Jun 2023 07:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1685715617; x=1688307617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FqaYMxWoeNH3a7vv1yp0mvQMbR3V3EytnPDXxbqJ8VE=;
        b=YplxNmFBW9ljUSBNluudr9Q6wJ87klI3TZokg2k+vwOdVg3A1AJX0pByRXwDqo5MwQ
         alW49lR9XyUQRlk8vt7/xFfIsTB0flktCR+vD1xy2IwNrEoErUzHEn55bDAo5dNnYjOO
         hlmGmFRf+2Fm0iceBj47fAw1vRm2jD5BSmGtugnmJtfDezNH4aKScnhjDxWGb5LL7ypz
         fJzuxhuft9F1/d0AJw9yoXkpAePkuiZjqAB4ZmRDCE8ZLU0IAXmgmRwVUGE2hoENWDmB
         8POcecwSo0I1O94ydcJI8eaZYk6Zm4Sxyg2IRRnMyhcC0eiAebPLKM5kmkf/d3iZsQ9c
         DCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685715617; x=1688307617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqaYMxWoeNH3a7vv1yp0mvQMbR3V3EytnPDXxbqJ8VE=;
        b=OnvqjM+BnaKCvUVvBoSt7yApbgxUoVfXpMnheA/KchAmKHd6/HjSfp0mOzNCf69W2O
         5UqWH1ddXk3MrADXJxa72nzQhUZ9wXBgD4vod0xGoJEihrmlrt4QfjVKl5lpl5HQhcYa
         yv9IEDbcyhxR3TbRww0sN0kM6MNhoTkdU7t5JrUra50RdIA8QhLt11WMjQraQ38c10eG
         golHgzvPTI/lBWmTV2IQ/J9f2xNv0h1hYmrCG/UuyzdpbHom2yaRAQ1S8YcW365SBJ5a
         /fnoyVuPcJXyVUlfBY0Ty8CT8EnW92fQ0tfJSsxGl8MMYbis0+mj3rhp+Dh4ThcEBJ7t
         gX+Q==
X-Gm-Message-State: AC+VfDyCJSXNLra1Fr+R8zJbc3utrz7k8pJPN3ybuRhAAiK2evZoRk7X
        Dhh/SW09yxBx2Pj1L+wdV5b7gQ==
X-Google-Smtp-Source: ACHHUZ6vbHMkZi+Yoc+B1yGbLmCswR8p6D4EKcqpOa7k2x/EYO9kFPQlCeZsh27NoZY4RaKVPkuoOA==
X-Received: by 2002:aca:1817:0:b0:398:282e:4c81 with SMTP id h23-20020aca1817000000b00398282e4c81mr140727oih.19.1685715617084;
        Fri, 02 Jun 2023 07:20:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id pz26-20020ad4551a000000b006263735a9adsm847340qvb.112.2023.06.02.07.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:20:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q55dX-001vaI-OV;
        Fri, 02 Jun 2023 11:20:15 -0300
Date:   Fri, 2 Jun 2023 11:20:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 05/12] powerpc: add pte_free_defer() for pgtables sharing
 page
Message-ID: <ZHn6n5eVTsr4Wl8x@ziepe.ca>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
 <28eb289f-ea2c-8eb9-63bb-9f7d7b9ccc11@google.com>
 <ZHSwWgLWaEd+zi/g@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHSwWgLWaEd+zi/g@casper.infradead.org>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Mon, May 29, 2023 at 03:02:02PM +0100, Matthew Wilcox wrote:
> On Sun, May 28, 2023 at 11:20:21PM -0700, Hugh Dickins wrote:
> > +void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
> > +{
> > +	struct page *page;
> > +
> > +	page = virt_to_page(pgtable);
> > +	call_rcu(&page->rcu_head, pte_free_now);
> > +}
> 
> This can't be safe (on ppc).  IIRC you might have up to 16x4k page
> tables sharing one 64kB page.  So if you have two page tables from the
> same page being defer-freed simultaneously, you'll reuse the rcu_head
> and I cannot imagine things go well from that point.
> 
> I have no idea how to solve this problem.

Maybe power and s390 should allocate a side structure, sort of a
pre-memdesc thing to store enough extra data?

If we can get enough bytes then something like this would let a single
rcu head be shared to manage the free bits.

struct 64k_page {
    u8 free_pages;
    u8 pending_rcu_free_pages;
    struct rcu_head head;
}

free_sub_page(sub_id)
    if (atomic_fetch_or(1 << sub_id, &64k_page->pending_rcu_free_pages))
         call_rcu(&64k_page->head)

rcu_func()
   64k_page->free_pages |= atomic_xchg(0, &64k_page->pending_rcu_free_pages)

   if (64k_pages->free_pages == all_ones)
      free_pgea(64k_page);

Jason
