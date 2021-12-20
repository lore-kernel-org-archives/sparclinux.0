Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6103EC433EF
	for <sparclinux@archiver.kernel.org>; Mon, 20 Dec 2021 08:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237902AbhLTIW7 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 20 Dec 2021 03:22:59 -0500
Received: from smtpbg126.qq.com ([106.55.201.22]:18922 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237894AbhLTIW7 (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Mon, 20 Dec 2021 03:22:59 -0500
X-QQ-mid: bizesmtp50t1639988569t2c2iu13
Received: from localhost.localdomain (unknown [118.121.67.96])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 20 Dec 2021 16:22:47 +0800 (CST)
X-QQ-SSF: 01000000002000D0K000B00A0000000
X-QQ-FEAT: xoS364mEyr1o3iMfbKGx93ELoV4m7FkNOyJ74z7uJ7YcP3HN2yqSJpFY/vc/Z
        gQ0Xh1wCT+0Piv7mYtm595gQwudY6R2FfyHnWOXRL+EP8SbR7lNvQXtzDKfqsNMAYek5ILZ
        2W0s9cCBdln0BBehlwsEq/RkcnIDQ+fNfYfxUHw/1Ds9sSRt5OmccmtRqVryParsRx/8EL3
        bSgicxGqljlnr7PN2OaZW+CKjR/j3nT7+FUqgLDSxnDcZXK/CkzZ2orQAUJJSltMWjrJx+q
        Ily1ay53Uk5C9XzFz/+uMaVQAFN5oZrgwu6KkFnloInZl+hGzqy5wtzPvoZZEQJ+BMX7FP6
        vzWN4RhrOyab5dPXRD2nJfW0z4VjNkwKcE6Rd9lYAr/5zzxOs4=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     davem@davemloft.net
Cc:     andreas@gaisler.com, sam@ravnborg.org, wangborong@cdjrlc.com,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc32: use strscpy to copy strings
Date:   Mon, 20 Dec 2021 16:22:44 +0800
Message-Id: <20211220082244.927883-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam2
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

The strlcpy should not be used because it doesn't limit the source
length. So that it will lead some potential bugs.

But the strscpy doesn't require reading memory from the src string
beyond the specified "count" bytes, and since the return value is
easier to error-check than strlcpy()'s. In addition, the implementation
is robust to the string changing out from underneath it, unlike the
current strlcpy() implementation.

Thus, replace strlcpy with strscpy.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/sparc/kernel/ioport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 57a72c46eddb..85c7b70225f2 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -191,7 +191,7 @@ static void __iomem *_sparc_alloc_io(unsigned int busno, unsigned long phys,
 		tack += sizeof (struct resource);
 	}
 
-	strlcpy(tack, name, XNMLN+1);
+	strscpy(tack, name, XNMLN+1);
 	res->name = tack;
 
 	va = _sparc_ioremap(res, busno, phys, size);
-- 
2.34.1

