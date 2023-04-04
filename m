Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B33C6FD1D
	for <sparclinux@archiver.kernel.org>; Tue,  4 Apr 2023 14:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbjDDOFd (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 4 Apr 2023 10:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbjDDOFa (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 4 Apr 2023 10:05:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95AF3C0F
        for <sparclinux@vger.kernel.org>; Tue,  4 Apr 2023 07:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680617026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+eiQuy0297qofRfcSxKqcQyipv7GSPC3sFo1rtx/hWs=;
        b=Hlufh4P1/Uv2Bqdme6Keb8/6GBcNyKI9QTQBniUO21558N2lIJSKKhtJEFZ8RJRmFssdOz
        rwmkrybLLvKiuwHcp6YNxamduU9HG5lH+1bVxyIVNQfpQMA1uOrHJPkf8IvP4ORBQIvUZL
        JSO/3X9wZbSyYYhyhkrVTPqpK4zQ0Yo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-l-Jjqsw6M8yrt5NxFvF7Eg-1; Tue, 04 Apr 2023 10:03:44 -0400
X-MC-Unique: l-Jjqsw6M8yrt5NxFvF7Eg-1
Received: by mail-wm1-f71.google.com with SMTP id m5-20020a05600c4f4500b003ee8db23ef9so17668097wmq.8
        for <sparclinux@vger.kernel.org>; Tue, 04 Apr 2023 07:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680617022;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+eiQuy0297qofRfcSxKqcQyipv7GSPC3sFo1rtx/hWs=;
        b=QHYfSHvTEUKdzjvdAmXlcDfI66VT4OhCKa/efe3bogFdDmOJIvKMqPOHnU2tQXtgA4
         NGIwGRip5YL1PuyzdpABpsRd7Mt7O3rJ8ThDj1UA2BMhBe+aiFZg3UJ8DziN2KlDzBJI
         UmOW+0NXygpQ1Gxpm0FGzJFQXUvlx1h1R4i197WnmbNNTSyFtTNxb3fPxtuVMhOtytN7
         nnlujInrjVsyqHhITdmgXElHC+8TYlEezqY+9xrgnSWFjLjSdySzXuG6dTVdxYAPgtVk
         zOPB51wNjadWL6cVvpT4S3g6Napd9Rza7Js6xxkMEgn0dVq0NUUCo3j8fv4RBlCG2O3j
         8ySg==
X-Gm-Message-State: AAQBX9d9AEsuXlmBFetYF+Hio8LW1uiIJJ01sKy8Tk6pIB6IaTMdmxd/
        MT0hfMErpfHy3RS3Jkrh/NwwgiujGIzhf1mah3S58YeOOYP0dgHmfnVvLtQ9rWDw+UVy2XxIMkS
        CavnTUiKfjgm9FUsaXfTpng==
X-Received: by 2002:a5d:6291:0:b0:2d6:5afe:7b99 with SMTP id k17-20020a5d6291000000b002d65afe7b99mr1501632wru.10.1680617021985;
        Tue, 04 Apr 2023 07:03:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZgF89ZubYczhCwXf0n6e5MiZ9Gbs+vNGbCQed6l+DJFU8EvLia/3dXAX7rxTgsIMUPc3yreQ==
X-Received: by 2002:a5d:6291:0:b0:2d6:5afe:7b99 with SMTP id k17-20020a5d6291000000b002d65afe7b99mr1501576wru.10.1680617021501;
        Tue, 04 Apr 2023 07:03:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:b600:e63:6c3b:7b5d:f439? (p200300cbc709b6000e636c3b7b5df439.dip0.t-ipconnect.de. [2003:cb:c709:b600:e63:6c3b:7b5d:f439])
        by smtp.gmail.com with ESMTPSA id i17-20020a5d5591000000b002eaac3a9beesm2694936wrv.8.2023.04.04.07.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 07:03:40 -0700 (PDT)
Message-ID: <d21bfe1d-46e6-5547-cdcb-0d851bf0834a@redhat.com>
Date:   Tue, 4 Apr 2023 16:03:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to CPUs in kernel mode
Content-Language: en-US
To:     Yair Podemsky <ypodemsk@redhat.com>, linux@armlinux.org.uk,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, peterz@infradead.org, arnd@arndb.de,
        keescook@chromium.org, paulmck@kernel.org, jpoimboe@kernel.org,
        samitolvanen@google.com, frederic@kernel.org, ardb@kernel.org,
        juerg.haefliger@canonical.com, rmk+kernel@armlinux.org.uk,
        geert+renesas@glider.be, tony@atomide.com,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com,
        nick.hawkins@hpe.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, mtosatti@redhat.com, vschneid@redhat.com,
        dhildenb@redhat.com
Cc:     alougovs@redhat.com
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230404134224.137038-4-ypodemsk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 04.04.23 15:42, Yair Podemsky wrote:
> The tlb_remove_table_smp_sync IPI is used to ensure the outdated tlb page
> is not currently being accessed and can be cleared.
> This occurs once all CPUs have left the lockless gup code section.
> If they reenter the page table walk, the pointers will be to the new
> pages.
> Therefore the IPI is only needed for CPUs in kernel mode.
> By preventing the IPI from being sent to CPUs not in kernel mode,
> Latencies are reduced.
> 
> Race conditions considerations:
> The context state check is vulnerable to race conditions between the
> moment the context state is read to when the IPI is sent (or not).
> 
> Here are these scenarios.
> case 1:
> CPU-A                                             CPU-B
> 
>                                                    state == CONTEXT_KERNEL
> int state = atomic_read(&ct->state);
>                                                    Kernel-exit:
>                                                    state == CONTEXT_USER
> if (state & CT_STATE_MASK == CONTEXT_KERNEL)
> 
> In this case, the IPI will be sent to CPU-B despite it is no longer in
> the kernel. The consequence of which would be an unnecessary IPI being
> handled by CPU-B, causing a reduction in latency.
> This would have been the case every time without this patch.
> 
> case 2:
> CPU-A                                             CPU-B
> 
> modify pagetables
> tlb_flush (memory barrier)
>                                                    state == CONTEXT_USER
> int state = atomic_read(&ct->state);
>                                                    Kernel-enter:
>                                                    state == CONTEXT_KERNEL
>                                                    READ(pagetable values)
> if (state & CT_STATE_MASK == CONTEXT_USER)
> 
> In this case, the IPI will not be sent to CPU-B despite it returning to
> the kernel and even reading the pagetable.
> However since this CPU-B has entered the pagetable after the
> modification it is reading the new, safe values.
> 
> The only case when this IPI is truly necessary is when CPU-B has entered
> the lockless gup code section before the pagetable modifications and
> has yet to exit them, in which case it is still in the kernel.
> 
> Signed-off-by: Yair Podemsky <ypodemsk@redhat.com>
> ---
>   mm/mmu_gather.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index 5ea9be6fb87c..731d955e152d 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -9,6 +9,7 @@
>   #include <linux/smp.h>
>   #include <linux/swap.h>
>   #include <linux/rmap.h>
> +#include <linux/context_tracking_state.h>
>   
>   #include <asm/pgalloc.h>
>   #include <asm/tlb.h>
> @@ -191,6 +192,20 @@ static void tlb_remove_table_smp_sync(void *arg)
>   	/* Simply deliver the interrupt */
>   }
>   
> +
> +#ifdef CONFIG_CONTEXT_TRACKING
> +static bool cpu_in_kernel(int cpu, void *info)
> +{
> +	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
> +	int state = atomic_read(&ct->state);
> +	/* will return true only for cpus in kernel space */
> +	return state & CT_STATE_MASK == CONTEXT_KERNEL;
> +}
> +#define CONTEXT_PREDICATE cpu_in_kernel
> +#else
> +#define CONTEXT_PREDICATE NULL
> +#endif /* CONFIG_CONTEXT_TRACKING */
> +
>   #ifdef CONFIG_ARCH_HAS_CPUMASK_BITS
>   #define REMOVE_TABLE_IPI_MASK mm_cpumask(mm)
>   #else
> @@ -206,8 +221,8 @@ void tlb_remove_table_sync_one(struct mm_struct *mm)
>   	 * It is however sufficient for software page-table walkers that rely on
>   	 * IRQ disabling.
>   	 */
> -	on_each_cpu_mask(REMOVE_TABLE_IPI_MASK, tlb_remove_table_smp_sync,
> -			NULL, true);
> +	on_each_cpu_cond_mask(CONTEXT_PREDICATE, tlb_remove_table_smp_sync,
> +			NULL, true, REMOVE_TABLE_IPI_MASK);
>   }
>   
>   static void tlb_remove_table_rcu(struct rcu_head *head)


Maybe a bit cleaner by avoiding CONTEXT_PREDICATE, still not completely nice
(an empty dummy function "cpu_maybe_in_kernel" might be cleanest but would
be slightly slower for !CONFIG_CONTEXT_TRACKING):

#ifdef CONFIG_CONTEXT_TRACKING
static bool cpu_in_kernel(int cpu, void *info)
{
	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
	int state = atomic_read(&ct->state);
	/* will return true only for cpus in kernel space */
	return state & CT_STATE_MASK == CONTEXT_KERNEL;
}
#endif /* CONFIG_CONTEXT_TRACKING */


...
#ifdef CONFIG_CONTEXT_TRACKING
	on_each_cpu_mask(REMOVE_TABLE_IPI_MASK, tlb_remove_table_smp_sync,
			 NULL, true);
#else /* CONFIG_CONTEXT_TRACKING */
	on_each_cpu_cond_mask(cpu_in_kernel, tlb_remove_table_smp_sync,
			      NULL, true, REMOVE_TABLE_IPI_MASK);
#endif /* CONFIG_CONTEXT_TRACKING */


-- 
Thanks,

David / dhildenb

