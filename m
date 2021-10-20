Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFC7C433F5
	for <sparclinux@archiver.kernel.org>; Wed, 20 Oct 2021 17:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F1C611C7
	for <sparclinux@archiver.kernel.org>; Wed, 20 Oct 2021 17:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhJTRrJ (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 20 Oct 2021 13:47:09 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:40448 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhJTRrF (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 20 Oct 2021 13:47:05 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:55038)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFdx-00GCw3-UI; Wed, 20 Oct 2021 11:44:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFdw-001NdN-DC; Wed, 20 Oct 2021 11:44:49 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
Date:   Wed, 20 Oct 2021 12:43:50 -0500
Message-Id: <20211020174406.17889-4-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFdw-001NdN-DC;;;mid=<20211020174406.17889-4-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+5xPDePglvOJbR0eiAg965Omb5l3uiL9A=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 04/20] signal/sparc32: Remove unreachable do_exit in do_sparc_fault
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

The call to do_exit in do_sparc_fault immediately follows a call to
unhandled_fault.  The function unhandled_fault never returns.  This
means the call to do_exit can never be reached.

Cc: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Fixes: 2.3.41
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/sparc/mm/fault_32.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index fa858626b85b..90dc4ae315c8 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -248,7 +248,6 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	}
 
 	unhandled_fault(address, tsk, regs);
-	do_exit(SIGKILL);
 
 /*
  * We ran out of memory, or some other thing happened to us that made
-- 
2.20.1

