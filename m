Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAC7C433C1
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 12:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA813601FD
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 12:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbhCXMnO (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 24 Mar 2021 08:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbhCXMnF (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 24 Mar 2021 08:43:05 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A88FC061763
        for <sparclinux@vger.kernel.org>; Wed, 24 Mar 2021 05:43:05 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id o66so13941964ybg.10
        for <sparclinux@vger.kernel.org>; Wed, 24 Mar 2021 05:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5koTzc7SocDwyyR+0u0cdPsa9/u7b9iziGmsMmokCg4=;
        b=K7VsrfppCDDgtGML5QwEcCn1Tbi6UdXw03q/3YexaCxNje92ZRM4FZmccT+uG0Mtpo
         nHbu0xK8ReQBGbQSRLTlZSWqTBRX+LV/n+rL9Klc4V9iZtP6TjqjdCNUABiFOEzmUO9E
         J7VtENwHEfRDCGjwv+AtpRUt3t5JG24HQ5Y58MnHx2c+AMe62Io2h5/CdXCpLp8xzOw9
         XUlRvAkcypu8vUIGI/VCItPO/8tPtnAatcntISdCzPqWES7UNM6b8iq6pBHMXHSjFvdT
         kaSjqFxGgJTCy4Wr1w4fCvBBNK5p3VlkcnRjIj+aT5y+v3zFXbC4DiFzTXA7WxylqJoI
         97kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5koTzc7SocDwyyR+0u0cdPsa9/u7b9iziGmsMmokCg4=;
        b=lMVnNTKw1lvvteCfPaCyi8yQ5wOcVpc+59A0+cmtMz+cr7sbqL1roZAhhfM2P2O+4C
         VBbS+fGRANzyX09x+PQJZCXRamXkeD+xzAszmHBwdIJ0T0TPgR0s58TnsJvVjpzM1LWU
         09RVjqWcAcrFWX3TMQlQaraPLyOeYKVSZLKC0BHhM4pWfLLSrV8BC43djxy0PZFjCfgK
         cOuBj1GNfWx43yvGdtB0mDOxF249aJVe3tLwOYKzVU3TIR/idxRH7AM53BTNu2Ae86Wp
         ASHjIApIo2GiUWIHGcB4TB3wsoYaQUUdUeAGDoQ00v9TEUOb53DFt5tLCJe20Sg0Bn0x
         y3XQ==
X-Gm-Message-State: AOAM530PVmDKnkpM+sOV3Pp/SQVjCoWj579cocafVxXml1TFh4+MYwav
        +I8fo+BGLlG/5rpGzJj4Wi0ihWfcvMWMXDQR50o=
X-Google-Smtp-Source: ABdhPJxcHlh9HbAu5m6XVPhkDxWdzDaS+7s7YV2+lBpgsPc8Se4siCfs7GGpOXvdmyIU4jADAPW7SyGdwXQmnp7T9JI=
X-Received: by 2002:a25:ae87:: with SMTP id b7mr4321715ybj.25.1616589784960;
 Wed, 24 Mar 2021 05:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <9ffdf604-ce04-9200-65c9-dd8921a45038@web.de> <186a7992-6e83-dc8a-1cfc-d07bb36935f5@physik.fu-berlin.de>
 <4d033ff9-329e-77e7-20de-720aa65bba3e@web.de> <n0n38p9-rn4s-213-n983-9o3o4oo8s54r@vanv.qr>
 <20210323165721.GA14577@lst.de> <d68767c2-e010-f90e-9f2c-bb5250465c58@web.de>
 <20210324082817.GA2625@lst.de> <de572001-6238-8fda-aab4-f2ca443f2057@web.de>
In-Reply-To: <de572001-6238-8fda-aab4-f2ca443f2057@web.de>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Wed, 24 Mar 2021 15:42:52 +0300
Message-ID: <CADxRZqz0XkgGHyi_pMDc1w5ZQY8BR0hT11_8aP+WHhQ42+BtLg@mail.gmail.com>
Subject: Re: Regression in 028abd92 for Sun UltraSPARC T1
To:     Frank Scheiner <frank.scheiner@web.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Engelhardt <jengelh@inai.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, Mar 24, 2021 at 3:31 PM Frank Scheiner <frank.scheiner@web.de> wrote:
> Sorry, but I can't install `gdb` on my T1000 ATM, because it depends on
> "libpython3.8" for sparc64 (see [1]) and "libpython3.9" for the other
> architectures, but "libpython3.8" is actually not available for sparc64,
> "libpython3.9" is available for sparc64 though:
> ...
> The following packages have unmet dependencies:
>   gdb : Depends: libpython3.8 (>= 3.8.2) but it is not installable
>         Recommends: libc-dbg
> E: Unable to correct problems, you have held broken packages.
> ```
> Something wrong with the dependencies. Any suggestions?

Frank,

you could use http://snapshot.debian.org to install old versions of
packages, i.e. gdb and libpython-3.8
