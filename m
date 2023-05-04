Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0FCC77B7C
	for <sparclinux@archiver.kernel.org>; Thu,  4 May 2023 22:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjEDWPC (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 4 May 2023 18:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjEDWPB (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 4 May 2023 18:15:01 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB86F120AB
        for <sparclinux@vger.kernel.org>; Thu,  4 May 2023 15:14:59 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64115eef620so15684576b3a.1
        for <sparclinux@vger.kernel.org>; Thu, 04 May 2023 15:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683238499; x=1685830499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOpu4K0AbTK/Q+LJp4KPhDC1e5615vKmnF8Avzjqp1E=;
        b=AtjVbUDuDhuC3T5VTZajscYw/VEjMbUiZ2X5khp5ctkS+27M1j/InYQ5Dwvm/plnmd
         krdbBv8nVdEof2X0yL/YrwWPzFZVjFX99rqofGl1oH4jqhbFnFmnoLtQFzOtxTTSUQ8z
         KlY7Tr7uge6pyOt+bCScYMrb0Elk2S6F8xzAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683238499; x=1685830499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOpu4K0AbTK/Q+LJp4KPhDC1e5615vKmnF8Avzjqp1E=;
        b=gyEahIZAFV81Vr79Jb87vE4Usy6C4TnQMcFqQFB31pvTQ9Hv2uzSSHqyP2Pwa0Kh6O
         /+aZ1jt+G7Hqtm5ZYNt4e+jMIsEiOmS4nQQThmaz6IT92O2ECcYxSuZBTXySs7YoCGEV
         OhHzCxvp5VuqQyXZZXDWN1cYxmzY8sQBvDlT1tAlI9lLPD+mwez6W3pi9mlxdKt+oTSB
         5JZo0LaJi3u/i1wqTzZPf2MQCHmCc+xVU8HNaA9lI7QdMwn1/pAlxKMnA8ONLlQfHYUE
         5htSeK4iKXHnh2fA6RcrVC9oXdFX4nZQnoysOwRNtkQYtO4S2OqHoWDPo9p0Af5Sjx1A
         0nzQ==
X-Gm-Message-State: AC+VfDzG8zJQfWlWkjLtSq+jv3P3xOYeM/eMMoQFHxP0FWmwMQnKThUc
        5AQ8GZvsS2zrkX9PzM8FwMRZTA==
X-Google-Smtp-Source: ACHHUZ6/nKe5trCUHnOhrXovtrUyQ0CQn+r16BvPpklIKc+6VPGovlM2nNhX9qvrY/8nVCSqNXN/Lw==
X-Received: by 2002:a05:6a00:8086:b0:634:c34f:e214 with SMTP id eh6-20020a056a00808600b00634c34fe214mr3971422pfb.10.1683238499411;
        Thu, 04 May 2023 15:14:59 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:edf0:7321:6b9e:d5e7])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7819a000000b006437c0edf9csm169615pfi.16.2023.05.04.15.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 15:14:58 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Stephen Boyd <swboyd@chromium.org>, ricardo.neri@intel.com,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wens@csie.org>, christophe.leroy@csgroup.eu,
        davem@davemloft.net, sparclinux@vger.kernel.org,
        mpe@ellerman.id.au, Will Deacon <will@kernel.org>,
        ravi.v.shankar@intel.com, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v4 05/17] watchdog/hardlockup: Rename touch_nmi_watchdog() to touch_hardlockup_watchdog()
Date:   Thu,  4 May 2023 15:13:37 -0700
Message-ID: <20230504151100.v4.5.I4e47cbfa1bb2ebbcdb5ca16817aa2887f15dc82c@changeid>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230504221349.1535669-1-dianders@chromium.org>
References: <20230504221349.1535669-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

In preparation for the buddy hardlockup detector, rename
touch_nmi_watchdog() to touch_hardlockup_watchdog() to make it clear
that it will touch whatever hardlockup detector is configured. We'll
add a #define for the old name (touch_nmi_watchdog) so that we don't
have to touch every piece of code referring to the old name.

Ideally this change would also rename the arch_touch_nmi_watchdog(),
but that is harder since arch_touch_nmi_watchdog() is exported with
EXPORT_SYMBOL() and thus is ABI. Add a comment next to the call to
hopefully alleviate some of the confusion here.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- ("Rename touch_nmi_watchdog() to ...") new for v4.

 include/linux/nmi.h | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 454fe99c4874..35d09d70f394 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -125,18 +125,35 @@ void watchdog_nmi_disable(unsigned int cpu);
 void lockup_detector_reconfigure(void);
 
 /**
- * touch_nmi_watchdog - restart NMI watchdog timeout.
+ * touch_hardlockup_watchdog - manually pet the hardlockup watchdog.
  *
- * If the architecture supports the NMI watchdog, touch_nmi_watchdog()
- * may be used to reset the timeout - for code which intentionally
- * disables interrupts for a long time. This call is stateless.
+ * If we support detecting hardlockups, touch_hardlockup_watchdog() may be
+ * used to pet the watchdog (reset the timeout) - for code which
+ * intentionally disables interrupts for a long time. This call is stateless.
  */
-static inline void touch_nmi_watchdog(void)
+static inline void touch_hardlockup_watchdog(void)
 {
+	/*
+	 * Pass on to the hardlockup detector selected via CONFIG_. Note that
+	 * the hardlockup detector may not be arch-specific nor using NMIs,
+	 * but arch_touch_nmi_watchdog() is exported with EXPORT_SYMBOL() and
+	 * is thus ABI.
+	 */
 	arch_touch_nmi_watchdog();
+
+	/*
+	 * Touching the hardlock detector implcitily pets the
+	 * softlockup detector too
+	 */
 	touch_softlockup_watchdog();
 }
 
+/*
+ * It's encouraged for code to refer to the new name, but allow the old
+ * name as well.
+ */
+#define touch_nmi_watchdog	touch_hardlockup_watchdog
+
 /*
  * Create trigger_all_cpu_backtrace() out of the arch-provided
  * base function. Return whether such support was available,
-- 
2.40.1.521.gf1e218fcd8-goog

