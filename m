Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10071C43214
	for <sparclinux@archiver.kernel.org>; Fri, 13 Aug 2021 08:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA13B60234
	for <sparclinux@archiver.kernel.org>; Fri, 13 Aug 2021 08:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239773AbhHMIMW (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbhHMIMV (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 13 Aug 2021 04:12:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C161C061756;
        Fri, 13 Aug 2021 01:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J5iMSjwPMvkOFpq0TMlTZtl3sxje2OPtaEgmn6rI3kw=; b=tLoy64zP56BA6COvXf26VAiBG9
        oKjbIjnNL8arRxo50od3oQ9WiLXRnnIQhwWpPCi11t8FmIOTy5frodVYORATqo1cnyknkdAttACMh
        IuMWI23bPAIcxV2I4FQ55yZj75VZCoja9nk9jCbJl2kLpcbtCS6bW+/E3OtXurRenuXwnHahWGhHg
        VmR8RasuVRLggxW1RHCjYBVYq+of6asU83tj5SwmMaoQZlZNE/hmhjV94fEjEqMYdxvBoRzvKKJgC
        EoAexDTExue7OUZO7UKAGrfL514yBqR5kWkuh5KUCOhD+Khwegyzwh0IZDHIBx/Bt0akrVQgr2x1g
        9A5BlXNA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mESEG-00FTaW-Kf; Fri, 13 Aug 2021 08:07:59 +0000
Date:   Fri, 13 Aug 2021 09:07:48 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 12/15] pci: Mark MSI data shared
Message-ID: <YRYoVBIXZ/910eaq@infradead.org>
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210805005218.2912076-13-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805005218.2912076-13-sathyanarayanan.kuppuswamy@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, Aug 04, 2021 at 05:52:15PM -0700, Kuppuswamy Sathyanarayanan wrote:
>  
> -	return ioremap(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
> +	return ioremap_shared(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);

Please add a comment here.  I also find the amount of ioremap_* variants
rather frustrating.  Maybe it it is time for a ioremap_flags which
replaces the too-lowlevel pgprot_t of the ioremap_prot provided by some
architectures with a more highlevel flags arguments that could also
provide an accessible to the hypervisor flag.
