Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4445FC433EF
	for <sparclinux@archiver.kernel.org>; Wed, 20 Oct 2021 17:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FF576128E
	for <sparclinux@archiver.kernel.org>; Wed, 20 Oct 2021 17:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhJTRsG (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 20 Oct 2021 13:48:06 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:57266 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhJTRrh (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 20 Oct 2021 13:47:37 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:53180)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeU-002tQl-C2; Wed, 20 Oct 2021 11:45:22 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeT-001NdN-BO; Wed, 20 Oct 2021 11:45:21 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
Date:   Wed, 20 Oct 2021 12:44:01 -0500
Message-Id: <20211020174406.17889-15-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFeT-001NdN-BO;;;mid=<20211020174406.17889-15-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/AOAfq9OrbTsAKGIOxrYpXtjiyRsjzJi8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 15/20] signal/sparc32: Exit with a fatal signal when try_to_clear_window_buffer fails
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

The function try_to_clear_window_buffer is only called from
rtrap_32.c.  After it is called the signal pending state is retested,
and signals are handled if TIF_SIGPENDING is set.  This allows
try_to_clear_window_buffer to call force_fatal_signal and then rely on
the signal being delivered to kill the process, without any danger of
returning to userspace, or otherwise using possible corrupt state on
failure.

The functional difference between force_fatal_sig and do_exit is that
do_exit will only terminate a single thread, and will never trigger a
core-dump.  A multi-threaded program for which a single thread
terminates unexpectedly is hard to reason about.  Calling force_fatal_sig
does not give userspace a chance to catch the signal, but otherwise
is an ordinary fatal signal exit, and it will trigger a coredump
of the offending process if core dumps are enabled.

Cc: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/sparc/kernel/windows.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/windows.c b/arch/sparc/kernel/windows.c
index 69a6ba6e9293..bbbd40cc6b28 100644
--- a/arch/sparc/kernel/windows.c
+++ b/arch/sparc/kernel/windows.c
@@ -121,8 +121,10 @@ void try_to_clear_window_buffer(struct pt_regs *regs, int who)
 
 		if ((sp & 7) ||
 		    copy_to_user((char __user *) sp, &tp->reg_window[window],
-				 sizeof(struct reg_window32)))
-			do_exit(SIGILL);
+				 sizeof(struct reg_window32))) {
+			force_fatal_sig(SIGILL);
+			return;
+		}
 	}
 	tp->w_saved = 0;
 }
-- 
2.20.1

