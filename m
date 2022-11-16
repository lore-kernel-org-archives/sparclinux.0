Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DF4C4167D
	for <sparclinux@archiver.kernel.org>; Wed, 16 Nov 2022 11:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbiKPLp5 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 16 Nov 2022 06:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbiKPLp2 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 16 Nov 2022 06:45:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ADA63AA
        for <sparclinux@vger.kernel.org>; Wed, 16 Nov 2022 03:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668598126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1VQojSTl69umpLmMH43+9BkpSdHFQwxnTFgYvpcg2e8=;
        b=XjaTTjKp5I/WmkMYUyxbT4MS+5VZW9XlYYMwgeeRxeDbCIf0geD9EBbdCodZ60JJfmRL9i
        8AxQ9NH0UNOFjxh/R8RwwtYvLgSA06qgQ8P4lN8XoO0+rnlwZxT1h18eARAusGTQqkVmxf
        U/y6xlC9HzRxIkIxKKqWnqtmxSPfwCg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-516-lK_XbBcfObOVh_G-x9K2MQ-1; Wed, 16 Nov 2022 06:28:44 -0500
X-MC-Unique: lK_XbBcfObOVh_G-x9K2MQ-1
Received: by mail-wm1-f71.google.com with SMTP id x10-20020a05600c420a00b003cfa33f2e7cso9862196wmh.2
        for <sparclinux@vger.kernel.org>; Wed, 16 Nov 2022 03:28:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1VQojSTl69umpLmMH43+9BkpSdHFQwxnTFgYvpcg2e8=;
        b=GdS/VZJyDq12CFHUKlnGO3g7Lw+ZqkL+ladiwr8YHs1vhKgP/+N4SPULtE42iqGKUs
         MFX9nwebrJZchlK3SSh2CItQTymboc7qaJVxgDBVIECcp8XuxptSlePrLF8cJOJO2LsP
         0WAJ8sgIjs4jcGGXbYI5KRye/0Pzw/HIQ4WkrzO7FE5ayvRHRpwfgR/rReFQ4FU7Uun/
         mJ/aujoxvPy+zlbwpjlFboasP54PtAAGqPDjJBH6+yNvr/x0rkc8PL8lBd2BWpNKax6L
         sobEDItq4mES9G9zD/XDUjvjMKt7DL+h13L7XMnTlNS0izfQ/abqyC+TUOhia+HZyfyn
         yB5w==
X-Gm-Message-State: ANoB5pkuUZaPgGMc7UcFf3FTxGSCu8QMpxiNC7TLbMGPz3KyIjOavKtO
        tk/jn6yBKQtjDEy6VckDkOMWNSPwMrA9ePGPSuVnfS2TFTWnEV77+Rd+u1eSKN9SW8sT+S2ZgV+
        EG1kApc6F5o0c+w09ArWsvA==
X-Received: by 2002:adf:e0ce:0:b0:236:4c14:4e4c with SMTP id m14-20020adfe0ce000000b002364c144e4cmr13631423wri.634.1668598123339;
        Wed, 16 Nov 2022 03:28:43 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6e1elsSkTG3wibaAG5hhsqopWoPQ9BVnWOuhu0PibIHa2gEBmHuSu+l8O0CstgpsJn73mbQw==
X-Received: by 2002:adf:e0ce:0:b0:236:4c14:4e4c with SMTP id m14-20020adfe0ce000000b002364c144e4cmr13631403wri.634.1668598123006;
        Wed, 16 Nov 2022 03:28:43 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:9f00:a98d:4026:7c44:40fd? (p200300cbc7049f00a98d40267c4440fd.dip0.t-ipconnect.de. [2003:cb:c704:9f00:a98d:4026:7c44:40fd])
        by smtp.gmail.com with ESMTPSA id r11-20020a5d694b000000b0023691d62cffsm14554511wrw.70.2022.11.16.03.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 03:28:42 -0800 (PST)
Message-ID: <d814343b-2fc9-bb03-8378-b7ce6bc7373e@redhat.com>
Date:   Wed, 16 Nov 2022 12:28:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Test case for "mm/thp: carry over dirty bit when thp splits on
 pmd"
Content-Language: en-US
To:     Anatoly Pugachev <matorola@gmail.com>, hev <r@hev.cc>
Cc:     Peter Xu <peterx@redhat.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <CAHirt9gr7oL87co3y1hCs3Ux4utzFP5oj6GFOFMZuJR2Vv8+rA@mail.gmail.com>
 <CADxRZqxqb7f_WhMh=jweZP+ynf_JwGd-0VwbYgp4P+T0-AXosw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CADxRZqxqb7f_WhMh=jweZP+ynf_JwGd-0VwbYgp4P+T0-AXosw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 16.11.22 11:45, Anatoly Pugachev wrote:
> On Wed, Nov 16, 2022 at 11:49 AM hev <r@hev.cc> wrote:
>>
>> Hello Peter,
>>
>> I see a random crash issue  on the LoongArch system, that is caused by
>> commit 0ccf7f1 ("mm/thp: carry over dirty bit when thp splits on
>> pmd").
>>
>> Now, the thing is already resolved. The root cause is arch's mkdirty
>> is set hardware writable bit in unconditional. That breaks
>> write-protect and then breaks COW.

Ehm, does this imply that

pte = maybe_mkwrite(pte_mkdirty(pte), vma);

will result in a writable PTE, even though the VMA does not include 
VM_WRITE?

That would be really broken.

-- 
Thanks,

David / dhildenb

