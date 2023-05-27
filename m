Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95EBC7EE2E
	for <sparclinux@archiver.kernel.org>; Sat, 27 May 2023 01:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbjE0BnC (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 26 May 2023 21:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238078AbjE0Bmy (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 26 May 2023 21:42:54 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D0AE78
        for <sparclinux@vger.kernel.org>; Fri, 26 May 2023 18:42:34 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d4e45971bso1117180b3a.2
        for <sparclinux@vger.kernel.org>; Fri, 26 May 2023 18:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685151754; x=1687743754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxNnTqvzGhDuJSCmbsa+rtoHfqlXA4TJSz9TjwxMeho=;
        b=ShJfBqA9ft7ncDs0dOFd2RPnmhJyBiEjNx2LZ1p8J3ek51VUldJqNKK6EfAx/6LMhv
         I51cZ9p9OhuJ3HYRQJPDRwiiLTttUI75WZhav7nrw8b5x+FhEcc5+eyfOPfL9y63jllh
         02RO3yac0QfbIeTbVj1CHjUWHigjgjdAjKjnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685151754; x=1687743754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxNnTqvzGhDuJSCmbsa+rtoHfqlXA4TJSz9TjwxMeho=;
        b=jTikNOdexT8Ps6TXGSuApgkB5RwJKUzg0DYujBjorkfVu8GCo2GSyacJUe8/nmPJYh
         r7it0ywAbOA4wpkQaqdRJhJUQB7t08mJz426ak2n7PNij0E4BJK0ESGaavebxPQBe2zK
         45bpURniaaYkyK2PyzQEVtMeQnLa+JsUyiOoW8ULPZfnCIHIh02mGLp7k08haUyFatdD
         yNmRi1Oo5EOaIPhS8YU+POH56ECsyfTAzOGX3Ow40eZzml8faQcNiUPeEqIvvBvOZetZ
         V2AI8RYMvkZ8ag3v0wNc3sdKjxBA0iDyFAiKn/zz0LHyuaTYpsar+tAM8LkyazTeflod
         DMtQ==
X-Gm-Message-State: AC+VfDwUC4uTS4/YNCmmgL9PDr4rAkslbM25iCy7VBnoSjBaowRglkSO
        62WlxQdwY65GU4P7EHsscYuN1g==
X-Google-Smtp-Source: ACHHUZ44oKfcxHCQB35NN8gNpgRMYCCD+rINnjdYYnIa0h9+Lp5g65zql8hV6FRXqlU+zWxTf6WHVg==
X-Received: by 2002:a05:6a00:3911:b0:63b:7fc0:a4af with SMTP id fh17-20020a056a00391100b0063b7fc0a4afmr5852154pfb.26.1685151753915;
        Fri, 26 May 2023 18:42:33 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4015:7255:c79a:26d7])
        by smtp.gmail.com with ESMTPSA id x25-20020aa79199000000b0063b8ddf77f7sm3202440pfa.211.2023.05.26.18.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 18:42:33 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 10/10] watchdog/hardlockup: Rename HAVE_HARDLOCKUP_DETECTOR_NON_ARCH to ..._PERF_OR_BUDDY
Date:   Fri, 26 May 2023 18:41:40 -0700
Message-ID: <20230526184139.10.I821fe7609e57608913fe05abd8f35b343e7a9aae@changeid>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To: <20230527014153.2793931-1-dianders@chromium.org>
References: <20230527014153.2793931-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

HAVE_HARDLOCKUP_DETECTOR_NON_ARCH is a mouthful and
confusing. HAVE_HARDLOCKUP_DETECTOR_PERF_OR_BUDDY is even more of a
mouthful, but probably less confusing. Rename the Kconfig names.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 lib/Kconfig.debug | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index eb1edd5905bc..b9e162698a82 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1058,7 +1058,7 @@ config HARDLOCKUP_DETECTOR_BUDDY
 # needs SMP). In either case, using the "non-arch" code conflicts with
 # the NMI watchdog code (which is sometimes used directly and sometimes used
 # by the arch-provided hardlockup detector).
-config HAVE_HARDLOCKUP_DETECTOR_NON_ARCH
+config HAVE_HARDLOCKUP_DETECTOR_PERF_OR_BUDDY
 	bool
 	depends on (HAVE_HARDLOCKUP_DETECTOR_PERF || SMP) && !HAVE_NMI_WATCHDOG
 	default y
@@ -1077,10 +1077,10 @@ config HARDLOCKUP_DETECTOR_PREFER_BUDDY
 	  an arch-specific hardlockup detector or if resources needed
 	  for the hardlockup detector are better used for other things.
 
-# This will select the appropriate non-arch hardlockdup detector
-config HARDLOCKUP_DETECTOR_NON_ARCH
+# This will select the appropriate non-arch hardlockup detector
+config HARDLOCKUP_DETECTOR_PERF_OR_BUDDY
 	bool
-	depends on HAVE_HARDLOCKUP_DETECTOR_NON_ARCH
+	depends on HAVE_HARDLOCKUP_DETECTOR_PERF_OR_BUDDY
 	select HARDLOCKUP_DETECTOR_BUDDY if !HAVE_HARDLOCKUP_DETECTOR_PERF || HARDLOCKUP_DETECTOR_PREFER_BUDDY
 	select HARDLOCKUP_DETECTOR_PERF if HAVE_HARDLOCKUP_DETECTOR_PERF && !HARDLOCKUP_DETECTOR_PREFER_BUDDY
 
@@ -1098,9 +1098,9 @@ config HARDLOCKUP_CHECK_TIMESTAMP
 config HARDLOCKUP_DETECTOR
 	bool "Detect Hard Lockups"
 	depends on DEBUG_KERNEL && !S390
-	depends on HAVE_HARDLOCKUP_DETECTOR_NON_ARCH || HAVE_HARDLOCKUP_DETECTOR_ARCH
+	depends on HAVE_HARDLOCKUP_DETECTOR_PERF_OR_BUDDY || HAVE_HARDLOCKUP_DETECTOR_ARCH
 	select LOCKUP_DETECTOR
-	select HARDLOCKUP_DETECTOR_NON_ARCH if HAVE_HARDLOCKUP_DETECTOR_NON_ARCH
+	select HARDLOCKUP_DETECTOR_PERF_OR_BUDDY if HAVE_HARDLOCKUP_DETECTOR_PERF_OR_BUDDY
 
 	help
 	  Say Y here to enable the kernel to act as a watchdog to detect
-- 
2.41.0.rc0.172.g3f132b7071-goog

