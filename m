Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B754C432BE
	for <sparclinux@archiver.kernel.org>; Sun, 29 Aug 2021 22:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B6DC604AC
	for <sparclinux@archiver.kernel.org>; Sun, 29 Aug 2021 22:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbhH2W1X (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sun, 29 Aug 2021 18:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21044 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234860AbhH2W1X (ORCPT
        <rfc822;sparclinux@vger.kernel.org>);
        Sun, 29 Aug 2021 18:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630275990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w+MBpgO+PBJKHqx0Y7eErLZSvPvNS8U9WRpzvSbhkVw=;
        b=gAmBZHwpZem49MSfu5U/CZ/a5gr5V2xPAiE8x7s7qTrcmyfHUZMhvXgnbBO48QN3T2mExC
        dO1u1BknmTb7tV0FmR+iQOV+BEZ7G638rsmFUPAERL53ZoCG+bUOEYbJE+c6RSOTkl8b/o
        ajJCJ6lUbgZfEZWmQfT67AkAmqdybSI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-TCu94BaiP1-hpw8M_LnYLw-1; Sun, 29 Aug 2021 18:26:29 -0400
X-MC-Unique: TCu94BaiP1-hpw8M_LnYLw-1
Received: by mail-wm1-f71.google.com with SMTP id j135-20020a1c238d000000b002e87aa95b5aso8408006wmj.4
        for <sparclinux@vger.kernel.org>; Sun, 29 Aug 2021 15:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w+MBpgO+PBJKHqx0Y7eErLZSvPvNS8U9WRpzvSbhkVw=;
        b=oMsn7cG7xhVVZAkf9IS+k7eQTX6I4omxJLJbkcpyqTYWST34MXE8IBol6nasp8y1hP
         jOkFmXpL8+SONuzCkCDOa7jstnRcgexlfTKnuMPFpoUv+hPDk44pB8oKFqKbr+QeytvV
         aMUQRmep3vTAqdFx8oMXChLyuvDt8tjZzzh3Rjqd3bcF7er284tdhtefVLc/fT3bHS2G
         PHYlHaSq1NInZtQJ+LaY/AaKQi+RzOAy5Gp7OcO573t/Pp7OcQd7W+hGKpkMHZZXwHS3
         iOsptpwdUo3iG+aYkLx7YVlhjY1bcrhI05D9tjnwCNZjjQzHJjkm+Ccfu9VOxbaKCVLU
         c/TA==
X-Gm-Message-State: AOAM533pwUN/HIsw9n8Qmk7t9kbWZCgj2+pezz4ZBHKE6fqs0lWY2ZpH
        pDDJDSRsaXRpKUyU4c80zOP37SNQbvAU2G4LzemjFyON9PFRqgHAZMalIuTdmCqU9VMFdPGIBku
        +bGmhYAdP7Djm3p1Gvmbq6g==
X-Received: by 2002:adf:d191:: with SMTP id v17mr9646957wrc.345.1630275987868;
        Sun, 29 Aug 2021 15:26:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrWdV4UWjmsxWXnznxAyF40RS7x+qTXWNuG7vw+rYxDj6nRO9NmovukIvxjT80bQD6fn6smQ==
X-Received: by 2002:adf:d191:: with SMTP id v17mr9646917wrc.345.1630275987667;
        Sun, 29 Aug 2021 15:26:27 -0700 (PDT)
Received: from redhat.com ([2.55.28.138])
        by smtp.gmail.com with ESMTPSA id c190sm12208101wma.21.2021.08.29.15.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 15:26:26 -0700 (PDT)
Date:   Sun, 29 Aug 2021 18:26:20 -0400
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
Message-ID: <20210829181635-mutt-send-email-mst@kernel.org>
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210805005218.2912076-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210823195409-mutt-send-email-mst@kernel.org>
 <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
 <CAPcyv4iJVQKJ3bVwZhD08c8GNEP0jW2gx=H504NXcYK5o2t01A@mail.gmail.com>
 <d992b5af-8d57-6aa6-bd49-8e2b8d832b19@linux.intel.com>
 <20210824053830-mutt-send-email-mst@kernel.org>
 <d21a2a2d-4670-ba85-ce9a-fc8ea80ef1be@linux.intel.com>
 <20210829112105-mutt-send-email-mst@kernel.org>
 <09b340dd-c8a8-689c-4dad-4fe0e36d39ae@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09b340dd-c8a8-689c-4dad-4fe0e36d39ae@linux.intel.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Sun, Aug 29, 2021 at 09:17:53AM -0700, Andi Kleen wrote:
> Also I changing this single call really that bad? It's not that we changing
> anything drastic here, just give the low level subsystem a better hint about
> the intention. If you don't like the function name, could make it an
> argument instead?

My point however is that the API should say that the
driver has been audited, not that the mapping has been
done in some special way. For example the mapping can be
in some kind of wrapper, not directly in the driver.
However you want the driver validated, not the wrapper.

Here's an idea:



diff --git a/include/linux/audited.h b/include/linux/audited.h
new file mode 100644
index 000000000000..e23fd6ad50db
--- /dev/null
+++ b/include/linux/audited.h
@@ -0,0 +1,3 @@
+#ifndef AUDITED_MODULE
+#define AUDITED_MODULE
+#endif

Now any audited driver must do
#include <linux/audited.h>
first of all.
Implementation-wise it can do any number of things,
e.g. if you like then sure you can do:

#ifdef AUDITED_MODULE
#define pci_ioremap pci_ioremap_shared
#else
#define pci_ioremap pci_ioremap
#endif

but you can also thinkably do something like (won't work,
but just to give you the idea):

#ifdef AUDITED_MODULE
#define __init __init
#else
#define __init
#endif

or any number of hacks like this.


-- 
MST

