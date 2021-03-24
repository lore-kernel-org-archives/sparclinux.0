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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE2AC433C1
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 15:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D73EF61A02
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 15:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbhCXP71 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 24 Mar 2021 11:59:27 -0400
Received: from mout.web.de ([212.227.17.12]:40179 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236863AbhCXP6y (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Wed, 24 Mar 2021 11:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1616601522;
        bh=1t//Gi7U5XKAtaQn4o6FrECR8fKBb5X9+lwZZa0R9ag=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ATxEwkp9FRr8DTJL/dJYxnsCcMWDIBjRNc36pFrYDfhE3Tx+aVrd+h2s0wrJXggzm
         rC7LTndODXt+rghNGRx7pd2GoAkJwM4NjOK5+G//OPQMeGw7tj0RAXFH15voLuDMK0
         Rc2bXecFJMuioebwka6xuRfZDSepxedAcj6jEmzQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.30] ([217.247.35.184]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MAdx1-1lUqOQ3Izr-00BtME; Wed, 24
 Mar 2021 16:58:41 +0100
Subject: Re: Regression in 028abd92 for Sun UltraSPARC T1
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Christoph Hellwig <hch@lst.de>,
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
From:   Frank Scheiner <frank.scheiner@web.de>
Message-ID: <250aaeb3-40fe-60c7-044e-aa9daacd7c12@web.de>
Date:   Wed, 24 Mar 2021 16:58:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <p1p52s61-n8p-s29n-n195-q22rs07qoq40@vanv.qr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s8KOEq3rMqbSwPD95dZ9ts00wl0QGkIv4F9VrchHsjXJ4JnzDv5
 Sfd0swP0P+sWb2RSagE9/xKTHHcfjOA9TTxFPfzDp3wR+rpkPRwmBxH8necb1d5ijpl+B2y
 LZiK5SLKcwUzaRhCGGYmBjM9QQJCqoEWaVJp4w6lPF8/kIRVgjHBhnSJOiHLJmIkiQSpzPG
 zVCobJ/JNLCYkeVIgkwnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wej9R+JPbCo=:pOem6h+oq6ys/tGtYiytUj
 ecpnm+xNwrB/R+QUWRQNF+9eeJPUTmHvG70Mw0542d91wnckcs7M5fjFJuLRMlPZv3RsmyTfS
 1N99kpAmz+XBUKDhpgk7qbrT291BjwivlDJE4M4HzwZ/EKxxpKfkFY/9oJyjjeQlIpMRAEnPS
 Fw+ktVsv7P7OAiuoMIo3bWr1ED2UGmrKGAu1gICmW9ooyqKlo36iKJy1U0TDjWgA08n6FwYny
 aC5vD4R2b1oSFbYvnfLF0/3NwmDy5XXbwBwXGtsWftc6+cPvrC6ltFyL5HMhcOybpJPkPx8lP
 dLAnLjjvedHBWHejwGlQTJyEUPGM1rGaKXyLbm9d1ezAhFTdfKGMRNgyvJLJxnIzEgZgPREqe
 su8uJCbeN3nqZ+1efhqX5rxUHJaEFrUyW9qIxvoKE4ZIVmbQHSfkTBSHuMRjl7R6qwiQnX8n3
 rMRlhfIoro6CtewemXEK95evs4MspyzWJ+ud8wMMWXF9wCbZVsCYxNlfCJj6fSwyF/ONnp98S
 ADcuw2Z++GtZpmwqQQfF2lsX3wva+KQOCwHnym/oRgk8QNX5QYR9+4BHEsuOGeJhRed+R4zue
 LyLH7DvM1gRlTmDVKRc4yQO8o2G+hlt9xDKfQ8qHcPmHbQvVCY8Uzo/rBorK1Cen3060F18/6
 dkz8FoBbvIeE7t/bizdyxOwDBY6zDVpy3ugvGAX9QUhVgU2lfvTNBj6WxzlvP1RZom0y6GVBQ
 ehDJ+K9HQFJakopBt2XOzt2FVa9YUYs7ZK+IWJKmtFIEIN6VXLf6IaxWZ+XjG9Xoz54dmE64l
 bwv5yCAE8QZtgTBDnrk5JjbRhQakotIn/RhVMMupqqEq7BN1po8F4tPV6qsWYruGOsN2nX+uP
 ZdlDbgf0VpGQWFLQu2qQ==
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org



On 24.03.21 16:22, Jan Engelhardt wrote:
>
> On Wednesday 2021-03-24 14:57, Frank Scheiner wrote:
>
>> (gdb) l *(sys_mount+0x114/0x1e0)
>> 0x6c6380 is in __se_sys_mount (fs/namespace.c:3390).
>
> /0x1e0 does not normally belong there. Just
>
> 	l *(sys_mount+0x114)
>

I guess this comes from my log on [1]:

```
[...]
[   20.089289] RPC: <kfree+0x3ac/0x420>
[   20.089415] l0: ffff8001f8885cc8 l1: ffff8001f8881380 l2:
ffff8001ec434558 l3: 0000000000201db0
[   20.089586] l4: 000000000000029c l5: ffff80010000c1a0 l6:
ffff8001ec79c000 l7: 00000000006c6380
[   20.089802] i0: 0000000000001000 i1: ffff8001ec436000 i2:
00000000006c6494 i3: ffff8001ec436000
[   20.089877] i4: ffff800008405340 i5: 00006000045396c0 i6:
ffff8001ec79f561 i7: 00000000006c6494
[   20.090051] I7: <sys_mount+0x114/0x1e0>
[   20.090186] Call Trace:
[   20.090279] [<00000000006c6494>] sys_mount+0x114/0x1e0
[   20.090338] [<00000000006c6454>] sys_mount+0xd4/0x1e0
[   20.090499] [<0000000000406274>] linux_sparc_syscall+0x34/0x44
[   20.090697] Disabling lock debugging due to kernel taint
[   20.090770] Caller[00000000006c6494]: sys_mount+0x114/0x1e0
[   20.090926] Caller[00000000006c6454]: sys_mount+0xd4/0x1e0
[   20.091133] Caller[0000000000406274]: linux_sparc_syscall+0x34/0x44
[   20.091196] Caller[0000000000100aa8]: 0x100aa8
[...]
```

[1]: https://pastebin.com/ApPYsMcu

Here the result for the suggested command:
```
root@t1000:~/mnt/torvalds-linux# gdb -q vmlinux
Reading symbols from vmlinux...
(gdb) l *(sys_mount+0x114)
0x6c6494 is in __se_sys_mount (fs/namespace.c:3415).
3410		if (IS_ERR(options))
3411			goto out_data;
3412
3413		ret =3D do_mount(kernel_dev, dir_name, kernel_type, flags, options);
3414
3415		kfree(options);
3416	out_data:
3417		kfree(kernel_dev);
3418	out_dev:
3419		kfree(kernel_type);
(gdb)
```

Cheers,
Frank
