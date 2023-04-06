Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A7EC76196
	for <sparclinux@archiver.kernel.org>; Thu,  6 Apr 2023 14:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjDFON0 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 6 Apr 2023 10:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238927AbjDFONO (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 6 Apr 2023 10:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C5FA277
        for <sparclinux@vger.kernel.org>; Thu,  6 Apr 2023 07:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680790321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oy2QomrGUBDfWG7234e6lYS9Z4zzgLJXtJtCEsgjhmY=;
        b=aZhN1NC/iWWs/nmzETinltHhAezLhQDbgIzpvQxSWycMVSuxgGVvVcvmNr6gV/6TrwKrlR
        H/UpujZANJOXhiL0pyb+Jdl+gBaLUXFN3Vxuybe0NgK7HVpfqujLcfvS3Ryp88SzLPd/ho
        AL6MENLq53/v3AJTB/yPGoHczRXQdj0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-WfURSqD_Ok21xxzAajBKBQ-1; Thu, 06 Apr 2023 10:12:00 -0400
X-MC-Unique: WfURSqD_Ok21xxzAajBKBQ-1
Received: by mail-qv1-f71.google.com with SMTP id g6-20020ad45426000000b005a33510e95aso18008275qvt.16
        for <sparclinux@vger.kernel.org>; Thu, 06 Apr 2023 07:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680790320; x=1683382320;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oy2QomrGUBDfWG7234e6lYS9Z4zzgLJXtJtCEsgjhmY=;
        b=6Cg5gIQFahhVEoro1mQRNdMFnXspa7psfkgmhbrTVTSWALtqSZ0wjrQ0mCbFbVmJd0
         OOzaOHtTa6gyIur1wCFdSLvwtu5tcJbByiMEXzDJgc+Q59DTF9QpxtNX31BRpR1SZfUY
         NBeufzJmlnxe5Ho4i4EhQnxnidkYvZcvKYwpkrt4Ho3kcz8soR0DncG4/yD6HpCEA/VQ
         WrQFN3w/KLlTBt+o8YWhypeMglMtjv4uVmAeCYjSX8Lj1cS4/kf2kij6tGyrr7bIWwvC
         mtzH3x2Q3d+pTzrHxKuazxy81XTuTyoHmBePSSGeaS2XbmHaEXfJbS06wc1SuxfmAwpp
         U0mQ==
X-Gm-Message-State: AAQBX9fZLRv/AW7I+veHN6ALw7hrCVigA27k+kiic0QNhRuRSuX+UWsK
        WiyXzF45BmQITHJnCmb2mxvFxpOwUw2fxYuIPh64yWAHFNc6JFo0HfMmWzoNw6uKKzHmjmX+ScF
        G8DKbbe30dxunE69xcqJGOA==
X-Received: by 2002:a05:6214:c21:b0:5a2:e3e4:59b0 with SMTP id a1-20020a0562140c2100b005a2e3e459b0mr4151658qvd.44.1680790319567;
        Thu, 06 Apr 2023 07:11:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350YdFg9Rpod34ylmYUyAnCfxfiKdtnShPJSS+THNG9On45kotrwTmF6ARLq441OR3LQJbmn9Kg==
X-Received: by 2002:a05:6214:c21:b0:5a2:e3e4:59b0 with SMTP id a1-20020a0562140c2100b005a2e3e459b0mr4151612qvd.44.1680790319253;
        Thu, 06 Apr 2023 07:11:59 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id d11-20020a0cf6cb000000b005dd8b9345f4sm514523qvo.140.2023.04.06.07.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:11:58 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Yair Podemsky <ypodemsk@redhat.com>, linux@armlinux.org.uk,
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
In-Reply-To: <20230406133805.GO386572@hirez.programming.kicks-ass.net>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com>
 <ZC1Q7uX4rNLg3vEg@lothringen> <ZC1XD/sEJY+zRujE@lothringen>
 <20230405114148.GA351571@hirez.programming.kicks-ass.net>
 <ZC1j8ivE/kK7+Gd5@lothringen> <xhsmhpm8ia46p.mognet@vschneid.remote.csb>
 <20230406133805.GO386572@hirez.programming.kicks-ass.net>
Date:   Thu, 06 Apr 2023 15:11:52 +0100
Message-ID: <xhsmh8rf59k2f.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 06/04/23 15:38, Peter Zijlstra wrote:
> On Wed, Apr 05, 2023 at 01:45:02PM +0100, Valentin Schneider wrote:
>>
>> I've been hacking on something like this (CSD deferral for NOHZ-full),
>> and unfortunately this uses the CPU-local cfd_data storage thing, which
>> means any further smp_call_function() from the same CPU to the same
>> destination will spin on csd_lock_wait(), waiting for the target CPU to
>> come out of userspace and flush the queue - and we've just spent extra
>> effort into *not* disturbing it, so that'll take a while :(
>
> I'm not sure I buy into deferring stuff.. a NOHZ_FULL cpu might 'never'
> come back. Queueing data just in case it does seems wasteful.

Putting those callbacks straight into the bin would make my life much
easier!

Unfortunately, even if they really should, I don't believe all of the
things being crammed onto NOHZ_FULL CPUs have the same definition of
'never' as we do :/

