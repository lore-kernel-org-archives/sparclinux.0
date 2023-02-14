Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258F8C6379F
	for <sparclinux@archiver.kernel.org>; Tue, 14 Feb 2023 09:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjBNJGQ (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 14 Feb 2023 04:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjBNJFf (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 14 Feb 2023 04:05:35 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBBF23D90
        for <sparclinux@vger.kernel.org>; Tue, 14 Feb 2023 01:05:01 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bu23so14845156wrb.8
        for <sparclinux@vger.kernel.org>; Tue, 14 Feb 2023 01:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KZk18aUwfr/crPnHPA/QNPK0H4tWzNL+2OmakVamCi8=;
        b=FuqeOAA0zOBxZDuVrmVbvP8dKvoEf0MRrKKfm5NpFSyLOS1syMedD57gIqKmrL5zko
         qHpdqh+1Qi4vk3xY+Y+b00Y3rfjpVOFAPuWKFoaNHXYX+NhTIfQLIuO5WcCVUFUjRwy7
         xMFDBg0c617IjgdOAOjwaUswIiGz5V4UI7DfJ8LBDe8ExR38WilQf/7hqV4J4nMfP3dK
         +NkXzLhRfCI4LG9OC+J6fTkyG/7he+OYSDs5hlMQV6UXzYF2Dol240t6thsBMIDBZKNF
         mf4lP1Tmk2bhebKijyv57HPqf77+Ml7M9RiO9cyGc/K41l5a0L/IdrW6ctCufCt4MQrg
         Mpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZk18aUwfr/crPnHPA/QNPK0H4tWzNL+2OmakVamCi8=;
        b=tom0dNMpCM5vu9DHYaMj4yElkmTPX5osquWNefuIKkYL8NygpAxLuz7ScCaR7MeJfU
         ymLZpDatHPs8BDBoq8YwB3Q16dMvnM7SQxEoEsl+EQRo7Labi7ulvEn3G8P8lS7/YYeB
         9bTU6wcyFgcGv19ZFJbk9AiyOg3ZjMnhPI8aXW18/4sl0PzIsrauNdlXdbf8Zzrl1vb0
         iS4kgmMSulzKzHo8lTJjZT3N8ChJS9YvnVmRzKJchr7SGpX9jyXQrNdCMTsJwOPJ3kq1
         l/+UKf2Q5Ax3d+NyqNPEhQuDwYMrjsxc9lXOenMbffr2pNlpp/RReAupnmq93+pUQmuA
         seRQ==
X-Gm-Message-State: AO0yUKXQClIjkYGxtLsHBeGgsUEIWZ5bKC18YXtOXf0Ld4c3kZp6sSCl
        MJhQa95i6qtkUuyRsN4eCnsCIw==
X-Google-Smtp-Source: AK7set+jlADAGeMno/J4b9rMaQi1OSFbGE2cOeHJ3WYCoMJkKRkmj2/GQpc+G+sprep4ghyf/aRSVg==
X-Received: by 2002:a05:6000:8b:b0:2bd:f5bd:5482 with SMTP id m11-20020a056000008b00b002bdf5bd5482mr1310606wrx.28.1676365493352;
        Tue, 14 Feb 2023 01:04:53 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id d13-20020adfe88d000000b002c54f4d0f71sm7494931wrm.38.2023.02.14.01.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:04:52 -0800 (PST)
Message-ID: <a018ab25-b545-1227-951b-a7b4e1c25d5e@linaro.org>
Date:   Tue, 14 Feb 2023 10:04:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v3 20/24] x86: Remove empty <uapi/asm/setup.h>
Content-Language: en-US
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
References: <20230214074925.228106-1-alexghiti@rivosinc.com>
 <20230214074925.228106-21-alexghiti@rivosinc.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230214074925.228106-21-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 14/2/23 08:49, Alexandre Ghiti wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>   arch/x86/include/asm/setup.h      | 2 --
>   arch/x86/include/uapi/asm/setup.h | 1 -
>   2 files changed, 3 deletions(-)
>   delete mode 100644 arch/x86/include/uapi/asm/setup.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

