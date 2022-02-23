Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB01C433FE
	for <sparclinux@archiver.kernel.org>; Wed, 23 Feb 2022 01:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiBWBno (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 22 Feb 2022 20:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbiBWBnb (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 22 Feb 2022 20:43:31 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DD950B2F
        for <sparclinux@vger.kernel.org>; Tue, 22 Feb 2022 17:42:59 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 75so18529926pgb.4
        for <sparclinux@vger.kernel.org>; Tue, 22 Feb 2022 17:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=EIgDsKHK/7A3hYjGzuwp0mt1Zx4DqedctDxyTOeLL7s=;
        b=zoYMgTMzBim7kT8E8RtAzBQzMnYT267FbUn9niV42OhWDDak0NhGQ8Ea/WIztMSdKQ
         WSxjG++qNqyUmAc2rFY4lbsG8EtYCif2aWPLPIhNyEZJFdnXyvMGv1g5SNsAeHcVaduN
         3aF9JUoL1uISZZVizP5eOdEs4wFcri1mJ7W2+7jH2qbukUw1tdGNQIlJ7nb9rT4vPg83
         DNDX30kjb/RQrzmTdb3zLlrb9dUO4t3W5ODDYJ1SgNy4mYdShMW01rxlYfOZC4Zw1ELa
         Ncu4htbBSvAwLAgsMrP0ne4wobOp/VZfsAFVcBGt3znGcbkmYmTp/NzzfAR3cyfAxHK5
         q+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=EIgDsKHK/7A3hYjGzuwp0mt1Zx4DqedctDxyTOeLL7s=;
        b=zYhjj1i/HC1piwrey4e6scFHw7SgM5GvDpQ8bclraxX5AGYFa/ETA4WtXqE7DEQho6
         BcvuRh+N6V+VyDIdt6yYb94xrEgeExjDi82pgwpktIgrWF067WCHG/bXjDsD8VQ3NGfh
         KSqL72zhhkwuLGd0hE2oWWdPlhfFhld30qc51IQlyx3Y+jvPG4OY5T8XkuBVlan52VDM
         +dkDCJZVUhepjRimTLX1wLwy5r8SnqqRelAqjsXMpfRDrdZGbVzC5Q3hklHBAgSWxVHU
         JTFKnMYyZMVzxAffxuvJ/bqpacVGwl+Qj4E2nH0Lmr3xD7+mX3PdbAPfkMQfuRDw6CQl
         BlAQ==
X-Gm-Message-State: AOAM530EvU3qUyC72RDmkV5wtH+NTvqxgFp2Tm0xflGoDWHVdtYrps/Z
        f7zebfHtgRDKChGGu77YRGr2sw==
X-Google-Smtp-Source: ABdhPJzyj2zCoiD8VneIC0PIYB0EkFnPoGuLVRxasLol3DuwplyySz8DnRpIoBlUCpRMhRxzsN0fNg==
X-Received: by 2002:a05:6a00:114f:b0:4cd:65d0:7dd5 with SMTP id b15-20020a056a00114f00b004cd65d07dd5mr27015541pfm.41.1645580578972;
        Tue, 22 Feb 2022 17:42:58 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id h7sm18228501pfi.128.2022.02.22.17.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 17:42:58 -0800 (PST)
Date:   Tue, 22 Feb 2022 17:42:58 -0800 (PST)
X-Google-Original-Date: Tue, 22 Feb 2022 17:22:39 PST (-0800)
Subject:     Re: [PATCH V5 21/21] KVM: compat: riscv: Prevent KVM_COMPAT from being selected
In-Reply-To: <20220201150545.1512822-22-guoren@kernel.org>
CC:     guoren@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        anup@brainfault.org, Greg KH <gregkh@linuxfoundation.org>,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, Christoph Hellwig <hch@lst.de>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     guoren@kernel.org
Message-ID: <mhng-6be88a24-32d7-451d-8a78-b9dcc90ce991@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, 01 Feb 2022 07:05:45 PST (-0800), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Current riscv doesn't support the 32bit KVM API. Let's make it
> clear by not selecting KVM_COMPAT.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Anup Patel <anup@brainfault.org>
> ---
>  virt/kvm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index f4834c20e4a6..a8c5c9f06b3c 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -53,7 +53,7 @@ config KVM_GENERIC_DIRTYLOG_READ_PROTECT
>
>  config KVM_COMPAT
>         def_bool y
> -       depends on KVM && COMPAT && !(S390 || ARM64)
> +       depends on KVM && COMPAT && !(S390 || ARM64 || RISCV)
>
>  config HAVE_KVM_IRQ_BYPASS
>         bool

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

I'm assuming Anup is going to take this as per the discussion, but LMK 
if you want me to take it along with the rest of the series.  There's 
some minor comments outstanding on the other patches.
