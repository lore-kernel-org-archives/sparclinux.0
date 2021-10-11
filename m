Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3348C433F5
	for <sparclinux@archiver.kernel.org>; Mon, 11 Oct 2021 12:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B794060F38
	for <sparclinux@archiver.kernel.org>; Mon, 11 Oct 2021 12:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbhJKMG2 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 08:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59813 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234579AbhJKMG0 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>);
        Mon, 11 Oct 2021 08:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633953866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6/UQYl/XVfz1u8aL1mV3gDk9yEhwnmg9oxdpI3UoFb8=;
        b=UAQPpOL3d+SkOdmqk2dJ32OTYJEBpDYO4Qmc1inMO5yuKE1D8K4Hmj4orZqF+Wg8qX0N0a
        13urz43P0iMNNKx7Se3CULcesjErBH0U62PdhmJpBqnQcd+lvDmpnT0QOUyzbRdxlsln65
        880juoDXVPZ3cUtt+RrweQg2AsVqzog=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-Ki8D_pmcP1K08VBtctOLZQ-1; Mon, 11 Oct 2021 08:04:24 -0400
X-MC-Unique: Ki8D_pmcP1K08VBtctOLZQ-1
Received: by mail-ed1-f71.google.com with SMTP id u17-20020a50d511000000b003daa3828c13so15677433edi.12
        for <sparclinux@vger.kernel.org>; Mon, 11 Oct 2021 05:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6/UQYl/XVfz1u8aL1mV3gDk9yEhwnmg9oxdpI3UoFb8=;
        b=TM/BZQYcj0NO/m7v4QlCpjzk1fd+Cob3QyyoO8J2qgOETEgtvRs/q54+khxARfCHPm
         ONIRCafq+pDJNS+zsxAkQ0E1TL+VbxeiUVVowZxeSJMEYw3MS+hts/W+1ZdKRCiQ44fN
         QDJv0WHtmK3A+PeP/yJBv9ApKVlkKo9Ghwe1Miec/MPIHOjt04j7XmfbZ9CQGFB3w5p8
         yoZOL7NOJ7fJaqO4ACG7W3HfEQl2AqGfy2lqEI2h+RznVlL/RR9dHNO3SPDWsWd2sfpT
         hIiNXGk6S4Soj0Nw3BzoU7tKmqRNQ6fERxukZiiNrS4mCgfYIfe9H1rKNRZqSmjCpT/m
         bEjQ==
X-Gm-Message-State: AOAM531WID7VVU2/TXOEKR3TI8G3Tp4bCFzl5g8afvi+fTXODnU32wfE
        Mz8bGsIsJZ4vACyIBDCNYiR7+7Lp14yiJUHPM0RfDh4A3D2LnIQb+ijQmeaqaTAVi9Z4ZqQpHQb
        N0myagUm27Vz5iW6gnoNXmQ==
X-Received: by 2002:a17:906:6bce:: with SMTP id t14mr5105170ejs.546.1633953863649;
        Mon, 11 Oct 2021 05:04:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVo7pMtVffuQEXqsF/L2jnPTyIClLeLABvDqmnuGdNXl4W+vIVe08L9GSGn7GemWiCV8sawQ==
X-Received: by 2002:a17:906:6bce:: with SMTP id t14mr5105145ejs.546.1633953863516;
        Mon, 11 Oct 2021 05:04:23 -0700 (PDT)
Received: from redhat.com ([2.55.159.57])
        by smtp.gmail.com with ESMTPSA id j22sm3412840ejt.11.2021.10.11.05.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 05:04:22 -0700 (PDT)
Date:   Mon, 11 Oct 2021 08:04:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
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
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v5 16/16] x86/tdx: Add cmdline option to force use of
 ioremap_host_shared
Message-ID: <20211011075945-mutt-send-email-mst@kernel.org>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-17-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009070132-mutt-send-email-mst@kernel.org>
 <8c906de6-5efa-b87a-c800-6f07b98339d0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c906de6-5efa-b87a-c800-6f07b98339d0@linux.intel.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Sun, Oct 10, 2021 at 07:39:55PM -0700, Andi Kleen wrote:
> 
> > The connection is quite unfortunate IMHO.
> > Can't there be an option
> > that unbreaks drivers *without* opening up security holes by
> > making BIOS shared?
> 
> That would require new low level APIs that distinguish both cases, and a
> tree sweep.
> 
> 
> -Andi

Presumably bios code is in arch/x86 and drivers/acpi, right?
Up to 200 calls the majority of which is likely private ...

I don't have better ideas but the current setup will just
result in people making their guests vulnerable whenever they
want to allow device pass-through.

-- 
MST

