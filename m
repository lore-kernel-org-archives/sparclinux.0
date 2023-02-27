Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86A5C7EE31
	for <sparclinux@archiver.kernel.org>; Mon, 27 Feb 2023 17:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjB0RB4 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 27 Feb 2023 12:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjB0RBz (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 27 Feb 2023 12:01:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657D61E9EB
        for <sparclinux@vger.kernel.org>; Mon, 27 Feb 2023 09:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677517266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+gj+IVlpRNML/WhRdwS5WpJ1kIzGGA+IXuZi3TvglQ=;
        b=MrzMv/usUX5QJ7MfXIzP6UasX8styJCjS6RvawQpVwkFJTJOAASaI3SZ5dopTQUIU2Zlwb
        fFv2C5AK3/shy165dPEMHzG5GwjEMDWq1z6CVJqfoEp601rjg1yQUlLqvpWHqkeV+0JXA4
        RoBVkKJCkvGWUQ/safPk0USMCnYoBWc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-538-JkKkDa5IMGGTDe61IplC1A-1; Mon, 27 Feb 2023 12:01:04 -0500
X-MC-Unique: JkKkDa5IMGGTDe61IplC1A-1
Received: by mail-wr1-f72.google.com with SMTP id c30-20020adfa31e000000b002c59b266371so1006249wrb.6
        for <sparclinux@vger.kernel.org>; Mon, 27 Feb 2023 09:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+gj+IVlpRNML/WhRdwS5WpJ1kIzGGA+IXuZi3TvglQ=;
        b=7ru2mR0K7tj+V60LyFNel3GLA0rXLTatuJeen0ee/vlfFBRD1lyWxdhpPJ4YfBrpeB
         aYwik0JLE7DssogJRtt16356RQ/ytodY+Rf/dLPBYwWliqNlimbrqWdLhsP5U+BgFzgc
         AYrSbaWCKLOTf3zSr+yEB1V4B0T5mbeNc3FThr4+XRCTf3BvTFQvIKjzGYRHfU0ofH7/
         ETnrut58UZ2RVIWk7ZvTkarpnwdI66UYUD8w8tdcwIUyIUAenRKnI8qwb8mQbHbLTZV4
         4E1FupDIkP9vOlZGxhScxO1EZPimwYM+fo3/XpXdZamyxPYsismKlr3RdKA8wFMmnBd3
         zlOg==
X-Gm-Message-State: AO0yUKVgSlSD+UG9KtD20KdlsbbVZq2C7dLhBZ7nPzEhlTGyqpsHGtu4
        miJ6X7LGhb7fJsHVAdrbR8VU6PLNYPJ+oXXRxnpbDiAbpXL1griFkD0M+TOm0yViwxgB7MJMlSX
        iwN/JsBwj5qHmPkvuVMxyFw==
X-Received: by 2002:a5d:570e:0:b0:2bf:d940:29b6 with SMTP id a14-20020a5d570e000000b002bfd94029b6mr22317907wrv.54.1677517263129;
        Mon, 27 Feb 2023 09:01:03 -0800 (PST)
X-Google-Smtp-Source: AK7set/UUjV2lk6TzBDGO2RyIGoSkW6MncSJyiWPHsxHHIhpKbsx37PxyO7HkStEnBG5FTknvHrGmg==
X-Received: by 2002:a5d:570e:0:b0:2bf:d940:29b6 with SMTP id a14-20020a5d570e000000b002bfd94029b6mr22317842wrv.54.1677517262720;
        Mon, 27 Feb 2023 09:01:02 -0800 (PST)
Received: from [192.168.3.108] (p5b0c68fb.dip0.t-ipconnect.de. [91.12.104.251])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c1d0400b003db0ad636d1sm15217382wms.28.2023.02.27.09.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 09:01:02 -0800 (PST)
Message-ID: <c145a2db-f92c-65aa-3e68-07dbb2e097a6@redhat.com>
Date:   Mon, 27 Feb 2023 18:01:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH mm-unstable v1 11/26] microblaze/mm: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
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
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAMuHMdWSaoKqO1Nx7QMDCcXrRmFbqqX8uwDRezXs8g+HdEFjKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

>>>>    /*
>>>>     * Externally used page protection values.
>>>> diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
>>>> index 42f5988e998b..7e3de54bf426 100644
>>>> --- a/arch/microblaze/include/asm/pgtable.h
>>>> +++ b/arch/microblaze/include/asm/pgtable.h
>>>> @@ -131,10 +131,10 @@ extern pte_t *va_to_pte(unsigned long address);
>>>>     * of the 16 available.  Bit 24-26 of the TLB are cleared in the TLB
>>>>     * miss handler.  Bit 27 is PAGE_USER, thus selecting the correct
>>>>     * zone.
>>>> - * - PRESENT *must* be in the bottom two bits because swap cache
>>>> - * entries use the top 30 bits.  Because 4xx doesn't support SMP
>>>> - * anyway, M is irrelevant so we borrow it for PAGE_PRESENT.  Bit 30
>>>> - * is cleared in the TLB miss handler before the TLB entry is loaded.
>>>> + * - PRESENT *must* be in the bottom two bits because swap PTEs use the top
>>>> + * 30 bits.  Because 4xx doesn't support SMP anyway, M is irrelevant so we
>>>> + * borrow it for PAGE_PRESENT.  Bit 30 is cleared in the TLB miss handler
>>>> + * before the TLB entry is loaded.
>>>
>>> So the PowerPC 4xx comment is still here?
>>
>> I only dropped the comment above __swp_type(). I guess you mean that we
>> could also drop the "Because 4xx doesn't support SMP anyway, M is
>> irrelevant so we borrow it for PAGE_PRESENT." sentence, correct? Not
> 
> Yes, that's what I meant.
> 
>> sure about the "Bit 30 is cleared in the TLB miss handler" comment, if
>> that can similarly be dropped.
> 
> No idea, didn't check. But if it was copied from PPC, chances are
> high it's no longer true....

I'll have a look.

> 
>>>>     * - All other bits of the PTE are loaded into TLBLO without
>>>>     *  * modification, leaving us only the bits 20, 21, 24, 25, 26, 30 for
>>>>     * software PTE bits.  We actually use bits 21, 24, 25, and
>>>> @@ -155,6 +155,9 @@ extern pte_t *va_to_pte(unsigned long address);
>>>>    #define _PAGE_ACCESSED 0x400   /* software: R: page referenced */
>>>>    #define _PMD_PRESENT   PAGE_MASK
>>>>
>>>> +/* We borrow bit 24 to store the exclusive marker in swap PTEs. */
>>>> +#define _PAGE_SWP_EXCLUSIVE    _PAGE_DIRTY
>>>
>>> _PAGE_DIRTY is 0x80, so this is also bit 7, thus the new comment is
>>> wrong?
>>
>> In the example, I use MSB-0 bit numbering (which I determined to be
>> correct in microblaze context eventually, but I got confused a couple a
>> times because it's very inconsistent). That should be MSB-0 bit 24.
> 
> Thanks, TIL microblaze uses IBM bit numbering...

I assume IBM bit numbering corresponds to MSB-0 bit numbering, correct?


I recall that I used the comment above "/* Definitions for MicroBlaze. 
*/" as an orientation.

0  1  2  3  4  ... 18 19 20 21 22 23 24 25 26 27 28 29 30 31
RPN.....................  0  0 EX WR ZSEL.......  W  I  M  G


So ... either we adjust both or we leave it as is. (again, depends on 
what the right thing to to is -- which I don't know :) )

-- 
Thanks,

David / dhildenb

