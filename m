Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46E3C636CC
	for <sparclinux@archiver.kernel.org>; Wed,  8 Feb 2023 14:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjBHON6 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 8 Feb 2023 09:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjBHONr (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 8 Feb 2023 09:13:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E4045F74
        for <sparclinux@vger.kernel.org>; Wed,  8 Feb 2023 06:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675865534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MVdXAMmBKMdGVdB031db9qoOwXwbq1WnNqDyKF+cm50=;
        b=CPO++j16ssfrygSjiUWHVjcqYqmvbD4z6se3E9WBVNebAjxGY1FguXmFm5iSVHj+2J4xB+
        tu8Iv9zAmozBbHF0yF5x+F5/ThEUBrQ91arhLNE1whzoGTCaGDKa+Jc6u5AVzErrHQI4MG
        fFcxjU+ewh5PJKx7nEQ+CkGTyzPwZwg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-347-bnYLz8zJN42PLPqGt3cjEQ-1; Wed, 08 Feb 2023 09:12:12 -0500
X-MC-Unique: bnYLz8zJN42PLPqGt3cjEQ-1
Received: by mail-wm1-f72.google.com with SMTP id p14-20020a05600c468e00b003e0107732f4so3063016wmo.1
        for <sparclinux@vger.kernel.org>; Wed, 08 Feb 2023 06:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVdXAMmBKMdGVdB031db9qoOwXwbq1WnNqDyKF+cm50=;
        b=bAKaABwhF+zblcrxr87ol6Vtnihzs/MqPsefA72Pyg68k7FJ44phhydYUL9UDVU9ew
         O8J/iKx9vWtmaKuva//coW4tGn3APtygBbEcBpjq1yZ/K/tVjJMZZtRvli6srm2LF9SH
         /kaaSK12IDPv+fHHIoK7QglnnXSQt9ELLW0gstJmybj6acn/z0Dd5z+M5OfBatrChtAQ
         AUTdaQwHYHfNckK2XM6Q85EaLymornt1R2Dstqb+ZVCt6UijOk92NZi5bOOXZ7cHA8gS
         Qg6cVqcy1eq7A8BqAGhhY1oo2qNCGQ89yThL9mi83J5SXiTyjJ2BSn6pAYJVHl42qxjc
         QsfA==
X-Gm-Message-State: AO0yUKUNDD7uBm9h854LDF2VSKgph5VUlevuJtjzWnQNdPe9o5KH6Fg6
        0dAsxWf6cULVl6xjcTxIESCYWXlLe0M1awJ81XX2MrdH/tai023WhdeB3Fh75uaIJHazqEC822/
        zDpDUjcSDHE2GVmvVY4uHVA==
X-Received: by 2002:a05:600c:2ac8:b0:3d9:fb59:c16b with SMTP id t8-20020a05600c2ac800b003d9fb59c16bmr6807550wme.36.1675865529922;
        Wed, 08 Feb 2023 06:12:09 -0800 (PST)
X-Google-Smtp-Source: AK7set9buY9+5cxJmjHAU1gwkYhkjh45ggBfiU2I1/g0SGqFxOSQ99Rkm86npGHpTIA79oxlUNrbqQ==
X-Received: by 2002:a05:600c:2ac8:b0:3d9:fb59:c16b with SMTP id t8-20020a05600c2ac800b003d9fb59c16bmr6807491wme.36.1675865529588;
        Wed, 08 Feb 2023 06:12:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:b300:758c:6214:cd51:8ab0? (p200300cbc704b300758c6214cd518ab0.dip0.t-ipconnect.de. [2003:cb:c704:b300:758c:6214:cd51:8ab0])
        by smtp.gmail.com with ESMTPSA id a3-20020a05600c224300b003db01178b62sm2066527wmm.40.2023.02.08.06.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 06:12:08 -0800 (PST)
Message-ID: <39fd91e3-c93b-23c6-afc6-cbe473bb0ca9@redhat.com>
Date:   Wed, 8 Feb 2023 15:12:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        Russell King <linux@armlinux.org.uk>
References: <20230113171026.582290-1-david@redhat.com>
 <20230113171026.582290-5-david@redhat.com> <Y+GcDFMNHw2cdDN1@sirena.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH mm-unstable v1 04/26] arm/mm: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
In-Reply-To: <Y+GcDFMNHw2cdDN1@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 07.02.23 01:32, Mark Brown wrote:
> On Fri, Jan 13, 2023 at 06:10:04PM +0100, David Hildenbrand wrote:
>> Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE by stealing one bit from the
>> offset. This reduces the maximum swap space per file to 64 GiB (was 128
>> GiB).
>>
>> While at it drop the PTE_TYPE_FAULT from __swp_entry_to_pte() which is
>> defined to be 0 and is rather confusing because we should be dealing
>> with "Linux PTEs" not "hardware PTEs". Also, properly mask the type in
>> __swp_entry().
> 
> Today's -next (and at least back to Friday, older logs are unclear - I
> only noticed -next issues today) fails to NFS boot on an AT91SAM9G20-EK
> (an old ARMv5 platform) with multi_v5_defconfig, a bisect appears to
> point to this patch (20aae9eff5acd8f5 in today's -next) as the culprit.

It's been in -next for quite a while, thanks for the report!

> 
> The failure happens at some point after starting userspace, the kernel
> starts spamming the console with messages in the form:
> 
>      get_swap_device: Bad swap file entry 10120d20
> 

_swap_info_get() tells us that the swp type seems to be bad.
I assume we're dealing with a migration entry, if swap is disabled, and fail to
detect is_migration_entry() correctly because the type is messed up.

Could you give the following a test?


 From 8c4bdbd9862f85782d5919d044c172b584063e83 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 8 Feb 2023 15:08:01 +0100
Subject: [PATCH] arm/mm: Fix swp type masking in __swp_entry()

We're masking with the number of type bits instead of the type mask, which
is obviously wrong.

Fixes: 20aae9eff5ac ("arm/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE")
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
  arch/arm/include/asm/pgtable.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 2e626e6da9a3..a58ccbb406ad 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -292,7 +292,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
  
  #define __swp_type(x)		(((x).val >> __SWP_TYPE_SHIFT) & __SWP_TYPE_MASK)
  #define __swp_offset(x)		((x).val >> __SWP_OFFSET_SHIFT)
-#define __swp_entry(type, offset) ((swp_entry_t) { (((type) & __SWP_TYPE_BITS) << __SWP_TYPE_SHIFT) | \
+#define __swp_entry(type, offset) ((swp_entry_t) { (((type) & __SWP_TYPE_MASK) << __SWP_TYPE_SHIFT) | \
  						   ((offset) << __SWP_OFFSET_SHIFT) })
  
  #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
-- 
2.39.1


-- 
Thanks,

David / dhildenb

