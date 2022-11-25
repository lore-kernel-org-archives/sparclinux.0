Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021B3C4332F
	for <sparclinux@archiver.kernel.org>; Fri, 25 Nov 2022 11:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiKYLSg (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 25 Nov 2022 06:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKYLSf (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 25 Nov 2022 06:18:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AC9BC18
        for <sparclinux@vger.kernel.org>; Fri, 25 Nov 2022 03:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669375058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zyy3mklCUVWd6KO+luDiECSd4Ib/ky9wcUWfw8KGsR8=;
        b=MuZyMktORvyqfqoE1nRBQw7oqEBhpY1PHHY6N1Xv0VlOLEcFRT3FE/LNBXG4qHPiTiODvS
        N7kGM7OQ5uai90DUkOv5oHnSRSfrTNOpbI5pq0sJdfPosYaGhWPGyeugo8eUmoS23rTgw9
        U/v0FMylzaqLKtHQiUp2gKSezr1THRk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-597-MPAszM1nOqeO_Xj38mOBnQ-1; Fri, 25 Nov 2022 06:17:30 -0500
X-MC-Unique: MPAszM1nOqeO_Xj38mOBnQ-1
Received: by mail-wm1-f70.google.com with SMTP id b47-20020a05600c4aaf00b003d031aeb1b6so4007564wmp.9
        for <sparclinux@vger.kernel.org>; Fri, 25 Nov 2022 03:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zyy3mklCUVWd6KO+luDiECSd4Ib/ky9wcUWfw8KGsR8=;
        b=RXLE1IIIZTEyRkJYgoCWIfCaBYovk/6wUJYZ9sP00WVSn/ihOtZE48giRfh2cnRkdP
         23FbVqlCOoFPVkSOITwyLAkFzNtRQqSZIYwZ7sdDx3tZ+0PIAJJu+2KrXoixbFPPKxvu
         iBFYbGTEz2Hp83TKo2jr2ZIrzqDO5NgpYIt53P6goP90uTBdPQNF7u4voH7cg1p3ZuOS
         +hAS6nFQ2a3l6eOXbDsx/kuidSdHjlFuvqiBLjZFOs1iXsZNRrI1yDzosSZDFsTo3TtO
         slT1pEYftZ9pi8e+4UzyBFjDTggowuGTaPoabdTWJ5jr/M02InRftKCS0eA4l6eMrhs4
         ESSw==
X-Gm-Message-State: ANoB5pkxDebvdGCLFIUc1Jxa8EAc5BRgN345oqMkp5B3BMCORIjluAMo
        NZLLWqOSxh1uNxCy3osOnAR1w8DJCPOf77t6B2uzR1+rwqQdsx5X7oF2g/quUGYsbUZHjwPIoYz
        rheQGna9LlpvGwa5JGmZ1eg==
X-Received: by 2002:a05:600c:34cd:b0:3cf:9877:c7e0 with SMTP id d13-20020a05600c34cd00b003cf9877c7e0mr20749400wmq.109.1669375048833;
        Fri, 25 Nov 2022 03:17:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6VLs2svU8i4vFDb1wfwGRLcn65K+FRFFunWp795dzeb7ohMuetGOCftJvcxOMVJ5DgxhudNg==
X-Received: by 2002:a05:600c:34cd:b0:3cf:9877:c7e0 with SMTP id d13-20020a05600c34cd00b003cf9877c7e0mr20749375wmq.109.1669375048470;
        Fri, 25 Nov 2022 03:17:28 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:d800:887:cbec:f31f:a08? (p200300cbc704d8000887cbecf31f0a08.dip0.t-ipconnect.de. [2003:cb:c704:d800:887:cbec:f31f:a08])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b003b4935f04a4sm6326099wmq.5.2022.11.25.03.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 03:17:28 -0800 (PST)
Message-ID: <06b0a108-0496-ad28-a88c-a4d2fd554ca8@redhat.com>
Date:   Fri, 25 Nov 2022 12:17:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Test case for "mm/thp: carry over dirty bit when thp splits on
 pmd"
Content-Language: en-US
To:     hev <r@hev.cc>
Cc:     Peter Xu <peterx@redhat.com>,
        Anatoly Pugachev <matorola@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <CAHirt9gr7oL87co3y1hCs3Ux4utzFP5oj6GFOFMZuJR2Vv8+rA@mail.gmail.com>
 <CADxRZqxqb7f_WhMh=jweZP+ynf_JwGd-0VwbYgp4P+T0-AXosw@mail.gmail.com>
 <Y3UPAKqVp6WAmRHV@x1n>
 <CAHirt9i03CFCK-4XNZb8dUxHrQqKx8c0_3=S2Y3oNvUex3xCBw@mail.gmail.com>
 <Y3Z9Zf0jARMOkFBq@x1n>
 <CAHirt9i8iLCP3_ppEL5kO2XLVAg0sno0GdzdKyzk7DSMTJF0tA@mail.gmail.com>
 <79cf9e73-440c-5ff0-856f-3df6c13061ef@redhat.com>
 <CAHirt9gKYojqqj3ty1+kLwxOc9DbjPj_WzLvOvx0SnWaWFGc4g@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHirt9gKYojqqj3ty1+kLwxOc9DbjPj_WzLvOvx0SnWaWFGc4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 25.11.22 12:15, hev wrote:
> Hi, David,
> 
>>
>> Just to ask again,
>>
>> is code like
>>          maybe_mkwrite(pte_mkdirty(entry), vma);
>>
>> Like we have in copy_present_page(), wp_page_reuse(), wp_page_copy() ...
>> broken on LoongArch of the VMA lacks VM_WRITE?
> 
> Sorry for the late reply. In this test case, The VMA doesn't lack VM_WRITE.
> 

Let me ask again: is this a problem in all of the functions I mentioned 
above were we *could* lack VM_WRITE?

Because that needs fixing independently of this issue here.

-- 
Thanks,

David / dhildenb

