Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F80C0032E
	for <sparclinux@archiver.kernel.org>; Thu, 26 Oct 2023 02:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjJZCQS (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 25 Oct 2023 22:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZCQS (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 25 Oct 2023 22:16:18 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191AD93
        for <sparclinux@vger.kernel.org>; Wed, 25 Oct 2023 19:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Wzg8L27iK/4jwoWeUpFwrV/R1lAKP0Rc4AC4lxf/kpc=; b=FnnQWYwg0hqm/vxCvpzQSXCleA
        TPUtsFP4taz+lVzkf4Ig5/s6l9zYY2Wl9I4dsMb2lB+ZkHHKynpn3rbaNh1NV7ZptkgdQW/914bL3
        INOBWokxMbS4UaP+xhrb9JMMTGlmaX2DPtW2xyRTDaSTYhpqF3SCquoCXtMLdRqHHwdqI7m2ALbRC
        fzk/nuftmVvMUi/WIr6UoVQIJ/v1Rywq+noI0mhZ/5NNN3RiLK72xU+fnT/bXNlIOGUCvvAqEfZSG
        X/C8l6X9oePBUTTk8P6mWaynFunJz/HPeswpLXO7pE3q0PrFpR1/JXV0JzPaGRzPbMWMMuKTnL1Xm
        225/zJDQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qvpuv-005mfx-1V
        for sparclinux@vger.kernel.org;
        Thu, 26 Oct 2023 02:16:13 +0000
Date:   Thu, 26 Oct 2023 03:16:13 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     sparclinux@vger.kernel.org
Subject: [PATCH] sparc32: fix a braino in fault handling in
 csum_and_copy_..._user()
Message-ID: <20231026021613.GI800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Fault handler used to make non-trivial calls, so it needed
to set a stack frame up.  Used to be
	save ... - grab a stack frame, old %o... become %i...
	....
	ret	- go back to address originally in %o7, currently %i7
	 restore - switch to previous stack frame, in delay slot
Non-trivial calls had been gone since ab5e8b331244 and that code should
have become
	retl	- go back to address in %o7
	 clr %o0 - have return value set to 0
What it had become instead was
	ret	- go back to address in %i7 - return address of *caller*
	 clr %o0 - have return value set to 0
which is not good, to put it mildly - we forcibly return 0 from
csum_and_copy_{from,to}_iter() (which is what the call of that
thing had been inlined into) and do that without dropping the
stack frame of said csum_and_copy_..._iter().  Confuses the
hell out of the caller of csum_and_copy_..._iter(), obviously...

Fixes: ab5e8b331244 "sparc32: propagate the calling conventions change down to __csum_partial_copy_sparc_generic()"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sparc/lib/checksum_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/lib/checksum_32.S b/arch/sparc/lib/checksum_32.S
index 84ad709cbecb..66eda40fce36 100644
--- a/arch/sparc/lib/checksum_32.S
+++ b/arch/sparc/lib/checksum_32.S
@@ -453,5 +453,5 @@ ccslow:	cmp	%g1, 0
  * we only bother with faults on loads... */
 
 cc_fault:
-	ret
+	retl
 	 clr	%o0
-- 
2.39.2

