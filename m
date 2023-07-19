Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D6AEB64DA
	for <sparclinux@archiver.kernel.org>; Wed, 19 Jul 2023 08:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjGSIny (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 19 Jul 2023 04:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjGSIny (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 19 Jul 2023 04:43:54 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E86110E
        for <sparclinux@vger.kernel.org>; Wed, 19 Jul 2023 01:43:52 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76595a7b111so528663885a.2
        for <sparclinux@vger.kernel.org>; Wed, 19 Jul 2023 01:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689756231; x=1690361031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=opnGFGlJMMOa3QM4I72KjXzhOJNz0fm8ESXFSvOwDDA=;
        b=v2vvyAVlh8AgroQMbZyFOCH/onK/R1y2gZKqoU15ITY7m57+AuC8FlyqIfFa2NtoHr
         3rziSSfeanIVQFRRtrGs2ZmRy4Mk8h6iL2jqrNWSa3Jl9QhmFoA/Bo5uVEfnghBYkbWU
         lZbUluy2je0likMwbvRgmq9VAUVtAWlS1/VMyLj5cXd/sEpWhDIz4EXrYxGacVO8WkDd
         zo8+g2nECcTUmzTXPaOsfLRN11y3MphgFPGopWMFWjiKOL7Qksb3JbOFMVNUfalLdv/g
         T8FzhqyT7ayyWY9S/kR51QZZOwV6boGJvk9jSVcK3i/ZtIY8uW7eBylSv7b9WZ4PRyI1
         9VTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689756231; x=1690361031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opnGFGlJMMOa3QM4I72KjXzhOJNz0fm8ESXFSvOwDDA=;
        b=Ch1tivqBZ9l9Z7I4fcyn6hnPEP1BhjKP/bWGxsX7b6VBTzibtbUmSvHA8xsmXaGGd4
         J0RRpCjGoVMVAI63aSuLkxDqRkWgfHEbbVNN52LAe3Jb/fY2IztGZTQVbumU8rCp+eHx
         SgBvjD5RjROX3NwK8iZYB/yU+8F3FwqA/P3KhTXqjueIG6D+Y3hZL5TgXH3k2/U0tJCh
         pmKdep/DRVCM2SuItdqCP9GgB69qfmipgVkVH89yNAe8wMp7tnQE+NJ8y81soRjHekKl
         Ws3DyuLY59Ywh2Ayz2YnQnDJ0Ly3Woho0Gn3yCWPudDV6CmJT5dNmh371b2JdDhgRhku
         pKig==
X-Gm-Message-State: ABy/qLax69AagIul9GhTg9Gmn5/aqcNEc+KUdKJuHXmSen2z9T5g95ej
        wZG8TkmYK3f7PaqZEvgwaJLcrXPgvjdpXGEDX6XU+Q==
X-Google-Smtp-Source: APBJJlHhNyAkVd8gzq/+Z0Wx2hYxAO8gUQGhztu5sA4v0XCTIUzVGsJHmCOEY8F8+ExsNyaawu4wnfyYYtov/Ukb/Ro=
X-Received: by 2002:a05:620a:40d4:b0:765:5e69:29b0 with SMTP id
 g20-20020a05620a40d400b007655e6929b0mr5176245qko.62.1689756231330; Wed, 19
 Jul 2023 01:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230718085619.17403-1-xujianghui@cdjrlc.com> <19b84a97cb5487c22fcd3cc232abe860@208suo.com>
 <CALMQjD9M9tZiBmo69pLvC5QVLxgRfo_2R=X2x3sAfU5ts-zBFw@mail.gmail.com>
In-Reply-To: <CALMQjD9M9tZiBmo69pLvC5QVLxgRfo_2R=X2x3sAfU5ts-zBFw@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 19 Jul 2023 11:43:40 +0300
Message-ID: <CAA8EJpr1q2xVkA93pOu0r_VN-umMGmPYrbLyuZtPRkbeuj1Zqw@mail.gmail.com>
Subject: Re: [PATCH] sparc: add missing put_device()
To:     Kjetil Oftedal <oftedal@gmail.com>
Cc:     sunran001@208suo.com, davem@davemloft.net,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, 19 Jul 2023 at 11:12, Kjetil Oftedal <oftedal@gmail.com> wrote:
>
> On Tue, 18 Jul 2023 at 11:10, <sunran001@208suo.com> wrote:
> >
> > The of_find_device_by_node() takes a reference to the underlying device
> > structure, we should release that reference.
> >
> > ./arch/sparc/kernel/of_device_common.c:36:1-7: ERROR: missing
> > put_device; call of_find_device_by_node on line 30, but without a
> > corresponding object release within this function.
> > ./arch/sparc/kernel/of_device_common.c:50:1-7: ERROR: missing
> > put_device; call of_find_device_by_node on line 42, but without a
> > corresponding object release within this function.
> >
> > Signed-off-by: Ran Sun <sunran001@208suo.com>
> > ---
> >   arch/sparc/kernel/of_device_common.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/sparc/kernel/of_device_common.c
> > b/arch/sparc/kernel/of_device_common.c
> > index 7851307de6d0..5e9847d0fbed 100644
> > --- a/arch/sparc/kernel/of_device_common.c
> > +++ b/arch/sparc/kernel/of_device_common.c
> > @@ -33,8 +33,8 @@ int of_address_to_resource(struct device_node *node,
> > int index,
> >       if (!op || index >= op->num_resources)
> >           return -EINVAL;
> >
> > -    put_device(op->dev);
> >       memcpy(r, &op->archdata.resource[index], sizeof(*r));
> > +    put_device(op->dev);
> >       return 0;
> >   }
> >   EXPORT_SYMBOL_GPL(of_address_to_resource);
> > @@ -47,8 +47,8 @@ void __iomem *of_iomap(struct device_node *node, int
> > index)
> >       if (!op || index >= op->num_resources)
> >           return NULL;
> >
> > -    put_device(op->dev);
> >       r = &op->archdata.resource[index];
> > +    put_device(op->dev);
> >
> >       return of_ioremap(r, 0, resource_size(r), (char *) r->name);
> >   }
>
>
> Based on Dmitry Baryshkov earlier comment I am not sure if this is a safe fix.
> (And I am not fully knowledgable about the memory lifecycle here)
>
> If it is so that the device can disappear after put_device, is it then
> safe to access a
> pointer to that devices resource information when calling of_ioremap() ?

No, r, being a pointer to device's archdata, can also be gone.

Also, I'd note to Ran Sun, that sending an unversioned fix for a fix
is frowned upon. Please send a proper versioned patch with the
included changelog, etc.
I think I have already pointed you to Documentation/process/ files.
Please read them carefully and follow them, otherwise your further
patches can get ignored/NAKed.

-- 
With best wishes
Dmitry
