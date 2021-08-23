Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C642C4338F
	for <sparclinux@archiver.kernel.org>; Mon, 23 Aug 2021 23:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FDB461374
	for <sparclinux@archiver.kernel.org>; Mon, 23 Aug 2021 23:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbhHWX45 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 23 Aug 2021 19:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34589 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233350AbhHWX45 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>);
        Mon, 23 Aug 2021 19:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629762973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RF+d9qpVprIgoIZ0mXGZUwRPD3HGuqO+bXOLg0En698=;
        b=TjrQUVXiJRnZm5zdmiMSgNJM8Mz4QUaHHG/Z62UymjbI9HNCRXB352A6+ylM01kehZPLga
        fgigsL7HPBFhN0gZspn969usecXH5HSrik36Km+PHQI4BB3usiez5X4n5XiC6jSG50ncdU
        IiWUJTngOLA0p4IKybgaISdO8LX6qxw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-xo89RZk7OQeiBDgIOUgC1A-1; Mon, 23 Aug 2021 19:56:12 -0400
X-MC-Unique: xo89RZk7OQeiBDgIOUgC1A-1
Received: by mail-ej1-f71.google.com with SMTP id ne21-20020a1709077b95b029057eb61c6fdfso6317357ejc.22
        for <sparclinux@vger.kernel.org>; Mon, 23 Aug 2021 16:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RF+d9qpVprIgoIZ0mXGZUwRPD3HGuqO+bXOLg0En698=;
        b=Dp+mcwn0Adf0YykDckEgir3Ov4xvSHUe54M8zbyumaLEsbT/l1chYQJOC8WCRQfA1f
         SNzH/J8T1hbzt1lp5tgVQqYsPZYFFcMhDzFUwh0WIlrMKVLxGYWrZhmvdog7g5jRIWZW
         ZjqEQYYg08k8O53lXewqg2OirmUMCUoZO6BG+hLQs0xWc1gQjrP/WnVLuFfgnoBAu8rn
         spb+P50arrZYTPzZ9+xJBaqJ22PTge7DjDAY15su/e0IagiFGLL3i/cg9cKzXZOImCyy
         0Jks0AhEZ78lDzUdFUxyVWxdpdsdUYnMD3A7s1OXIoF2UY80y6V7ps4HqYg8TWgeqBXf
         HQlQ==
X-Gm-Message-State: AOAM531qH+mZkT3QHONp0Wr2BwEptbsfbbGwCwQteTrcyEYGvKq/8Igm
        GG4ocxhUpvhFkf/gewB/EUnoS7FTeHZiq8GUafbiITqdlReymz1TDXCMg0ihdl3Nam7aZGad+pu
        ROwzBbotkWw4axF8uGlCkjA==
X-Received: by 2002:a17:907:2cf1:: with SMTP id hz17mr32841061ejc.438.1629762970795;
        Mon, 23 Aug 2021 16:56:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlg8FJcUqFiderk/GNwJI39sbQlYErPR6APlNK/zjSzsj+DjKP0nKP8p+wjD6AR325FzPuGA==
X-Received: by 2002:a17:907:2cf1:: with SMTP id hz17mr32841039ejc.438.1629762970610;
        Mon, 23 Aug 2021 16:56:10 -0700 (PDT)
Received: from redhat.com ([2.55.137.225])
        by smtp.gmail.com with ESMTPSA id m17sm4928372ejr.27.2021.08.23.16.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 16:56:09 -0700 (PDT)
Date:   Mon, 23 Aug 2021 19:56:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
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
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
Message-ID: <20210823195409-mutt-send-email-mst@kernel.org>
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210805005218.2912076-12-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805005218.2912076-12-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, Aug 04, 2021 at 05:52:14PM -0700, Kuppuswamy Sathyanarayanan wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Add a new variant of pci_iomap for mapping all PCI resources
> of a devices as shared memory with a hypervisor in a confidential
> guest.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

I'm a bit puzzled by this part. So why should the guest *not* map
pci memory as shared? And if the answer is never (as it seems to be)
then why not just make regular pci_iomap DTRT?

Thanks!

> ---
>  include/asm-generic/pci_iomap.h |  6 +++++
>  lib/pci_iomap.c                 | 46 +++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iomap.h
> index d4f16dcc2ed7..0178ddd7ad88 100644
> --- a/include/asm-generic/pci_iomap.h
> +++ b/include/asm-generic/pci_iomap.h
> @@ -18,6 +18,12 @@ extern void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
>  extern void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
>  					unsigned long offset,
>  					unsigned long maxlen);
> +extern void __iomem *pci_iomap_shared(struct pci_dev *dev, int bar,
> +				      unsigned long max);
> +extern void __iomem *pci_iomap_shared_range(struct pci_dev *dev, int bar,
> +					    unsigned long offset,
> +					    unsigned long maxlen);
> +
>  /* Create a virtual mapping cookie for a port on a given PCI device.
>   * Do not call this directly, it exists to make it easier for architectures
>   * to override */
> diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
> index 6251c3f651c6..b04e8689eab3 100644
> --- a/lib/pci_iomap.c
> +++ b/lib/pci_iomap.c
> @@ -25,6 +25,11 @@ static void __iomem *map_ioremap_wc(phys_addr_t addr, size_t size)
>  	return ioremap_wc(addr, size);
>  }
>  
> +static void __iomem *map_ioremap_shared(phys_addr_t addr, size_t size)
> +{
> +	return ioremap_shared(addr, size);
> +}
> +
>  static void __iomem *pci_iomap_range_map(struct pci_dev *dev,
>  					 int bar,
>  					 unsigned long offset,
> @@ -101,6 +106,47 @@ void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
>  }
>  EXPORT_SYMBOL_GPL(pci_iomap_wc_range);
>  
> +/**
> + * pci_iomap_shared_range - create a virtual shared mapping cookie for a
> + *                          PCI BAR
> + * @dev: PCI device that owns the BAR
> + * @bar: BAR number
> + * @offset: map memory at the given offset in BAR
> + * @maxlen: max length of the memory to map
> + *
> + * Remap a pci device's resources shared in a confidential guest.
> + * For more details see pci_iomap_range's documentation.
> + *
> + * @maxlen specifies the maximum length to map. To get access to
> + * the complete BAR from offset to the end, pass %0 here.
> + */
> +void __iomem *pci_iomap_shared_range(struct pci_dev *dev, int bar,
> +				     unsigned long offset, unsigned long maxlen)
> +{
> +	return pci_iomap_range_map(dev, bar, offset, maxlen,
> +				   map_ioremap_shared);
> +}
> +EXPORT_SYMBOL_GPL(pci_iomap_shared_range);
> +
> +/**
> + * pci_iomap_shared - create a virtual shared mapping cookie for a PCI BAR
> + * @dev: PCI device that owns the BAR
> + * @bar: BAR number
> + * @maxlen: length of the memory to map
> + *
> + * See pci_iomap for details. This function creates a shared mapping
> + * with the host for confidential hosts.
> + *
> + * @maxlen specifies the maximum length to map. To get access to the
> + * complete BAR without checking for its length first, pass %0 here.
> + */
> +void __iomem *pci_iomap_shared(struct pci_dev *dev, int bar,
> +			       unsigned long maxlen)
> +{
> +	return pci_iomap_shared_range(dev, bar, 0, maxlen);
> +}
> +EXPORT_SYMBOL_GPL(pci_iomap_shared);
> +
>  /**
>   * pci_iomap - create a virtual mapping cookie for a PCI BAR
>   * @dev: PCI device that owns the BAR
> -- 
> 2.25.1

