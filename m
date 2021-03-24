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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D73C433DB
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 16:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E34B7619F8
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 16:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbhCXQhx (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 24 Mar 2021 12:37:53 -0400
Received: from mout.web.de ([217.72.192.78]:45853 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235137AbhCXQhX (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Wed, 24 Mar 2021 12:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1616603831;
        bh=FHxGxTteaIUO9SPqHCASty6phHyn4tOHUqKtvwoFtsM=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=oJqlO3qnFt9G5F/HQFOP8iK2zV5uCumQwfFtQ23TI9mkwc7nYm/NJJ0Gyr4/4666k
         XwL66Nz7/AWjoiB5CsGOK4PSfDUjues6xlF1KIBkGQPFi/Jb3O0fcT8j1cz1Kac1Of
         xrEzitbJGqKFsNEnekDtCkwrMRh6AWYKz2Cd6Y7g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.30] ([217.247.35.184]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LudGm-1lpXJ12uw4-00zrH5; Wed, 24
 Mar 2021 17:37:11 +0100
Subject: Re: Regression in 028abd92 for Sun UltraSPARC T1
From:   Frank Scheiner <frank.scheiner@web.de>
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
 <092f6c45-d4fe-ac02-d416-e644e2f26795@web.de>
Message-ID: <b8e98852-8e90-2860-a051-2173da2805c7@web.de>
Date:   Wed, 24 Mar 2021 17:37:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <092f6c45-d4fe-ac02-d416-e644e2f26795@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HfqRSksAZDyT+7B/1/r7l/JruuH9HGVBwxmmvBM2HB4gDG3zlVd
 gGhFwyUAB7XPdxKGRIz846YeUXobpViNFGPelewopWhvt6cPU0i425qPnUXRgHvA4sgpqA9
 aNkegJF58RZvmj/T7EOachQayKyUjtKepXx14zo817oLvIrnFtpB+URprmu6KvCMk55vdGe
 JWNwFqsBoiPRZfAI0IV8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lbENEDDbp6g=:f0RGKBwbTKLcqhgQUw8sWV
 KqWcvXi8SLpcgKVXWizf+WVek2zjDA9wtThE+CpvxDRQ594tELNzGyRIOozP42vKXk69z9Ztm
 qujLBfz0aejuzHQmSDhzNOiGMAkXzM2axRWYrfMKxul41bvJFs/DhblRaVQ6ghutNEPIUfi7J
 qQIGo13nvRgbxkElaDqt3xqx0xNnfEA7PN/0y9UnqTcD1Bs4en0AZ0Ne3dkaqLm//usGos4iX
 DsyyDDefj7JBfzY+Z5htpBuUk6fbYXYOk4y4HE87UgftqURTCxTN6SzhKPE/K2dTnW2grTJPN
 ZWdtLcyP+lh39ils5zQpIo1Vye8H9zZRPEwSFxpkNHCtGcYdxoofzGrC1h/pD6ZT7RWOUUVlm
 LJ81b3arIovX+qmN0+PYuJwkk2/U66WAgAcxrcLXYEB1Kuhh/sbOhtIWdKhpzSblMgY99pmvK
 4Tb/cXhrFZ7bjK3B/VVZqM47fuckKgmVY6tPukI+12s0NC4MNrQe7PrZRNxBGtQYeMB03aDAi
 hVu52bCLQl0YUuOFc8mmKPuSr1eqxVIMRZNZ6c0gZj7qg+TCvq0EpmBr3XcXesA9cwymNqxz3
 QBvtEZFGmyXPEP8fgSnab8f+32mpiyR6DV2BePnQqrxKFEhsGAQ+b7tB036SRtRj2FRgOek6Y
 bW4aD3N48V1nj0LNFkm9xn3+bOF28TBPyhYym/8fqWCbyrZcL+v4nVUsJqWh83OPTh5W9AZ1M
 PRgoQwJgr0gqIC8dnWjxmHHqTocFSArumpMEIUXvsW56Sxvt9Cjj6yDetqopvWLWWNMVRVril
 J5KyefcdB0SWiPjpGlzp2lO/BRhsiR4gj6XAYGt2cGswteowb6WjPSLFHqYv8w/zf819QIsaT
 KMjrwNKbcQLrs+jfYeww==
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 24.03.21 17:33, Frank Scheiner wrote:
> On 24.03.21 17:10, Christoph Hellwig wrote:
>> On Wed, Mar 24, 2021 at 04:58:39PM +0100, Frank Scheiner wrote:
>>> [=C2=A0=C2=A0 20.090279] [<00000000006c6494>] sys_mount+0x114/0x1e0
>>> [=C2=A0=C2=A0 20.090338] [<00000000006c6454>] sys_mount+0xd4/0x1e0
>>> [=C2=A0=C2=A0 20.090499] [<0000000000406274>] linux_sparc_syscall+0x34=
/0x44
>>> [=C2=A0=C2=A0 20.090697] Disabling lock debugging due to kernel taint
>>> [=C2=A0=C2=A0 20.090770] Caller[00000000006c6494]: sys_mount+0x114/0x1=
e0
>>> [=C2=A0=C2=A0 20.090926] Caller[00000000006c6454]: sys_mount+0xd4/0x1e=
0
>>> [=C2=A0=C2=A0 20.091133] Caller[0000000000406274]: linux_sparc_syscall=
+0x34/0x44
>>> [=C2=A0=C2=A0 20.091196] Caller[0000000000100aa8]: 0x100aa8
>>> [...]
>>> ```
>>>
>>> [1]: https://pastebin.com/ApPYsMcu
>>>
>>> Here the result for the suggested command:
>>
>> Thanks.=C2=A0 And very strange, as i can't find what would free options
>> before.=C2=A0 Does the system boot if you comment out that kfree in lin=
e
>> 3415 (even if that casues a memleak elsewhere).
>
> Unfortunately not, the result with the kfree() commented in
> fs/namespace.c:3415 looks pretty similar in my eyes.

Actually on second view the result looks different. :-/
