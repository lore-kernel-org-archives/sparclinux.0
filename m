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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA6BC433C1
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 13:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EFE861A01
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 13:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbhCXN6R (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 24 Mar 2021 09:58:17 -0400
Received: from mout.web.de ([212.227.17.12]:53427 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235756AbhCXN6I (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Wed, 24 Mar 2021 09:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1616594266;
        bh=NCeBXFSX4eeQUKoz31XwHl2RHRBCqgITAg1DQAMA7ZE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BSDg/kaSI5WcCyC3+SqlQC6GsiVdlCeBNfyxn0AseHyBiynPal4qYW9GbrvM+9p2f
         s0tZqR24HlN3wlgKF/vx/4XVMjWhtvWIBkr9XcVavi3m2KZHYHu6XxX4oxKzBifj4O
         Qjtr0T9OK6KpAZ3IrWut/OW/JdHJ43+FJwd9iBcA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.30] ([217.247.35.184]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LpNwf-1lupvb0yZh-00f7Eg; Wed, 24
 Mar 2021 14:57:46 +0100
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
From:   Frank Scheiner <frank.scheiner@web.de>
Message-ID: <a356b88c-2b75-3d8b-ba47-8f0c6d0420e0@web.de>
Date:   Wed, 24 Mar 2021 14:57:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210324082817.GA2625@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S5ruF7g2joLcpZeVWMtBs+A+swY1fc6MtvrCOFdwZ8A+ZWP88LF
 5wMlw9oxJRHdxpLeAqcg1dB/C5CF70H9cRt97j5ONhDzznAiPF7S4ysI740hbDLEDs23ahR
 4D7jfnW3UGC19rX+fXRf8WxB5Hb0p66DiI3Yy/sRGWZIOO5eoic6Jut1WvNUn5T+omRo7yv
 mkK2ddjbEpBrx93mbNKyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hGnS0mC2Lp0=:NVLI5p8u1OM2hLivIKtr5e
 qcMfe6iYSo/Eht9bNNtWOFw0M6MXE+JZVwVB8WhHwt1j7rsGfRqAnnskqTW6AgL8Gj1B5algq
 3mS5CJr+yAjTRmM88X65A1/KS0nuzyqnrygma442otvrE0Csmf4TYELGuhXPW2yPKmawrKKQY
 edsdXNZ0ytnWwjtaonCCSQ7rdnUPwtqzqRvHjw1KBtfpk8drAKe6Aug8DnqgdVCw5MKz9tBcU
 ksSsbQ//2QkFd0z6ijk/rPX06FR28LPk/etIWWroaM2+UYwlVFiu1LiUSSkOfI6OiXAC1bSCq
 vCq2o6eo8BJtg1XpscTQkLCz18sBNyu/e6iVRx8lmtePtbIf2mgAa4cFQgZuP+NLdTRTQ1bPi
 f2NW3+NOPHImpSYx3ARuK3YobHX6HzYIusj9Y+Ly5mlslZNByuYrbboTHSFfK0glNUydKKRj3
 FSeou6l+erfGEtLyLola760Zszq1sAJmgE6sIPZJERJDCxb6jp6Woe0ZycdyhuTTG5PhriLXd
 VHDpLFIrvTMAhTAg5hmublv324GYMZ6UbGUOB21EoTw4QxX+kTj7uSH3ewpDR4w6Qa/37n6XH
 wO7gbv2d6Wi4ilM4Oprf4f0FZEJBjeVnHI5eENsQ697mhwg8+bVrvJX6xC3CoEvD3IvkIR2HW
 utzt0I40vlgYww43Imlx6b0ri7cps6mTflfAwBWe/ITHLbq1K95An31W7tzhM6CAJDQ5KgdTQ
 /aepHoKK+hwhS9h/nyKdjpKs7WIEuTFir/VlBl4PNKYMuwklAu0b3xtr7+YSIqR6HyyUvSCLu
 CawqLwyzm40TZXeXgQ5l5OHic/yJ1HFv9DS8pbeB+7yBYlzWlYnqsv3QXFQEAZTYhPXXqS6lT
 tg+BJ4WnqC41iUtN+jew==
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 24.03.21 09:28, Christoph Hellwig wrote:
> On Tue, Mar 23, 2021 at 11:17:41PM +0100, Frank Scheiner wrote:
>> 028abd9222df0cf5855dab5014a5ebaf06f90565
>>
>> ...is broken on my T1000.
>>
>> As I don't know how big attachments can be on this list, I put the logs
>> on pastebin.
>>
>> A log for 028abd9222df is here:
>>
>> https://pastebin.com/ApPYsMcu
>
> Just do confirm:  in this tree line 304 in mm/slub.c is this BUG_ON:
>
> 	BUG_ON(object =3D=3D fp); /* naive detection of double free or corrupti=
on */
>
> which would mean we have a double free.  In that case it would be
> interesting which call to kfree this is, which could be done by
> calling gdb on vmlinux and then typing;
>
> l *(sys_mount+0x114/0x1e0)
>
> Not that a double free caused by this conversion makes any sense to me..
>

Finally - a T1 thread is so slow (for untaring) that I untared the
tarball from my X4270 cross-compile host to the T1000's root FS in the end=
:

```
root@t1000:~/mnt/torvalds-linux# git describe
v5.9-rc1-3-g028abd9222df
root@t1000:~/mnt/torvalds-linux# gdb -q vmlinux
Reading symbols from vmlinux...
(gdb) l *(sys_mount+0x114/0x1e0)
0x6c6380 is in __se_sys_mount (fs/namespace.c:3390).
3385		/* ... and return the root of (sub)tree on it */
3386		return path.dentry;
3387	}
3388	EXPORT_SYMBOL(mount_subtree);
3389
3390	SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *,
dir_name,
3391			char __user *, type, unsigned long, flags, void __user *, data)
3392	{
3393		int ret;
3394		char *kernel_type;
(gdb)
```

...not sure if that adds anything to what Anatoly already provided apart
from the "correct" line numbers for the actually used kernel.

Cheers,
Frank
