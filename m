Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60A6C433FE
	for <sparclinux@archiver.kernel.org>; Mon, 21 Nov 2022 19:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiKUT7Q (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 21 Nov 2022 14:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiKUT7P (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 21 Nov 2022 14:59:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D66165BE
        for <sparclinux@vger.kernel.org>; Mon, 21 Nov 2022 11:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669060668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XPlBQXmJ5evKwNgTVcA7C80tIxQSellMXEsHFcRanUk=;
        b=NyA2IqNPssv1TqBnW5jl4a1c3YqS0HNwwZkHNqK9uI9uQuY7ay3D5tK9nPaul/GWwlWyib
        6pA0ph7sDRzuNvmtL5ISUOWh2eZ0SyoiYCDDyxbz8c+zTDUhbGOaTbKEKH6DJNyqFaTn6q
        lI0M9sIn3W8NMbZUd94DMaoHwvKE254=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-47-JLbQ62O4N3KAWcNcILGTww-1; Mon, 21 Nov 2022 14:57:46 -0500
X-MC-Unique: JLbQ62O4N3KAWcNcILGTww-1
Received: by mail-wm1-f70.google.com with SMTP id h4-20020a1c2104000000b003d01b66fe65so2763434wmh.2
        for <sparclinux@vger.kernel.org>; Mon, 21 Nov 2022 11:57:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XPlBQXmJ5evKwNgTVcA7C80tIxQSellMXEsHFcRanUk=;
        b=pKHVkjYXANpmID/NI/cJeZ10kz4jg9SRFB5o0wr77BdRwOjfm8XXjngY+6t+rKCOMW
         g8lr9igif2J4cmPy8vBgdUyyGdo7eMFLn4S0v9L6bV9PRhBhkWm2WDpgmQ6FgXghO5lV
         34XkXoRmPW7htztPaVWzS3Y9cUxWe315GuP+y/q3H/E+OvYmif373TZ2XhXiu8BXz1y1
         1gglkp3DRYSl2b3TC9mcxRNWrl9mziRhEx5lmZcrtKuV3XlPUi1VUXAIGnNHQndfkPuB
         LlPkQy69v0FGhwYe99iIIYUlRPHZiFWg2/zLe3mvcTtVB+Y7Py//j8Ssq67PfeAfWktf
         +SWw==
X-Gm-Message-State: ANoB5pkfu9JqmV8dYuRnnLxEu/kjEKaDOvyQgwhgkM0XtjbHT3KOJlrv
        bQ40hpP3lr9Y5fvwrG0kcV0dotC1p95j4aXem28pTKBX0uneGFV//OKNBhsQSfQwcQg/4vYOmXW
        XysUTzQj0g7PmztQ2eDf/YA==
X-Received: by 2002:a05:600c:4e13:b0:3cf:86b8:71f7 with SMTP id b19-20020a05600c4e1300b003cf86b871f7mr18147998wmq.76.1669060665332;
        Mon, 21 Nov 2022 11:57:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf65NRVPabgH8LNOkymNHBwNkhBJEr9UcjvaSftZKvy8dJsW7/2IKe/d/GMGIfuMBDFu66FvcQ==
X-Received: by 2002:a05:600c:4e13:b0:3cf:86b8:71f7 with SMTP id b19-20020a05600c4e1300b003cf86b871f7mr18147982wmq.76.1669060664987;
        Mon, 21 Nov 2022 11:57:44 -0800 (PST)
Received: from [192.168.3.108] (p5b0c67dc.dip0.t-ipconnect.de. [91.12.103.220])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d5412000000b00241bd7a7165sm10998413wrv.82.2022.11.21.11.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 11:57:44 -0800 (PST)
Message-ID: <79cf9e73-440c-5ff0-856f-3df6c13061ef@redhat.com>
Date:   Mon, 21 Nov 2022 20:57:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Test case for "mm/thp: carry over dirty bit when thp splits on
 pmd"
Content-Language: en-US
To:     hev <r@hev.cc>, Peter Xu <peterx@redhat.com>
Cc:     Anatoly Pugachev <matorola@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <CAHirt9gr7oL87co3y1hCs3Ux4utzFP5oj6GFOFMZuJR2Vv8+rA@mail.gmail.com>
 <CADxRZqxqb7f_WhMh=jweZP+ynf_JwGd-0VwbYgp4P+T0-AXosw@mail.gmail.com>
 <Y3UPAKqVp6WAmRHV@x1n>
 <CAHirt9i03CFCK-4XNZb8dUxHrQqKx8c0_3=S2Y3oNvUex3xCBw@mail.gmail.com>
 <Y3Z9Zf0jARMOkFBq@x1n>
 <CAHirt9i8iLCP3_ppEL5kO2XLVAg0sno0GdzdKyzk7DSMTJF0tA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHirt9i8iLCP3_ppEL5kO2XLVAg0sno0GdzdKyzk7DSMTJF0tA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 19.11.22 15:06, hev wrote:
> Hi, Peter,
> 
> On Fri, Nov 18, 2022 at 2:29 AM Peter Xu <peterx@redhat.com> wrote:
>>
>> On Thu, Nov 17, 2022 at 10:29:57AM +0800, hev wrote:
>>> Hi Peter,
>>
>> Hi, Hev,
>>
>>>
>>> On Thu, Nov 17, 2022 at 12:25 AM Peter Xu <peterx@redhat.com> wrote:
>>>>
>>>> On Wed, Nov 16, 2022 at 01:45:15PM +0300, Anatoly Pugachev wrote:
>>>>> On Wed, Nov 16, 2022 at 11:49 AM hev <r@hev.cc> wrote:
>>>>>>
>>>>>> Hello Peter,
>>>>
>>>> Hi, Hev,
>>>>
>>>> Thanks for letting me know.
>>>>
>>>>>>
>>>>>> I see a random crash issue  on the LoongArch system, that is caused by
>>>>>> commit 0ccf7f1 ("mm/thp: carry over dirty bit when thp splits on
>>>>>> pmd").
>>>>>>
>>>>>> Now, the thing is already resolved. The root cause is arch's mkdirty
>>>>>> is set hardware writable bit in unconditional. That breaks
>>>>>> write-protect and then breaks COW.
>>>>
>>>> Could you help explain how that happened?
>>>>
>>>> I'm taking example of loongarch here:
>>>>
>>>> static inline pte_t pte_mkdirty(pte_t pte)
>>>> {
>>>>          pte_val(pte) |= (_PAGE_DIRTY | _PAGE_MODIFIED);
>>>>          return pte;
>>>> }
>>>>
>>>> #define _PAGE_MODIFIED          (_ULCAST_(1) << _PAGE_MODIFIED_SHIFT)
>>>> #define _PAGE_MODIFIED_SHIFT    9
>>>
>>> _PAGE_MODIFIED is a software dirty bit
>>>
>>>> #define _PAGE_DIRTY             (_ULCAST_(1) << _PAGE_DIRTY_SHIFT)
>>>> #define _PAGE_DIRTY_SHIFT       1
>>>
>>> _PAGE_DIRTY is a hardware writable bit (bad naming), meaning that mmu
>>> allows write memory without any exception raised.
>>
>> (I just missed this email before I reply to the other one, I should have
>>   read this one first..)
>>
>> I see. This surprises me a bit, as I can't quickly tell how it'll always
>> work with the generic mm code.
>>
>> Say, is there a quick answer on why _PAGE_DIRTY is set here rather than
>> pte_mkwrite()?  Because AFAIU that's where the mm wants to grant write
>> permission to a page table entry as the API, no?
>>
>>>
>>>>
>>>> I don't see when write bit is set, which is bit 8 instead:
>>>>
>>>> #define _PAGE_WRITE             (_ULCAST_(1) << _PAGE_WRITE_SHIFT)
>>>> #define _PAGE_WRITE_SHIFT       8
>>>
>>> _PAGE_WRITE is a software writable bit (not hardware).
>>>
>>> As David said, In __split_huge_pmd_locked, the VMA does not include VM_WRITE,
>>>
>>> entry = maybe_mkwrite(entry, vma);
>>>
>>> so the pte does not include software writable bit (_PAGE_WRITE).
>>
>> Are you sure?  In your test case you mapped with RW, IIUC it means even
>> after the fork() VM_WRITE is set on both sides?
> 
> Sorry, I was wrong.
> 
> In this case, both VMAs are writable, the pte's writable bit is
> cleared by pte_wrprotect. So if pte_mkdirty sets hardware writable bit
> unconditionally, then there will be no way to catch writes to
> implement COW.
> 
> I will try to explain how it works about pte write, dirty and
> write-protect on LoongArch in the LoongArch mailing-list.

Just to ask again,

is code like
	maybe_mkwrite(pte_mkdirty(entry), vma);

Like we have in copy_present_page(), wp_page_reuse(), wp_page_copy() ... 
broken on LoongArch of the VMA lacks VM_WRITE?

That would need *real* fixing, no hacks around that in other code areas.

-- 
Thanks,

David / dhildenb

