Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BE0C4338F
	for <sparclinux@archiver.kernel.org>; Tue, 24 Aug 2021 01:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC7060231
	for <sparclinux@archiver.kernel.org>; Tue, 24 Aug 2021 01:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbhHXBGj (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 23 Aug 2021 21:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbhHXBGe (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 23 Aug 2021 21:06:34 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5ADC0613D9
        for <sparclinux@vger.kernel.org>; Mon, 23 Aug 2021 18:04:11 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id w8so18262720pgf.5
        for <sparclinux@vger.kernel.org>; Mon, 23 Aug 2021 18:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+KWjXh2lT4oyxvT6TUUge6cE2M/3E1/QPatrdIWAbCk=;
        b=ssDUJbZQUoHOjzKeOoupouQflaDtoV/KGM0ZbImx65Id9YAIXzBr7xLGKgTJu5h7I2
         HHPWAyYNY1bDMlXgvnD4vDkqa1dsykDsMeTtzg3vHCZHA743vpTJ8zJ4NdfqSdbmmqvy
         KiEWa7Khi9N0O/9RoziHtutYHO2/nwyh6DBm4tBUK7GNpef0LXqDL+0p5s3nrsgMW6K/
         FFWm8o5SonyxAvLyA2+U5fUS7ZWjvbxn5iMEzqko5Bo0H+b6KX6dRPsNpkxsT+0zJzz9
         wV+DeBmwuvYfrQWDLM0QASdRWxoXpFfTwLTHLiDMsXuWjkskMss7fMermWEKgv/FmCUr
         IxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KWjXh2lT4oyxvT6TUUge6cE2M/3E1/QPatrdIWAbCk=;
        b=cFhsIPhGOKHOscO8u8/5AfvkVe95trPmmKW0b3DRlCBIRf4pX30NABEGDcoKGQOIf5
         axp+FBo/qBzw65P5TymUV8pfPx5KcsIPMAtxWSpH4Ae9LgEK1bpRoOJxiL4umD+ow907
         92/Xd3VlFazRKQf+w50GHcJDO9NDoDNVcBxFmPPxEK6lk33DJjlaRN0rmez0MTJNFBhF
         u8tCRts3efTvZEAsb738GEqIxGrqUGNXgrizy0dN0KoEw7axvj48kCtD3x819a32xAWy
         zjsajRf5xmjvbea2sH6th8YtyV0ieZH0zJ0Uy3b20ZjbzJkbX3V6zEXytzxbHPGQZelx
         oC4g==
X-Gm-Message-State: AOAM533vRAF9tsze/g/8HWSuGdm1VO6cKAIWTMBKkgfM39H/11nSXF0F
        NVQg8KDrhn5BKakG6q2m39m7ZMPXd9mbk4S6Kjj0Nw==
X-Google-Smtp-Source: ABdhPJwr+d+03lWZE5hBC3RKJQrz+BrvZKJ9PwHrCLpkrlXplyqx0kAfavOgC5QFY0A8k9yCeP+k8gHn1t12t0fKZcY=
X-Received: by 2002:a05:6a00:16c6:b029:32d:e190:9dd0 with SMTP id
 l6-20020a056a0016c6b029032de1909dd0mr36118105pfc.70.1629767051049; Mon, 23
 Aug 2021 18:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210805005218.2912076-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210823195409-mutt-send-email-mst@kernel.org> <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
In-Reply-To: <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 23 Aug 2021 18:04:00 -0700
Message-ID: <CAPcyv4iJVQKJ3bVwZhD08c8GNEP0jW2gx=H504NXcYK5o2t01A@mail.gmail.com>
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
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
        Andi Kleen <ak@linux.intel.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Mon, Aug 23, 2021 at 5:31 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 8/23/21 4:56 PM, Michael S. Tsirkin wrote:
> >> Add a new variant of pci_iomap for mapping all PCI resources
> >> of a devices as shared memory with a hypervisor in a confidential
> >> guest.
> >>
> >> Signed-off-by: Andi Kleen<ak@linux.intel.com>
> >> Signed-off-by: Kuppuswamy Sathyanarayanan<sathyanarayanan.kuppuswamy@linux.intel.com>
> > I'm a bit puzzled by this part. So why should the guest*not*  map
> > pci memory as shared? And if the answer is never (as it seems to be)
> > then why not just make regular pci_iomap DTRT?
>
> It is in the context of confidential guest (where VMM is un-trusted). So
> we don't want to make all PCI resource as shared. It should be allowed
> only for hardened drivers/devices.

That's confusing, isn't device authorization what keeps unaudited
drivers from loading against untrusted devices? I'm feeling like
Michael that this should be a detail that drivers need not care about
explicitly, in which case it does not need to be exported because the
detail can be buried in lower levels.

Note, I specifically said "unaudited", not "hardened" because as Greg
mentioned the kernel must trust drivers, its devices that may not be
trusted.
