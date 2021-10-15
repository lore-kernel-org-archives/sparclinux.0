Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69B2C433EF
	for <sparclinux@archiver.kernel.org>; Fri, 15 Oct 2021 06:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A47FC61163
	for <sparclinux@archiver.kernel.org>; Fri, 15 Oct 2021 06:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbhJOG7o (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 15 Oct 2021 02:59:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32759 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235811AbhJOG7j (ORCPT
        <rfc822;sparclinux@vger.kernel.org>);
        Fri, 15 Oct 2021 02:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634281052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XrPIV2fprNlCi1MFN3D9uad/uIU7Ev00FM5PU9k9D8g=;
        b=C3PbEB7xE7mcwU+QYayRXhFogfghbKaCxUoVFresog2GSD32Xvc/ZG2LfJ3OkZE2Pnj9XV
        nCtvKP3J7BTlcq8p5R3a/sd5Bu55rMpGc3a4+zH7MdQ68GQC45aZGiFk+fJSpeXvBhM4zA
        /AwZBGd2WNUCOpzoOeiKyCHQUNnzM8Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-Ji8DgghxNyaaQogWNUVA0g-1; Fri, 15 Oct 2021 02:57:26 -0400
X-MC-Unique: Ji8DgghxNyaaQogWNUVA0g-1
Received: by mail-ed1-f71.google.com with SMTP id c25-20020a056402143900b003dc19782ea8so3835722edx.3
        for <sparclinux@vger.kernel.org>; Thu, 14 Oct 2021 23:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XrPIV2fprNlCi1MFN3D9uad/uIU7Ev00FM5PU9k9D8g=;
        b=a7FHrjk2DVPQUM3t55scOarWq8tPOF5XCqLivQmbvt367KESxYCOrk3mSYSLkrgoJn
         HWtaDNc1wb/B6JEsIQCcvSXExSQLGIJVdjipZhkwIigBn3i+7S3EUENKT+PL1HVwsCp8
         +H1ngbnxriHfb572HDaQKaOocYxddbQh4tG6uT+X3fbOdyUy8/Ku4B9O6zNHXuxgLbwb
         RAeIV46IvI/wZT8maQLRG2OOif+psubTPsR01vw234rnyqy3V6UL89r3WFvaXnj0NtMh
         EKaTjqzEl+cAeGwXda9khjjUwCEh6N5pgRF0XbU38OJWDscZeC01BKFzaIKv6l0nI7gD
         3ulw==
X-Gm-Message-State: AOAM53002cel/Cz3WsN2BhDvOpC5PVjVFwFd408tQ5+CPtDctNDG9a62
        aM4VtMuKByh6XomB78Oo3wJBv7IYlp4gPYCb/oN2uECQUjxDK6RdFEQaQNRFwmjf/K6TBJyp7IP
        3Bs4YDi1UagxZ5o+SPxxZIg==
X-Received: by 2002:a05:6402:447:: with SMTP id p7mr15322742edw.261.1634281045396;
        Thu, 14 Oct 2021 23:57:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3wsrR7axiFHmfph2bLnxYqxO8ciYC1BIDrnzojSmvwa6tk0pkkVI5pGdF1DtDsbmx8LCmYQ==
X-Received: by 2002:a05:6402:447:: with SMTP id p7mr15322726edw.261.1634281045218;
        Thu, 14 Oct 2021 23:57:25 -0700 (PDT)
Received: from redhat.com ([2.55.1.196])
        by smtp.gmail.com with ESMTPSA id e11sm4094212edl.70.2021.10.14.23.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 23:57:24 -0700 (PDT)
Date:   Fri, 15 Oct 2021 02:57:16 -0400
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
Message-ID: <20211015024923-mutt-send-email-mst@kernel.org>
References: <20211009070132-mutt-send-email-mst@kernel.org>
 <8c906de6-5efa-b87a-c800-6f07b98339d0@linux.intel.com>
 <20211011075945-mutt-send-email-mst@kernel.org>
 <9d0ac556-6a06-0f2e-c4ff-0c3ce742a382@linux.intel.com>
 <20211011142330-mutt-send-email-mst@kernel.org>
 <4fe8d60a-2522-f111-995c-dcbefd0d5e31@linux.intel.com>
 <20211012165705-mutt-send-email-mst@kernel.org>
 <c09c961d-f433-4a68-0b38-208ffe8b36c7@linux.intel.com>
 <20211012171846-mutt-send-email-mst@kernel.org>
 <c2ce5ad8-4df7-3a37-b235-8762a76b1fd3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2ce5ad8-4df7-3a37-b235-8762a76b1fd3@linux.intel.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu, Oct 14, 2021 at 10:50:59PM -0700, Andi Kleen wrote:
> 
> > I thought you basically create an OperationRegion of SystemMemory type,
> > and off you go. Maybe the OSPM in Linux is clever and protects
> > some memory, I wouldn't know.
> 
> 
> I investigated this now, and it looks like acpi is using ioremap_cache(). We
> can hook into that and force non sharing. It's probably safe to assume that
> this is not used on real IO devices.
> 
> I think there are still some other BIOS mappings that use just plain
> ioremap() though.
> 
> 
> -Andi

Hmm don't you mean the reverse? If you make ioremap shared then OS is
protected from malicious ACPI? If you don't make it shared then
malicious ACPI can poke at arbitrary OS memory.  Looks like making
ioremap non shared by default is actually less safe than shared.
Interesting.

For BIOS I suspect there's no way around it, it needs to be
audited since it's executable.

-- 
MST

