Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D8DC004D4
	for <sparclinux@archiver.kernel.org>; Fri, 20 Jan 2023 03:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjATDQH (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 19 Jan 2023 22:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjATDQB (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 19 Jan 2023 22:16:01 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D396B27BE
        for <sparclinux@vger.kernel.org>; Thu, 19 Jan 2023 19:15:39 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id 3so4343426vsq.7
        for <sparclinux@vger.kernel.org>; Thu, 19 Jan 2023 19:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Hpc5Ciyxu29gomOTvRt7HRyn5ui+yh0jFZKfccP/3A=;
        b=6ipErWbF5wYAMGrwowJPn2VP4KJ9ijlP4WCHTjoDjDh9WU2oC66c2szaAh27ljPc/2
         /qcJlPmhvqZmNOYwkIXjFzWXXYg3MM+iGn+Mv3KFuOdX692Pmq0PW5Z7IcBwlMFLjDpT
         r2tUwTkUAm9b0oCWn3acyclThA0FWFRKYmWlrcjw+AYHlcXhWfSIgH0tkXNqrWEjeTrQ
         L6NMCRU0hmCZUWhwYST4V6b6L4P6XUhlyvTw8zLAZZd5CMnYiYGIusHPB8xwEdTVSQGu
         /Wis04U9Zb5RvqO9FjEV3MuaPyXKgigSsleVPI8wC0SMbslSqQP6AsNmsXpW1ZQaZIha
         0zuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Hpc5Ciyxu29gomOTvRt7HRyn5ui+yh0jFZKfccP/3A=;
        b=XR8OSf5Pk2681XL8UkzwFOwKiICAqxCQp4Ggbm4hDeaVqPuQtzsEhl9TGwC+xV8cPO
         gJtPj/LcrfdaZLkyBv+vkKUv/IQqFO5xQQbtwzAZ+j7TSorYJxaDBdLBKxegk2OXKoeK
         OBAys1R0zcbCN7ertGACT6Pt582Rpl67s4Gx/JLLsdi+XJ6bT8g0vxcBVefKWSG3+WFd
         fCMsJahcavCGYoiuqDHARIubK1McSBMvKkR9zY22Lvk2rwquMm3s/TpITQr9ohCyP/2/
         /nqfRFHqXNRLhBIJCQkaQa+xOaZH3IuK6kKmadH+X5i0EzgJOVDpn1G9JAn5bPeMCtmm
         sz6A==
X-Gm-Message-State: AFqh2kpxL9IMRltf1vVoly4kqFIJ5OtBHUIm0SCS3rLwzl5vQ5BRQy8w
        HAwWblsTk4AsJyOSn0/Fw13cAdln7p9nnuMAuqkdw6PP0XEIJIXw9Fc=
X-Google-Smtp-Source: AMrXdXtjyf+fQ9q4OP75X7YsCp1FrKqaqir0r4nm353FcrUzBifgDBMUDDotUCcoXFmJIxCcDXn5Q2jRa2S9UonXbu0=
X-Received: by 2002:a05:6102:1510:b0:3d3:e5dc:e359 with SMTP id
 f16-20020a056102151000b003d3e5dce359mr1785070vsv.61.1674184538020; Thu, 19
 Jan 2023 19:15:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6130:1015:b0:559:9619:d862 with HTTP; Thu, 19 Jan 2023
 19:15:37 -0800 (PST)
X-Originating-IP: [24.53.241.20]
In-Reply-To: <CADyTPEwt=ZNams+1bpMB1F9w_vUdPsGCt92DBQxxq_VtaLoTdw@mail.gmail.com>
References: <CADyTPEwt=ZNams+1bpMB1F9w_vUdPsGCt92DBQxxq_VtaLoTdw@mail.gmail.com>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Thu, 19 Jan 2023 22:15:37 -0500
Message-ID: <CADyTPEyAidGgBT3f1VJLHb3ouO-r1UyvFp1PcwXxy0NRG94sbw@mail.gmail.com>
Subject: Re: PROBLEM: Only one CPU active on Ultra 60 since ~4.8 (regression)
To:     sparclinux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi,

I'm resending this report CC'd to linux-kernel as there was no response
on the sparclinux list.

I tried 6.2-rc4 and there is no change in behaviour.  Reverting the
indicated commit still works to fix the problem.

On 2022-07-12, Nick Bowler <nbowler@draconx.ca> wrote:
> When using newer kernels on my Ultra 60 with dual 450MHz UltraSPARC-II
> CPUs, I noticed that only CPU 0 comes up, while older kernels (including
> 4.7) are working fine with both CPUs.
>
> I bisected the failure to this commit:
>
>   9b2f753ec23710aa32c0d837d2499db92fe9115b is the first bad commit
>   commit 9b2f753ec23710aa32c0d837d2499db92fe9115b
>   Author: Atish Patra <atish.patra@oracle.com>
>   Date:   Thu Sep 15 14:54:40 2016 -0600
>
>       sparc64: Fix cpu_possible_mask if nr_cpus is set
>
> This is a small change that reverts very easily on top of 5.18: there is
> just one trivial conflict.  Once reverted, both CPUs work again.
>
> Maybe this is related to the fact that the CPUs on this system are
> numbered CPU0 and CPU2 (there is no CPU1)?
>
> Here is /proc/cpuinfo on a working kernel:
>
>     % cat /proc/cpuinfo
>     cpu             : TI UltraSparc II  (BlackBird)
>     fpu             : UltraSparc II integrated FPU
>     pmu             : ultra12
>     prom            : OBP 3.23.1 1999/07/16 12:08
>     type            : sun4u
>     ncpus probed    : 2
>     ncpus active    : 2
>     D$ parity tl1   : 0
>     I$ parity tl1   : 0
>     cpucaps         : flush,stbar,swap,muldiv,v9,mul32,div32,v8plus,vis
>     Cpu0ClkTck      : 000000001ad31b4f
>     Cpu2ClkTck      : 000000001ad31b4f
>     MMU Type        : Spitfire
>     MMU PGSZs       : 8K,64K,512K,4MB
>     State:
>     CPU0:           online
>     CPU2:           online
>
> And on a broken kernel:
>
>     % cat /proc/cpuinfo
>     cpu             : TI UltraSparc II  (BlackBird)
>     fpu             : UltraSparc II integrated FPU
>     pmu             : ultra12
>     prom            : OBP 3.23.1 1999/07/16 12:08
>     type            : sun4u
>     ncpus probed    : 2
>     ncpus active    : 1
>     D$ parity tl1   : 0
>     I$ parity tl1   : 0
>     cpucaps         : flush,stbar,swap,muldiv,v9,mul32,div32,v8plus,vis
>     Cpu0ClkTck      : 000000001ad31861
>     MMU Type        : Spitfire
>     MMU PGSZs       : 8K,64K,512K,4MB
>     State:
>     CPU0:           online
>
> Let me know if you need any more info.
>
> Thanks,
>   Nick
