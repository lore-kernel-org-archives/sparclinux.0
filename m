Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54706C48BCF
	for <sparclinux@archiver.kernel.org>; Wed,  9 Jun 2021 10:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3619D61287
	for <sparclinux@archiver.kernel.org>; Wed,  9 Jun 2021 10:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237673AbhFIKzo (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 9 Jun 2021 06:55:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45719 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236081AbhFIKzj (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 9 Jun 2021 06:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623236025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBWPCdmnHsH7qQGe81DFl3a6ru5xcOhjproglm1WObM=;
        b=SedtYsjxMaQhR5CjOgiuDrw3GNR9NX1oTbZoGNgWb2don5i1RYydwOFlk+tI7be5H3TtRe
        zDBvF9y4X6YwLGqksExPQxck41D7b5v5j/x7NYGOHvgcjH924LEb8B4Edd/I9hALknW3u/
        yAY7bEOaWjuQkG+9FMGH+u33d7Xwxe8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-blcqFmVaP0GXC1W8DNjYWQ-1; Wed, 09 Jun 2021 06:53:44 -0400
X-MC-Unique: blcqFmVaP0GXC1W8DNjYWQ-1
Received: by mail-wm1-f71.google.com with SMTP id w3-20020a1cf6030000b0290195fd5fd0f2so1802432wmc.4
        for <sparclinux@vger.kernel.org>; Wed, 09 Jun 2021 03:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JBWPCdmnHsH7qQGe81DFl3a6ru5xcOhjproglm1WObM=;
        b=Yeli3k1A2SZSBhAm6GLutwROYHVQsotbXH4OxDWMmwDtnuTUFLG1bO+oGlTz/pQeKw
         jwK7KLl56Oc5vFNv7J5z8AfBuqmIEk+pLKM8B3e33HrwoKMLqypXKq5zzNQvYrzsXaKo
         cIDV5bfACB1XXmR00jusEIQmm6EHWIQ8kIM+Om1tCEw6LmTsLR7sZRNHy2EUNAPyw7cn
         5CvUahEJyoYkPEA0+7ESUx4behioR8DSGPDXLXf2QQvZFmj+oezu8DRfsHbDCODRouJG
         kHaIHA9G3OhSBEV1efJHSs/3FUzMvonYCT/3w/Ihase1YcfKiZVDLF/cNupyhzWIvyYh
         yybw==
X-Gm-Message-State: AOAM533b7s1cuC9WLNypfHgWA8KMkLMBK658hw4nRqSIN0Gt2b0MgLat
        cRNV0U2Ld7rTl4YRT6C2KEQE7/1TimV9MT1MXlBx3pewJG3W+F+9LqaiqfeAY1gH+hQWuTGbp4j
        /PPd5usTDGDFhfEZL1S0496ckRM4U3b6TD+HYtEoj+bN1kvjb3WEyLpmuyasVkuJOJUuBuA==
X-Received: by 2002:a05:600c:b50:: with SMTP id k16mr26766732wmr.137.1623236022839;
        Wed, 09 Jun 2021 03:53:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytaUEoH1yZlmOCQRNfd+wo+CI/GKYwuDVo1xp/A/CuJsfRh3qeLKHuz3pPcIzWarSKIwDzSA==
X-Received: by 2002:a05:600c:b50:: with SMTP id k16mr26766696wmr.137.1623236022628;
        Wed, 09 Jun 2021 03:53:42 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c611d.dip0.t-ipconnect.de. [91.12.97.29])
        by smtp.gmail.com with ESMTPSA id v15sm1695174wrw.24.2021.06.09.03.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 03:53:42 -0700 (PDT)
Subject: Re: [PATCH 3/9] arc: remove support for DISCONTIGMEM
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Vineet Gupta <vgupta@synopsys.com>, kexec@lists.infradead.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
References: <20210602105348.13387-1-rppt@kernel.org>
 <20210602105348.13387-4-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <e9ef94f5-02bc-920b-9e6a-2d234e5bbbc5@redhat.com>
Date:   Wed, 9 Jun 2021 12:53:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602105348.13387-4-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 02.06.21 12:53, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> DISCONTIGMEM was replaced by FLATMEM with freeing of the unused memory map
> in v5.11.
> 
> Remove the support for DISCONTIGMEM entirely.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

