Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A97C433C1
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 16:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 883D0619F3
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 16:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbhCXQeG (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 24 Mar 2021 12:34:06 -0400
Received: from mout.web.de ([217.72.192.78]:41143 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235878AbhCXQdv (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Wed, 24 Mar 2021 12:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1616603618;
        bh=wyjiF4IYovZTckNAemeqLa7r7yK7qFKJOspKltO06zw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LY70SvH9w0ARt3kd9tXW62uKv6XL7tPXuvTgvU4D7bscV+MzdjKxh1oDGP/AQAH11
         yy1QaSBRitT3kuzybeje2QTy3tKrXvEW1/nMQ8VNVHSQZG/02ayoczUQdQTWa2ivyP
         EV+yp7667mQJsnN+KupAHOWuzFKlInsPBgm50iLE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.30] ([217.247.35.184]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LlneG-1lyRCU0anI-00ZPJW; Wed, 24
 Mar 2021 17:33:38 +0100
Subject: Re: Regression in 028abd92 for Sun UltraSPARC T1
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Engelhardt <jengelh@inai.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>
References: <9ffdf604-ce04-9200-65c9-dd8921a45038@web.de>
 <186a7992-6e83-dc8a-1cfc-d07bb36935f5@physik.fu-berlin.de>
 <4d033ff9-329e-77e7-20de-720aa65bba3e@web.de>
 <n0n38p9-rn4s-213-n983-9o3o4oo8s54r@vanv.qr> <20210323165721.GA14577@lst.de>
 <d68767c2-e010-f90e-9f2c-bb5250465c58@web.de> <20210324082817.GA2625@lst.de>
 <a356b88c-2b75-3d8b-ba47-8f0c6d0420e0@web.de>
 <p1p52s61-n8p-s29n-n195-q22rs07qoq40@vanv.qr>
 <250aaeb3-40fe-60c7-044e-aa9daacd7c12@web.de> <20210324161045.GA5969@lst.de>
From:   Frank Scheiner <frank.scheiner@web.de>
Message-ID: <092f6c45-d4fe-ac02-d416-e644e2f26795@web.de>
Date:   Wed, 24 Mar 2021 17:33:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210324161045.GA5969@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7Z0m9Cu85iM7QQMt0nIfTpj9rRZazYdt+Er/3rNSUpyVbCEQH7g
 5DwFwM4TCgzvDsTpbeWX9bgUtakAz3GU4LMvQvlT5Wu2xq7jPM4mnXcGSvTSauvOA4ieEy7
 sznv/Brp2m6suo6/ITEhilWusho8UOzxFmhtis/FD5nI8NqqvrZAbdxjCc7wS1tylntLJWy
 IvRmMMEbrFl5yVSnBHKqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oGWZQT5vqrE=:EVzgDHwoGs20pF8yeDU1Cw
 +FcOibrnH53epV+TbuokcYI3N8WLXO58GLsCAP4OI82eWwCxZsa8HBJZGoxn22zyT7fnKX73T
 5xp7ytHd5INLidhOaZpi2EaINvUOnA8hkISPyFrDl5OLIezIC2F2uU66H71EF+OARsa2fmCWw
 GofdD/ZeB2sOpcg/Ooow7Rj3SCBKGG0JXrG93NJ6rUyVoJ6O4bGOsVpXwQq7KMdyGFfZoSKnt
 6K9N3Ii2rUv4wckk82l1qU1Kr2Z1Yt+DhBPd17hXTk/gTaR6fjePAGzQMTjQUDCgHVSSFZSib
 ZcXZZ1zKAbAEO0inANZhvcQNVAIZI9OEW3LlyM1BxfcFVQ6Dy3YtX9+FdKlBEp0SKWREwEpAr
 UEXpUFGA9IMGVazQy4reta4w0Ji8DDLJbXA1nJW/w3Cjm3xUt2Pc+Wo+HB5WTUTzMb8LxzI1t
 R0H/GmOjfmdbLyHExqv+1jzpDh9x5VwqtcoCeXSSDGnDoZULqNIuwtt5hIoA+q95iQQ+8SrT7
 SFIIZWus+0m8wsGtDpDyl13LLAOLPoxnfSRkIY2dPdHm0wD9q/wPKOszxl96h6FrVF0kiRWsy
 xjTlNedMaMrQqOrgXni4y9KXiud25Zp/ECphhYpJXxKnmxeddbZYDJMfOni4TETsRNZLCmupm
 TUnijRB0rDjlWj2O0iHPRWVTZIC4BceinzwfeI1sQPCQ96QNiTWiqjxZfvnnTM0grokatkxyB
 uMe+PZuD755X+ZoSwjGYl8Klv8fIy6bpQMrxXN6nRGErO0DiSzEdo+3+MJ8DG670VcvJX34MF
 76i3NSHLo1T99R/w3BHaRw6OQ0gePCN7kgArP1u+ETOIxbhQAYtfWZs6UbFJgGu0VWMOQItLC
 zzJVdkMojRNA0JPdJIoA==
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 24.03.21 17:10, Christoph Hellwig wrote:
> On Wed, Mar 24, 2021 at 04:58:39PM +0100, Frank Scheiner wrote:
>> [   20.090279] [<00000000006c6494>] sys_mount+0x114/0x1e0
>> [   20.090338] [<00000000006c6454>] sys_mount+0xd4/0x1e0
>> [   20.090499] [<0000000000406274>] linux_sparc_syscall+0x34/0x44
>> [   20.090697] Disabling lock debugging due to kernel taint
>> [   20.090770] Caller[00000000006c6494]: sys_mount+0x114/0x1e0
>> [   20.090926] Caller[00000000006c6454]: sys_mount+0xd4/0x1e0
>> [   20.091133] Caller[0000000000406274]: linux_sparc_syscall+0x34/0x44
>> [   20.091196] Caller[0000000000100aa8]: 0x100aa8
>> [...]
>> ```
>>
>> [1]: https://pastebin.com/ApPYsMcu
>>
>> Here the result for the suggested command:
>
> Thanks.  And very strange, as i can't find what would free options
> before.  Does the system boot if you comment out that kfree in line
> 3415 (even if that casues a memleak elsewhere).

Unfortunately not, the result with the kfree() commented in
fs/namespace.c:3415 looks pretty similar in my eyes. Log is on [2]

[1]: https://pastebin.com/zmSFpv3R

Cheers,
Frank

