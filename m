Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FAEC64ED6
	for <sparclinux@archiver.kernel.org>; Tue, 28 Feb 2023 15:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjB1P5r (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 28 Feb 2023 10:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjB1P50 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 28 Feb 2023 10:57:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD2A31E30
        for <sparclinux@vger.kernel.org>; Tue, 28 Feb 2023 07:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677599747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBghEncF8boHA8ERPg4saQyYB+zKBnxfff7p7OTCduA=;
        b=Bzq8IokY3k/GJpwh78aJ9A+e5MzynQFp4XCe+4dEyBin9vQKFT0M4qmBIUR1Zwtst/Bla5
        JJVEVwrcthE9UZlNxVDfBF4mliVjP4NGv4b56Ym26IUInhmSwsWCxS5cfQDhyDmljjgcS9
        /a693KGZrhH9xUGfLSEjzndinCSQPBU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-49-BWx5XJYlNTGtezlR5jlfcw-1; Tue, 28 Feb 2023 10:55:45 -0500
X-MC-Unique: BWx5XJYlNTGtezlR5jlfcw-1
Received: by mail-wm1-f72.google.com with SMTP id y16-20020a1c4b10000000b003dd1b5d2a36so328007wma.1
        for <sparclinux@vger.kernel.org>; Tue, 28 Feb 2023 07:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBghEncF8boHA8ERPg4saQyYB+zKBnxfff7p7OTCduA=;
        b=GD/1TJi8iAnxF3oaMoqrbKg1DpWPyV7Xz2b/U1r7Ly4f+W+3ynXlkC3zr32IccwGd/
         fZJYHP8aSgfMCnJNLtU7zBYjY1aaSXctTc0Op4V2dt/4cM4FfeoIkp9uMAVuemHyAkmu
         ipAT4/47tbkFcUwJHe098J61IUxltsqp9gJD3sn4DHQuhWEJtrFj71WWlr61PNan1sSD
         RETRSEOsLQlHVdcOfwohFJQk6VkWIxd+H3D7NxIxCRtnmac6ea2kCBEnKJPiyUKcnraO
         UzqwMB789ORU0pRalKb6RTsbSs5f8aYTcI8c920IhJ5RjafTspiK86JbbVKzC8NbBgXF
         S1yw==
X-Gm-Message-State: AO0yUKV8Z3q6Si0dy4h/iBiVWUCLPdckO4PNLG3JbqzjKpW+vUKcxGqV
        HTmxxSEmQQVftuxXDJe0g9/2PLL+S6p857WpLEdXV312SPgpdaKJWMV1fOatso7TU15HzuCqrX1
        xEpTwOaoBO+IElGjhGfMzXg==
X-Received: by 2002:a05:600c:350f:b0:3eb:3945:d400 with SMTP id h15-20020a05600c350f00b003eb3945d400mr2593165wmq.6.1677599743552;
        Tue, 28 Feb 2023 07:55:43 -0800 (PST)
X-Google-Smtp-Source: AK7set+wnf2WDMcprxngEfzcv3vYTz2vjDLBbvltb+8+t+ERFjJxQhjmdzxRvt+YBcvxcSrV4CC0jA==
X-Received: by 2002:a05:600c:350f:b0:3eb:3945:d400 with SMTP id h15-20020a05600c350f00b003eb3945d400mr2593150wmq.6.1677599743200;
        Tue, 28 Feb 2023 07:55:43 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:b800:3757:baed:f95e:20ac? (p200300cbc706b8003757baedf95e20ac.dip0.t-ipconnect.de. [2003:cb:c706:b800:3757:baed:f95e:20ac])
        by smtp.gmail.com with ESMTPSA id o25-20020a05600c511900b003dfe549da4fsm18407191wms.18.2023.02.28.07.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 07:55:42 -0800 (PST)
Message-ID: <5d99c731-c47a-c525-76e5-4578d9dfc9ee@redhat.com>
Date:   Tue, 28 Feb 2023 16:55:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH mm-unstable v1 11/26] microblaze/mm: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        Michal Simek <monstr@monstr.eu>
References: <20230113171026.582290-1-david@redhat.com>
 <20230113171026.582290-12-david@redhat.com>
 <CAMuHMdX-FDga8w=pgg1myskEx6wp+oyZifhPPPFnWrc1zW7ZpQ@mail.gmail.com>
 <9ed766a6-cf06-535d-3337-ea6ff25c2362@redhat.com>
 <CAMuHMdWSaoKqO1Nx7QMDCcXrRmFbqqX8uwDRezXs8g+HdEFjKA@mail.gmail.com>
 <c145a2db-f92c-65aa-3e68-07dbb2e097a6@redhat.com>
 <CAMuHMdX7MND++KXgTpx4jscfctQA_-zPt3EN9-+79EWE7e+OjA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAMuHMdX7MND++KXgTpx4jscfctQA_-zPt3EN9-+79EWE7e+OjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 27.02.23 20:46, Geert Uytterhoeven wrote:
> Hi David,
> 
> On Mon, Feb 27, 2023 at 6:01 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>     /*
>>>>>>      * Externally used page protection values.
>>>>>> diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
>>>>>> index 42f5988e998b..7e3de54bf426 100644
>>>>>> --- a/arch/microblaze/include/asm/pgtable.h
>>>>>> +++ b/arch/microblaze/include/asm/pgtable.h
> 
>>>>>>      * - All other bits of the PTE are loaded into TLBLO without
>>>>>>      *  * modification, leaving us only the bits 20, 21, 24, 25, 26, 30 for
>>>>>>      * software PTE bits.  We actually use bits 21, 24, 25, and
>>>>>> @@ -155,6 +155,9 @@ extern pte_t *va_to_pte(unsigned long address);
>>>>>>     #define _PAGE_ACCESSED 0x400   /* software: R: page referenced */
>>>>>>     #define _PMD_PRESENT   PAGE_MASK
>>>>>>
>>>>>> +/* We borrow bit 24 to store the exclusive marker in swap PTEs. */
>>>>>> +#define _PAGE_SWP_EXCLUSIVE    _PAGE_DIRTY
>>>>>
>>>>> _PAGE_DIRTY is 0x80, so this is also bit 7, thus the new comment is
>>>>> wrong?
>>>>
>>>> In the example, I use MSB-0 bit numbering (which I determined to be
>>>> correct in microblaze context eventually, but I got confused a couple a
>>>> times because it's very inconsistent). That should be MSB-0 bit 24.
>>>
>>> Thanks, TIL microblaze uses IBM bit numbering...
>>
>> I assume IBM bit numbering corresponds to MSB-0 bit numbering, correct?
> 
> Correct, as seen in s370 and PowerPC manuals...

Good, I have some solid s390x background, but thinking about the term 
"IBM PC" made me double-check that we're talking about the same thing ;)

> 
>> I recall that I used the comment above "/* Definitions for MicroBlaze.
>> */" as an orientation.
>>
>> 0  1  2  3  4  ... 18 19 20 21 22 23 24 25 26 27 28 29 30 31
>> RPN.....................  0  0 EX WR ZSEL.......  W  I  M  G
> 
> Indeed, that's where I noticed the "unconventional" numbering...
> 
>> So ... either we adjust both or we leave it as is. (again, depends on
>> what the right thing to to is -- which I don't know :) )
> 
> It depends whether you want to match the hardware documentation,
> or the Linux BIT() macro and friends...

The hardware documentation, so we should be good.

Thanks!

-- 
Thanks,

David / dhildenb

