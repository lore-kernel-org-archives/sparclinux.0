Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB89DEB64DD
	for <sparclinux@archiver.kernel.org>; Tue,  4 Jul 2023 16:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjGDQ12 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 4 Jul 2023 12:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjGDQ1W (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 4 Jul 2023 12:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1605410FB
        for <sparclinux@vger.kernel.org>; Tue,  4 Jul 2023 09:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688487993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3N/Gyf3beclIUSfPsZhAnE2wLloPptbf+HqX/lLqDWc=;
        b=fHw9FiyufPGlzK4AIgS0dgZSj76QR2FVKZvFvIluVIyEuP6f3F2l9lrIR/e7xDHUCo0DWG
        LtDrB9sZuGTrAaR8aaSfQoiN+gnQoz1dcDo/jLka8JWUNjX/woiMKkO0AMpZE+9Vz1vK2O
        XMYn5sTagth877zSew8hlnGG90Q13y8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-pMr-nKKgNc2dcpBZa1v9qg-1; Tue, 04 Jul 2023 12:26:32 -0400
X-MC-Unique: pMr-nKKgNc2dcpBZa1v9qg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-313e6020882so2403367f8f.1
        for <sparclinux@vger.kernel.org>; Tue, 04 Jul 2023 09:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688487991; x=1691079991;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3N/Gyf3beclIUSfPsZhAnE2wLloPptbf+HqX/lLqDWc=;
        b=kQkUwtTvAK/vySJtsPN7sFxucfU0C7JYPK0ZemJgQ20TDm6W6Yx6aOqxPFWvyM+Ux8
         ll2+Umd9MuTm1PQ7q69fUo1qUXOi0GVhZYrMLyPJuFrK9qTMv0AqWDeo/OSBmtfCvBFh
         k0w3qh+Nxoma1NrI2mF+ZJJjC36OceAgh5GGHlKp8Lpo+9uAtzow17zUjGsutcpJVJDw
         nUW+S+mnifVTHv78dybyF07XgBLhwsbHGEQhOITBi4UpodPVkCjCCUUOhRhOJIBnQJma
         7jrtgb8zDvSxKYjvNNNmogwVuPfOCFqIxfUyuY+zaJlh70VF+SjhYRibxSlE/6MYhQSJ
         l34g==
X-Gm-Message-State: AC+VfDw2DkB4c0ziLrSWvOMSFfUoTSzmrjZ5oIROyRkAlLIHrBZeAjTr
        pSyDjN3RiINCwfSTQBT8QfdQGrcUtU+iljFVVD8rNqVYBdIP/9Vr4VJ+c35j5pFBaBY8JGqPMRz
        dhFDFJ4iAu5/odzJe9S8JuA==
X-Received: by 2002:a7b:ca57:0:b0:3fb:af9a:bf30 with SMTP id m23-20020a7bca57000000b003fbaf9abf30mr12688292wml.2.1688487991085;
        Tue, 04 Jul 2023 09:26:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ71ufTEe/wWv7h1ExOsJanD4siZOoua0ql6zTBm+MH4Z3jUb1+lMMqlPgaWI376xU4gg3rSqQ==
X-Received: by 2002:a7b:ca57:0:b0:3fb:af9a:bf30 with SMTP id m23-20020a7bca57000000b003fbaf9abf30mr12688259wml.2.1688487990852;
        Tue, 04 Jul 2023 09:26:30 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s25-20020a7bc399000000b003fa96fe2bebsm25398819wmj.41.2023.07.04.09.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:26:30 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de,
        deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-arch@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 03/12] sysfb: Do not include <linux/screen_info.h> from
 sysfb header
In-Reply-To: <20230629121952.10559-4-tzimmermann@suse.de>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-4-tzimmermann@suse.de>
Date:   Tue, 04 Jul 2023 18:26:29 +0200
Message-ID: <87cz17lk22.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The header file <linux/sysfb.h> does not need anything from
> <linux/screen_info.h>. Declare struct screen_info and remove
> the include statements.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

