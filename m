Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F6AC4167B
	for <sparclinux@archiver.kernel.org>; Wed,  2 Nov 2022 18:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiKBSgT (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 2 Nov 2022 14:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiKBSgH (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 2 Nov 2022 14:36:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16F72F675
        for <sparclinux@vger.kernel.org>; Wed,  2 Nov 2022 11:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667414061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u2LZi3yU3n7R/W4GuO9j//JNe6TLauoqoSJ+PuigISI=;
        b=Y6RmZFOR73EALSyfaV2bE0L24NL5a41dlOm8eBdCP9amuAKVt23asQgFgwCxZGIS0O9P8A
        lRHAmPAYusRvClFbzkTs/wr9srl8z3P1XOuJMFkQoCzdzl1t+VDXV6x1107Y7J1g9nkSkm
        9ZqoCyjc6DypKIKWoie1+/4B1vPUXQ4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-509-W-w7lG05NgWRhsjzA5Mo2g-1; Wed, 02 Nov 2022 14:34:20 -0400
X-MC-Unique: W-w7lG05NgWRhsjzA5Mo2g-1
Received: by mail-qk1-f198.google.com with SMTP id bk21-20020a05620a1a1500b006be9f844c59so15840196qkb.9
        for <sparclinux@vger.kernel.org>; Wed, 02 Nov 2022 11:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2LZi3yU3n7R/W4GuO9j//JNe6TLauoqoSJ+PuigISI=;
        b=oUVlaIEjWTVzUZ7E2v5mT9C43LHR66zO5RYcKjTQLZ6tdWkuiCWemshwtjdP8gcFBb
         9MQZoY9QS8cZsN/4lqoWZLBs3cdjaBbZdSKssSFfnKp5LVibivPT5VHqNRxudabKgFXs
         8Ad6FDdLxTkEsldzBfGWFTfEUUB/5DsL2OKZTKAN+3PDs7KjzMbZuevEWOzquSbsDPEr
         3Re46TkyiixYNKnWIo1YS1q6dkAzxFUfHPGBnBoS5Y0maPm1Gs8rleEtWIawavgdI3ma
         6YoG7HvCjtYy2Iq8/S5sJtwk10/Y6HbUu4kCR2UCnC2q0oC3JYvkzTtFG4v/k/1MnC/n
         loDA==
X-Gm-Message-State: ACrzQf0oNCYcqhshxFEfebJmOzPWtFPgFipg7SHZozQa0PflS7rOks9+
        sqayo0Lkv7q0+7fGnAuxHv4an4Mogcqnib3rARHeR/g+s3DW3fIxmaH+hhV1/fwkEAql5ciO7v4
        wynHeqlq7tn4aUkKbyz46ng==
X-Received: by 2002:a05:6214:20e2:b0:4bb:7aa5:bf0a with SMTP id 2-20020a05621420e200b004bb7aa5bf0amr22430256qvk.112.1667414059600;
        Wed, 02 Nov 2022 11:34:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5c7dwIqNgpqOLvhPHAiOA2g1SXDg3luIhlombymy6f4ZTzz3+a5A/2CAiuRdtosOetG1hbOw==
X-Received: by 2002:a05:6214:20e2:b0:4bb:7aa5:bf0a with SMTP id 2-20020a05621420e200b004bb7aa5bf0amr22430223qvk.112.1667414059378;
        Wed, 02 Nov 2022 11:34:19 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id f20-20020a05620a409400b006bbf85cad0fsm9161228qko.20.2022.11.02.11.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:34:18 -0700 (PDT)
Date:   Wed, 2 Nov 2022 14:34:17 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Anatoly Pugachev <matorola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Miller <davem@davemloft.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, sparclinux@vger.kernel.org
Subject: Re: dpkg fails on sparc64 (was: [PATCH v4 4/7] mm/thp: Carry over
 dirty bit when thp splits on pmd)
Message-ID: <Y2K4Kd8JRWa1noLB@x1n>
References: <20220811161331.37055-1-peterx@redhat.com>
 <20220811161331.37055-5-peterx@redhat.com>
 <20221021160603.GA23307@u164.east.ru>
 <Y1Wbi4yyVvDtg4zN@x1n>
 <CADxRZqy+cMHN4FjtDr7-LOyVf0y+G8MPiBoGiTEsSj48jBfVnw@mail.gmail.com>
 <Y1f2IR+h4i2+/swj@x1n>
 <CADxRZqz+Sk=yxrJQ8B7UVkrcct9w6nUeiaaVn7QTFL59isFLDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADxRZqz+Sk=yxrJQ8B7UVkrcct9w6nUeiaaVn7QTFL59isFLDA@mail.gmail.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, Nov 01, 2022 at 04:13:20PM +0300, Anatoly Pugachev wrote:
> On Tue, Oct 25, 2022 at 5:43 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Oct 25, 2022 at 01:22:45PM +0300, Anatoly Pugachev wrote:
> > > On Sun, Oct 23, 2022 at 10:53 PM Peter Xu <peterx@redhat.com> wrote:
> > > > On Fri, Oct 21, 2022 at 07:06:03PM +0300, Anatoly Pugachev wrote:
> > > > >
> > > > >     Link: https://lkml.kernel.org/r/20220811161331.37055-5-peterx@redhat.com
> >
> > Maybe we need to have the minimum revert for v6.1 before we have more
> > clues.
> 
> Just a quick update on 6.1.0-rc3
> 
> Tested again with 6.1.0-rc3, segfaults dpkg... applied patch - no dpkg
> segfaults.

Andrew, shall we apply the minimum revert for this patch for now?  The
one-liner was attached in this email I replied to Anatoly:

https://lore.kernel.org/all/Y1Wbi4yyVvDtg4zN@x1n/

Thanks,

-- 
Peter Xu

