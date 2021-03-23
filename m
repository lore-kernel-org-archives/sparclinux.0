Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C7DC433C1
	for <sparclinux@archiver.kernel.org>; Tue, 23 Mar 2021 16:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B010619B4
	for <sparclinux@archiver.kernel.org>; Tue, 23 Mar 2021 16:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhCWQ5z (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 23 Mar 2021 12:57:55 -0400
Received: from verein.lst.de ([213.95.11.211]:33273 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231941AbhCWQ5Y (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Tue, 23 Mar 2021 12:57:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 000F668B02; Tue, 23 Mar 2021 17:57:21 +0100 (CET)
Date:   Tue, 23 Mar 2021 17:57:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>,
        Frank Scheiner <frank.scheiner@web.de>
Subject: Re: Regression in 028abd92 for Sun UltraSPARC T1
Message-ID: <20210323165721.GA14577@lst.de>
References: <9ffdf604-ce04-9200-65c9-dd8921a45038@web.de> <186a7992-6e83-dc8a-1cfc-d07bb36935f5@physik.fu-berlin.de> <4d033ff9-329e-77e7-20de-720aa65bba3e@web.de> <n0n38p9-rn4s-213-n983-9o3o4oo8s54r@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n0n38p9-rn4s-213-n983-9o3o4oo8s54r@vanv.qr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, Mar 23, 2021 at 05:50:59PM +0100, Jan Engelhardt wrote:
> Some participants in the discussion over at the debian-sparc list mentioned
> "NFS" and "Invalid argument", which is something I know just too well from
> iptables. NFS is a filesystem that uses an extra data blob (5th argument to the
> mount syscall). Such blobs have historically not always been designed to bear
> the same layout between ILP32 and LP64 modes, and nfs's structs fell prey to
> this as well.
> 
> My hypothesis now is that fs/nfs/fs_context.c line 1160:
> 
> 	if (in_compat_syscall())
> 		nfs4_compat_mount_data_conv(data);
> 
> and ones similar to it (I didn't look too close where nfs3 gets to do its
> conversion), no longer trigger as a result of compat_sys_mount being
> wiped from the syscall table:

No, if in_compat_syscall() syscall doesn't trigger properly the kernel
would not get this far.

That being said, the NFS compat code was moved out of the compat mount
handler and into nfs and refactored in the commit just before this one.

Frank, can you double check that commit
67e306c6906137020267eb9bbdbc127034da3627 really still works, and
only 028abd9222df0cf5855dab5014a5ebaf06f90565 broke your setup?
