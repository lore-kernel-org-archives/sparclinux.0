Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7BCC433EF
	for <sparclinux@archiver.kernel.org>; Mon,  8 Nov 2021 02:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 406F361351
	for <sparclinux@archiver.kernel.org>; Mon,  8 Nov 2021 02:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbhKHCXo (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sun, 7 Nov 2021 21:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhKHCXn (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sun, 7 Nov 2021 21:23:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF2EC061570
        for <sparclinux@vger.kernel.org>; Sun,  7 Nov 2021 18:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=CJChvlJAKWa55QVSfeUfSnCGmGNB7IQg3OhvF2RrHJs=; b=fx2FkO39E+WoiZ2xNaVE/kbN1R
        rDMIbPYEth1qnK/ZvjQ8LmnUDNGjD4kIQMaLsvzTBR6CrK0kST37t8EYsfHYEuE6Tru0pfYUZOw/j
        YwwDOwfCESln9YEoZkjclVLMecQdOc+Uhyv2cKB5xMlnqkTHxq8QJme1kQS8Ghs6DuTl57yzKwqt2
        TB6Eoxv8UvFP4/OqaA4v6p6sK8klOl+YbxBSSbQCQlHatNvTigSgZITNkA5HgTIvBhvXkeioEhnXR
        cHFG8Ah8oHRh9G7fARWySqf/0RJcPZQIDqX5bwk8OVJnoPtsG73tvxubv2qOipPIZB5dqY9/QTjAP
        u/Sqdjhg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjuFt-0087RV-5s; Mon, 08 Nov 2021 02:19:47 +0000
Date:   Mon, 8 Nov 2021 02:19:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     sparclinux@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] Fix W=1 builds on sparc
Message-ID: <YYiJMeWiCgK8ECGP@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Running the following command:

$ make W=1 O=.sparc ARCH=sparc64 CROSS_COMPILE=sparc64-linux-gnu- mm/util.o

  CC      arch/sparc/kernel/asm-offsets.s
../arch/sparc/kernel/asm-offsets.c:29:5: error: no previous prototype for ‘sparc64_foo’ [-Werror=missing-prototypes]
../arch/sparc/kernel/asm-offsets.c:48:5: error: no previous prototype for ‘foo’ [-Werror=missing-prototypes]

These functions obviously aren't actually called from anywhere, so
just silence the warning (and fix the build) by declaring them
immediately before defining them.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/arch/sparc/kernel/asm-offsets.c b/arch/sparc/kernel/asm-offsets.c
index 5784f2df489a..354a4d4d7b37 100644
--- a/arch/sparc/kernel/asm-offsets.c
+++ b/arch/sparc/kernel/asm-offsets.c
@@ -19,6 +19,7 @@
 #include <asm/hibernate.h>
 
 #ifdef CONFIG_SPARC32
+int sparc32_foo(void);
 int sparc32_foo(void)
 {
 	DEFINE(AOFF_thread_fork_kpsr,
@@ -26,6 +27,7 @@ int sparc32_foo(void)
 	return 0;
 }
 #else
+int sparc64_foo(void);
 int sparc64_foo(void)
 {
 #ifdef CONFIG_HIBERNATION
@@ -45,6 +47,7 @@ int sparc64_foo(void)
 }
 #endif
 
+int foo(void);
 int foo(void)
 {
 	BLANK();
