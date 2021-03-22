Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC11C433DB
	for <sparclinux@archiver.kernel.org>; Mon, 22 Mar 2021 21:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF07E619A8
	for <sparclinux@archiver.kernel.org>; Mon, 22 Mar 2021 21:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCVVz7 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 22 Mar 2021 17:55:59 -0400
Received: from mout.web.de ([212.227.17.12]:47533 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhCVVzw (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Mon, 22 Mar 2021 17:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1616450126;
        bh=lBu0m2WJSn96hCQHaQusGQiAakvZbDb+PgDDIlt9ixk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UKvPGMe3nkKPh1fYGpPh9CcjRf1EmVm3oJMVfUTtUEebb39pCKhZLfTFLGNN0wt/U
         aknqVObRNlQfIfCM/wierR1TsFcwl7vbjym17u0ggUJdUvMtiNjBgwwllxoH97F8Fy
         bMznQuFchivlvhKx6/xYlDeUkSxI700aY0LCIDlk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.30] ([87.155.239.151]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mf3qK-1lrjb218tm-00gmQR; Mon, 22
 Mar 2021 22:55:26 +0100
Subject: Re: Regression in 028abd92 for Sun UltraSPARC T1
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sparc kernel list <sparclinux@vger.kernel.org>
Cc:     debian-sparc <debian-sparc@lists.debian.org>,
        Christoph Hellwig <hch@lst.de>
References: <9ffdf604-ce04-9200-65c9-dd8921a45038@web.de>
 <186a7992-6e83-dc8a-1cfc-d07bb36935f5@physik.fu-berlin.de>
From:   Frank Scheiner <frank.scheiner@web.de>
Message-ID: <4d033ff9-329e-77e7-20de-720aa65bba3e@web.de>
Date:   Mon, 22 Mar 2021 22:55:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <186a7992-6e83-dc8a-1cfc-d07bb36935f5@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L38dVAc77msEM/iZI/qYQcJTU26zDo5jGC+Cncj8pb5D29bFxpN
 1D77YyZ9BPmUTSS3rUwdXf2dt+TF6iX0Y+ed2Lrk5MVjLTN1SyMpStyxhfiQ/c0o7KsiXQc
 7EVtV63jxa0VAWvCiuCS6Zi+Ts1djrmyn1Fey8Cj4rXxSQNJVJvFZLm5p+1pFEsAC29txBb
 IU4i9X6C9+13Tg0lvIBOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Shkj7DthxR8=:jirruQlOoPHhCm4IT6BNXz
 ngkL4JNF150DXovhXpvs+KDYOY4wChQVsG4g8UYMuo0UJtKYguH2Wh394iHV0W4jnk4R6SBz+
 tLuIeplEyXPVvtLs0jp53zfWqReqUghetbR6CgsCO5cqibnzeTw9+wo5FnjYQ4D0oscu0rLoN
 RKpUvH/xFTpMaOinp+BzWjbtexrXY53dP+k9xjQBDbGwZX7te/byPJKCP/qUfvu7CrCMucRmS
 VlClOq9w2WEK4nChIG7DZKq0CIqybi/eCqPgDm6modKdFvBqvtTomeV/Aqe32RVERObCOadVQ
 ruOCs3EHgjz+XNEmy6ZHyTRUsWT1jBPEciWrqMo6O9uBIek3IJ6SVku3+Ns7sbmfgjQxepy5D
 cbBc4i16B6P6oC1y6tDpsx/5e6FhiuhwNtHmCk3P+DfMN3+tivgJTdJgKzleuAQfce2JMA7Ld
 6LrJjy52dgrfvnHLSlUpPNoqhhgV5wAp1udxVwNkkM1gvmUPp9ys/xUpFxu0EySu5wV90cV8g
 wAUd/n78QDI5dvvzbp8r7VMHbs5F33tDwmdk50uPT6vzolISl6Wg58TZQchHQD0RMswTiXcUH
 X7pJLiOadJ1SX8K9gFb5ZjDv+t93CW7ntVLA7iewdUB9XMiaCfnzT8Ghmvah6Z6992dlPTtu0
 +CmK+4bZtnwARM1hGvuLK/8FXAHtRf9e/u6bVMhJuhKSz8RfrDu/fSTtOXYj8K/jLxbMYW1vf
 NRPnzZhybL1s5BSEtcs+ZX0Qcu87sotCcfhp8pkcm8yeqS1ch/IvDTIy6o/YBA72eQGGETJch
 OBiMWkA2ykQqyGYVjHuvsremtMTj4zJrkZjGbEfdPS52mfvjhlJqGLCDbnH/1tQ1D9uJ/PZCQ
 CUTgt4uRRaBEAFJ8IC1A==
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi,

On 22.03.21 22:48, John Paul Adrian Glaubitz wrote:
> On 3/22/21 10:30 PM, Frank Scheiner wrote:
>> Riccardo Mottola first recognized a problem with 5.10.x kernels on his
>> Sun T2000 with UltraSPARC T1 (details in [this thread]). I could verify
>> the problem also on my Sun T1000 and it looks like this specific issue
>> breaks the mounting of the root FS or maybe mounting file systems at
>> all. This affects both booting from disk and from network.
>> (...)
>> ...as first bad commit.
>>
>> ```
>> commit 028abd9222df0cf5855dab5014a5ebaf06f90565
>> Author: Christoph Hellwig <hch@lst.de>
>> Date:   Thu Sep 17 10:22:34 2020 +0200
>>
>>      fs: remove compat_sys_mount
>>
>>      compat_sys_mount is identical to the regular sys_mount now, so
>> remove it
>>      and use the native version everywhere.
>> ```
>>
>> [1]:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D028abd9222df0cf5855dab5014a5ebaf06f90565
>
> Looking at this change, I think it's rather unexpected that this particu=
lar
> change would break the kernel on a specific CPU target. Are you sure tha=
t
> this is the right bad commit?

Well, I strictly followed the `git bisect` process and tested each and
every proposed revision. It's indeed strange that this only affects
UltraSPARC T1s, but the changes match the behavior: mounting of (root)
FS is broken.

> If you found the right commit, then I assume there is something wrong wi=
th
> the syscall handling on UltraSPARC T1.

Could be, all in all the T1 is a first of its kind.

Cheers,
Frank
