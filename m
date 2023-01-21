Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC73C004D4
	for <sparclinux@archiver.kernel.org>; Sat, 21 Jan 2023 13:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjAUNYv (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 21 Jan 2023 08:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAUNYv (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sat, 21 Jan 2023 08:24:51 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED47347080
        for <sparclinux@vger.kernel.org>; Sat, 21 Jan 2023 05:24:49 -0800 (PST)
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pJDrU-0004Z9-1J; Sat, 21 Jan 2023 14:24:48 +0100
Message-ID: <8e936732-6035-296d-f5ef-a1231b5216a8@leemhuis.info>
Date:   Sat, 21 Jan 2023 14:24:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US, de-DE
To:     Nick Bowler <nbowler@draconx.ca>, sparclinux@vger.kernel.org
Cc:     Atish Patra <atish.patra@oracle.com>
References: <CADyTPEwt=ZNams+1bpMB1F9w_vUdPsGCt92DBQxxq_VtaLoTdw@mail.gmail.com>
From:   "Linux kernel regression tracking (#adding)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: PROBLEM: Only one CPU active on Ultra 60 since ~4.8 (regression)
In-Reply-To: <CADyTPEwt=ZNams+1bpMB1F9w_vUdPsGCt92DBQxxq_VtaLoTdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1674307490;be4eff81;
X-HE-SMSGID: 1pJDrU-0004Z9-1J
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 12.07.22 07:38, Nick Bowler wrote:
> Hi,
> 
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

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 9b2f753ec23710aa32c0d837
#regzbot title sparc: only one CPU active on Ultra 60
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
