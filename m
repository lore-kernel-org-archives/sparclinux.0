Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3D7C76195
	for <sparclinux@archiver.kernel.org>; Fri, 24 Mar 2023 09:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjCXJAY (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 24 Mar 2023 05:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjCXJAW (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 24 Mar 2023 05:00:22 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2F72119
        for <sparclinux@vger.kernel.org>; Fri, 24 Mar 2023 02:00:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso2689722wms.1
        for <sparclinux@vger.kernel.org>; Fri, 24 Mar 2023 02:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679648415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5xxjybCBQ7FBka5nE6E8+uHXCIz/6b/SCGTHJfPcbCM=;
        b=a1FBd8hdYt0yM0X/QMw5JK93/6fmZkvcvOaCpGAhllGD9kZY3ocWprh/fBfy2T2rod
         YkjH4UdxH2uedUuCvo+EkF57N3c7HVf3QBOceSd07Mza5R+OpESBolPUbeS2d8fEsBnh
         OQSDXwfd2956PoRvrlESlWmo04/2c61Xl/bDa7ICS7G31P3ZvNNxX5D0+ZOcZrZ5tdVJ
         2S9NsPv6/2vlegpFew239TZL4Ndvj2ZSLHjydzAhHLKc0SUYXBptCAACw1ytjJlvXLD2
         ngcfW35TYBHM51xRfg++jvURD69Dmc0jU2GT+32k16t0vBRoghLroNVWI9Q6WKBRZRnc
         Sc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679648415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5xxjybCBQ7FBka5nE6E8+uHXCIz/6b/SCGTHJfPcbCM=;
        b=eIcsXyFnXtL8MmFgQgpw6uT6MUGNO7poBXLsqFsEk2yh7qZDB9PaWZGpNNt2w+KiMh
         qDumYhtFiiEelGsng+hcVOkLwIXUX5iMHNPWE/oC+9zHlR0hljKm6+H5QNb8/ek0q9F3
         O/Vi7Pa9i5YSLmy8C3KvO0Mi5UD98Os1EA28CCORefa56iC4+Py+u8Gth635rdroxp1p
         rlXduXyEtB3lGyz7641hyvgT1GkFAoH4IWI/wH7I1HL27fv/Bmp6FvoO/1FIl8c5ABic
         TpZ7PrUKeNeagJvPavgk8h2uCS/lrYiIO2KBDTF0g8DEGx67zuquE8d6lIMlxAWqIMcE
         MPeA==
X-Gm-Message-State: AO0yUKVFVIyKxN8+wOEkWeB3pNqbUjTxp8N5XShpfiCVs4qrd2folOce
        GAbvGpZNwkuUyUh4knq+lUXV9Q==
X-Google-Smtp-Source: AK7set/G+BrnIBHzdKAcJLIchyTJ1+8LJ+VqEzbQ4F0KmkhucSNebeQVHkqJ+K4tuv21EwA1IHVe7Q==
X-Received: by 2002:a7b:c459:0:b0:3eb:a4e:a2b2 with SMTP id l25-20020a7bc459000000b003eb0a4ea2b2mr1815337wmi.4.1679648415689;
        Fri, 24 Mar 2023 02:00:15 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.152.149])
        by smtp.gmail.com with ESMTPSA id n20-20020a7bc5d4000000b003ee10fb56ebsm4302953wmk.9.2023.03.24.02.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 02:00:15 -0700 (PDT)
Message-ID: <78a9e002-ba18-c580-fe89-46f5653ea49d@linaro.org>
Date:   Fri, 24 Mar 2023 10:00:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v7 3/6] PCI: Allow pci_bus_for_each_resource() to take
 less arguments
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Juergen Gross <jgross@suse.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Anatolij Gustschin <agust@denx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <20230323173610.60442-1-andriy.shevchenko@linux.intel.com>
 <20230323173610.60442-4-andriy.shevchenko@linux.intel.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230323173610.60442-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 23/3/23 18:36, Andy Shevchenko wrote:
> Refactor pci_bus_for_each_resource() in the same way as it's done in
> pci_dev_for_each_resource() case. This will allow to hide iterator
> inside the loop, where it's not used otherwise.
> 
> No functional changes intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> ---
>   drivers/pci/bus.c                  |  7 +++----
>   drivers/pci/hotplug/shpchp_sysfs.c |  8 ++++----
>   drivers/pci/pci.c                  |  3 +--
>   drivers/pci/probe.c                |  2 +-
>   drivers/pci/setup-bus.c            | 10 ++++------
>   include/linux/pci.h                | 17 +++++++++++++----
>   6 files changed, 26 insertions(+), 21 deletions(-)

Nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

