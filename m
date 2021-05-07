Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3EBC433ED
	for <sparclinux@archiver.kernel.org>; Fri,  7 May 2021 08:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22398613CD
	for <sparclinux@archiver.kernel.org>; Fri,  7 May 2021 08:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbhEGIlR (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 7 May 2021 04:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbhEGIlR (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 7 May 2021 04:41:17 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49A8C061574
        for <sparclinux@vger.kernel.org>; Fri,  7 May 2021 01:40:17 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id h202so10937801ybg.11
        for <sparclinux@vger.kernel.org>; Fri, 07 May 2021 01:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YWypHOf38xNpYW1uVedzbi/0kVxnKQP8/NX23zX3pi0=;
        b=qQRbnyL/pwQdh+m/LiLW/3Alr8x4nJTs12b5br50CPHCgsatFNpIbj0qz9PWBfktN1
         WyqUL1EqhYyQe2vnDbzxDuryZDd4M0bwJKdNjTLgeT/kjOnV4yr2HNLUcGE4vuPa+oza
         U8v9fj/CBqLTJdwospng8hBB3+lh1/QJ5fX1fLfA5kGm26G8boCphptwZJjwbcXSJhep
         Hm0KwQnQTMqYxS6cV3oU69Zk7HwoBM8EC0ahNLqvkfEcgbWP1ldOV2cHQstognu3DIov
         2+FxDHyQ0h4hon/zVdBS2OQ3KMclA7/9fMRF41sWamM/Bhd0z2WrJauy3UN/Zdh4zcDm
         adQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YWypHOf38xNpYW1uVedzbi/0kVxnKQP8/NX23zX3pi0=;
        b=BzlvrVIxCb/Q/DlzSKRLmTKNKhVks4cdkXQUWkJpdrJ8OXTQVDBrvpn1KcQEFnAMxO
         JhRTOmvJrfNRaM+AqbTpa6pl+qp3JccEDeLyGfKF7rWQ2VHtFxeFJNMoWzcKuPaDOjkG
         STI5tda1NoDnV5jwkaKdvW41a3LrqKy8e50nIt7xTPzSruKD0GACMgsPEp02ADA4H1J+
         bP/jOW0sjSUvko6ddWZZ2WJSZEZXPUgo4FI+4WGuZlDyfRGFioPm+p871RISQRIVZV9Z
         AzTb9hLXLZGvXPAw9Q5kpXEc0xx6OQpWEbbcllfMTIrXh/1U3X0ZSTj4P479TP2178zG
         +ByQ==
X-Gm-Message-State: AOAM531EaXifr3oenxEpgvKVzvgmgaqGedpxv7lFAmq7WyRVl6w1ea19
        FqENkNmH1vNAdyfB8SKrQ2Wu6lqv/zSmjR7svHk=
X-Google-Smtp-Source: ABdhPJynqVkgXpQ+Hq3PHvqhcbt575JVGRMZgh69oOIKvgjMEfG+PE0viklAsx3MMmOna5PVFtY0SwP+9jwlzKcNoXQ=
X-Received: by 2002:a25:df8a:: with SMTP id w132mr5513654ybg.287.1620376817067;
 Fri, 07 May 2021 01:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <520.1620350498@sss.pgh.pa.us>
In-Reply-To: <520.1620350498@sss.pgh.pa.us>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Fri, 7 May 2021 11:40:06 +0300
Message-ID: <CADxRZqyzbEo6kiC_DD6y9sFOtVJ4z8Ss+raccv8sy-XXdjzQHw@mail.gmail.com>
Subject: Re: [cfarm-admins] gcc202 is occasionally returning EIO from fdatasync(2)
To:     Tom Lane <tgl@sss.pgh.pa.us>
Cc:     GCC Compile Farm administrators 
        <cfarm-admins@lists.tetaneutral.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sparc kernel list <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri, May 7, 2021 at 4:22 AM Tom Lane via cfarm-admins
<cfarm-admins@lists.tetaneutral.net> wrote:
>
> Hi folks,
>
> I thought you ought to know about $SUBJECT.  Maybe it's some
> weird kernel glitch, but if it is reflecting real I/O errors,
> maybe that machine is about to have a disk failure.  Poking
> into its SMART logs (if any) might be useful.
>
> I got interested in this because a Postgres buildfarm instance
> that runs periodically on that machine reported a couple of
> unexplainable failures in the last few weeks [1].  I was able
> to reproduce the failure and determine that it's a fault in
> the logic that ought to report a failure from fdatasync(2).
> Looking in the core file shows that errno = 5 (EIO) is what
> was reported.  So we (PG) have some things to fix, but meanwhile
> I felt you'd better know about the possibility of a hardware
> issue.
>
>                         regards, tom lane
>
> [1] https://www.postgresql.org/message-id/CA+hUKGLhc0Nwnn9u60oYrx4MAUga+qEvj+4pBqPwrmPKDNtFmA@mail.gmail.com

Tom,

just checked /home filesystem, there's no errors... And yes, there's
sometimes (sporadically) I see kernel messages like those in logs:

May 07 03:26:45 gcc202 kernel: sunvdc: vdc_tx_trigger() failure, err=-11
May 07 03:26:45 gcc202 kernel: blk_update_request: I/O error, dev
vdiskc, sector 159273120 op 0x1:(WRITE) flags 0x4800 phys_seg 17 prio
class 0
May 07 03:31:39 gcc202 kernel: dm-0: writeback error on inode
2148294407, offset 0, sector 159239256
May 07 03:31:39 gcc202 kernel: sunvdc: vdc_tx_trigger() failure, err=-11
May 07 03:31:39 gcc202 kernel: blk_update_request: I/O error, dev
vdiskc, sector 157618896 op 0x1:(WRITE) flags 0x4800 phys_seg 16 prio
class 0
May 07 03:35:06 gcc202 kernel: dm-0: writeback error on inode
155142134, offset 0, sector 157584576
May 07 03:35:06 gcc202 kernel: sunvdc: vdc_tx_trigger() failure, err=-11
May 07 03:35:06 gcc202 kernel: blk_update_request: I/O error, dev
vdiskc, sector 657284672 op 0x1:(WRITE) flags 0x1000 phys_seg 4 prio
class 0
May 07 03:35:06 gcc202 kernel: XFS (dm-0): metadata I/O error in
"xfs_buf_ioend+0x2cc/0x640 [xfs]" at daddr 0x272d5640 len 32 error 5

I can't find a reproducer for it to start debugging the issue, but
going to run xfstests [1] on my sparc64 test LDOM to see if it would
catch something...

By the way, there are no SMART disk diagnostics available, since the
machine is a LDOM (read virtual machine) and backend storage is zfs
volume (OS is solaris 11 sparc), which is living on older Hitachi
AMS2000 (over FC).

Thanks for your report anyway.

1. https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
