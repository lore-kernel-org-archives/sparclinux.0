Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45008C433EF
	for <sparclinux@archiver.kernel.org>; Tue, 12 Jul 2022 05:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiGLFiv (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 12 Jul 2022 01:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiGLFiv (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 12 Jul 2022 01:38:51 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F264012632
        for <sparclinux@vger.kernel.org>; Mon, 11 Jul 2022 22:38:47 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id s21so6668155pjq.4
        for <sparclinux@vger.kernel.org>; Mon, 11 Jul 2022 22:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=TDJSnzLSwL5TnhRSGkOInxm4fzXjDw8jSQVtBMTFQyU=;
        b=jwFqK0zIpWgNrgKWjoBsoEdpLMneegAR9ZBBZXQYWHEVBaaNLw83JXzTrN/6L9AGGD
         K+6ai9qRF5sSz+GJqil9ATpBGwy0OSkqR+zd5dPNGP4Xer+LtOAg+nljyaI3M1siWv13
         vktaCvo1Y4PpFA3u5xB1AwUPPN8ZhnUM+DqNttLqGdd0KlT46fTQBAAwW4vpH8LtV7Mm
         +BzGB1rFuYwgtr8R876s+6njfF3PwuZFes9tcuUCnhg2QipJ5zSOmM2Kp4S/HE3avhmN
         nbrF217++dDPYzPu2BEH4G1tjP8zmjllyyoEufZ8kngR5+T0wCpZetArVIFwyfPR2Kst
         PoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=TDJSnzLSwL5TnhRSGkOInxm4fzXjDw8jSQVtBMTFQyU=;
        b=QiUhdiDL61r+nOWjC01o4oRONIq0VGrKt6Q5Wur4VLpTLnLmgpCRglTedFnFz1XEqC
         PbD4DjIPcUMtdX5+32jLZnmOQamJ32RQwM9OPfmPuugiimURF3kNqxbCyI673dV0/J6g
         ibWYdriJIVdxLJRql5/wWcUszQWOseJ5yyOBk01r7uzHfQS51ZmZ2eYvj1QEhWm6/A7V
         XfrUrXurDcxhTOWGFT02XZmS+nTCZProafrl50L2nToN9pG+k8tpsLau91BFtUkZebO/
         +9JRkTyrbFeggn11BmHE6bixWT7Am9eWlWD7F8BMiaggrqlVA8i1DrAb0y+pTmuMH2H5
         9v2A==
X-Gm-Message-State: AJIora/Vr7wccGGp/1N7Ikv9D+eq1KlL1tYPvWdTQgKpouCEveUaMZbW
        I0lQpRK9zDIJUa0J9pTgijNm/gnWzOfwTiv/e8jJHSm+eZC5BQ==
X-Google-Smtp-Source: AGRyM1uNYfSIGOSUtf43R1BmFTT9uyrpKXfW96orooz2l8jf2CaiLaUsOrAoQKrtu7AQj3Z3rTXVAP/dvjBMeAXCYvY=
X-Received: by 2002:a17:902:db02:b0:16c:5568:d740 with SMTP id
 m2-20020a170902db0200b0016c5568d740mr4514023plx.100.1657604327061; Mon, 11
 Jul 2022 22:38:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac4:d06f:0:b0:535:c52f:e1cf with HTTP; Mon, 11 Jul 2022
 22:38:46 -0700 (PDT)
X-Originating-IP: [24.53.241.20]
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Tue, 12 Jul 2022 01:38:46 -0400
Message-ID: <CADyTPEwt=ZNams+1bpMB1F9w_vUdPsGCt92DBQxxq_VtaLoTdw@mail.gmail.com>
Subject: PROBLEM: Only one CPU active on Ultra 60 since ~4.8 (regression)
To:     sparclinux@vger.kernel.org
Cc:     Atish Patra <atish.patra@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi,

When using newer kernels on my Ultra 60 with dual 450MHz UltraSPARC-II
CPUs, I noticed that only CPU 0 comes up, while older kernels (including
4.7) are working fine with both CPUs.

I bisected the failure to this commit:

  9b2f753ec23710aa32c0d837d2499db92fe9115b is the first bad commit
  commit 9b2f753ec23710aa32c0d837d2499db92fe9115b
  Author: Atish Patra <atish.patra@oracle.com>
  Date:   Thu Sep 15 14:54:40 2016 -0600

      sparc64: Fix cpu_possible_mask if nr_cpus is set

This is a small change that reverts very easily on top of 5.18: there is
just one trivial conflict.  Once reverted, both CPUs work again.

Maybe this is related to the fact that the CPUs on this system are
numbered CPU0 and CPU2 (there is no CPU1)?

Here is /proc/cpuinfo on a working kernel:

    % cat /proc/cpuinfo
    cpu             : TI UltraSparc II  (BlackBird)
    fpu             : UltraSparc II integrated FPU
    pmu             : ultra12
    prom            : OBP 3.23.1 1999/07/16 12:08
    type            : sun4u
    ncpus probed    : 2
    ncpus active    : 2
    D$ parity tl1   : 0
    I$ parity tl1   : 0
    cpucaps         : flush,stbar,swap,muldiv,v9,mul32,div32,v8plus,vis
    Cpu0ClkTck      : 000000001ad31b4f
    Cpu2ClkTck      : 000000001ad31b4f
    MMU Type        : Spitfire
    MMU PGSZs       : 8K,64K,512K,4MB
    State:
    CPU0:           online
    CPU2:           online

And on a broken kernel:

    % cat /proc/cpuinfo
    cpu             : TI UltraSparc II  (BlackBird)
    fpu             : UltraSparc II integrated FPU
    pmu             : ultra12
    prom            : OBP 3.23.1 1999/07/16 12:08
    type            : sun4u
    ncpus probed    : 2
    ncpus active    : 1
    D$ parity tl1   : 0
    I$ parity tl1   : 0
    cpucaps         : flush,stbar,swap,muldiv,v9,mul32,div32,v8plus,vis
    Cpu0ClkTck      : 000000001ad31861
    MMU Type        : Spitfire
    MMU PGSZs       : 8K,64K,512K,4MB
    State:
    CPU0:           online

Let me know if you need any more info.

Thanks,
  Nick
