Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8786AC64EC4
	for <sparclinux@archiver.kernel.org>; Fri,  3 Feb 2023 14:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjBCOex (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 3 Feb 2023 09:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjBCOel (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 3 Feb 2023 09:34:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CC914EA6
        for <sparclinux@vger.kernel.org>; Fri,  3 Feb 2023 06:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675434831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QVQjsvvXC5vAa55XgbnpLQZ7ycccPtxDGUTVFYgFp7U=;
        b=YkMFWPGdOtwCaWTz3sSvnVhVAlrfBii+eUr9heNgK0zcWZ5uFBEjdbf5rSCms0FYPl7Lr/
        bO0fnCEfCIHkDejKwepgZcmt3RpDroIX3KxaJm84hRwwiwlG15yQ5klR/qCKr4tHLiKOFb
        huKGEOL7l9phcOkJbxz9I9IKwPCKr+Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-232-uCtwTxawPDq0Tnz8627sGw-1; Fri, 03 Feb 2023 09:33:49 -0500
X-MC-Unique: uCtwTxawPDq0Tnz8627sGw-1
Received: by mail-wr1-f71.google.com with SMTP id o9-20020adfa109000000b002bfc062eaa8so715568wro.20
        for <sparclinux@vger.kernel.org>; Fri, 03 Feb 2023 06:33:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVQjsvvXC5vAa55XgbnpLQZ7ycccPtxDGUTVFYgFp7U=;
        b=HmhwLVp2q4oK56jDTlgNvGlmRKWk5Wyf6cAOoMt45tLH9Tt4D/v+1YRGWy2JLRP/Fb
         q7+Q2gRqEKjajWYUwBc5Yw5xV7kmy9ERKdZKM6kP+B/V5mikB3MY3usYuAfbezdv3M7i
         a1U61eesFikSpTg0eWXLMbcQQm7jf6jGDa+4qLSb4u56GwwLqWxqYTmNpYmqlVbTC2OX
         jPKj2VOeM2uVIobZfkdky8wsQ7Id8SC2NP2Xmkt14Xe0BgiZUSxv88Z2oDPiOb8J4swH
         SYz71KtpkWXH3ciU5RDGMOjMvvEm/1kmX2qoILKov0IIi+PDe/e0+oIHb9iZ7PbXUpGG
         judQ==
X-Gm-Message-State: AO0yUKWlNM/86/+2L2Cult/H1hE1Isz8nAMFdhMKrK4eK//JzwfbF+Un
        0aOOvC7vMDHi4ke2tRCWJYSjFDk4VlbjvLS+mpuZ5hbZ5tc97qDeZo1JtsqjQ1JrMM6Vn6lJmt9
        EHlzkfmU+peSpe4OQy0hniA==
X-Received: by 2002:a05:600c:3514:b0:3df:ead3:c6fc with SMTP id h20-20020a05600c351400b003dfead3c6fcmr1739791wmq.17.1675434828394;
        Fri, 03 Feb 2023 06:33:48 -0800 (PST)
X-Google-Smtp-Source: AK7set+nCaLsRgMPjXxFJ2S9nOzpB4vodjtO+Yac8mpKGPJpDWQMNBTnVH2IJfyVyYdKVED3TZv5Cg==
X-Received: by 2002:a05:600c:3514:b0:3df:ead3:c6fc with SMTP id h20-20020a05600c351400b003dfead3c6fcmr1739731wmq.17.1675434828065;
        Fri, 03 Feb 2023 06:33:48 -0800 (PST)
Received: from [192.168.3.108] (p5b0c6376.dip0.t-ipconnect.de. [91.12.99.118])
        by smtp.gmail.com with ESMTPSA id o35-20020a05600c512300b003cffd3c3d6csm3239260wms.12.2023.02.03.06.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 06:33:47 -0800 (PST)
Message-ID: <de9cb029-b36e-efe9-9d0e-46a382e889b5@redhat.com>
Date:   Fri, 3 Feb 2023 15:33:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 4/4] mm, arch: add generic implementation of
 pfn_valid() for FLATMEM
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
        x86@kernel.org, Huacai Chen <chenhuacai@loongson.cn>
References: <20230129124235.209895-1-rppt@kernel.org>
 <20230129124235.209895-5-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230129124235.209895-5-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 29.01.23 13:42, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Every architecture that supports FLATMEM memory model defines its own
> version of pfn_valid() that essentially compares a pfn to max_mapnr.
> 
> Use mips/powerpc version implemented as static inline as a generic
> implementation of pfn_valid() and drop its per-architecture definitions.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Guo Ren <guoren@kernel.org>		# csky
> Acked-by: Huacai Chen <chenhuacai@loongson.cn>	# LoongArch
> Acked-by: Stafford Horne <shorne@gmail.com>	# OpenRISC
> ---

LGTM with the fixup

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

