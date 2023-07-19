Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEECEB64DA
	for <sparclinux@archiver.kernel.org>; Wed, 19 Jul 2023 08:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjGSIMj (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 19 Jul 2023 04:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjGSIMj (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 19 Jul 2023 04:12:39 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DF91B6
        for <sparclinux@vger.kernel.org>; Wed, 19 Jul 2023 01:12:38 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-c5ffb6cda23so6588045276.0
        for <sparclinux@vger.kernel.org>; Wed, 19 Jul 2023 01:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689754357; x=1690359157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H0U6Ou3M4UAvInWN+ZE6t/YPUoa+2emaVfRoP2o2T/0=;
        b=jbEBYFLlHvPiDR4nmf/tquae2y7UQ/uLAHNr3DF9BwkAr9QMM8miJLv2R/aazzFTAW
         KaXOCmOjd4uFQxnyFPR8EWcktqKfr/txA1KMAvHgzo18n6jfHnBXFhQFKe4Q9ts4a0qw
         MkfwCi+UbXGOLJZIZ0xUn+y0KdaEKdIfYY/y21YW9Ftu3q/WzvTjEEEcoioFtdsuJBYe
         Ri7TJJ5ip/Fonf6uUwlOs1Wfkk6E3XKzWQKN0q6x3nthpO3FQzZtnoz6qJ2RmznjVhJG
         FYYghstJsItzB5WScBju+pcrx3UsAkRlnPZNmlWQLRH/lAU5UGA0BggnokZG/PrKD7MI
         LzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689754357; x=1690359157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0U6Ou3M4UAvInWN+ZE6t/YPUoa+2emaVfRoP2o2T/0=;
        b=W4LEEplzUx3b3KM6xuclqKQoju8k3GXeJ/wpZCGCpVf9jpj46RqglZ0ePytcRVxTzh
         d8pRN+zeg8m7zwBgcITyXtJHJNkL2+MCduz8olNrGOXObQ9ksQKcwD5iYFaaZ5pOahpA
         s3lbeV58RGthuPgd//Ihvf61EapxyxAwr8zbqekWCG55EQuyV1jgtE+Aen+C55dNButf
         OPNQAO8QjMC+D4wOlLDdziFG1k6GL4NcsaYzWSb+Fs0HC9ojSpkwpYUd9P24mQ8Thnb2
         LcYX2nyhFUfrSBt8gUxVavadKj0mPO1Qkb+d4RSnf1HBVtHKKVvKHTidhtQk0XkbjInX
         BBIA==
X-Gm-Message-State: ABy/qLYQShyqIooFUwHShUnrXAmRfWJ9FLkrIkwg+e+EQuz30Xr8QsNt
        +hF4Qb/5t3twqx+Tpq2F8RJbiC8vH0NTyb1qQ6k=
X-Google-Smtp-Source: APBJJlHeKJSZsF9NU8YP1IU04a7hifxc4dYmkgCrow6mcYTlVysL6G+aC1sI1JitOYNpKPNyAeqIGG45eykAgFQd1UM=
X-Received: by 2002:a25:6850:0:b0:bd7:545e:ab41 with SMTP id
 d77-20020a256850000000b00bd7545eab41mr2063292ybc.27.1689754357440; Wed, 19
 Jul 2023 01:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230718085619.17403-1-xujianghui@cdjrlc.com> <19b84a97cb5487c22fcd3cc232abe860@208suo.com>
In-Reply-To: <19b84a97cb5487c22fcd3cc232abe860@208suo.com>
From:   Kjetil Oftedal <oftedal@gmail.com>
Date:   Wed, 19 Jul 2023 10:12:24 +0200
Message-ID: <CALMQjD9M9tZiBmo69pLvC5QVLxgRfo_2R=X2x3sAfU5ts-zBFw@mail.gmail.com>
Subject: Re: [PATCH] sparc: add missing put_device()
To:     sunran001@208suo.com
Cc:     davem@davemloft.net, sparclinux@vger.kernel.org,
        dmitry.baryshkov@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, 18 Jul 2023 at 11:10, <sunran001@208suo.com> wrote:
>
> The of_find_device_by_node() takes a reference to the underlying device
> structure, we should release that reference.
>
> ./arch/sparc/kernel/of_device_common.c:36:1-7: ERROR: missing
> put_device; call of_find_device_by_node on line 30, but without a
> corresponding object release within this function.
> ./arch/sparc/kernel/of_device_common.c:50:1-7: ERROR: missing
> put_device; call of_find_device_by_node on line 42, but without a
> corresponding object release within this function.
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   arch/sparc/kernel/of_device_common.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/sparc/kernel/of_device_common.c
> b/arch/sparc/kernel/of_device_common.c
> index 7851307de6d0..5e9847d0fbed 100644
> --- a/arch/sparc/kernel/of_device_common.c
> +++ b/arch/sparc/kernel/of_device_common.c
> @@ -33,8 +33,8 @@ int of_address_to_resource(struct device_node *node,
> int index,
>       if (!op || index >= op->num_resources)
>           return -EINVAL;
>
> -    put_device(op->dev);
>       memcpy(r, &op->archdata.resource[index], sizeof(*r));
> +    put_device(op->dev);
>       return 0;
>   }
>   EXPORT_SYMBOL_GPL(of_address_to_resource);
> @@ -47,8 +47,8 @@ void __iomem *of_iomap(struct device_node *node, int
> index)
>       if (!op || index >= op->num_resources)
>           return NULL;
>
> -    put_device(op->dev);
>       r = &op->archdata.resource[index];
> +    put_device(op->dev);
>
>       return of_ioremap(r, 0, resource_size(r), (char *) r->name);
>   }


Based on Dmitry Baryshkov earlier comment I am not sure if this is a safe fix.
(And I am not fully knowledgable about the memory lifecycle here)

If it is so that the device can disappear after put_device, is it then
safe to access a
pointer to that devices resource information when calling of_ioremap() ?

-
Kjetil Oftedal
