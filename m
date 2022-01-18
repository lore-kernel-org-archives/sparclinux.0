Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CC8C4332F
	for <sparclinux@archiver.kernel.org>; Tue, 18 Jan 2022 11:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241074AbiARLsX (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 18 Jan 2022 06:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239760AbiARLsW (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 18 Jan 2022 06:48:22 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9383C061574;
        Tue, 18 Jan 2022 03:48:21 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id c6so15653069plh.6;
        Tue, 18 Jan 2022 03:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dejh5tcJ4gWGMzdNPEhsckEWG7ff8PXHm722G9XwW+k=;
        b=lhyWQKxAG89IPXoDBrz6HFbtQzqa9iaOYj+PFdjDoTlmha8BtPoN/SFZIdB4e77qbZ
         CBlTTcpb1QSpDDgbaKs/yMQRWx9xJEXXy+ObN+vGaqwEMUHvNvPJBcdihgIWzbIbwIyi
         t0z3JbvURqorA6ScZQzlV6PZRhjt97uJ/0+BbBjzHQmSKSLHn+JB8eFs2Fs6o8tQ/mKQ
         rUwpVZK3W7hmfBhNJ7b3ynsP/J30cSDxjWsJesM1dv+MWnERRqVLqHEqhrY7T3xefrk/
         40Idt100/aXP2A0ckDAObcJP+ame/UJT0rubeLfx0tMIplSAiSL4vidJMCU86XCODEqc
         kKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dejh5tcJ4gWGMzdNPEhsckEWG7ff8PXHm722G9XwW+k=;
        b=tgEzA75tCdbW9465sQfcQT3i0XFvlMxqwWv3kN9Mpr6jfz1qolRforlEXQ6mHzJ1Dw
         QMGk2L9t/7R+7Qo2aE/D6K4RVT3r22IH/hILpc7wCt26lZ38s+WSTwbVOdrrQwqGFXH7
         Ri8ncBrtJMI9BgdpBtMNi+JI7STXjLsDFEYTuCN+zK3mt0mDDMKOk1FCpXhPwGgbr4Vc
         FThCNaHghxjZyn386doOTPTw8SjcCEg5ZuHUveeWrFrKaYa3gk2T1Ut2g7szW1UokgON
         21wAPqdtV07fMcIo7wVHFFVwUBKkeW9gmaFllQubSEYaVZAnNWeXnbzan0OJp6Kb+LW3
         Uhhw==
X-Gm-Message-State: AOAM5328p7rI41zU19zNU3qs4z9MRNmlW+5cZCytAVq1vpL8r+r/51Ry
        3I9eiv/CR9HsoP4399HymsI=
X-Google-Smtp-Source: ABdhPJxwzr02xBpJ396V3SpOF+QPWB4Svb44p09ND0mT7txf7kG/F8oGaHQopWM70s1EOb1e2640uQ==
X-Received: by 2002:a17:902:ec83:b0:14a:3c28:6820 with SMTP id x3-20020a170902ec8300b0014a3c286820mr27820410plg.43.1642506501286;
        Tue, 18 Jan 2022 03:48:21 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id k9sm14959387pgr.47.2022.01.18.03.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 03:48:20 -0800 (PST)
Date:   Tue, 18 Jan 2022 20:48:17 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Michal Simek <monstr@monstr.eu>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        openrisc@lists.librecores.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@linux-xtensa.org, linux-kernel@linux-xtensa.org
Subject: Re: architectures that still need to remove set_fs()
Message-ID: <YeapAai1NIuy0zV4@antec>
References: <20220118074836.GA20994@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118074836.GA20994@lst.de>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi,

On Tue, Jan 18, 2022 at 08:48:36AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> you are in this list because your architecture still implements and
> uses address space overrides using set_fs(), which are deprecated and
> have been removed from all mainstream architecture ports.  To help
> cleanup the core kernel it would be great to make progress on removing
> set_fs entirely.
> 
> The following steps are required:
> 
>  (1) implement the __get_kernel_nofault and __put_kernel_nofault
>      helper to access kernel memory without page faults, replacing
>      the get/put_user under set_fs(KERNEL_DS) abuse.  Mips has a good
>      example for a trivial implementation for architectures that use
>      a common address space in commit 04324f44cb69

Also see commit 08ee3a009f49a which is preparation for removing set_fs/get_fs
this commit implements __get_kernel_nofault/__put_kernel_nofault for mips.

>  (2) remove any architecture specific use of such constructs.  This
>      only affects ia64 and sh.
>  (3) stop selecting the SET_FS and remove all the set_fs-related
>      infrastructure.  The above mips commit is a good guide once again.
> 
> Thanks!

I will look into this for OpenRISC.

-Stafford
