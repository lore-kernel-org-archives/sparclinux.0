Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FDEC433ED
	for <sparclinux@archiver.kernel.org>; Fri,  7 May 2021 14:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE4D6128B
	for <sparclinux@archiver.kernel.org>; Fri,  7 May 2021 14:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhEGOPG (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 7 May 2021 10:15:06 -0400
Received: from sss.pgh.pa.us ([66.207.139.130]:57039 "EHLO sss.pgh.pa.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230306AbhEGOPG (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Fri, 7 May 2021 10:15:06 -0400
X-Greylist: delayed 520 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 May 2021 10:15:05 EDT
Received: from sss1.sss.pgh.pa.us (localhost [127.0.0.1])
        by sss.pgh.pa.us (8.15.2/8.15.2) with ESMTP id 147E55ED033337;
        Fri, 7 May 2021 10:05:05 -0400
From:   Tom Lane <tgl@sss.pgh.pa.us>
To:     Anatoly Pugachev <matorola@gmail.com>
cc:     GCC Compile Farm administrators 
        <cfarm-admins@lists.tetaneutral.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sparc kernel list <sparclinux@vger.kernel.org>
Subject: Re: [cfarm-admins] gcc202 is occasionally returning EIO from fdatasync(2)
In-reply-to: <CADxRZqyzbEo6kiC_DD6y9sFOtVJ4z8Ss+raccv8sy-XXdjzQHw@mail.gmail.com>
References: <520.1620350498@sss.pgh.pa.us> <CADxRZqyzbEo6kiC_DD6y9sFOtVJ4z8Ss+raccv8sy-XXdjzQHw@mail.gmail.com>
Comments: In-reply-to Anatoly Pugachev <matorola@gmail.com>
        message dated "Fri, 07 May 2021 11:40:06 +0300"
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <33335.1620396305.1@sss.pgh.pa.us>
Date:   Fri, 07 May 2021 10:05:05 -0400
Message-ID: <33336.1620396305@sss.pgh.pa.us>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Anatoly Pugachev <matorola@gmail.com> writes:
> just checked /home filesystem, there's no errors... And yes, there's
> sometimes (sporadically) I see kernel messages like those in logs:

Interesting.  In case it helps, I have accurate timestamps for the three
events we've seen so far:

2021-04-22 20:16:43 MSK 
2021-05-05 20:25:52 MSK
2021-05-07 03:31:39 MSK

The last one correlates with what you showed here:

> May 07 03:31:39 gcc202 kernel: dm-0: writeback error on inode
> 2148294407, offset 0, sector 159239256
> May 07 03:31:39 gcc202 kernel: sunvdc: vdc_tx_trigger() failure, err=-11
> May 07 03:31:39 gcc202 kernel: blk_update_request: I/O error, dev
> vdiskc, sector 157618896 op 0x1:(WRITE) flags 0x4800 phys_seg 16 prio
> class 0

Also, while this might be a mirage, I have the distinct impression
that the problem is load-sensitive.  Yesterday I could not make
the failure happen just by looping the test case that had shown
it previously.  But after realizing I was the only one using the
machine, I tried starting some non-conflicting tests in additional
ssh sessions, and then it happened pretty quickly with the extra
load.

			regards, tom lane
