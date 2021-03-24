Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806E9C433E1
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 13:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CFE661A0B
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 13:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbhCXNZG (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 24 Mar 2021 09:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbhCXNYk (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 24 Mar 2021 09:24:40 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A757C061763
        for <sparclinux@vger.kernel.org>; Wed, 24 Mar 2021 06:24:39 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id w8so14085483ybt.3
        for <sparclinux@vger.kernel.org>; Wed, 24 Mar 2021 06:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xR5mFQZSFzqk0NyBHd1vhTGlx/ttxzoH0gU0klOnv9w=;
        b=HGNFUXu7IbjhbM0oZ+Diz2w82mEudexwaMAJTd3T+LW7VH29FJra4wy9zh1vhILu56
         IE9hT5ClAmOSB/+MdUoqExNNJx5xDlDEAVSZw3820pXORSlNabAvKjyBMG54rdjtcpz0
         jeOcW33rYSq1fr2Nq9+pCdVBPfYKaOcbx6MJjkM7eN0t43T5/tfKZi4eGUI3gupzHAhL
         WWmDmC9UszYASdoLcXQMk6dwrVgla6+4cj7qrqs8YDQ8DLOyMxqBzc4ppN8d74epXRRF
         jpoOcWpiXWqSW8BTg2MYyp1lkSo3BzukQjgZZWwj9D50ePyn1bikwLcuYJtJum0pXId+
         xidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xR5mFQZSFzqk0NyBHd1vhTGlx/ttxzoH0gU0klOnv9w=;
        b=JJBXwOIa4hxEVDhQey1IBuSDm19g+RvPsN6nqlbLqLCBDZzE9kyXi5NaJjKPJG+QOK
         2e/ipivVzEUM8Ecg4zjSSfH7gGpqZ7zokccFcu7LXOKv7buXrPrdk9lO9r+vily0jvJn
         EJ8gsPrAAYEXZ7M1qz1o1W4vXWFP0NhjP9b2CjZA4ghrPSM+GiX/Tk1boQOn6BqgEhhW
         qYTIWsRm5nrXC6nvi8Z2OlSrg987L5yhZStQJ9O1iYBpc1GQJHI0kGEX3ZFtB2R6F9RO
         iZOLIWFB8AFqBtK2uXYQOP5sm8sHoEWkiCkftrCTKeUAKEFX64+2avUWDoXl9m0fLz2H
         A09A==
X-Gm-Message-State: AOAM531Eodejcg3nWis5utbfr/0C/RLJ9PRigO2C/odii1AO5NAb8sWQ
        pRwMmQOYSASeL62N2WhApiMHcshaDH0XdhOKw7U=
X-Google-Smtp-Source: ABdhPJz5jAv6krpmKkc6mI1IPuzwgAoa0uQT9N9rr/ZWQMSyjoKS4fI5iuj0h8nrzB2Yyp+/vLGXj4eTXjnVa8L/szk=
X-Received: by 2002:a25:3801:: with SMTP id f1mr4894145yba.353.1616592278449;
 Wed, 24 Mar 2021 06:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <9ffdf604-ce04-9200-65c9-dd8921a45038@web.de> <186a7992-6e83-dc8a-1cfc-d07bb36935f5@physik.fu-berlin.de>
 <4d033ff9-329e-77e7-20de-720aa65bba3e@web.de> <n0n38p9-rn4s-213-n983-9o3o4oo8s54r@vanv.qr>
 <20210323165721.GA14577@lst.de> <d68767c2-e010-f90e-9f2c-bb5250465c58@web.de>
 <20210324082817.GA2625@lst.de> <8600c0fc-7144-4b38-d6ae-4dbbabb125ba@web.de>
 <dc37860d-168e-4e4e-475e-943556e8484f@physik.fu-berlin.de> <2c1d1de8-bbba-02b9-f0b5-d3d6cb089198@web.de>
In-Reply-To: <2c1d1de8-bbba-02b9-f0b5-d3d6cb089198@web.de>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Wed, 24 Mar 2021 16:24:25 +0300
Message-ID: <CADxRZqy0qZYs3442zyHfcw1Q0qfx_Quor+1OH2UMv43nz_HkJA@mail.gmail.com>
Subject: Re: Regression in 028abd92 for Sun UltraSPARC T1
To:     Frank Scheiner <frank.scheiner@web.de>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christoph Hellwig <hch@lst.de>,
        Jan Engelhardt <jengelh@inai.de>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, Mar 24, 2021 at 4:19 PM Frank Scheiner <frank.scheiner@web.de> wrote:
> On 24.03.21 14:16, John Paul Adrian Glaubitz wrote:
> > On 3/24/21 2:09 PM, Frank Scheiner wrote:> Kernel sources are not available on the T1000.
> >>
> >> If need be, where do they need to exist and how should the directory be
> >> named - `/usr/src/[...]`?
> >
> > Try installing "linux-source" and the "-dbg" package for your Debian kernel.
>
> But don't I need the source for the kernel at 028abd92? I figured, I
> need the sources in `/usr/src/linux-source-5.9.0-rc1+` because
> "5.9.0-rc1+" is the version the corresponding modules are installed -
> could that be correct?

Frank,

i'm using gdb from kernel sources directory (from which kernel is
installed), like:

$ uname -a
Linux ttip 5.12.0-rc4 #203 SMP Wed Mar 24 15:50:29 MSK 2021 sparc64 GNU/Linux
$ cd linux-2.6
linux-2.6$ git describe
v5.12-rc4
linux-2.6$ gdb -q vmlinux
Reading symbols from vmlinux...
(gdb) l *(sys_mount+0x114/0x1e0)
0x6dd7c0 is in __se_sys_mount (fs/namespace.c:3431).
3426            /* ... and return the root of (sub)tree on it */
3427            return path.dentry;
3428    }
3429    EXPORT_SYMBOL(mount_subtree);
3430
3431    SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
3432                    char __user *, type, unsigned long, flags,
void __user *, data)
3433    {
3434            int ret;
3435            char *kernel_type;
(gdb)
