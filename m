Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF556C433FE
	for <sparclinux@archiver.kernel.org>; Wed, 20 Oct 2021 17:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F5C61390
	for <sparclinux@archiver.kernel.org>; Wed, 20 Oct 2021 17:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhJTRrU (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 20 Oct 2021 13:47:20 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43342 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhJTRrP (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 20 Oct 2021 13:47:15 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:50228)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFe8-00EwIU-Fz; Wed, 20 Oct 2021 11:45:00 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFe7-001NdN-FW; Wed, 20 Oct 2021 11:45:00 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
Date:   Wed, 20 Oct 2021 12:43:54 -0500
Message-Id: <20211020174406.17889-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFe7-001NdN-FW;;;mid=<20211020174406.17889-8-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+m7zFDieSDYP9ie4oAgZCOoskjv4SbOX8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 08/20] signal/sparc: In setup_tsb_params convert open coded BUG into BUG
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

The function setup_tsb_params has exactly one caller tsb_grow.  The
function tsb_grow passes in a tsb_bytes value that is between 8192 and
1048576 inclusive, and is guaranteed to be a power of 2.  The function
setup_tsb_params verifies this property with a switch statement and
then prints an error and causes the task to exit if this is not true.

In practice that print statement can never be reached because tsb_grow
never passes in a bad tsb_size.  So if tsb_size ever gets a bad value
that is a kernel bug.

So replace the do_exit which is effectively an open coded version of
BUG() with an actuall call to BUG().  Making it clearer that this
is a case that can never, and should never happen.

Cc: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/sparc/mm/tsb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index 0dce4b7ff73e..912205787161 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -266,7 +266,7 @@ static void setup_tsb_params(struct mm_struct *mm, unsigned long tsb_idx, unsign
 	default:
 		printk(KERN_ERR "TSB[%s:%d]: Impossible TSB size %lu, killing process.\n",
 		       current->comm, current->pid, tsb_bytes);
-		do_exit(SIGSEGV);
+		BUG();
 	}
 	tte |= pte_sz_bits(page_sz);
 
-- 
2.20.1

