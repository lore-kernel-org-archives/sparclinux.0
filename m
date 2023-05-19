Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5358DC7EE29
	for <sparclinux@archiver.kernel.org>; Fri, 19 May 2023 17:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjESRV1 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 19 May 2023 13:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjESRVE (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 19 May 2023 13:21:04 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B9018C
        for <sparclinux@vger.kernel.org>; Fri, 19 May 2023 10:20:59 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-25374c9be49so1402065a91.3
        for <sparclinux@vger.kernel.org>; Fri, 19 May 2023 10:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684516858; x=1687108858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnFfGU/I4XqnD3vR2plxo+ON4CdNtjzdhInwWKp0AYA=;
        b=lxH/4MUC2qjFAGmxlIf7xL66pYKuvfuFHFniVj+sFei0k520ZoJVIsJ2TuQTYRFKmU
         Kv7RzI/+zr61ZR632FK90CsTulb8O6mzHcizjQlqqXpquiqqpjeZ06rYt7ixiRLOzaPI
         g9JXyU6LG/ka08BvJnteCTM4hKwIRgOw+mRuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516858; x=1687108858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnFfGU/I4XqnD3vR2plxo+ON4CdNtjzdhInwWKp0AYA=;
        b=E/UpnvZSigwskOChMSQX0ahQA5lPT9yjb8n4Ece7yIMosL1GRVLiXO6XSIByiuef/6
         /5vG1ppJBtRUfZT+e/kZ/kwH+2SMNrRN6QXEp3YcsmVoQAIsdCW/69+gLTCzBprTlvxo
         5mHg6Ok90BWJGFnGDkKAWZr3GYZb1fySB94PzLjQUiAMFCOXdiKULW4vSSuOAfgnnBnM
         tsyrVSeDi47KO/p4xW9tGK8MERmoSshh9x9Yz4IE+6mLzCkIivhM1rn3CiC6ZM+e3Pwm
         OoWQEbwbSijvb1OYWX3rudAxgsVV79WofHhjWxti/3KjChyCgc2pFC54U2sURp9EwtKX
         EtEQ==
X-Gm-Message-State: AC+VfDyTllFhRvPXACbiboPHk36YQZg+ct9GLyy4o1GNxVLUEh3JNq+c
        IVbimA/A3Y57S39BoV2vKwY+Wg==
X-Google-Smtp-Source: ACHHUZ6fm8nmFPR/13lOFlRmyTFHqJAlM+nr9rZSbMpGPC09DnlecDv3KY2MaywK0HIZmVs5jnrdNw==
X-Received: by 2002:a17:90a:2a42:b0:252:e7db:66df with SMTP id d2-20020a17090a2a4200b00252e7db66dfmr2384233pjg.49.1684516858651;
        Fri, 19 May 2023 10:20:58 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9b89:2dd0:d160:429d])
        by smtp.gmail.com with ESMTPSA id gj19-20020a17090b109300b0024e4f169931sm1763835pjb.2.2023.05.19.10.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:20:57 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephane Eranian <eranian@google.com>, mpe@ellerman.id.au,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev@lists.ozlabs.org, Sumit Garg <sumit.garg@linaro.org>,
        npiggin@gmail.com, davem@davemloft.net,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, sparclinux@vger.kernel.org,
        christophe.leroy@csgroup.eu,
        Catalin Marinas <catalin.marinas@arm.com>,
        ravi.v.shankar@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Ian Rogers <irogers@google.com>, ito-yuichi@fujitsu.com,
        ricardo.neri@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v5 07/18] watchdog/perf: Rename watchdog_hld.c to watchdog_perf.c
Date:   Fri, 19 May 2023 10:18:31 -0700
Message-ID: <20230519101840.v5.7.Ice803cb078d0e15fb2cbf49132f096ee2bd4199d@changeid>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

The code currently in "watchdog_hld.c" is for detecting hardlockups
using perf, as evidenced by the line in the Makefile that only
compiles this file if CONFIG_HARDLOCKUP_DETECTOR_PERF is
defined. Rename the file to prepare for the buddy hardlockup detector,
which doesn't use perf.

It could be argued that the new name makes it less obvious that this
is a hardlockup detector. While true, it's not hard to remember that
the "perf" detector is always a hardlockup detector and it's nice not
to have names that are too convoluted.

Acked-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v4)

Changes in v4:
- ("Rename watchdog_hld.c to watchdog_perf.c") new for v4.

 kernel/Makefile                            | 2 +-
 kernel/{watchdog_hld.c => watchdog_perf.c} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename kernel/{watchdog_hld.c => watchdog_perf.c} (99%)

diff --git a/kernel/Makefile b/kernel/Makefile
index b69c95315480..7eb72033143c 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -91,7 +91,7 @@ obj-$(CONFIG_FAIL_FUNCTION) += fail_function.o
 obj-$(CONFIG_KGDB) += debug/
 obj-$(CONFIG_DETECT_HUNG_TASK) += hung_task.o
 obj-$(CONFIG_LOCKUP_DETECTOR) += watchdog.o
-obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF) += watchdog_hld.o
+obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF) += watchdog_perf.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RELAY) += relay.o
 obj-$(CONFIG_SYSCTL) += utsname_sysctl.o
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_perf.c
similarity index 99%
rename from kernel/watchdog_hld.c
rename to kernel/watchdog_perf.c
index 2125b09e09d7..8b8015758ea5 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_perf.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Detect hard lockups on a system
+ * Detect hard lockups on a system using perf
  *
  * started by Don Zickus, Copyright (C) 2010 Red Hat, Inc.
  *
-- 
2.40.1.698.g37aff9b760-goog

