Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342C8C77B7C
	for <sparclinux@archiver.kernel.org>; Thu, 11 May 2023 04:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbjEKEfw (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 11 May 2023 00:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjEKEfv (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 11 May 2023 00:35:51 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C004C30
        for <sparclinux@vger.kernel.org>; Wed, 10 May 2023 21:35:49 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-ba65a4f502fso1797527276.0
        for <sparclinux@vger.kernel.org>; Wed, 10 May 2023 21:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683779748; x=1686371748;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+p7cDTQzCuKi1QAFDlX+tde47HjymadRIrRiXpBnjrE=;
        b=RNxRw3AER9+L5QAQHv+p6mRvl+kLRPDjAKnUfRCQOcDelCmEsaqcsoNCZ9z6jDnrrF
         1dGvlmTRCSz6GivkNmP4B8tOGOOSq6Wt3W4n6WYv2A/10cBkSKHBqKgYZ1kIdqfRxRv2
         b6/PqCtdX4ix7yNCLa/PS5e6wv2Gw1YtT/EuoE2wpe5IJsk/tNbOekNlZ2HocnjPlgpj
         lSA1YwTzKnLyqwSgSKCOk/yYtynRYu60PUe/zpxP112dZ3XnJoa/QQJP9/l4IL72dAw3
         efPluGkJmhM0YEv05bCCm1C2B3NBAmU0VrOlKGR25w8Huvmiap7lbD8JzalsqF5imjPe
         EiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683779748; x=1686371748;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+p7cDTQzCuKi1QAFDlX+tde47HjymadRIrRiXpBnjrE=;
        b=SPW9y4MHGQ/497sKLIHwtOW1fs/Xd6H3AqaUr4hNjCmSj9zytiHbK08oxkBQ88CneW
         z3ESUndxGhO48QoCqFctM8gtJAePvNcv9fzlAh6s1kPtHp+4zr3yDQcZauSBRSSEeOKW
         SlwGTcztsE8StOb/sDMoeOfEdAdwVhEcU+RsOTRXXZTXkj7A+TwgIDND86gMBBspuy2L
         +xM3x4XemAlMJ8qc4rhgCtUP2vjcDi42Nk5uHxo1l06pcCtyXZNzvBJnIIIW0LfED4eD
         yuhE8UH9JoZqAd4hL5R9YD5eyLRY7CWJUmHvsvuvtaL+lUGUpLdNitQCV1Ri72Q7cq+V
         16xg==
X-Gm-Message-State: AC+VfDyI7RqAy6JZM+5Ks1xT5pZJ2iQgTTq7Q6jV5m6WsgajTSz9FWl8
        qHYAZueUEFh7lyhrLZDsN4k69Q==
X-Google-Smtp-Source: ACHHUZ4jNGBbv4gj0OghzQ/5FaHnsUorF/gO/2yZgUAa0GVD52UTO1h980KsCPnjFH9AHSAArpdGLQ==
X-Received: by 2002:a25:4884:0:b0:b9d:fe06:1f5b with SMTP id v126-20020a254884000000b00b9dfe061f5bmr18740294yba.15.1683779748403;
        Wed, 10 May 2023 21:35:48 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a81-20020a251a54000000b00b7767ca749esm4213494yba.59.2023.05.10.21.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 21:35:47 -0700 (PDT)
Date:   Wed, 10 May 2023 21:35:44 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Helge Deller <deller@gmx.de>,
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
        Max Filippov <jcmvbkbc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/23] arch: allow pte_offset_map[_lock]() to fail
In-Reply-To: <ZFs0k2rrLPH9A/UU@casper.infradead.org>
Message-ID: <d7f3c7b2-25b8-ef66-98a8-43d68f4499f@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com> <ZFs0k2rrLPH9A/UU@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, 10 May 2023, Matthew Wilcox wrote:
> On Tue, May 09, 2023 at 09:39:13PM -0700, Hugh Dickins wrote:
> > Two: pte_offset_map() will need to do an rcu_read_lock(), with the
> > corresponding rcu_read_unlock() in pte_unmap().  But most architectures
> > never supported CONFIG_HIGHPTE, so some don't always call pte_unmap()
> > after pte_offset_map(), or have used userspace pte_offset_map() where
> > pte_offset_kernel() is more correct.  No problem in the current tree,
> > but a problem once an rcu_read_unlock() will be needed to keep balance.
> 
> Hi Hugh,
> 
> I shall have to spend some time looking at these patches, but at LSFMM
> just a few hours ago, I proposed and nobody objected to removing
> CONFIG_HIGHPTE.  I don't intend to take action on that consensus
> immediately, so I can certainly wait until your patches are applied, but
> if this information simplifies what you're doing, feel free to act on it.

Thanks a lot, Matthew: very considerate, as usual.

Yes, I did see your "Whither Highmem?" (wither highmem!) proposal on the
list, and it did make me think, better get these patches and preview out
soon, before you get to vanish pte_unmap() altogether.  HIGHMEM or not,
HIGHPTE or not, I think pte_offset_map() and pte_unmap() still have an
important role to play.

I don't really understand why you're going down a remove-CONFIG_HIGHPTE
route: I thought you were motivated by the awkardness of kmap on large
folios; but I don't see how removing HIGHPTE helps with that at all
(unless you have a "large page tables" effort in mind, but I doubt it).

But I've no investment in CONFIG_HIGHPTE if people think now is the
time to remove it: I disagree, but wouldn't miss it myself - so long
as you leave pte_offset_map() and pte_unmap() (under whatever names).

I don't think removing CONFIG_HIGHPTE will simplify what I'm doing.
For a moment it looked like it would: the PAE case is nasty (and our
data centres have not been on PAE for a long time, so it wasn't a
problem I had to face before); and knowing pmd_high must be 0 for a
page table looked like it would help, but now I'm not so sure of that
(hmm, I'm changing my mind again as I write).

Peter's pmdp_get_lockless() does rely for complete correctness on
interrupts being disabled, and I suspect that I may be forced in the
PAE case to do so briefly; but detest that notion.  For now I'm just
deferring it, hoping for a better idea before third series finalized.

I mention this (and Cc Peter) in passing: don't want this arch thread
to go down into that rabbit hole: we can start a fresh thread on it if
you wish, but right now my priority is commit messages for the second
series, rather than solving (or even detailing) the PAE problem.

Hugh
