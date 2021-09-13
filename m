Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579C5C433F5
	for <sparclinux@archiver.kernel.org>; Mon, 13 Sep 2021 05:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B22260F4B
	for <sparclinux@archiver.kernel.org>; Mon, 13 Sep 2021 05:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbhIMFyz (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 13 Sep 2021 01:54:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237161AbhIMFyy (ORCPT
        <rfc822;sparclinux@vger.kernel.org>);
        Mon, 13 Sep 2021 01:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631512418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lmIEdzAE8KtfMvdI7Vd3u1eV+5W/XqJ3cF9Jvl0CpQM=;
        b=E8wPUo4YGf0ClFFj7olvkyJ5+CPF7gYV5p/uoy5NV0oieQltH61lQo12gx5jxDCF+KgZuP
        UP8wErPPqrFfX5RTvrMstwhBoZ2jfNz4HOQOJIi7NFZrePAEjjPCAzqN3nmXLnbedqdtVV
        tAI7Z1Az6+O/aNMBgUFRsPbDla7PT/c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-xuX5UXGGPsKsatd4veu_ag-1; Mon, 13 Sep 2021 01:53:36 -0400
X-MC-Unique: xuX5UXGGPsKsatd4veu_ag-1
Received: by mail-wm1-f71.google.com with SMTP id g70-20020a1c2049000000b00303d06c20b2so2152349wmg.0
        for <sparclinux@vger.kernel.org>; Sun, 12 Sep 2021 22:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lmIEdzAE8KtfMvdI7Vd3u1eV+5W/XqJ3cF9Jvl0CpQM=;
        b=T1fcmnOyfLffaln4fkxPo3Q3ecj/zP8xQtQJGOwW9IWQ20KBCu3OINOJO4ub/20CaC
         e3q+fq/8gd1Zlony+TWwJ046o/HDugFpYQdd9Dk9CUNlg4BJv1gSUsq/QaKRgQORmO+a
         jOtICHQDSfhVJFta+wj+5tLkfA7LUwFraBtDtxVCu1TiSjnduVbtswNJcRQ1ENt7+CSs
         cOsjxj7FL6TyH7wJ9z51Du/Z8Dgj0yasUV4UnUqxneMTah6qW61PKt1yae4mJU7opyGi
         738LBuWLn3TjvCZpNBibW2TWqlTQZXsa2QC+uq+kkJ2D5a/GyVoOksq2NjrLoi76jmbX
         9zTQ==
X-Gm-Message-State: AOAM531tH3YGBSNhUkaLxvI9jR+LuQ2P7hobhylr8E5abm7wZNxF0a2B
        VlUH3aDbvUxh/VCOsXHtu53D2yIiIHZlmpKcb+QtGYbmBEtB+cPo4704vdfNdpCXr48uT+rEDpo
        aok30ZNeI7lO9kJBfIlmfGw==
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr9470561wmk.135.1631512415167;
        Sun, 12 Sep 2021 22:53:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTQJ4DZD+V1695amUyGJ/+8H3ZLTdwwSERHH6LaZYj9FQdGTZerMCI+h0RgKu+afW5N87HtQ==
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr9470536wmk.135.1631512414954;
        Sun, 12 Sep 2021 22:53:34 -0700 (PDT)
Received: from redhat.com ([2.55.27.174])
        by smtp.gmail.com with ESMTPSA id k29sm5687574wms.24.2021.09.12.22.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 22:53:33 -0700 (PDT)
Date:   Mon, 13 Sep 2021 01:53:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
Message-ID: <20210913013815-mutt-send-email-mst@kernel.org>
References: <d21a2a2d-4670-ba85-ce9a-fc8ea80ef1be@linux.intel.com>
 <20210829112105-mutt-send-email-mst@kernel.org>
 <09b340dd-c8a8-689c-4dad-4fe0e36d39ae@linux.intel.com>
 <20210829181635-mutt-send-email-mst@kernel.org>
 <3a88a255-a528-b00a-912b-e71198d5f58f@linux.intel.com>
 <20210830163723-mutt-send-email-mst@kernel.org>
 <69fc30f4-e3e2-add7-ec13-4db3b9cc0cbd@linux.intel.com>
 <20210910054044-mutt-send-email-mst@kernel.org>
 <f672dc1c-5280-7bbc-7a56-7c7aab31725c@linux.intel.com>
 <20210911195006-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911195006-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Sat, Sep 11, 2021 at 07:54:43PM -0400, Michael S. Tsirkin wrote:
> On Fri, Sep 10, 2021 at 09:34:45AM -0700, Andi Kleen wrote:
> > > > that's why
> > > > an extra level of defense of ioremap opt-in is useful.
> > > OK even assuming this, why is pci_iomap opt-in useful?
> > > That never happens before probe - there's simply no pci_device then.
> > 
> > 
> > Hmm, yes that's true. I guess we can make it default to opt-in for
> > pci_iomap.
> > 
> > It only really matters for device less ioremaps.
> 
> OK. And same thing for other things with device, such as
> devm_platform_ioremap_resource.
> If we agree on all that, this will basically remove virtio
> changes from the picture ;)


Something else that was pointed out to me:

         fs->window_kaddr = devm_memremap_pages(&vdev->dev, pgmap);
         if (IS_ERR(fs->window_kaddr))
                 return PTR_ERR(fs->window_kaddr);


looks like if we forget to set the shared flag then it will
corrupt the DAX data?


> -- 
> MST
> 

