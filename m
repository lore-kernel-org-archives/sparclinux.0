Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA27C433F5
	for <sparclinux@archiver.kernel.org>; Wed, 20 Oct 2021 17:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D36611F2
	for <sparclinux@archiver.kernel.org>; Wed, 20 Oct 2021 17:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhJTRsH (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 20 Oct 2021 13:48:07 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43558 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhJTRrk (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 20 Oct 2021 13:47:40 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:50654)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeX-00EwP4-Bx; Wed, 20 Oct 2021 11:45:25 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeV-001NdN-HO; Wed, 20 Oct 2021 11:45:24 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
Date:   Wed, 20 Oct 2021 12:44:02 -0500
Message-Id: <20211020174406.17889-16-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFeV-001NdN-HO;;;mid=<20211020174406.17889-16-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+PPL8dLrIlJ5bbcAk6ZNzCrUxBuSVPrlA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 16/20] signal/sparc32: In setup_rt_frame and setup_fram use force_fatal_sig
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Modify the 32bit version of setup_rt_frame and setup_frame to act
similar to the 64bit version of setup_rt_frame and fail with a signal
instead of calling do_exit.

Replacing do_exit(SIGILL) with force_fatal_signal(SIGILL) ensures that
the process will be terminated cleanly when the stack frame is
invalid, instead of just killing off a single thread and leaving the
process is a weird state.

Cc: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/sparc/kernel/signal_32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
index 02f3ad55dfe3..cd677bc564a7 100644
--- a/arch/sparc/kernel/signal_32.c
+++ b/arch/sparc/kernel/signal_32.c
@@ -244,7 +244,7 @@ static int setup_frame(struct ksignal *ksig, struct pt_regs *regs,
 		get_sigframe(ksig, regs, sigframe_size);
 
 	if (invalid_frame_pointer(sf, sigframe_size)) {
-		do_exit(SIGILL);
+		force_fatal_sig(SIGILL);
 		return -EINVAL;
 	}
 
@@ -336,7 +336,7 @@ static int setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs,
 	sf = (struct rt_signal_frame __user *)
 		get_sigframe(ksig, regs, sigframe_size);
 	if (invalid_frame_pointer(sf, sigframe_size)) {
-		do_exit(SIGILL);
+		force_fatal_sig(SIGILL);
 		return -EINVAL;
 	}
 
-- 
2.20.1

