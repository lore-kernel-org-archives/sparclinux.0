Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925C8C001DE
	for <sparclinux@archiver.kernel.org>; Tue, 15 Aug 2023 07:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbjHOHeT (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 15 Aug 2023 03:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbjHOHd7 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 15 Aug 2023 03:33:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593E9107
        for <sparclinux@vger.kernel.org>; Tue, 15 Aug 2023 00:33:58 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-986d8332f50so692421166b.0
        for <sparclinux@vger.kernel.org>; Tue, 15 Aug 2023 00:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692084836; x=1692689636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ptPuBEpK+bTuLrHXWomcWZqL5q0T5IOC69Hvw3A95bI=;
        b=KFI+UK7Ev9NoB+QrDddZx9LmrmscknI+E/D4xZ0r2SJDn+V/VJeg6WzDm8K+PE5VNN
         M2LvF3rGyjKn17nbxKUmHNYzOzfjr95LpdXsPqRBGgf2GbmDPiXhPfd8YTIEkrriESHf
         nVwDddGFJiJnMuNDWe+lbiX5vs9w9SOivomOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692084836; x=1692689636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptPuBEpK+bTuLrHXWomcWZqL5q0T5IOC69Hvw3A95bI=;
        b=H66F/6t6lShuDc02KUGvSwLLzcoxtJMvJfi3/XBveuRKlARIZWRSrWdqehMMJTCBIm
         GzODrb7iDZgvu8UIYO7DouLYvMmgINftClGO9XkSWVrFfOM+UYlmqjWh5F8TsnWI6Ybc
         Bc4qAhy47JiICoegZszWaDUaZaBgiTWM0qBF6p9H/IzphebcqOyV+gYiPKGTctq+ueGL
         MNQnRW5BLkjhkUUP7uRUdpf8PgyEpvAMqEwaFQxRWlY8T5SXWrBmcP0wYF86iAlBPUmu
         vEVd07JmHrAijyDvB26Uq2tc9CL5eO7RXkwZTONDSIAShLrzdFGxJqWca9hFZkLXbRJK
         4fBw==
X-Gm-Message-State: AOJu0Ywi2h706NeovL0AZh/BL0F6bzeGuJtYrmUaUofyukEklnB6Hly/
        w3RR21uR0b9a1HvpT3lowxP+zT5yANn+dYg4YWYjtd2h
X-Google-Smtp-Source: AGHT+IFmNvjl1uQyi8MnRJ9Sx9uOp8XQqnxiNCxCHCLWQHZDjm9/81hdBPj4LuFqHi+C7+48yh9M5w==
X-Received: by 2002:a17:906:3d21:b0:99b:c952:309a with SMTP id l1-20020a1709063d2100b0099bc952309amr8948913ejf.39.1692084836735;
        Tue, 15 Aug 2023 00:33:56 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id b15-20020a170906490f00b0099c971ba285sm6622988ejq.5.2023.08.15.00.33.53
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 00:33:54 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-522dd6b6438so6396712a12.0
        for <sparclinux@vger.kernel.org>; Tue, 15 Aug 2023 00:33:53 -0700 (PDT)
X-Received: by 2002:a05:6402:290:b0:523:1004:1c9a with SMTP id
 l16-20020a056402029000b0052310041c9amr8202386edv.35.1692084833506; Tue, 15
 Aug 2023 00:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <202308151426.97be5bd8-oliver.sang@intel.com>
In-Reply-To: <202308151426.97be5bd8-oliver.sang@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Aug 2023 07:33:36 +0000
X-Gmail-Original-Message-ID: <CAHk-=whbOEhPUL1m8Ua-+-E7kJXED4xa+duzRF-wJKR84NAPWg@mail.gmail.com>
Message-ID: <CAHk-=whbOEhPUL1m8Ua-+-E7kJXED4xa+duzRF-wJKR84NAPWg@mail.gmail.com>
Subject: Re: [linus:master] [locking] c8afaa1b0f: stress-ng.zero.ops_per_sec
 6.3% improvement
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, 15 Aug 2023 at 07:12, kernel test robot <oliver.sang@intel.com> wrote:
>
> kernel test robot noticed a 6.3% improvement of stress-ng.zero.ops_per_sec on:

WTF? That's ridiculous. Why would that even test new_inode() at all?
And why would it make any difference anyway to prefetch a new inode?
The 'zero' test claims to just read /dev/zero in a loop...

[ Goes looking ]

>      39.35            -0.3       39.09        perf-profile.calltrace.cycles-pp.inode_sb_list_add.new_inode.shmem_get_inode.__shmem_file_setup.shmem_zero_setup

Ahh. It also does the mmap side, and the shared case ends up always
creating a new inode.

And while the test only tests *reading* and the mmap is read-only, the
/dev/zero file descriptor was opened for writing too, for a different
part of a test.

So even though the mapping is never written to, MAYWRITE is set, and
so the /dev/zero mapping is done as a shared memory mapping and we
can't do it as just a private one.

That's kind of stupid and looks unintentional, but whatever.

End result: that benchmark ends up being at least partly (and a fairly
noticeable part) a shmem setup benchmark, for no actual good reason.

Oh well. I certainly don't mind the removal apparently then also
helping some odd benchmark case, but I don't think this translates to
anything real. Very random.

                    Linus
