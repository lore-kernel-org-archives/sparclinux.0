Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F700C4320E
	for <sparclinux@archiver.kernel.org>; Tue, 24 Aug 2021 21:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8AA0610FD
	for <sparclinux@archiver.kernel.org>; Tue, 24 Aug 2021 21:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbhHXVGW (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbhHXVGV (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 24 Aug 2021 17:06:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0E6C0617A8
        for <sparclinux@vger.kernel.org>; Tue, 24 Aug 2021 14:05:36 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id w68so19451027pfd.0
        for <sparclinux@vger.kernel.org>; Tue, 24 Aug 2021 14:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=50KgIimgoHn2hLRecJ9xsYP+KbZzb8N9bfDIuPfzvjQ=;
        b=NvAgKb0THlkdDUQ0aRx+9mednYqLHP6M3XIYjenGeve36GswyogqqyEtfltG9odhSS
         sXNl+nzWb/jgjnohkyON1TK0N4HUhwZj7aRcTxvirbX0hPedZ8o7Xo7c5YpxKjNNzQYr
         zyJiMtdKa9NltLOObRsERtWbUkAqlgZSPFS2egovwI2a4M3yx8YiJOFhAZDgyiFWM4Tr
         bAb4DagRmpCRfU/tqemlilYyGEtImDNJKoZmeV/8h3FeicEkU17ZO2s8oFIsfzw7ghCP
         W7IqcpYk1aL3JziP3HtHww5os2Qnu25hR/eXZFgKZ3PqWWua0S27ru9KI2z3Lojktzjy
         vK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=50KgIimgoHn2hLRecJ9xsYP+KbZzb8N9bfDIuPfzvjQ=;
        b=ka8utNtOMdM4v7Gc0tRYnpE6kZ+VIa9veHLA53VlnIBxHoiTSUNvmGa7h/EBX6jl9I
         /dvCtFduz//FKq1XbnE+bvIWXb5dJHjWcw6Fmq0QHhjiWM3SII9NlGNBuF/sWzHQUVSF
         Sg/jlvQvOj6Xqtr1ZjcwLoM6OswXXiQa43ngRpFcrcQq/RRM4BgwGcQymQDIXImlk6Gt
         qMJhpa7oZRonscN2uX/YQtIU39r/QKSHXcF8WTTmTDdCRljMC8kuy4GJ/yuyXaYGz85G
         7tA3CEmP0vmAfAgN3e1OwjqMgr7O4w8HunKsQuFvb8Wvad3NjilltXvMmKA6jBhjg/KD
         k+nw==
X-Gm-Message-State: AOAM530Vvpgv3aPNwHBZoghNofAtypv0l21sfgCCYXrbxGIZ/82351Gi
        4QGvakpUWaxGtm0pg26eGCZQHfa/UvGYKcH1Zsbpcw==
X-Google-Smtp-Source: ABdhPJwkzMtO2gq/o/NUrPl5vjkkiQPqJ23InKpT9YHvAxhia00+dsPd0+b1/fg0fqEO9y3ko1JQOVp9Vu81LPNo08o=
X-Received: by 2002:a65:6642:: with SMTP id z2mr26349152pgv.240.1629839136081;
 Tue, 24 Aug 2021 14:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210824203115.GA3492097@bjorn-Precision-5520> <bb8c6f96-2597-bb80-bd08-7958405e1bf5@linux.intel.com>
In-Reply-To: <bb8c6f96-2597-bb80-bd08-7958405e1bf5@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 24 Aug 2021 14:05:25 -0700
Message-ID: <CAPcyv4jjonArG94PbuMPTZefxqnFr+PEG7Gjem0Taa_iGRmSDA@mail.gmail.com>
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
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
        virtualization@lists.linux-foundation.org,
        Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, Aug 24, 2021 at 1:50 PM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 8/24/2021 1:31 PM, Bjorn Helgaas wrote:
> > On Tue, Aug 24, 2021 at 01:14:02PM -0700, Andi Kleen wrote:
> >> On 8/24/2021 11:55 AM, Bjorn Helgaas wrote:
> >>> [+cc Rajat; I still don't know what "shared memory with a hypervisor
> >>> in a confidential guest" means,
> >> A confidential guest is a guest which uses memory encryption to isolate
> >> itself from the host. It doesn't trust the host. But it still needs to
> >> communicate with the host for IO, so it has some special memory areas that
> >> are explicitly marked shared. These are used to do IO with the host. All
> >> their usage needs to be carefully hardened to avoid any security attacks on
> >> the guest, that's why we want to limit this interaction only to a small set
> >> of hardened drivers. For MMIO, the set is currently only virtio and MSI-X.
> > Good material for the commit log next time around.  Thanks!
>
> This is all in the patch intro too, which should make it into the merge
> commits.
>
> I don't think we can reexplain the basic concepts for every individual
> patch in a large patch kit.

Maybe not the whole cover letter, but how about just a line in this
one that says "Recall that 'shared' in this context refers to memory
that lacks confidentiality and integrity protection from the VMM so
that it can communicate with the VM." Although I think
ioremap_noprotect() might be clearer than shared for the protected
guest use case?
