Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46FFC4321E
	for <sparclinux@archiver.kernel.org>; Wed,  2 Nov 2022 18:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiKBSfH (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 2 Nov 2022 14:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiKBSfG (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 2 Nov 2022 14:35:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB052FFD8
        for <sparclinux@vger.kernel.org>; Wed,  2 Nov 2022 11:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667414050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iOwZQK5qeETgL3wqlfHaHMAHqEn7+FhbLCJ4P7hdM2o=;
        b=AUtQ+S2xKMYXFQEbsiHOvNjJXSAp6C37S2qBKL7jBd6FLIOpe3Xpt8EOwn/MapnpV3KoGz
        wbp6F+nAso5uk7/tw/VzoSJN7NxnhOaLf9HvG7tmiP/32Q19yvivHxinRAU1iXTZQQa7ec
        EMgEsC0oM4WfuN/164eFobDdbhHvEtg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-263-EdyqfvREPg-5HCNV7ZnAWA-1; Wed, 02 Nov 2022 14:34:09 -0400
X-MC-Unique: EdyqfvREPg-5HCNV7ZnAWA-1
Received: by mail-qv1-f70.google.com with SMTP id ng1-20020a0562143bc100b004bb706b3a27so10558380qvb.20
        for <sparclinux@vger.kernel.org>; Wed, 02 Nov 2022 11:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOwZQK5qeETgL3wqlfHaHMAHqEn7+FhbLCJ4P7hdM2o=;
        b=hX4HvlIC8VMBgcnx5aJfnAqd9rhPwA8bcVW7FLtfH9sUPI/61yjKpLS6OmfQuikpR1
         HZUj9TdDu2pRwcBs8d1I3AqbPVFI3RSk3pbJyKwvTnlaoRCFxhXdZZoYQQFErrabUBWT
         7nnIOgTuGknngHSbou3V+JAIakK1mfRumUcJW7cVD6spCvX1LQb7nxO6apoQJNtxEPwb
         IHNPzaUYwIsTi3tpEqcsg0F75iNPaxqQa9hAvn68i8GT7pEC0KGpDGKr97ah8IcGMdLg
         2q+eqCLmsF/AubIm3sH8ueWf6wX1JfD5D31/ihk6QCcjnJjp7l18yIp6yi2nKkgd3lW8
         NQUg==
X-Gm-Message-State: ACrzQf1Sbv2btbioX4tvrlHP0bhbHxk5ZOP4cS7aNnZ1jIxrtJSUPeKf
        9X9Scg/Ye0mGfS35C2x4fkq7mXmEHpWVPJheLC8Za2KgsDfTSx0W4MnFIfvUzVArwzAiTc0OrZZ
        KMqvZSPm2rnndt+TaFaibwQ==
X-Received: by 2002:a05:622a:183:b0:3a5:4255:a0fe with SMTP id s3-20020a05622a018300b003a54255a0femr5122040qtw.441.1667414048631;
        Wed, 02 Nov 2022 11:34:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM513iTu4ts5GTQjgBcRtTQiZ5hV5vnGyMiejNr5eqgULDfvGkfyMfW7xqa9AO3zDpp+iTddyQ==
X-Received: by 2002:a05:622a:183:b0:3a5:4255:a0fe with SMTP id s3-20020a05622a018300b003a54255a0femr5122009qtw.441.1667414048423;
        Wed, 02 Nov 2022 11:34:08 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id w187-20020a3794c4000000b006eed47a1a1esm8757820qkd.134.2022.11.02.11.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:34:06 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFC PATCH v2 2/8] trace: Add trace_ipi_send_cpumask()
Date:   Wed,  2 Nov 2022 18:33:30 +0000
Message-Id: <20221102183336.3120536-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221102182949.3119584-1-vschneid@redhat.com>
References: <20221102182949.3119584-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

trace_ipi_raise() is unsuitable for generically tracing IPI sources due to
its "reason" argument being an uninformative string (on arm64 all you get
is "Function call interrupts" for SMP calls).

Add a variant of it that takes a exports a target CPU, a callsite and a
callback.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/trace/events/ipi.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/trace/events/ipi.h b/include/trace/events/ipi.h
index 0be71dad6ec03..b1125dc27682c 100644
--- a/include/trace/events/ipi.h
+++ b/include/trace/events/ipi.h
@@ -35,6 +35,28 @@ TRACE_EVENT(ipi_raise,
 	TP_printk("target_mask=%s (%s)", __get_bitmask(target_cpus), __entry->reason)
 );
 
+TRACE_EVENT(ipi_send_cpumask,
+
+	TP_PROTO(const struct cpumask *cpumask, unsigned long callsite, void *callback),
+
+	TP_ARGS(cpumask, callsite, callback),
+
+	TP_STRUCT__entry(
+		__cpumask(cpumask)
+		__field(void *, callsite)
+		__field(void *, callback)
+	),
+
+	TP_fast_assign(
+		__assign_cpumask(cpumask, cpumask_bits(cpumask));
+		__entry->callsite = (void *)callsite;
+		__entry->callback = callback;
+	),
+
+	TP_printk("cpumask=%s callsite=%pS callback=%pS",
+		  __get_cpumask(cpumask), __entry->callsite, __entry->callback)
+);
+
 DECLARE_EVENT_CLASS(ipi_handler,
 
 	TP_PROTO(const char *reason),
-- 
2.31.1

