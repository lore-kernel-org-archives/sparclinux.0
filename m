Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC86EB64DA
	for <sparclinux@archiver.kernel.org>; Wed, 19 Jul 2023 14:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjGSO0Z (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 19 Jul 2023 10:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjGSO0T (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 19 Jul 2023 10:26:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA86E270C
        for <sparclinux@vger.kernel.org>; Wed, 19 Jul 2023 07:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689776716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xY+xsOpuPsAa6KICDwWDt2PoXyQ0u/vopB2mSitD/gY=;
        b=UK723g9Xbr6CfQVpAoY61fE/wD+k+i5j9vQtue0SzSARbIRQAQ33QEVLRYyqRcs7RTlA7q
        nUqwUBGs4TJO9TdvHOAxNxVd4U6SP8JLrC31ghJL+tYEixl/O1FhT8rSexw9fBL02Y7Byf
        RaGw01FqRx4PXkb6Xu5hqvD4enQnpW8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-rQWxcYWmNxaji0ho4l0n7Q-1; Wed, 19 Jul 2023 10:25:12 -0400
X-MC-Unique: rQWxcYWmNxaji0ho4l0n7Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31429e93f26so4199969f8f.2
        for <sparclinux@vger.kernel.org>; Wed, 19 Jul 2023 07:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689776710; x=1690381510;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xY+xsOpuPsAa6KICDwWDt2PoXyQ0u/vopB2mSitD/gY=;
        b=bINsEB+YkKj2ImfN4dpUC1KVSq2csJ1UaZhsb6RLgUK+OsJAL6GhUmpYIsN4CBSDmf
         mB5EeA+txrBO90RqGOBQANjP+Pb9Mrb89BjlkX6g+mxDNk8VFEECgOd9kgN/nDGk42gE
         gjbYFMacdW8jrkwjyJQAO5TTpkef5javq2X52D4NLD91JfaDjCB5hByR4QfOgyvDSGtf
         4WXMgxkZlUCYhfcAzAZkvt2xNaeF+C10io21ayUJ3c2cF9zCqZ2fVO00fgKIJ106SgRY
         alV6zmxl8LC/6e7pf8F295rbiJpdkaDn1jviIapM7zU/62kq4Wi0tHauOSgpaChfJH6J
         BQww==
X-Gm-Message-State: ABy/qLYDP8+8fvtZPpO+NdFP9Up02mvBWoIaLp6t73CaCKYwwj4qpgb/
        r2RWNDCbXdyqm022BT7dGH6p8m1jMcVfjXQWwXivSg+zN1TWdyk7+isfq6CwEE6oigYQHUF3rqv
        VfQXmMIGcck4/VQ8ie9Fkjg==
X-Received: by 2002:adf:f6d2:0:b0:315:a2a0:e331 with SMTP id y18-20020adff6d2000000b00315a2a0e331mr15880wrp.50.1689776710229;
        Wed, 19 Jul 2023 07:25:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHdsBbmhlUZVwgJXnbSuIEfuMAzDx5IOvgnijOdvMDteAVkW8k0bDz3T8ek9eZvK84UcEFXkg==
X-Received: by 2002:adf:f6d2:0:b0:315:a2a0:e331 with SMTP id y18-20020adff6d2000000b00315a2a0e331mr15829wrp.50.1689776709888;
        Wed, 19 Jul 2023 07:25:09 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t13-20020a7bc3cd000000b003fc05b89e5bsm1805793wmj.34.2023.07.19.07.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 07:25:09 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Deepak Rawat <drawat.floss@gmail.com>,
        Dexuan Cui <decui@microsoft.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guo Ren <guoren@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Khalid Aziz <khalid@gonehiking.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        WANG Xuerui <kernel@xen0n.name>, Wei Liu <wei.liu@kernel.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 8/9] hyperv: avoid dependency on screen_info
In-Reply-To: <20230719123944.3438363-9-arnd@kernel.org>
References: <20230719123944.3438363-1-arnd@kernel.org>
 <20230719123944.3438363-9-arnd@kernel.org>
Date:   Wed, 19 Jul 2023 16:25:08 +0200
Message-ID: <877cqwhtbv.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The two hyperv framebuffer drivers (hyperv_fb or hyperv_drm_drv) access the
> global screen_info in order to take over from the sysfb framebuffer, which
> in turn could be handled by simplefb, simpledrm or efifb. Similarly, the
> vmbus_drv code marks the original EFI framebuffer as reserved, but this
> is not required if there is no sysfb.
>
> As a preparation for making screen_info itself more local to the sysfb
> helper code, add a compile-time conditional in all three files that relate
> to hyperv fb and just skip this code if there is no sysfb that needs to
> be unregistered.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

