Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77447C04A95
	for <sparclinux@archiver.kernel.org>; Wed, 28 Sep 2022 16:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiI1QXQ (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 28 Sep 2022 12:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbiI1QWs (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 28 Sep 2022 12:22:48 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4E8E1700
        for <sparclinux@vger.kernel.org>; Wed, 28 Sep 2022 09:22:46 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id w22-20020a056830061600b006546deda3f9so8508432oti.4
        for <sparclinux@vger.kernel.org>; Wed, 28 Sep 2022 09:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=RNYkwlzjSBs38E+/5XUZn4xEpIcCbwJSOmIImzP0KC4=;
        b=dog9Z6dDOTNjNFT3nVOx9AVPuy15Elp3ZH1zdCjCde6M2ULSae/opQ9DTfOXDMmbAa
         P+6LBTDdLGVRv5jOg/iz4bxV7IlENeLPwn7ylPWsm51mAwmjnoIsREm8CaqozryOClR0
         KNJ4Xcyi+JNTc4nXU8Coc6tODlMLmMSrhyKFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=RNYkwlzjSBs38E+/5XUZn4xEpIcCbwJSOmIImzP0KC4=;
        b=jpi8n8p0OqATApU2TvBqC1OxR2Ep0Da2SrtyWgLvtq8WJPOikPXqKJgX4/4uS9WrVM
         TV9xz3m9FrJc0vfOPzC8OmDW8KPyx9uhKam0a52Jz5kQvXVrXdqcnqtOZa6+YcoSOGKi
         inRZCGMLlNDVi2vDBBBBy0el4Zt3HtDaXgkJv3L0qPuVbJXokuZcRVH3A+bWiwx5ZWUy
         GElWXefCzLhtJvXRULqC6NgwWLfVJwjqZuhv+P82X57cOLR8X6Ei1mmnxnxweANwoloJ
         4oDtNtq5WNe2aP1HgXADvvBcges7gF/HdarrTnEjvpZr1YP0GTpgH1gJ4b5euMygM2KA
         ymCA==
X-Gm-Message-State: ACrzQf2B+eMomBSowNMIxei3/sOuaxzlzGJ7jK8lhMg+MBn5MNTf8dJr
        Xt4vz3dvPyyQJ8Zh9FQS8u/NRkiwa+qHtA==
X-Google-Smtp-Source: AMsMyM4SXqGlsyIw/bJzMc5/1v9CmPLa228lmCtxBslB61dZIpZwrtRa0+0uSvw+jX1cJTZjuYfLxA==
X-Received: by 2002:a9d:5f9b:0:b0:654:e87a:2aec with SMTP id g27-20020a9d5f9b000000b00654e87a2aecmr14460884oti.354.1664382164172;
        Wed, 28 Sep 2022 09:22:44 -0700 (PDT)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com. [209.85.160.45])
        by smtp.gmail.com with ESMTPSA id z25-20020a9d7a59000000b0065af1b094dasm2348453otm.28.2022.09.28.09.22.42
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 09:22:43 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-131a7bce1acso2510161fac.7
        for <sparclinux@vger.kernel.org>; Wed, 28 Sep 2022 09:22:42 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr5762894oad.126.1664382162560; Wed, 28
 Sep 2022 09:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220926195931.2497968-1-shakeelb@google.com>
In-Reply-To: <20220926195931.2497968-1-shakeelb@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Sep 2022 09:22:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2DnK9RAJXJnrSa7WQdKhTXiHNoawCUcxGjk8TdCtJcw@mail.gmail.com>
Message-ID: <CAHk-=wj2DnK9RAJXJnrSa7WQdKhTXiHNoawCUcxGjk8TdCtJcw@mail.gmail.com>
Subject: Re: [PATCH] Revert "net: set proper memcg for net_init hooks allocations"
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anatoly Pugachev <matorola@gmail.com>,
        Vasily Averin <vvs@openvz.org>,
        Jakub Kicinski <kuba@kernel.org>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Mon, Sep 26, 2022 at 1:00 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> This reverts commit 1d0403d20f6c281cb3d14c5f1db5317caeec48e9.
>
> Anatoly Pugachev reported that the commit 1d0403d20f6c ("net: set proper
> memcg for net_init hooks allocations") is somehow causing the sparc64
> VMs failed to boot and the VMs boot fine with that patch reverted. So,
> revert the patch for now and later we can debug the issue.

Just FYI for the involved people - I've noq applied this directly to my tree.

                 Linus
