Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE19C433FE
	for <sparclinux@archiver.kernel.org>; Mon, 28 Nov 2022 08:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiK1ITq (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 28 Nov 2022 03:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiK1ITp (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 28 Nov 2022 03:19:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25582DE97
        for <sparclinux@vger.kernel.org>; Mon, 28 Nov 2022 00:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669623533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ueiNL/RrPlD3vRod9MDAxJpgFwmJj0Jyg8USWk7yPz8=;
        b=S+oFkjKVP3mckzd7VBbvH1QuZTZol0q9wTWffdsPiXu+2nmhjaLmPhu8ziCyV0KCioRPJI
        5JQ7Ka6QTT7w/TcDd4C3+oasgr3fATIDGVWRdSU8qp6A71RrRGJewLWoV59J4JHfMOQ3z1
        2VHUt/gcI6faTsrG8illEYtRpXcU/30=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-332-grx4cr92Op2P0CfVunx0AA-1; Mon, 28 Nov 2022 03:18:51 -0500
X-MC-Unique: grx4cr92Op2P0CfVunx0AA-1
Received: by mail-wm1-f72.google.com with SMTP id e8-20020a05600c218800b003cf634f5280so3470233wme.8
        for <sparclinux@vger.kernel.org>; Mon, 28 Nov 2022 00:18:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ueiNL/RrPlD3vRod9MDAxJpgFwmJj0Jyg8USWk7yPz8=;
        b=yxzsQiw9bi263hUDxeoKGbtiCx4sUkUI7kL1ChFWjAhwG3GYjmZFHdTGWE9OVSkpwZ
         GsV8tUVBkPvGvs8c7aX1losw6cgu7+9vAO2MLi/EJeTmEuC3EG1tdCyMkZQWLh7VCL1b
         QQBhm1xRTp+Vy/LJqA2/qwWyiasZbTSnJd6y3OlHAj0TS8qIxukmvS3VHI8gBPpc4GP5
         24ydIkjF88lHM3YljwX2ueZeoR71aanL4RfywNLq6iqMCcPNJLFWac2/DEDUYgKbHO+n
         6WuwvpOtoM3fV1rUD9YnWzZmpNgXL3/0dCVGrKzmr/Xa0MYY6heHnFzgMqvQ8SCxvva4
         fCmg==
X-Gm-Message-State: ANoB5plf/txFDy8dtbZJKBhYD4bepOpKW6ryveo7bzs/Ix21SiET31EY
        jo838bzuaDrfrQ0C51fWOVya3T59ue9VoQ1lnGmCwvzuo91whpiy7HfHFiuWEVtg5XvigwC7oJt
        osuWpgf4abRCTkZFLkozfCg==
X-Received: by 2002:a05:600c:3587:b0:3cf:a9c2:2b04 with SMTP id p7-20020a05600c358700b003cfa9c22b04mr36262295wmq.152.1669623530660;
        Mon, 28 Nov 2022 00:18:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5KFgnMS9OgeX6iNUgB1p0xskb3yOxviUW4FnLaUffslFm3du7Shktyf0rRUHCATZ7f+3nFJA==
X-Received: by 2002:a05:600c:3587:b0:3cf:a9c2:2b04 with SMTP id p7-20020a05600c358700b003cfa9c22b04mr36262220wmq.152.1669623530122;
        Mon, 28 Nov 2022 00:18:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:9000:3d6:e434:f8b4:80cf? (p200300cbc702900003d6e434f8b480cf.dip0.t-ipconnect.de. [2003:cb:c702:9000:3d6:e434:f8b4:80cf])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c310e00b003a2f2bb72d5sm22518102wmo.45.2022.11.28.00.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 00:18:49 -0800 (PST)
Message-ID: <9d0bf98a-3d6a-1082-e992-1338e1525935@redhat.com>
Date:   Mon, 28 Nov 2022 09:18:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH mm-unstable v1 16/20] mm/frame-vector: remove FOLL_FORCE
 usage
Content-Language: en-US
To:     Hans Verkuil <hverkuil@xs4all.nl>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <08b65ac6-6786-1080-18f8-d2be109c85fc@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 28.11.22 09:17, Hans Verkuil wrote:
> Hi David,
> 
> On 27/11/2022 11:35, David Hildenbrand wrote:
>> On 16.11.22 11:26, David Hildenbrand wrote:
>>> FOLL_FORCE is really only for ptrace access. According to commit
>>> 707947247e95 ("media: videobuf2-vmalloc: get_userptr: buffers are always
>>> writable"), get_vaddr_frames() currently pins all pages writable as a
>>> workaround for issues with read-only buffers.
>>>
>>> FOLL_FORCE, however, seems to be a legacy leftover as it predates
>>> commit 707947247e95 ("media: videobuf2-vmalloc: get_userptr: buffers are
>>> always writable"). Let's just remove it.
>>>
>>> Once the read-only buffer issue has been resolved, FOLL_WRITE could
>>> again be set depending on the DMA direction.
>>>
>>> Cc: Hans Verkuil <hverkuil@xs4all.nl>
>>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Cc: Tomasz Figa <tfiga@chromium.org>
>>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>    drivers/media/common/videobuf2/frame_vector.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/media/common/videobuf2/frame_vector.c
>>> index 542dde9d2609..062e98148c53 100644
>>> --- a/drivers/media/common/videobuf2/frame_vector.c
>>> +++ b/drivers/media/common/videobuf2/frame_vector.c
>>> @@ -50,7 +50,7 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
>>>        start = untagged_addr(start);
>>>          ret = pin_user_pages_fast(start, nr_frames,
>>> -                  FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
>>> +                  FOLL_WRITE | FOLL_LONGTERM,
>>>                      (struct page **)(vec->ptrs));
>>>        if (ret > 0) {
>>>            vec->got_ref = true;
>>
>>
>> Hi Andrew,
>>
>> see the discussion at [1] regarding a conflict and how to proceed with
>> upstreaming. The conflict would be easy to resolve, however, also
>> the patch description doesn't make sense anymore with [1].
> 
> Might it be easier and less confusing if you post a v2 of this series
> with my patch first? That way it is clear that 1) my patch has to come
> first, and 2) that it is part of a single series and should be merged
> by the mm subsystem.
> 
> Less chances of things going wrong that way.
> 
> Just mention in the v2 cover letter that the first patch was added to
> make it easy to backport that fix without being hampered by merge
> conflicts if it was added after your frame_vector.c patch.

Yes, that's the way I would naturally do, it, however, Andrew prefers 
delta updates for minor changes.

@Andrew, whatever you prefer!

Thanks!

-- 
Thanks,

David / dhildenb

