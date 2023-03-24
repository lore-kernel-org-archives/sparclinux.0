Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAF9C77B61
	for <sparclinux@archiver.kernel.org>; Fri, 24 Mar 2023 09:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjCXJCZ (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 24 Mar 2023 05:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjCXJCY (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 24 Mar 2023 05:02:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963E510E7
        for <sparclinux@vger.kernel.org>; Fri, 24 Mar 2023 02:02:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t15so985859wrz.7
        for <sparclinux@vger.kernel.org>; Fri, 24 Mar 2023 02:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679648540;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n243IrPXTdbsIKu5fMm4CD6r1EOzF5PeneoBpB/y4a4=;
        b=WdoFuibSoYq7PItUra7h1o7dNN+dLoO5akaOdiXzNB0GAE6fZrgXjLHEQ59DSfNlbF
         cgR9upm2UnMKp/K2iMTwYQO21eNLlcZA3VTjTQNcOKl6oB0YptTJSukTiMpZuSldqpht
         hT88zEf4E+gJCKG8bgBmZ3XtNmerD2XLEjORhA0Q/BXrUscdTef1dpRx9JDa6Bv504ko
         b2kwoYvEBcdXwhSFs2mCJx6XhNHoIVhKWvY4ugN0Krhnhx9JD7Gr1ZRwtzNsp6GxXu5W
         oQsFCmuvbtw0zcJ+Dg4t9K3RUmnMmVMxySl96IxGJYoNSUSPaDNY3cwVaR2TYMM/uF88
         /2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679648540;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n243IrPXTdbsIKu5fMm4CD6r1EOzF5PeneoBpB/y4a4=;
        b=sgcERwAQ6QUJA5b/tJCxO1zUHGax01bl8kaoX3PVaeGJP4PJ/Y2NpAjCpGix90/q4U
         AO4+S7A5P74/gEjMQ3HKkFzwy/6CyhywcqP6/qRQSplXrkcQ4cwoJE3LnHBnWbBJyNng
         TJzWg/o3CMWbQ8qd7RnK29WNAE6eeZy5Crh95LIWMb8dmdG1WZKR22I/NQLO+dxYYaUM
         4QlXlpS/kjGF9dN0SAGrx85u+6vlB+ag3H7mlPFuNshUNGW20CjqPumz6tQcTHzL0pzK
         Np7SftAjfmhFQzQrJh4waNuBvqppKZMiYIs8MndDnkn7NXDeCztnEAxNlo52DF/FPll5
         c4ZA==
X-Gm-Message-State: AAQBX9cENUqt3c57xekTLndBUXYizpnqI03V7vwECPC/PJmSjGO0H8XX
        IzqNqkwpSlSawwv05MSSejvz2Q==
X-Google-Smtp-Source: AKy350aF129LEbgPcrIERVDHzRV5kt9ClGRmiJzKHj2gDZXa1XzF6XQWfa0OQK6y0J9EwCOi2YJQVA==
X-Received: by 2002:a05:6000:1192:b0:2c7:17a4:4ece with SMTP id g18-20020a056000119200b002c717a44ecemr1496737wrx.26.1679648540094;
        Fri, 24 Mar 2023 02:02:20 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.152.149])
        by smtp.gmail.com with ESMTPSA id t6-20020adff606000000b002d828a9f9ddsm9869841wrp.115.2023.03.24.02.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 02:02:19 -0700 (PDT)
Message-ID: <43e7ef6d-6248-4ee5-7144-70809e5c93e0@linaro.org>
Date:   Fri, 24 Mar 2023 10:02:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v7 4/6] EISA: Convert to use less arguments in
 pci_bus_for_each_resource()
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
 <20230323173610.60442-5-andriy.shevchenko@linux.intel.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230323173610.60442-5-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 23/3/23 18:36, Andy Shevchenko wrote:
> The pci_bus_for_each_resource() can hide the iterator loop since
> it may be not used otherwise. With this, we may drop that iterator
> variable definition.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> ---
>   drivers/eisa/pci_eisa.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/eisa/pci_eisa.c b/drivers/eisa/pci_eisa.c

Since this is *PCI* EISA, could be squashed into previous patch.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

