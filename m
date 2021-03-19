Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA34BC433E0
	for <sparclinux@archiver.kernel.org>; Fri, 19 Mar 2021 07:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA4164F42
	for <sparclinux@archiver.kernel.org>; Fri, 19 Mar 2021 07:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbhCSHgx (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 19 Mar 2021 03:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbhCSHgP (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 19 Mar 2021 03:36:15 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105B1C06175F
        for <sparclinux@vger.kernel.org>; Fri, 19 Mar 2021 00:36:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id bf3so9637215edb.6
        for <sparclinux@vger.kernel.org>; Fri, 19 Mar 2021 00:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cFztndHYvTA4SCUs/JT696S46MToc8dDZLMQpjlmP/w=;
        b=CzTKZRB9XYctro9yS5XAB4f/goe6vswB80rzcTfnZNg4T7Cma8Qi/fhIzzB/KHC10k
         HTJ58OoyZwnle68+XdAI8h967PqPZjC+EiYIitFjXPQH5vU0poLXTS0NvgZ3OqdS9Ynt
         YkpDGAvFVkC55xYqvaHTC4yF72gdYTqFz70nnarPrdj8xC+I8wRG/RPMBdcl+DqGjrLI
         Nk2ZpVEWqYwISrhe0UYSVoRfCdfkdIgENjg+lxJPIC7Yc33CpKh49FeQcUqRFG/p8bdS
         gASNDSLPbcuEuH5DWXuN04kbKDKWzdVSK0bF4xfll27q+ZMRG+QCgNFZ75ZWYMu51mUX
         zeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cFztndHYvTA4SCUs/JT696S46MToc8dDZLMQpjlmP/w=;
        b=ST6PO3qSafDj7TzCYRAnnJYTNyqhTl//fVNNrXVfSXOu2248rPFLAUZ86mfYCggL9B
         cM5+Hq2Jc6OaaeZRO+WbdWOuVyEdbm/WGAZpYQzPKH1nucoqPthbJnpJbfLPMph+rRdO
         im9+YdQrcn1RsZGg4xNW7JWOimIxx7Z29odrp5tEfh5SUsHk5dG9hZrOKS5jcVjTX+dp
         yRy1FOP53VExpU/fv1ZmIB7EiMVuHvG2mvlnjAhwr1sm7D3HMSDkNG2fymg+UIpn81MD
         /kUYFbhBfcHw7jhMTlfB7eS/Q/kcdpRPoqd0g6gOiceAN6BMpwWA6xGIZlNPyjqjc3Q3
         oIcg==
X-Gm-Message-State: AOAM531XUEote/XKqAPD5ipDNZCsPqf6g/7F09hj6fcr3O8xIpu0mqyN
        vxaQB3zTmklK7YNaqNIHzEv1Gfg3GV9UGuoHPUCx5Q==
X-Google-Smtp-Source: ABdhPJydspitSfVdkxaZUChndZECWQ64tBaAPD5xdSiZthfRlEdlcjDTauWloJ3dqWbr1lvF0vXI9JXbx9jJ9nNiKZ8=
X-Received: by 2002:aa7:d416:: with SMTP id z22mr7919214edq.239.1616139373731;
 Fri, 19 Mar 2021 00:36:13 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 19 Mar 2021 13:06:02 +0530
Message-ID: <CA+G9fYseDSQ2Vgg5Cb=8HHdpm56aeVQH0Vdx7JK1SktGpRRkgw@mail.gmail.com>
Subject: sparc: clang: error: unknown argument: '-mno-fpu'
To:     clang-built-linux <clang-built-linux@googlegroups.com>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, sparclinux@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Linux mainline master build breaks for sparc defconfig.
There are multiple errors / warnings with clang-12 and clang-11 and 10.
 - sparc (defconfig) with clang-12, clang-11 and clang-10
 - sparc (tinyconfig) with clang-12, clang-11 and clang-10
 - sparc (allnoconfig) with clang-12, clang-11 and clang-10

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=sparc
CROSS_COMPILE=sparc64-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
clang'
clang: error: unknown argument: '-mno-fpu'
clang: error: unknown argument: '-fcall-used-g5'
clang: error: unknown argument: '-fcall-used-g7'
make[2]: *** [/builds/linux/scripts/Makefile.build:116:
scripts/mod/devicetable-offsets.s] Error 1
clang: error: unknown argument: '-mno-fpu'
clang: error: unknown argument: '-fcall-used-g5'
clang: error: unknown argument: '-fcall-used-g7'
make[2]: *** [/builds/linux/scripts/Makefile.build:271:
scripts/mod/empty.o] Error 1

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

build link,
https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/jobs/1110841374#L81

steps to reproduce:
--------------------------
# TuxMake is a command line tool and Python library that provides
# portable and repeatable Linux kernel builds across a variety of
# architectures, toolchains, kernel configurations, and make targets.
#
# TuxMake supports the concept of runtimes.
# See https://docs.tuxmake.org/runtimes/, for that to work it requires
# that you install podman or docker on your system.
#
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.

tuxmake --runtime podman --target-arch sparc --toolchain clang-12
--kconfig defconfig


--
Linaro LKFT
https://lkft.linaro.org
