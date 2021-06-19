Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE222C48BE5
	for <sparclinux@archiver.kernel.org>; Sat, 19 Jun 2021 09:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8EFF611CE
	for <sparclinux@archiver.kernel.org>; Sat, 19 Jun 2021 09:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhFSJsJ (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 19 Jun 2021 05:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhFSJsI (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sat, 19 Jun 2021 05:48:08 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D51CC061574;
        Sat, 19 Jun 2021 02:45:57 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id g4so16105556qkl.1;
        Sat, 19 Jun 2021 02:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PzhHRAQ5Svkk0I70djnQE5HENy3mID1lQRTd49BDNKg=;
        b=vW+YLNCLFosuKGCa6q+hnHHqYNXp/k57Va1OC9XIrIkUq8Wk0aJiFck3fzzRM8jd9h
         Yd0sP0nr4w4at3yrJTuIg049EM+Uz8COeHdwGN3hzOeYRSMJq/O4QWAuS7+kR+l4Pmp8
         +YHI9pW6fXDDMPSDtBl/9+fmT1De5ICus/AvZvMnaPZik5eN8Y6Viu6ueqBO7OSHppaC
         v7tcwS0V7CKy88ZaTAZ6FDVst0dhH6cYmKDEj3JfEJI8OVyx0djlq5sUv17LntPpZnMJ
         RpNRvYfSmUjkyHdmhnmZGNw3yVO3QR7Ib+vAqP6gYV4xnaLwVnmlx729zTcMpIJ5mzfZ
         bbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PzhHRAQ5Svkk0I70djnQE5HENy3mID1lQRTd49BDNKg=;
        b=b9Zv8ISiNsOPW2Jp+tJl3xNyszO9F9NHj09Pwf6fSUxRJ9Y0NMgQbeG4PURdDyyeJD
         D4IetknrDuncaxmipPHRdTyf5ijuGGV929x3e7bTp21yNxk50gQxwSe26mbtf5nweNI8
         KBqQzAY6ackYXRy0NSYzwplwtmXWAxMQB4GiLZTeiubIFI5AFp3L9d4ttbggXCM0hvCf
         yvSfVnv2tGWdM2c3iEoTVOCpWOJwhpG9ETGqB5yQidwhiMs7HP80tx+D4ZaYzUcsCwkt
         tQPKzIQmxSdJ/Hc4lGCjY0EOZepnOBzpUlXdrsaa87BcPrGNJG9OBTdmsFVCORydqbz+
         /mhQ==
X-Gm-Message-State: AOAM531PEFNmGEErMrGJeLqpt+g1f2dif3tTWv4Mo9ILRWPEqc0G31rb
        EfbwXCzvU4aJMzOaQI5iy8FOa/mXOaEj1aW+T8XDK6DidF0iHA==
X-Google-Smtp-Source: ABdhPJzqgTsUss+Mlk8wTIbZKaO/PULpJ49bXoyv8GTim81lOQQyKy7c5dnduRsXsY6gra4Z8sR5zEYkSRAPJsWOpYk=
X-Received: by 2002:a25:26cb:: with SMTP id m194mr19905097ybm.362.1624095956135;
 Sat, 19 Jun 2021 02:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <CADxRZqwzbHvMwEB=y_xi2GYK55wtnzycWcUoK_t4q_ccisp+Sg@mail.gmail.com>
 <f9bd5a0e-6f9e-c042-cbfc-2e03bf16b92c@canonical.com>
In-Reply-To: <f9bd5a0e-6f9e-c042-cbfc-2e03bf16b92c@canonical.com>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Sat, 19 Jun 2021 12:45:45 +0300
Message-ID: <CADxRZqz6EZ-K+mWn4A5kp9yZEt1v1YjmFqeZNcf+W99fT2dm8w@mail.gmail.com>
Subject: Re: [sparc64] kernel panic from running a program in userspace
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>,
        kernel-testers@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Sat, Jun 19, 2021 at 12:31 PM Colin Ian King
<colin.king@canonical.com> wrote:
>
> Hi,
>
> I suspect this issue was fixed with the following commit:
>
> commit e5e8b80d352ec999d2bba3ea584f541c83f4ca3f
> Author: Rob Gardner <rob.gardner@oracle.com>
> Date:   Sun Feb 28 22:48:16 2021 -0700
>
>     sparc64: Fix opcode filtering in handling of no fault loads

Colin,

yes, but I believe that it was quite a different kernel bug.
Besides, my current kernel test is based on git kernel 5.13.0-rc6
(released last monday), which already includes the mentioned 'opcode'
fix.

> > stress-ng.git$ ./stress-ng --verbose --timeout 10m --opcode -1
> > stress-ng: debug: [480950] stress-ng 0.12.10 g27f90a2276bd
> > stress-ng: debug: [480950] system: Linux ttip 5.13.0-rc6 #229 SMP Tue
> > Jun 15 12:30:23 MSK 2021 sparc64
> > stress-ng: debug: [480950] RAM total: 7.8G, RAM free: 7.0G, swap free: 768.7M
> > stress-ng: debug: [480950] 8 processors online, 256 processors configured
> > stress-ng: info:  [480950] dispatching hogs: 8 opcode
