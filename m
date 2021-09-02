Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31BEC432BE
	for <sparclinux@archiver.kernel.org>; Thu,  2 Sep 2021 02:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8038610A4
	for <sparclinux@archiver.kernel.org>; Thu,  2 Sep 2021 02:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhIBCzF (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 1 Sep 2021 22:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbhIBCzF (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 1 Sep 2021 22:55:05 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D57C061575;
        Wed,  1 Sep 2021 19:54:07 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id y18so650645ioc.1;
        Wed, 01 Sep 2021 19:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DW8iXfbLh2q7u5SVvpsUGnLef5eS1UxEivJKh91KQXk=;
        b=TKw8ArfDl+5zYD9xU+Slyf17czWgWrSuI1XAkMZKaCTk+fsD9N1w7yOgOy39tCV3m8
         d3NKUgeM97lIfzLsOzZeJrRJH35uHe8+U0UsB0VuZ4fkqweTVKC9U3neASeGCRJHlXBn
         eERKAfe/DghyXjsNiWfvNS/zQkYWDIEv7Xort5kviWRyBbmd+UCnfMoAhaQnTTWZwDAN
         oR1YyMrwZAOjB1FvO8rLzf6TiYsh2rUuRzGC0GlghYTMxFgX387ekQ1AngcPhfWrJ9kH
         rw9Af1LU1D4MlDqowFVWMgLrNiqfwTfqylrZABX0nZ34ZiGHsr54S8Dq/ShTcZdqtN8p
         sclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DW8iXfbLh2q7u5SVvpsUGnLef5eS1UxEivJKh91KQXk=;
        b=B39/6u6iNKQUHGpXia0fs6sL1OD6MBi2aGiLSmvmyzK9LrrH573pFHEc5VwT2vKcjR
         mjJnIwebqX1CCIU2fz0aK+bHQQdhfNFHOrtHvv59MAM/Ajfj8V8JQKFOvQNblflhLwI3
         JNb+BC4uBlbkE/5bkCPHxtmOMuptvlnkJJjwxc5YgqKJ4eQhKi4T45k8lrKs7v8Tt19D
         V16Yei6IKvZoIzqCeeADSnMMFAZgu+L+TiXrZnJcpFQ+UCPqFOEVVAH/vK7vSqqQJEJG
         lcwlsiFicDnsVVDDrDQEQdnhSUbxXrByasv/RZl01ZwB5eUa7Mabb9zAzxjm1ffkMGgo
         6LBg==
X-Gm-Message-State: AOAM5336Or0W/H2S9EwHJqE4Dv8+UPKmoYKjClqES5JeH0tn0RKbMmdH
        KdOEWagrKX9rVqiAILmKMjmdWoV/zCutzVEjRvXUIuI=
X-Google-Smtp-Source: ABdhPJwNf60dM3LZjiAqeigHW2/EnvbgMq70APSOLYwTXOyokVYIJV4DiPgatOpzJZxNTlwMTZkikWjW9bvzB5OZv3I=
X-Received: by 2002:a6b:f114:: with SMTP id e20mr877774iog.41.1630551246933;
 Wed, 01 Sep 2021 19:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210824031435.9664-1-kernelfans@gmail.com> <YSenB+Rr/4OV8EHQ@alley>
In-Reply-To: <YSenB+Rr/4OV8EHQ@alley>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 2 Sep 2021 10:53:56 +0800
Message-ID: <CAFgQCTtehXTfD2rfPOzBneXPYuFsDmozDL2bUT8b1DY1K5AXeQ@mail.gmail.com>
Subject: Re: [PATCH] kernel/watchdog: change prototype of watchdog_nmi_enable()
To:     Petr Mladek <pmladek@suse.com>
Cc:     sparclinux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        Santosh Sivaraj <santosh@fossix.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi Petr,

Thank you for reviewing.

But I am composing a series, which may overstep this patch. So please
drop this patch, and sorry for inconvenience.

Regards,

Pingfan

On Thu, Aug 26, 2021 at 10:36 PM Petr Mladek <pmladek@suse.com> wrote:
>
> On Tue 2021-08-24 11:14:35, Pingfan Liu wrote:
> > The only caller does not handle the return value of
> > watchdog_nmi_enable(). If there is an error, it seems to be reported by
> > arch specific code.
> >
> > Hence changing watchdog_nmi_enable() return value from int to void.
> >
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
>
> Looks good to me:
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
> Best Regards,
> Petr
