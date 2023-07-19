Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E9EC001E0
	for <sparclinux@archiver.kernel.org>; Wed, 19 Jul 2023 13:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjGSNuo (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 19 Jul 2023 09:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjGSNun (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 19 Jul 2023 09:50:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3CF1711
        for <sparclinux@vger.kernel.org>; Wed, 19 Jul 2023 06:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689774556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7gvBqRrgzjiPOFgHQxEB0Nm34S2dkYf27eWyqPPlFhY=;
        b=MJCgQrIBMcr7wbhfvbs95DRDAv9/Ek8YjI4PKuGYoZ1ZJb3B8nHvcNdwQToE6vqRgl2HsX
        Nw0b20nrnsMI3rhHGzzkjn4JwDxkIPKKvI+ZCeke872ig7XBJlzc9+CP1seBoWUwrs0f/O
        xmpG37jVTEXuI3uSdP9abNVIzc724nw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-sITwTHdoN32fQMg6ci-Uxg-1; Wed, 19 Jul 2023 09:49:14 -0400
X-MC-Unique: sITwTHdoN32fQMg6ci-Uxg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31701b27d19so375603f8f.1
        for <sparclinux@vger.kernel.org>; Wed, 19 Jul 2023 06:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689774552; x=1690379352;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7gvBqRrgzjiPOFgHQxEB0Nm34S2dkYf27eWyqPPlFhY=;
        b=H/JKcdR6jU17pX7vksxhIFKpxjDnHAeGHiylme1Kh6NFMxRMw/MIP9r7d+F5cuGIWQ
         BGwbEpv/2dWyOA57+rKZli6oj/QMD713Fgk8zeW1EnZMjOQE3OeHgkD9e83W+A9MF5Hs
         nr7w8QlbhzkclC+D63Rvb6u7Z9KUCVdXUJsQkSSIM4mJ4jsL/HrjbQ8noD4a/J2AyfHf
         J15OtPd09ZP8VcyCh8UUnBZvNMRCdTtH63LEecGBryrLElJ6s6XvZR63leCm8RY8V9Yt
         xgQhuWwJNT78ajYhOhO6AUS5QxGR/M6PMeVts8a5DXJDwvJVByoSD0ArIaLbCkvGmS90
         nqkA==
X-Gm-Message-State: ABy/qLbnxt/lS0W1GTyH7wt6xxjoR16fl5lpNZX9F5aKCzUtCkSBdBwy
        lOq/zsTcrelODl98GgIyftYBQDO7U4gYnG5L+3q5GOOTU4X+q6/w8QjVztpm0RxSZthSugc0ks4
        6Si7XJIsF4wg4kjPQXn59aw==
X-Received: by 2002:a5d:6a04:0:b0:314:3369:df57 with SMTP id m4-20020a5d6a04000000b003143369df57mr1948361wru.5.1689774552649;
        Wed, 19 Jul 2023 06:49:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFD8G6VPVcqqGeSjptpNDnOnSs3W+CAZM63rDbbbVz9hymKgoyuOl3Kik6r5ce0mC8oQNhizg==
X-Received: by 2002:a5d:6a04:0:b0:314:3369:df57 with SMTP id m4-20020a5d6a04000000b003143369df57mr1948300wru.5.1689774552274;
        Wed, 19 Jul 2023 06:49:12 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q2-20020a5d6582000000b003143bb5ecd5sm5381303wru.69.2023.07.19.06.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 06:49:11 -0700 (PDT)
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
Subject: Re: [PATCH v2 5/9] vgacon: remove screen_info dependency
In-Reply-To: <20230719123944.3438363-6-arnd@kernel.org>
References: <20230719123944.3438363-1-arnd@kernel.org>
 <20230719123944.3438363-6-arnd@kernel.org>
Date:   Wed, 19 Jul 2023 15:49:11 +0200
Message-ID: <87fs5khuzs.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The vga console driver is fairly self-contained, and only used by
> architectures that explicitly initialize the screen_info settings.
>
> Chance every instance that picks the vga console by setting conswitchp
> to call a function instead, and pass a reference to the screen_info
> there.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

