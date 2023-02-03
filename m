Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E8EC05027
	for <sparclinux@archiver.kernel.org>; Fri,  3 Feb 2023 14:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjBCOcA (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 3 Feb 2023 09:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbjBCObv (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 3 Feb 2023 09:31:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0538FB74
        for <sparclinux@vger.kernel.org>; Fri,  3 Feb 2023 06:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675434620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FGqA/t5BHooNtKKmgY/P/RvUeTIDhJpfv4X01I3UuzM=;
        b=i0GTS4Wv009WgzRHujY2hTs3SFt/CS5bl6wzzo/7K/g9TMrc/gHCwxHutEn/AuXmv2Wuce
        WelFsRCNVtdrmOlpTusE8WGRpyCeZjlljHrt6CmPDVhNBj+d36secvk4Jca26Nq9Zk/TqK
        lFMOk5tWPCCIV2sEOxQr/IxXs+PuHrs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-64-P6scQXQwPySSF6HVLWU0mQ-1; Fri, 03 Feb 2023 09:30:18 -0500
X-MC-Unique: P6scQXQwPySSF6HVLWU0mQ-1
Received: by mail-wm1-f72.google.com with SMTP id d14-20020a05600c34ce00b003dd07ce79c8so2706152wmq.1
        for <sparclinux@vger.kernel.org>; Fri, 03 Feb 2023 06:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGqA/t5BHooNtKKmgY/P/RvUeTIDhJpfv4X01I3UuzM=;
        b=HTJwLUXozYEo4JhH6rFwskymvz0NeT0Ovh3jvQ16TtqxVrkzWb8hYU99OW0ItOoO2Z
         Xk8dfCfJiJByhBYNuQOnTBUvOvSc1jw31LXY/QdKk6P+BVUckHH/tvC6+U0rFrxMGIy7
         JWMwX5MSosirLUpLujJgOQCoK5aQWtyu3h2XITfJXpVgixma3VZaYWbg7sgJFpBQ5dWr
         k9X6lBBgGSRcyVXFJWXmtO0ArVIiPLAilpcWIqu9uxWMFdOWCAZ3nRItY2O0R27iSi1+
         4NpWHdTO9Cm9iHoHrmecwF+dFyG4hzfUu8r9kthXUMQt+minRuaI2ss/T4chYF8zZiWV
         RyTw==
X-Gm-Message-State: AO0yUKV6LXlNqxwx0dz5so+lN7nOKD4d+2x6uxyg5dPA5HmxheBG7+pM
        At3SaM6xAgHYrH8mjeE6DTjufOYzgxNom7AFPxZXD/ca6hd26xtxbwRJdYMJ50mMu7DbXxZy1Nh
        8zZ/Da0QqWMgHprePyJ/gng==
X-Received: by 2002:a05:600c:3588:b0:3df:e1e9:200e with SMTP id p8-20020a05600c358800b003dfe1e9200emr4472909wmq.39.1675434616190;
        Fri, 03 Feb 2023 06:30:16 -0800 (PST)
X-Google-Smtp-Source: AK7set+3Fxk3nALXFhpoXy/lSyMSFcdmxLuZvgb86YYfx4M4JIQvKCJs/tKTkc3VpDPsDt8toFavpA==
X-Received: by 2002:a05:600c:3588:b0:3df:e1e9:200e with SMTP id p8-20020a05600c358800b003dfe1e9200emr4472869wmq.39.1675434615896;
        Fri, 03 Feb 2023 06:30:15 -0800 (PST)
Received: from [192.168.3.108] (p5b0c6376.dip0.t-ipconnect.de. [91.12.99.118])
        by smtp.gmail.com with ESMTPSA id h27-20020a05600c2cbb00b003db12112fcfsm3203111wmc.4.2023.02.03.06.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 06:30:15 -0800 (PST)
Message-ID: <569308c6-558b-de6e-1e98-2f50c1c56755@redhat.com>
Date:   Fri, 3 Feb 2023 15:30:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/4] arm: include asm-generic/memory_model.h from
 page.h rather than memory.h
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rich Felker <dalias@libc.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vineet Gupta <vgupta@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        x86@kernel.org
References: <20230129124235.209895-1-rppt@kernel.org>
 <20230129124235.209895-2-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230129124235.209895-2-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 29.01.23 13:42, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Makes it consistent with other architectures and allows for generic
> definition of pfn_valid() in asm-generic/memory_model.h with clear override
> in arch/arm/include/asm/page.h
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

