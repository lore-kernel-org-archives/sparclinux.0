Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C16C432BE
	for <sparclinux@archiver.kernel.org>; Sun, 29 Aug 2021 15:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5750F606A5
	for <sparclinux@archiver.kernel.org>; Sun, 29 Aug 2021 15:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbhH2P2o (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sun, 29 Aug 2021 11:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59301 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235470AbhH2P2o (ORCPT
        <rfc822;sparclinux@vger.kernel.org>);
        Sun, 29 Aug 2021 11:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630250870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/S0QZCFqA24VJgqlctj6OrB5o3BOYhqGUcLEBNlCi1I=;
        b=ElJiKy7/0Xuj6MbzzV2p2HwXbyFVWUCXAn6WJaDYPxPkC9S/JPbel2Yb1R/wc9ghqHXv0G
        HT/0f5AT88AaKySBnLKjYUmpU4RmXHmGlDjeWvjCYZBwTrDxNHuEMAo0/ZoUo74L8M/7ZR
        Nu5+17ZdsawMxR+QCmP7inaOSol9b50=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464--SISeDuLO4ammi19jAtlyA-1; Sun, 29 Aug 2021 11:27:49 -0400
X-MC-Unique: -SISeDuLO4ammi19jAtlyA-1
Received: by mail-wm1-f72.google.com with SMTP id u1-20020a05600c210100b002e74fc5af71so3887545wml.1
        for <sparclinux@vger.kernel.org>; Sun, 29 Aug 2021 08:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/S0QZCFqA24VJgqlctj6OrB5o3BOYhqGUcLEBNlCi1I=;
        b=rA8buIh8TuzNfjqaHQSmxwHHpwI8xLYCgeyiSWxXMqUySLpCsqNx3jMUYEeJUpGLxI
         7OnJZURx5wmbZyrJlNbDvvgRHYfc3VT5KUfn0J01lkrThBcHKiHxaiSVRFInGdgcUTjl
         HApSJINEz7foeN636yaAlDPs0z+OnynNlM3cUErhQJBGiJEUKHDkEkk09vpHPI7ccyF8
         v286PZEpj+4bDrXbhlVrJ2AxXQ9ebJiXPnHCunAVbXw/OtBOqvkmelROfDbQTzgPHdCX
         K93NdK27zmwi9jWZkZV2ED+r2wAf6zT0in5SUT8C8wvMId+UWvgP6OKjxJ28auSQEVEj
         Yiaw==
X-Gm-Message-State: AOAM5332ssEQ69bmal6CvxbKxOHQ2gWLJBN50VEQ0tHt/i6UumLMBQSg
        o1xdi/vKH41H1E6s3QXtJ1tfRdYmqcvE/oE3CB5tn667/DjnN4kDE1/Px2AFkvLDeqqDCoAfire
        5J9eIrQGvRJn3FgZ3UEN/0w==
X-Received: by 2002:a5d:6cc9:: with SMTP id c9mr9292558wrc.158.1630250868452;
        Sun, 29 Aug 2021 08:27:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFpypfJ90QjoywS7jnahpw22uN0JXnwctorbzewr/oyY6u13VvTyKXFX7etQ/daiEVk+VHUA==
X-Received: by 2002:a5d:6cc9:: with SMTP id c9mr9292527wrc.158.1630250868242;
        Sun, 29 Aug 2021 08:27:48 -0700 (PDT)
Received: from redhat.com ([2.55.137.4])
        by smtp.gmail.com with ESMTPSA id s1sm6762197wrs.53.2021.08.29.08.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 08:27:47 -0700 (PDT)
Date:   Sun, 29 Aug 2021 11:27:42 -0400
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
Message-ID: <20210829112105-mutt-send-email-mst@kernel.org>
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210805005218.2912076-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210823195409-mutt-send-email-mst@kernel.org>
 <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
 <CAPcyv4iJVQKJ3bVwZhD08c8GNEP0jW2gx=H504NXcYK5o2t01A@mail.gmail.com>
 <d992b5af-8d57-6aa6-bd49-8e2b8d832b19@linux.intel.com>
 <20210824053830-mutt-send-email-mst@kernel.org>
 <d21a2a2d-4670-ba85-ce9a-fc8ea80ef1be@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d21a2a2d-4670-ba85-ce9a-fc8ea80ef1be@linux.intel.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, Aug 24, 2021 at 10:20:44AM -0700, Andi Kleen wrote:
> 
> > I see. Hmm. It's a bit of a random thing to do it at the map time
> > though. E.g. DMA is all handled transparently behind the DMA API.
> > Hardening is much more than just replacing map with map_shared
> > and I suspect what you will end up with is basically
> > vendors replacing map with map shared to make things work
> > for their users and washing their hands.
> 
> That concept exists too. There is a separate allow list for the drivers. So
> just adding shared to a driver is not enough, until it's also added to the
> allowlist
> 
> Users can of course chose to disable the allowlist, but they need to
> understand the security implications.

Right. So given that, why do we need to tweak a random API like the map?
If you just make all maps be shared then the user is in control.
Seems sensible to me.

> 
> > 
> > I would say an explicit flag in the driver that says "hardened"
> > and refusing to init a non hardened one would be better.
> 
> 
> We have that too (that's the device filtering)
> 
> But the problem is that device filtering just stops the probe functions, not
> the initcalls, and lot of legacy drivers do MMIO interactions before going
> into probe. In some cases it's unavoidable because of the device doesn't
> have a separate enumeration mechanism it needs some kind of probing to even
> check for its existence And since we don't want to change all of them it's
> far safer to make the ioremap opt-in.
> 
> 
> -Andi

Let's be frank, even without encryption disabling most drivers -
especially weird ones that poke at hardware before probe -
is far safer than keeping them, but one loses a bunch of features.
IOW all this hardening is nice but which security/feature tradeoff
to take it a policy decision, not something kernel should do
imho.

-- 
MST

