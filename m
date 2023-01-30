Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CA4C54EED
	for <sparclinux@archiver.kernel.org>; Mon, 30 Jan 2023 10:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbjA3KUE (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 30 Jan 2023 05:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbjA3KUD (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 30 Jan 2023 05:20:03 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD4335B6
        for <sparclinux@vger.kernel.org>; Mon, 30 Jan 2023 02:20:02 -0800 (PST)
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pMQbl-0003Hy-BJ; Mon, 30 Jan 2023 10:37:49 +0100
Message-ID: <3d5f1e39-0ee7-0b5c-afa7-ef31b87bd1ef@leemhuis.info>
Date:   Mon, 30 Jan 2023 10:37:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: PROBLEM: sparc64 random crashes starting w/ Linux 6.1
 (regression)
Content-Language: en-US, de-DE
To:     Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, regressions@lists.linux.dev
Cc:     Peter Xu <peterx@redhat.com>
References: <CADyTPExpEqaJiMGoV+Z6xVgL50ZoMJg49B10LcZ=8eg19u34BA@mail.gmail.com>
From:   "Linux kernel regression tracking (#adding)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CADyTPExpEqaJiMGoV+Z6xVgL50ZoMJg49B10LcZ=8eg19u34BA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1675074002;56676f48;
X-HE-SMSGID: 1pMQbl-0003Hy-BJ
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 29.01.23 03:17, Nick Bowler wrote:
> 
> Starting with Linux 6.1.y, my sparc64 (Sun Ultra 60) system is very
> unstable, with userspace processes randomly crashing with all kinds of
> different weird errors.  The same problem occurs on 6.2-rc5.  Linux
> 6.0.y is OK.
> 
> Usually, it manifests with ssh connections just suddenly dropping out
> like this:
> 
>   malloc(): unaligned tcache chunk detected
>   Connection to alectrona closed.
> 
> but other kinds of failures (random segfaults, bus errors, etc.) are
> seen too.
> 
> I have not ever seen the kernel itself oops or anything like that, there
> are no abnormal kernel log messages of any kind; except for the normal
> ones that get printed when processes segfault, like this one:
> 
>   [  563.085851] zsh[2073]: segfault at 10 ip 00000000f7a7c09c (rpc
> 00000000f7a7c0a0) sp 00000000ff8f5e08 error 1 in
> libc.so.6[f7960000+1b2000]
> 
> I was able to reproduce this fairly reliably by using GNU ddrescue to
> dump a disk from the dvd drive -- things usually go awry after a minute
> or two.  So I was able to bisect to this commit:
> 
>   2e3468778dbe3ec389a10c21a703bb8e5be5cfbc is the first bad commit
>   commit 2e3468778dbe3ec389a10c21a703bb8e5be5cfbc
>   Author: Peter Xu <peterx@redhat.com>
>   Date:   Thu Aug 11 12:13:29 2022 -0400
> 
>       mm: remember young/dirty bit for page migrations
> 
> This does not revert cleanly on master, but I ran my test on the
> immediately preceding commit (0ccf7f168e17: "mm/thp: carry over dirty
> bit when thp splits on pmd") extra times and I am unable to get this
> one to crash, so reasonably confident in this bisection result...
> 
> Let me know if you need any more info!

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 2e3468778dbe3ec3
#regzbot title sparc64: random crashes
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
