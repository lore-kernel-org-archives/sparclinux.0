Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A1EC433DB
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 13:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 627B661A01
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 13:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbhCXN36 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 24 Mar 2021 09:29:58 -0400
Received: from mout.web.de ([212.227.17.12]:48007 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234710AbhCXN3x (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Wed, 24 Mar 2021 09:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1616592570;
        bh=3BTpDorQ2DcxQjoeTVtmb+pJAQgagg0GtbfWcrg4zrI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CJSN5hfRwtRvahCmTya3ECYQ2nTtuUW7AiBoFVeFG2wbYMHggqmrpmmVgFFP83K5w
         iTPB2vGlavUfgoGnXVbgOm5mqiRcm0QDz7S7Pn8U3NvN5dowohq9h3ilujoXZBfeLz
         ZeA92KmjSkX92zPvHj7hY0vlKTE2eBW38iqfQx10=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.30] ([217.247.35.184]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LkPnr-1lvMBd1z2Z-00cRYA; Wed, 24
 Mar 2021 14:29:30 +0100
Subject: Re: Regression in 028abd92 for Sun UltraSPARC T1
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christoph Hellwig <hch@lst.de>,
        Jan Engelhardt <jengelh@inai.de>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>
References: <9ffdf604-ce04-9200-65c9-dd8921a45038@web.de>
 <186a7992-6e83-dc8a-1cfc-d07bb36935f5@physik.fu-berlin.de>
 <4d033ff9-329e-77e7-20de-720aa65bba3e@web.de>
 <n0n38p9-rn4s-213-n983-9o3o4oo8s54r@vanv.qr> <20210323165721.GA14577@lst.de>
 <d68767c2-e010-f90e-9f2c-bb5250465c58@web.de> <20210324082817.GA2625@lst.de>
 <8600c0fc-7144-4b38-d6ae-4dbbabb125ba@web.de>
 <dc37860d-168e-4e4e-475e-943556e8484f@physik.fu-berlin.de>
 <2c1d1de8-bbba-02b9-f0b5-d3d6cb089198@web.de>
 <CADxRZqy0qZYs3442zyHfcw1Q0qfx_Quor+1OH2UMv43nz_HkJA@mail.gmail.com>
From:   Frank Scheiner <frank.scheiner@web.de>
Message-ID: <234666e6-b0bb-0dbf-19e6-9f3483469dad@web.de>
Date:   Wed, 24 Mar 2021 14:29:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CADxRZqy0qZYs3442zyHfcw1Q0qfx_Quor+1OH2UMv43nz_HkJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FgW73KJ4pus5NjrnkEmBHr2bJCqlClkTZNt/234jW9PM+RIyY6q
 kESaySztrDRVHO4J91yuPsqyuExQZvg/P22cCEdTeHze+l//gEixiL2lShrjOTaj7V5TyJ2
 caFOLtayIOtHrKV4sfzMZcMaBWM/aLjboi+8Zh/fpG0k/AOKWnzGrwIg8kRifJ3xsptvKrJ
 qdNhggdIKY/kXaCMEzaTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+IBpTOd/EvQ=:8s3cT8NJa5lVn6WlBYNeCR
 tjTxL7BBek0x4JOtePYeiKwBAVKvqUJwmTNuQDXmSeg1BLfNH2hE04yfDI2gdVqwDmnMDnGFT
 I4TTQDt8bm0kO4Q30OaHX/77lCLFztwWD931Yir9dspTuFwGpZxeV1xfLfzdPQojLY15uEEth
 IRGr9P1zcIUJOTeOSexhl2lWTvXi/lwdj/z2V7Fy/UdaVknCQG0u17ifi8F7EPgGeW48hYj/l
 6vYBzlOuzSfFVxe3FZ3+QUD10pFpPs5cued1jlgYdphbCKZ6IP/ShGBzQ7r505t81A+5dXEHs
 rgLZOrxAKZVDyrN05ozvgE7lZsRkllzn9IadQgp7EU9d+Y2NdclSqEaRio5IAJG/f98O9jmd+
 QIfj0lNfqhdXDZjBTCoe1vhpf2QDuz9fRM5DCMHPVgyzTYc40r9k7qx5PusML8old2MtqIL+C
 sSSCPwnpPyZsux+QUgjhKcysDBp7XDQLaOHspxBMSmYljcvhdFGuuc2s9EBguSVTombdD3rGj
 /axYUDbh+BEvE8NaFFWXXnhVndjL7N9aFdyXtkAfwxbY/Cx39UuRrvubcq7Ps7DbER+j6peAY
 Ibp+eT9kUt47080jNQVP1qDWdyxuAgb8SixfUtAvT5p4x9R1WuJ8EaoJRaMDbiYCUNATy0y9n
 vKRlb4vjkvc5tmy3rzG7CiQCESVsEyiz7GjtpR4/Tk/sHFAcCwC1CxRqL8XaL7aj2hdWj13pl
 vDtamXo7CJOggxNVPA2QgDWqeTWwL5MEE/79Y3pvig3OyqtTI5EFXhkBaUuCprl4oG/K+DQZs
 /ChhFkGPkpR3od7hu71a+lakZjapupRpLBU8ZMYjUk9M+CmHoRxeJYhFMwQXFpANPAJ/+LEH1
 s5pdHkdA4IP8hdMDPhHA==
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 24.03.21 14:24, Anatoly Pugachev wrote:
> On Wed, Mar 24, 2021 at 4:19 PM Frank Scheiner <frank.scheiner@web.de> w=
rote:
>> On 24.03.21 14:16, John Paul Adrian Glaubitz wrote:
>>> On 3/24/21 2:09 PM, Frank Scheiner wrote:> Kernel sources are not avai=
lable on the T1000.
>>>>
>>>> If need be, where do they need to exist and how should the directory =
be
>>>> named - `/usr/src/[...]`?
>>>
>>> Try installing "linux-source" and the "-dbg" package for your Debian k=
ernel.
>>
>> But don't I need the source for the kernel at 028abd92? I figured, I
>> need the sources in `/usr/src/linux-source-5.9.0-rc1+` because
>> "5.9.0-rc1+" is the version the corresponding modules are installed -
>> could that be correct?
>
> Frank,
>
> i'm using gdb from kernel sources directory (from which kernel is
> installed), like:
>
> $ uname -a
> Linux ttip 5.12.0-rc4 #203 SMP Wed Mar 24 15:50:29 MSK 2021 sparc64 GNU/=
Linux
> $ cd linux-2.6
> linux-2.6$ git describe
> v5.12-rc4
> linux-2.6$ gdb -q vmlinux
> Reading symbols from vmlinux...
> (gdb) l *(sys_mount+0x114/0x1e0)
> 0x6dd7c0 is in __se_sys_mount (fs/namespace.c:3431).
> 3426            /* ... and return the root of (sub)tree on it */
> 3427            return path.dentry;
> 3428    }
> 3429    EXPORT_SYMBOL(mount_subtree);
> 3430
> 3431    SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, d=
ir_name,
> 3432                    char __user *, type, unsigned long, flags,
> void __user *, data)
> 3433    {
> 3434            int ret;
> 3435            char *kernel_type;
> (gdb)
>

Ok, will try that approach. I'm currently `tar`ing the kernel sources
@028abd92 on the cross-compiling host and will move them over to the T1000=
.

Cheers,
Frank
