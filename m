Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183BFCE79AE
	for <sparclinux@archiver.kernel.org>; Wed, 20 Sep 2023 08:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbjITIKc (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 20 Sep 2023 04:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjITIKb (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 20 Sep 2023 04:10:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BDD9D
        for <sparclinux@vger.kernel.org>; Wed, 20 Sep 2023 01:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695197381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wUFr8wXK8O4RymSbY1nra3xh487ahU0WWNS0q+EozOI=;
        b=cZw9MAO/FcFnZh/YiCPqOFpRj2rCyX2RsOemK+2vaLaMFb0Wu8mzwKMzLVxGm29okoWQVG
        SkEfU37DssycvC5aRN3SI6NWuDrNFSPNEOXhHo4rvzLdpsGrsgeCCmv3lxG33uval6NTvj
        G7r3dbjR0RWZqiRjE8SH/XD1CzAFelQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-UIjasRoEP2eG5F5205xhhw-1; Wed, 20 Sep 2023 04:09:39 -0400
X-MC-Unique: UIjasRoEP2eG5F5205xhhw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40469bcd1eeso45794555e9.2
        for <sparclinux@vger.kernel.org>; Wed, 20 Sep 2023 01:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695197378; x=1695802178;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUFr8wXK8O4RymSbY1nra3xh487ahU0WWNS0q+EozOI=;
        b=wEhPKvaYgiV9hTfhgfTQC2+Mi3Dq182W0odPm2F3trCevOG6DigfN4YAtss+Il8B8m
         /FYe9gQYABm3uuuxe9uuL4xokA1QHD48w/lNsHirZ90BJD9/93exueZ39pCkd0DDWtrP
         VvmYOARFopCkGNP1YqkGpn6FUPX8J649u0GdJ9nJG/79+OlXx/ffQC9Id9pwFBmKQQIR
         XWSDemnJXVjuiwQXhlmB5IFqkJ7Fy/l1E4YeAStwHdrQLcSdvGTiV/UeMt4SNETmsmJ2
         ukLeKvK6kKLfT7N7wgLq+emipRlpsTOdxNZBqJWfyPOqOFGUUADiZFMIne8ruVUaG0Ec
         oK3A==
X-Gm-Message-State: AOJu0YyldSAYDsWu78aAy8niauXFB+NmdjNV2b1kARJKV+BxSY78tPf/
        Gkb5Ctr2gxq35K18cFb850DI3fuHooX8k50RL0xoRASdLiRWS4EJBxbT9iP7sekr7AA5ePpOQLS
        e6LXxFPIAOvojr/cJCH4LW5zOL2mgqA==
X-Received: by 2002:a1c:771a:0:b0:401:bf56:8ba0 with SMTP id t26-20020a1c771a000000b00401bf568ba0mr1546102wmi.28.1695197378554;
        Wed, 20 Sep 2023 01:09:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHysZz6FM59YTt5tU+tK8YwrLHrBxcEDjY1ArDkjh6Nbe/7xpyZCpKNOycMqjW9MlKxyQeQmA==
X-Received: by 2002:a1c:771a:0:b0:401:bf56:8ba0 with SMTP id t26-20020a1c771a000000b00401bf568ba0mr1546080wmi.28.1695197378265;
        Wed, 20 Sep 2023 01:09:38 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c22da00b003fedcd02e2asm1223759wmg.35.2023.09.20.01.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 01:09:38 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, arnd@arndb.de,
        deller@gmx.de
Cc:     linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-m68k@lists.linux-m68k.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 2/5] fbdev: Replace fb_pgprotect() with
 pgprot_framebuffer()
In-Reply-To: <20230912135050.17155-3-tzimmermann@suse.de>
References: <20230912135050.17155-1-tzimmermann@suse.de>
 <20230912135050.17155-3-tzimmermann@suse.de>
Date:   Wed, 20 Sep 2023 10:09:37 +0200
Message-ID: <87fs39l0zi.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Rename the fbdev mmap helper fb_pgprotect() to pgprot_framebuffer().
> The helper sets VMA page-access flags for framebuffers in device I/O
> memory.
>

I think this rename makes it more clear.

> Also clean up the helper's parameters and return value. Instead of
> the VMA instance, pass the individial parameters separately: existing
> page-access flags, the VMAs start and end addresses and the offset

But I fail to see the benefit of this part. Could you please add an
explanation about why this change is desirable ?

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

