Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508B2C7619A
	for <sparclinux@archiver.kernel.org>; Wed,  5 Apr 2023 12:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbjDEMqF (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 5 Apr 2023 08:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbjDEMqB (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 5 Apr 2023 08:46:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412321BC5
        for <sparclinux@vger.kernel.org>; Wed,  5 Apr 2023 05:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680698711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rJlvbrDO3MZW25EtVUfp0HoO311UYJgGKtfX/KEqF/k=;
        b=GER116tgb+iYLrIT7d4YCy70CvkCC3ZTYBKLxajJxbZgXuyKM2JcZML6stGxqYHRr9T3HP
        v8nxW5K3mkeZs7BYaINTyAH6JCw+5alZIbchu93T79G7V2a+W0U8fV0muR1w1xJg8nfw83
        Gk8E7tl2N3FaU5OmliSluZx/6RQwOf8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-z0QbwX5QNqOKqQEIYcIwcQ-1; Wed, 05 Apr 2023 08:45:10 -0400
X-MC-Unique: z0QbwX5QNqOKqQEIYcIwcQ-1
Received: by mail-qv1-f70.google.com with SMTP id q1-20020ad44341000000b005a676b725a2so16119453qvs.18
        for <sparclinux@vger.kernel.org>; Wed, 05 Apr 2023 05:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680698710;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJlvbrDO3MZW25EtVUfp0HoO311UYJgGKtfX/KEqF/k=;
        b=b+eG/qFRtc23KmdysAnLKCrwHQlUetJnLVTvtq/8SdA8fCMh8aP3vGRGc4iZY7+9pz
         bPzf7SgH/yk6YzxuS+tXXIbKyF8Z05T6FiCsVqUpwttdezU5sRBGw+RCsGUVljUebYzR
         xR550e19Impj/ThOiaGd7QtR/2zPTaB5gPpE815beVZ3blgPdttzeaNKPwyHwTQJoxd4
         Bo8rV5pkvyltFjDPfsn1rcfBYO93fHwdpMIQhY6u5Q0aOQIcDIncaDHS5s8Y4zCNiFEU
         8hveqErlRIeUaJRvYwJVg53Fov/xzPIdzMc4Ebn8/h5BJ4kReBYjqEFm9lGhxsZgEYLu
         OzlQ==
X-Gm-Message-State: AAQBX9dIQUoNRH3xMoVqm4VXkA0cTmi47rG2I2Reg5d7PfvN0yAnEwBy
        rfZPl40dOXLg0ZWZPpKeJSgh6FmAMRxR0G+IzRZc4IkIKfyIJGnGaRWSdbtWywByaauz12rmpcR
        Hj/9vrf5gPf/FQfexzaRcow==
X-Received: by 2002:a05:622a:1716:b0:3e4:eb03:687d with SMTP id h22-20020a05622a171600b003e4eb03687dmr4303556qtk.44.1680698709736;
        Wed, 05 Apr 2023 05:45:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350YM3193lIgKl2aWj9mqpkVtYuh0l9dX5dcxwgxaNjVBgfvhxy0L8/57jtC9NbW/iCG3sMx10Q==
X-Received: by 2002:a05:622a:1716:b0:3e4:eb03:687d with SMTP id h22-20020a05622a171600b003e4eb03687dmr4303502qtk.44.1680698709447;
        Wed, 05 Apr 2023 05:45:09 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id t186-20020a37aac3000000b00746b7372d62sm4415939qke.27.2023.04.05.05.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 05:45:08 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Yair Podemsky <ypodemsk@redhat.com>, linux@armlinux.org.uk,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, arnd@arndb.de, keescook@chromium.org,
        paulmck@kernel.org, jpoimboe@kernel.org, samitolvanen@google.com,
        ardb@kernel.org, juerg.haefliger@canonical.com,
        rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        tony@atomide.com, linus.walleij@linaro.org,
        sebastian.reichel@collabora.com, nick.hawkins@hpe.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, mtosatti@redhat.com, dhildenb@redhat.com,
        alougovs@redhat.com
Subject: Re: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to CPUs in kernel mode
In-Reply-To: <ZC1j8ivE/kK7+Gd5@lothringen>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com>
 <ZC1Q7uX4rNLg3vEg@lothringen> <ZC1XD/sEJY+zRujE@lothringen>
 <20230405114148.GA351571@hirez.programming.kicks-ass.net>
 <ZC1j8ivE/kK7+Gd5@lothringen>
Date:   Wed, 05 Apr 2023 13:45:02 +0100
Message-ID: <xhsmhpm8ia46p.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 05/04/23 14:05, Frederic Weisbecker wrote:
>  static void smp_call_function_many_cond(const struct cpumask *mask,
>                                       smp_call_func_t func, void *info,
> @@ -946,10 +948,13 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
>  #endif
>                       cfd_seq_store(pcpu->seq_queue, this_cpu, cpu, CFD_SEQ_QUEUE);
>                       if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu))) {
> -				__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
> -				nr_cpus++;
> -				last_cpu = cpu;
> -
> +				if (!(scf_flags & SCF_NO_USER) ||
> +				    !IS_ENABLED(CONFIG_GENERIC_ENTRY) ||
> +				     ct_state_cpu(cpu) != CONTEXT_USER) {
> +					__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
> +					nr_cpus++;
> +					last_cpu = cpu;
> +				}

I've been hacking on something like this (CSD deferral for NOHZ-full),
and unfortunately this uses the CPU-local cfd_data storage thing, which
means any further smp_call_function() from the same CPU to the same
destination will spin on csd_lock_wait(), waiting for the target CPU to
come out of userspace and flush the queue - and we've just spent extra
effort into *not* disturbing it, so that'll take a while :(

I don't have much that is in a shareable state yet (though I'm supposed to
talk some more about it at OSPM in <2 weeks, so I'll have to get there),
but ATM I'm playing with
o a bitmask (like in [1]) for coalescable stuff such as do_sync_core() for
  x86 instruction patching
o a CSD-like queue for things that need to pass data around, using
  statically-allocated storage (so with a limit on how much it can be used) - the
  alternative being allocating a struct on sending, since you don't have a
  bound on how much crap you can queue on an undisturbed NOHZ-full CPU...

[1]: https://lore.kernel.org/all/20210929152429.067060646@infradead.org/

