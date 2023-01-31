Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DA1C636D3
	for <sparclinux@archiver.kernel.org>; Tue, 31 Jan 2023 01:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjAaBqr (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 30 Jan 2023 20:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjAaBqp (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 30 Jan 2023 20:46:45 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2686423101
        for <sparclinux@vger.kernel.org>; Mon, 30 Jan 2023 17:46:31 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id 3so14575656vsq.7
        for <sparclinux@vger.kernel.org>; Mon, 30 Jan 2023 17:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r0G78tCFuMbUc11f4Np3FVLjYUjXRj+1bSf/D+z772Y=;
        b=mBtK5jkiEPcmqnnUf3pWbeh8X1hzLi8VxrmvPgnBVeR64+mnnmMndwS6dpqTQOgQTV
         GYrR7P3jZQo0pYnE8xyMUtVNrxhSv+1+3CdCnGJjS5kJOjSRSy0v6Su3cI6SYyqauSlB
         vPb8rMkw1MYjQiYj4oaoqHB3JVw4YvTnr2t97GRBiG2II0iD6Qq1DylRNSQrOR5rrmse
         cqXxYh6CCSb4Jd0lCVVJKNNpJGOcQa8yJTUZbSj0XSMK4LNVSLGenAQR4ZBr54k4VZIo
         RCH+zjvb6Bcc9CwtuiKAgBA08gZS+RMrsWymnMqBCPaa1E8w70bbakPcfMlclVt+O1T+
         8ZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r0G78tCFuMbUc11f4Np3FVLjYUjXRj+1bSf/D+z772Y=;
        b=qudN+XgRcscIdKpRh4922Rs/kk5FV8BxhSmMR1k+G+QITVkEP5Ix5frPDmB1fRpPzr
         VN2r+5ev44DfH2yN5G6uj/4+YacrvzwLmyxUXzkdYtPSl15EspTbPT/we02j6zhItttL
         o93CLM6mjJuea2xpqXB+CEcDsIs261m0ypRthVR6birdHbK0P/NzY2NNc6vNl4OBLvsV
         MLHUhtm6B38TUY3FrlevU1LuxAqUOPWeeYKlpiJiL5P4uraIt1Y/fv3HtsimpAqSMcWN
         Zu9Nf5lT+SReIV4B6VvxclB9GX/LwCT48nl5TtI7ZaF42ckVfI/JpoN/28IAQU4t0Ls8
         W/6A==
X-Gm-Message-State: AO0yUKWcx5bTT3F8MIOgAiChk+OvhAGOfonVRygEaT6Zh/Newrh7LEI+
        6QtbnwIzwqSDAVhgV8htaqh/42DVRMeOaBJS8iQaaIv3pYwSwLb4
X-Google-Smtp-Source: AK7set8T18QDx4rAbFvPvwBDlz5oPdhQHy9nhjNv0cUUAZfeKar7Fpa3GKrYmMJRQRPGA3x+F0b5SBaQ6GGUsLHTgr0=
X-Received: by 2002:a67:ecd8:0:b0:3eb:e432:5601 with SMTP id
 i24-20020a67ecd8000000b003ebe4325601mr2837366vsp.16.1675129590180; Mon, 30
 Jan 2023 17:46:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6130:1015:b0:559:9619:d862 with HTTP; Mon, 30 Jan 2023
 17:46:29 -0800 (PST)
X-Originating-IP: [24.53.241.20]
In-Reply-To: <Y9bvwz4FIOQ+D8c4@x1n>
References: <CADyTPExpEqaJiMGoV+Z6xVgL50ZoMJg49B10LcZ=8eg19u34BA@mail.gmail.com>
 <Y9bvwz4FIOQ+D8c4@x1n>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Mon, 30 Jan 2023 20:46:29 -0500
Message-ID: <CADyTPEzsvdRC15+Z5T3oryofwRYqHmHzwqRmJKJoHB3d7Tdayw@mail.gmail.com>
Subject: Re: PROBLEM: sparc64 random crashes starting w/ Linux 6.1 (regression)
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        regressions@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 2023-01-29, Peter Xu <peterx@redhat.com> wrote:
> On Sat, Jan 28, 2023 at 09:17:31PM -0500, Nick Bowler wrote:
>> Starting with Linux 6.1.y, my sparc64 (Sun Ultra 60) system is very
>> unstable, with userspace processes randomly crashing with all kinds of
>> different weird errors.  The same problem occurs on 6.2-rc5.  Linux
>> 6.0.y is OK.
[...]
> Could you try below patch to see whether it fixes your problem?  It should
> cover the last piece of possible issue with dirty bit on sparc after that
> patchset.  It's based on latest master branch (commit ab072681eabe1ce0).

Haven't seen any failures yet, so it seems this patch on top of 6.2-rc6
makes things much better.

I'll keep running this for a while to see if any other problems come up.

Thanks,
  Nick
