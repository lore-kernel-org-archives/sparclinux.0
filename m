Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F5EC433ED
	for <sparclinux@archiver.kernel.org>; Fri,  7 May 2021 17:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE434613ED
	for <sparclinux@archiver.kernel.org>; Fri,  7 May 2021 17:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhEGRa5 convert rfc822-to-8bit (ORCPT
        <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 7 May 2021 13:30:57 -0400
Received: from sss.pgh.pa.us ([66.207.139.130]:33417 "EHLO sss.pgh.pa.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230453AbhEGRa4 (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Fri, 7 May 2021 13:30:56 -0400
Received: from sss1.sss.pgh.pa.us (localhost [127.0.0.1])
        by sss.pgh.pa.us (8.15.2/8.15.2) with ESMTP id 147HTVt0043933;
        Fri, 7 May 2021 13:29:31 -0400
From:   Tom Lane <tgl@sss.pgh.pa.us>
To:     Anatoly Pugachev <matorola@gmail.com>
cc:     GCC Compile Farm administrators 
        <cfarm-admins@lists.tetaneutral.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sparc kernel list <sparclinux@vger.kernel.org>
Subject: Re: [cfarm-admins] gcc202 is occasionally returning EIO from fdatasync(2)
In-reply-to: <34248.1620397342@sss.pgh.pa.us>
References: <520.1620350498@sss.pgh.pa.us> <CADxRZqyzbEo6kiC_DD6y9sFOtVJ4z8Ss+raccv8sy-XXdjzQHw@mail.gmail.com> <33336.1620396305@sss.pgh.pa.us> <34248.1620397342@sss.pgh.pa.us>
Comments: In-reply-to Tom Lane <tgl@sss.pgh.pa.us>
        message dated "Fri, 07 May 2021 10:22:22 -0400"
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <43931.1620408571.1@sss.pgh.pa.us>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 07 May 2021 13:29:31 -0400
Message-ID: <43932.1620408571@sss.pgh.pa.us>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

I wrote:
> Oh, one more thing: that buildfarm instance has been running this
> same test case about once a day for a good long time.  We never
> saw this type of error before, but now we have two such failures
> in its last ten runs.  So it seems pretty clear that the issue
> started in mid-April.

Oh ... I lied.  I realized that Postgres' handling of this error has
varied in different branches, and when I looked for straight reports
of "Input/output error" I found a few more:

2021-03-20 00:48:48.117 MSK [4089174:11] 008_fsm_truncation.pl PANIC:  could not fdatasync file "000000010000000000000002": Input/output error
2021-04-06 19:30:54.103 MSK [3355008:11] 008_fsm_truncation.pl PANIC:  could not fdatasync file "000000010000000000000002": Input/output error
pg_basebackup: could not fsync file "000000010000000000000013": Input/output error

The last one is harder to get an exact timestamp for, but it
was approximately 2021-04-12 05:47:07 MSK.  In any case, it
seems this has been going on at least since mid-March.
I don't see any other similar failures in our logs, going
back six months.

			regards, tom lane
