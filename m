Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D4CC4320A
	for <sparclinux@archiver.kernel.org>; Tue, 24 Aug 2021 09:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E1661360
	for <sparclinux@archiver.kernel.org>; Tue, 24 Aug 2021 09:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbhHXJM6 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 24 Aug 2021 05:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20368 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235675AbhHXJM5 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>);
        Tue, 24 Aug 2021 05:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629796332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UO2zBbBs1G6uT3R3xch5pdAd9JzMFmQCenqYTZnnAws=;
        b=ciI55oT+4ry/YlJLlDbugRTfprdq8vmV8TxkKb01viiPuKkCGhO804W14LS76wuqUuE+pJ
        KfuZCRH8vytOEwSgN/ZVJOTN8ffYpvEEqlTWk9AnsTrzYcdsb0W9dwj/0mW756MhXE+X9y
        cur4x82RiyCts6/Ze32mfLqL6/9yMes=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-UXK7FWXtNW2Oen-Qiz74nQ-1; Tue, 24 Aug 2021 05:12:11 -0400
X-MC-Unique: UXK7FWXtNW2Oen-Qiz74nQ-1
Received: by mail-ej1-f70.google.com with SMTP id ak17-20020a170906889100b005c5d1e5e707so2048716ejc.16
        for <sparclinux@vger.kernel.org>; Tue, 24 Aug 2021 02:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UO2zBbBs1G6uT3R3xch5pdAd9JzMFmQCenqYTZnnAws=;
        b=uOWKhub0WOAx6XkstAq2l7V0/xi66GWpGfaovfY5z1anSUj53nOfmZOk1phrVrRhyg
         pbW9P0CGCcjnR+EEtJa/vMXPgDWQoV36JmXVNTThIlwe72yOeO1lbsp933J1Mo5R12l7
         YkfJGPAJRzrI/3ANVaxVoLz9D2mBsw6nQH4jSjxX9KABwLwZxP3K58vm8qm8BK0RjP92
         lIxbPRAHIuxZSADO/ovptd1wItaGNXMPsNMiyGzAbJeXjDxWW1a/qn4a3OSwbS4GSjFo
         Fd6VrObNlu4Vml/fW75HCSuJOROzAzpJ2kLhDFx3KzaJzPPsy1Ps/Xu7GRv3oAtjbIms
         15Hg==
X-Gm-Message-State: AOAM5315drGyd0IsMFl5OIMzBGI1HvkCbpokPtKSa3D//ZTf8u1zRwJX
        eJ0IvDQgHBy8rDg62ELGl0J1DN3FgJiKa77NQqRLh/yLTwqLoZizy0VZBkPfZma7yixZgU5yYKa
        u4g/mLu+r5+RqotCsUbvKZQ==
X-Received: by 2002:a17:906:544f:: with SMTP id d15mr39905081ejp.520.1629796330484;
        Tue, 24 Aug 2021 02:12:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3bMICaqu3WLm0C02mi3EAPqHyfBIAeSrxUN0aqhXmoBEhQ7Pz6k5PO9S6BLCHr/N7T4Bnvg==
X-Received: by 2002:a17:906:544f:: with SMTP id d15mr39905053ejp.520.1629796330344;
        Tue, 24 Aug 2021 02:12:10 -0700 (PDT)
Received: from redhat.com ([2.55.137.225])
        by smtp.gmail.com with ESMTPSA id b18sm2737239ejl.90.2021.08.24.02.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 02:12:09 -0700 (PDT)
Date:   Tue, 24 Aug 2021 05:12:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Kuppuswamy, Sathyanarayanan" 
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
Message-ID: <20210824050842-mutt-send-email-mst@kernel.org>
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210805005218.2912076-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210823195409-mutt-send-email-mst@kernel.org>
 <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Mon, Aug 23, 2021 at 05:30:54PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 8/23/21 4:56 PM, Michael S. Tsirkin wrote:
> > > Add a new variant of pci_iomap for mapping all PCI resources
> > > of a devices as shared memory with a hypervisor in a confidential
> > > guest.
> > > 
> > > Signed-off-by: Andi Kleen<ak@linux.intel.com>
> > > Signed-off-by: Kuppuswamy Sathyanarayanan<sathyanarayanan.kuppuswamy@linux.intel.com>
> > I'm a bit puzzled by this part. So why should the guest*not*  map
> > pci memory as shared? And if the answer is never (as it seems to be)
> > then why not just make regular pci_iomap DTRT?
> 
> It is in the context of confidential guest (where VMM is un-trusted). So
> we don't want to make all PCI resource as shared. It should be allowed
> only for hardened drivers/devices.

I can't say this answers the question at all. PCI devices are part of
the VMM and so un-trusted. In particular PCI devices do not have
the key to decrypt memory. Therefore as far as I can see PCI resources
should not be encrypted.  I conclude they all should be marked
shared.

If I'm wrong can you please give an example of a PCI resource
that is encrypted?

-- 
MST

