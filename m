Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C966C4332F
	for <sparclinux@archiver.kernel.org>; Tue, 29 Nov 2022 09:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiK2JRS (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 29 Nov 2022 04:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiK2JRQ (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 29 Nov 2022 04:17:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C0F56573
        for <sparclinux@vger.kernel.org>; Tue, 29 Nov 2022 01:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669713326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kLZwFc2T16+VzxzvdeqP7dZ+DZAGfAAiD+u0EUrSQ8s=;
        b=OvXTU6p0Ct0GG3VEsw6AOZSjwusuY/Ng6cuNku1asLSrx9F6Mc66uLvd7qxMRAZbOAL+J5
        Q8DdnyjmltiPLfDTqjLE3SaozLtbjrW5pWS5w+X7WF2iZ/48KkE540YFRqNv9Zfo0kmyyh
        pze47cOZYmn8QXjChvz5wyc79I3BaI4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-395-5qrDqcDiPXWU7zwmSgCVbg-1; Tue, 29 Nov 2022 04:15:24 -0500
X-MC-Unique: 5qrDqcDiPXWU7zwmSgCVbg-1
Received: by mail-wm1-f71.google.com with SMTP id ay19-20020a05600c1e1300b003cf758f1617so9893153wmb.5
        for <sparclinux@vger.kernel.org>; Tue, 29 Nov 2022 01:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLZwFc2T16+VzxzvdeqP7dZ+DZAGfAAiD+u0EUrSQ8s=;
        b=xUt1mjYwZNIsz+xzHP2PPuQjk1S6uPEyHO3nD1gKkmizKAjdJyvIf8uAW31k86q0lI
         nsNP/h/Mh6jYUn2YT+Y4JA0oQMRjjtIL/DtKsAbFIxiYn9J2l63WO6bcH3a+lhtKVzpm
         6gxB6dy3RRB1XaZp1TB3TgvMcQBOlJbO68Iq5FkoYt+jR8EGLbskqCBhQx+qNv+FMUJ2
         Fqsp6pR0WrNdhV9fJEzfFIbYWxf5SoyxBnCQY9gCBe0ipqy3O+OVNRa+7k4Rw+8s5Jsm
         bztaW/F3RrWNRJ7wT5y8gV7962krbEm31E9SSJFNZn03OJ2Hj/0vipG/v9DrYEowkHBH
         4Zcg==
X-Gm-Message-State: ANoB5pnk+nPM3YwExfu7XP1y2aTTEaNWZOcdwhqshH4A9jpjav7LJ5mh
        gAXBSBdSFtuA5XRGl+GrB6BIb7QhgT8wi4o7MvBgvAon9SLQEG1NNVz6A8jzHz1v3wugMtwflyp
        gPmQ336XuHUwk3E+E6W/3jA==
X-Received: by 2002:a05:600c:430c:b0:3cf:8ed7:7124 with SMTP id p12-20020a05600c430c00b003cf8ed77124mr42243436wme.140.1669713323606;
        Tue, 29 Nov 2022 01:15:23 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5aMoFyhfTZRz6WGw0GcgDkcONZAiRyZAh+e0PFHXmVnEtFtgvwKaxuOXbIxhdoVgI1OB8H+Q==
X-Received: by 2002:a05:600c:430c:b0:3cf:8ed7:7124 with SMTP id p12-20020a05600c430c00b003cf8ed77124mr42243382wme.140.1669713323266;
        Tue, 29 Nov 2022 01:15:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:ca00:3fb8:c253:3bf7:b60e? (p200300cbc705ca003fb8c2533bf7b60e.dip0.t-ipconnect.de. [2003:cb:c705:ca00:3fb8:c253:3bf7:b60e])
        by smtp.gmail.com with ESMTPSA id n26-20020a05600c3b9a00b003c6b70a4d69sm1498998wms.42.2022.11.29.01.15.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 01:15:22 -0800 (PST)
Message-ID: <abcba252-13a0-50aa-79ec-28b649c892cd@redhat.com>
Date:   Tue, 29 Nov 2022 10:15:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH mm-unstable v1 16/20] mm/frame-vector: remove FOLL_FORCE
 usage
Content-Language: en-US
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-17-david@redhat.com>
 <81fb0fa3-2e06-b765-56ac-a7d981194e59@redhat.com>
 <08b65ac6-6786-1080-18f8-d2be109c85fc@xs4all.nl>
 <9d0bf98a-3d6a-1082-e992-1338e1525935@redhat.com>
 <20221128145927.df895bf1966cfa125cae9668@linux-foundation.org>
 <22b1107b-0acc-5772-a883-8f3c4682eb1b@redhat.com>
 <c2681582-1e24-7ed9-e4fb-e2dd17a93aed@xs4all.nl>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <c2681582-1e24-7ed9-e4fb-e2dd17a93aed@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 29.11.22 10:08, Hans Verkuil wrote:
> On 29/11/2022 09:48, David Hildenbrand wrote:
>> On 28.11.22 23:59, Andrew Morton wrote:
>>> On Mon, 28 Nov 2022 09:18:47 +0100 David Hildenbrand <david@redhat.com> wrote:
>>>
>>>>> Less chances of things going wrong that way.
>>>>>
>>>>> Just mention in the v2 cover letter that the first patch was added to
>>>>> make it easy to backport that fix without being hampered by merge
>>>>> conflicts if it was added after your frame_vector.c patch.
>>>>
>>>> Yes, that's the way I would naturally do, it, however, Andrew prefers
>>>> delta updates for minor changes.
>>>>
>>>> @Andrew, whatever you prefer!
>>>
>>> I'm inclined to let things sit as they are.  Cross-tree conflicts
>>> happen, and Linus handles them.  I'll flag this (very simple) conflict
>>> in the pull request, if MM merges second.  If v4l merges second then
>>> hopefully they will do the same.  But this one is so simple that Linus
>>> hardly needs our help.
> 
> It's not about cross-tree conflicts, it's about the fact that my patch is
> a fix that needs to be backported to older kernels. It should apply cleanly
> to those older kernels if my patch goes in first, but if it is the other way
> around I would have to make a new patch for the stable kernels.

IIUC, the conflict will be resolved at merge time and the merge 
resolution will be part of the merge commit. It doesn't matter in which 
order the patches go upstream, the merge commit resolves the problematic 
overlap.

So your patch will be upstream as intended, where it can be cleanly 
backported.

Hope I am not twisting reality ;)

-- 
Thanks,

David / dhildenb

