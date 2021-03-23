Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F91C433DB
	for <sparclinux@archiver.kernel.org>; Tue, 23 Mar 2021 16:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19F89619BB
	for <sparclinux@archiver.kernel.org>; Tue, 23 Mar 2021 16:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbhCWQ63 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 23 Mar 2021 12:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbhCWQ6A (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 23 Mar 2021 12:58:00 -0400
X-Greylist: delayed 417 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 Mar 2021 09:57:59 PDT
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8162C061574
        for <sparclinux@vger.kernel.org>; Tue, 23 Mar 2021 09:57:59 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 37E345A191ABC; Tue, 23 Mar 2021 17:50:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 2875462BD2266;
        Tue, 23 Mar 2021 17:50:59 +0100 (CET)
Date:   Tue, 23 Mar 2021 17:50:59 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Christoph Hellwig <hch@lst.de>
cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>,
        Frank Scheiner <frank.scheiner@web.de>
Subject: Re: Regression in 028abd92 for Sun UltraSPARC T1
In-Reply-To: <4d033ff9-329e-77e7-20de-720aa65bba3e@web.de>
Message-ID: <n0n38p9-rn4s-213-n983-9o3o4oo8s54r@vanv.qr>
References: <9ffdf604-ce04-9200-65c9-dd8921a45038@web.de> <186a7992-6e83-dc8a-1cfc-d07bb36935f5@physik.fu-berlin.de> <4d033ff9-329e-77e7-20de-720aa65bba3e@web.de>
User-Agent: Alpine 2.24 (LSU 510 2020-10-10)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org


On Monday 2021-03-22 22:55, Frank Scheiner wrote:
>>> Riccardo Mottola first recognized a problem with 5.10.x kernels on his
>>> Sun T2000 with UltraSPARC T1 (details in [this thread]). I could verify
>>> the problem also on my Sun T1000 and it looks like this specific issue
>>> breaks the mounting of the root FS or maybe mounting file systems at
>>> all. This affects both booting from disk and from network.
>>> (...)
>>> ...as first bad commit.
>>>
>>> ```
>>> commit 028abd9222df0cf5855dab5014a5ebaf06f90565
>>> Author: Christoph Hellwig <hch@lst.de>
>>>      fs: remove compat_sys_mount

Some participants in the discussion over at the debian-sparc list mentioned
"NFS" and "Invalid argument", which is something I know just too well from
iptables. NFS is a filesystem that uses an extra data blob (5th argument to the
mount syscall). Such blobs have historically not always been designed to bear
the same layout between ILP32 and LP64 modes, and nfs's structs fell prey to
this as well.

My hypothesis now is that fs/nfs/fs_context.c line 1160:

	if (in_compat_syscall())
		nfs4_compat_mount_data_conv(data);

and ones similar to it (I didn't look too close where nfs3 gets to do its
conversion), no longer trigger as a result of compat_sys_mount being
wiped from the syscall table:

+++ arch/sparc/kernel/syscalls/syscall.tbl
@@ -201,7 +201,7 @@
 164    64      utrap_install           sys_utrap_install
 165    common  quotactl                sys_quotactl
 166    common  set_tid_address         sys_set_tid_address
-167    common  mount                   sys_mount                       compat_sys_mount
+167    common  mount                   sys_mount

I didn't extract from the debian-sparc discussion whether people were running
the all-LP64 userspace, or had some older Debian with a ILP32-on-64bitkernel
setup.


[But that's just a theory - a kernel theory!]
