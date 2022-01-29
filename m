Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA13CC43219
	for <sparclinux@archiver.kernel.org>; Sat, 29 Jan 2022 15:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbiA2PXn (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 29 Jan 2022 10:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350779AbiA2PXl (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sat, 29 Jan 2022 10:23:41 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077A5C06174A
        for <sparclinux@vger.kernel.org>; Sat, 29 Jan 2022 07:23:39 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id e17so13237352ljk.5
        for <sparclinux@vger.kernel.org>; Sat, 29 Jan 2022 07:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=drummond.us; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0mCWH6Tux8tcx0O8BuZbvK36ydxh3XeFUHA8Flrblcc=;
        b=cmvGYiFpo2ar6tVj5q2BCQVYb9k8BBD0XwhyxqAVItAmy2DCdgiftAuj8oc7BBE49Q
         LjK1fzbe0hOX97nInIogSNxADc9w4GpCfyauU6NFtNktDIG03u61lrQy9hqdUvd6EUft
         C6I/tHY4kzyBauIRoXYOzo9LGSe929OK0jEzQ59wjAL3By0a+QjA0M9X3G7I1kcoxcb7
         Q0AdPG8TS8c6yTTOUze5l0qFpdoVitgV/p2s3UNbwqPC0EG+SKAZieLlLnSPMO8rnFD5
         +FIv54+PLtXCBluE0vkOLnAVfI1OEciJIeE6mtAgIHH1+Z3qSeTB6dFp5Kah63auycAx
         k05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0mCWH6Tux8tcx0O8BuZbvK36ydxh3XeFUHA8Flrblcc=;
        b=TsqkPnxr8827o7y91ka9llvpS7JQh9DaQa81M3O2Timh7UdUhUq2lixWpaUfdvRZ4Q
         QA5+IJbOLARUOFAPbIYzZkdUjNublHCoA3ywJbt37gEPvAJlo4aZf+EdOGDmbyj28BuO
         BLd3ccfSdgTPAYxwnkJEMc7HwI5B6kEjpGkTzJkiv6HzGsqjkDYBsKHWojV2cQLk2HOK
         MSJ3i6if57WT4GVb5Fcnk3uuAuMd24bnjSTUwhh+HeSmQCzaPssvHrRiDxPPk/yVDN+V
         vOmIMZscyM258h5mJnptPHI9pcGfoHk0zWhr0d4r9XUk6cQb1bKo+i/c4JCzkRdvf28T
         /hww==
X-Gm-Message-State: AOAM5300O6WlJBHZYG59BiKOrkLqVqE9JDGPXn0572pkCAb3bkXu7aIX
        Ck3S+jvpx+mIz2u8Q/MhVzZgX+1YXEc+AbDl9bFn7Q==
X-Google-Smtp-Source: ABdhPJzK4pFoabd9NoIBHHNS2OQ2X0frUhiKWXvHsU/uBjqxnLeu+8dmN2me2gLqvfH4JEfcPiamxCIYMad5ipU8E2c=
X-Received: by 2002:a2e:994a:: with SMTP id r10mr8482884ljj.254.1643469817879;
 Sat, 29 Jan 2022 07:23:37 -0800 (PST)
MIME-Version: 1.0
References: <20220118044259.764945-1-walt@drummond.us> <YfFQeC1cUVFmISMK@kroah.com>
In-Reply-To: <YfFQeC1cUVFmISMK@kroah.com>
From:   Walt Drummond <walt@drummond.us>
Date:   Sat, 29 Jan 2022 07:23:26 -0800
Message-ID: <CADCN6nyyChM=jb9nmc2jDg2UdHUoXp3E05=ifxRpcs=8k8t09Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] status: TTY status message request
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     agordeev@linux.ibm.com, arnd@arndb.de, benh@kernel.crashing.org,
        borntraeger@linux.ibm.com, chris@zankel.net, davem@davemloft.net,
        hca@linux.ibm.com, deller@gmx.de, ink@jurassic.park.msu.ru,
        James.Bottomley@hansenpartnership.com, jirislaby@kernel.org,
        mattst88@gmail.com, jcmvbkbc@gmail.com, mpe@ellerman.id.au,
        paulus@samba.org, rth@twiddle.net, dalias@libc.org,
        tsbogend@alpha.franken.de, gor@linux.ibm.com, ysato@users.osdn.me,
        linux-kernel@vger.kernel.org, ar@cs.msu.ru,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

ACK, will do.

On Wed, Jan 26, 2022 at 5:45 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 17, 2022 at 08:42:57PM -0800, Walt Drummond wrote:
> > This patchset adds TTY status message request feature to the n_tty
> > line dicipline.  This feature prints a brief message containing basic
> > system and process group information to a user's TTY in response to a
> > new control character in the line dicipline (default Ctrl-T) or the
> > TIOCSTAT ioctl.  The message contains the current system load, the
> > name and PID of an interesting process in the forground process group,
> > it's run time, percent CPU usage and RSS.  An example of this message
> > is:
> >
> >   load: 0.31  cmd: sleep 3616843 [sleeping] 0.36r 0.00u 0.00s 0% 696k
> >
> > User API visible changes are limited to:
> >  - The addition of VSTATUS in termios.c_cc[]
> >  - The addition of NOKERNINFO bit in termios.l_cflags
> >  - The addition of the TIOCSTAT ioctl number
> >
> > None of these changes break the existing kernel api as the termios
> > structure on all architectures has enough space in the control
> > character array (.c_cc) for the new character, and the other changes
> > are space agnostic.
> >
> > This feature is in many other Unix-like systems, both current and
> > historical.  In other implementations, this feature would also send
> > SIGINFO to the process group; this implementation does not.
> >
> > Walt Drummond (3):
> >   vstatus: Allow the n_tty line dicipline to write to a user tty
> >   vstatus: Add user space API definitions for VSTATUS, NOKERNINFO and
> >     TIOCSTAT
> >   status: Display an informational message when the VSTATUS character is
> >     pressed or TIOCSTAT ioctl is called.
> >
> >  arch/alpha/include/asm/termios.h         |   4 +-
> >  arch/alpha/include/uapi/asm/ioctls.h     |   1 +
> >  arch/alpha/include/uapi/asm/termbits.h   |  34 ++---
> >  arch/ia64/include/asm/termios.h          |   4 +-
> >  arch/ia64/include/uapi/asm/termbits.h    |  34 ++---
> >  arch/mips/include/asm/termios.h          |   4 +-
> >  arch/mips/include/uapi/asm/ioctls.h      |   1 +
> >  arch/mips/include/uapi/asm/termbits.h    |  36 ++---
> >  arch/parisc/include/asm/termios.h        |   4 +-
> >  arch/parisc/include/uapi/asm/ioctls.h    |   1 +
> >  arch/parisc/include/uapi/asm/termbits.h  |  34 ++---
> >  arch/powerpc/include/asm/termios.h       |   4 +-
> >  arch/powerpc/include/uapi/asm/ioctls.h   |   2 +
> >  arch/powerpc/include/uapi/asm/termbits.h |  34 ++---
> >  arch/s390/include/asm/termios.h          |   4 +-
> >  arch/sh/include/uapi/asm/ioctls.h        |   1 +
> >  arch/sparc/include/uapi/asm/ioctls.h     |   1 +
> >  arch/sparc/include/uapi/asm/termbits.h   |  38 +++---
> >  arch/xtensa/include/uapi/asm/ioctls.h    |   1 +
> >  drivers/tty/Makefile                     |   2 +-
> >  drivers/tty/n_tty.c                      | 113 +++++++++++-----
> >  drivers/tty/n_tty_status.c               | 162 +++++++++++++++++++++++
> >  drivers/tty/tty_io.c                     |   2 +-
> >  include/asm-generic/termios.h            |   4 +-
> >  include/linux/tty.h                      | 123 ++++++++---------
> >  include/uapi/asm-generic/ioctls.h        |   1 +
> >  include/uapi/asm-generic/termbits.h      |  34 ++---
> >  27 files changed, 461 insertions(+), 222 deletions(-)
> >  create mode 100644 drivers/tty/n_tty_status.c
> >
> > --
> > 2.30.2
> >
>
> You forgot to cc: me on patch 2/3, which would be needed if I was to
> take them all.
>
> Please fix up patch 2 and resend the whole series.
>
> thanks,
>
> greg k-h
