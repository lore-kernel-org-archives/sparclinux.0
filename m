Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D54AC433F5
	for <sparclinux@archiver.kernel.org>; Thu, 29 Sep 2022 17:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbiI2Rcq (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 29 Sep 2022 13:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbiI2Rcp (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 29 Sep 2022 13:32:45 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F2B1F1E8D
        for <sparclinux@vger.kernel.org>; Thu, 29 Sep 2022 10:32:45 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id 8-20020a17090a0b8800b00205d8564b11so1980263pjr.5
        for <sparclinux@vger.kernel.org>; Thu, 29 Sep 2022 10:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WsPD8OiBsvjkVKcAs/WPDOcqgeN0W8DkJr3UcGrsUFA=;
        b=RV+HocxLFsLRry1I+aRLdKeC7EldCrfp2VQCMLg1VWjH9U97azRhEDVoxxf2UEWEFF
         OXyrMp/C5QPIzMJCf0eft4urK5HS9QJuYcjFeTAl+wnETsNAMHN6bE5BfcJ4zFe7Sihc
         XL+zdeBN9Bglgl6WJ2bWhBqufLqg880HFPoaOOMigjBgrAmaySyGNS9Cr+ooAU3S/de+
         SXCp3HPWyBy05Vde5tTf9emCFfN2fPC9pYXCbUuG2hI1VXDF/xR39dLlv+5pZwvK3aHi
         68zTNXCGzZ6FYhTxijAOfuPUMHCIkHZ9b4F7x110XQKq3gpdh44p+cLq0ZPVZ6tF1Adf
         Irdg==
X-Gm-Message-State: ACrzQf0HfsvCsc6td8Z5f278O4Y9jL7ExB6rZOSwyrJ8MzqrF+/qazII
        KGnooGRjup/zGyRYSmn71dw=
X-Google-Smtp-Source: AMsMyM4Ac/nZJNFUyCcw9/xd0GtCiPpSKp0b3QTq7vi0QJMYCjKX21QHqw3J/xzOMTH21QXkv5ts7w==
X-Received: by 2002:a17:90b:3e8c:b0:202:c7b1:b20b with SMTP id rj12-20020a17090b3e8c00b00202c7b1b20bmr4784725pjb.54.1664472764516;
        Thu, 29 Sep 2022 10:32:44 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:2e63:ed10:2841:950e? ([2620:15c:211:201:2e63:ed10:2841:950e])
        by smtp.gmail.com with ESMTPSA id m10-20020a17090a668a00b00203ab277966sm3790630pjj.7.2022.09.29.10.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 10:32:43 -0700 (PDT)
Message-ID: <1e7f849c-a951-d1bf-7ee8-b4c9088b5141@acm.org>
Date:   Thu, 29 Sep 2022 10:32:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] sparc: Unbreak the build
Content-Language: en-US
To:     "David S . Miller" <davem@davemloft.net>
Cc:     Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220830205854.1918026-1-bvanassche@acm.org>
 <22d99fab-bfa2-5001-8ef1-a4900056f0c4@gaisler.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <22d99fab-bfa2-5001-8ef1-a4900056f0c4@gaisler.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 9/9/22 08:28, Andreas Larsson wrote:
> On 2022-08-30 22:58, Bart Van Assche wrote:
>> Fix the following build errors:
>>
>> arch/sparc/mm/srmmu.c: In function ‘smp_flush_page_for_dma’:
>> arch/sparc/mm/srmmu.c:1639:13: error: cast between incompatible function types from ‘void (*)(long unsigned int)’ to ‘void (*)(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)’ [-Werror=cast-function-type]
>>   1639 |         xc1((smpfunc_t) local_ops->page_for_dma, page);
>>        |             ^
>> arch/sparc/mm/srmmu.c: In function ‘smp_flush_cache_mm’:
>> arch/sparc/mm/srmmu.c:1662:29: error: cast between incompatible function types from ‘void (*)(struct mm_struct *)’ to ‘void (*)(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)’ [-Werror=cast-function-type]
>>   1662 |                         xc1((smpfunc_t) local_ops->cache_mm, (unsigned long) mm);
>>        |
>> [ ... ]
>>
>> Compile-tested only.
>>
>> Fixes: 552a23a0e5d0 ("Makefile: Enable -Wcast-function-type")
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> 
> Tested-by: Andreas Larsson <andreas@gaisler.com>

Hi Dave,

Did I send this patch to the right maintainer? I sent this patch to you
because I found the following in the MAINTAINERS file:

SPARC + UltraSPARC (sparc/sparc64)
M:      "David S. Miller" <davem@davemloft.net>
L:      sparclinux@vger.kernel.org
S:      Maintained
Q:      http://patchwork.ozlabs.org/project/sparclinux/list/
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next.git
F:      arch/sparc/
F:      drivers/sbus/

In case this patch wouldn't be in your inbox anymore, it is available here:
https://lore.kernel.org/all/20220830205854.1918026-1-bvanassche@acm.org/

Thanks,

Bart.


