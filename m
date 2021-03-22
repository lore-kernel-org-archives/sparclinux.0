Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC912C433C1
	for <sparclinux@archiver.kernel.org>; Mon, 22 Mar 2021 21:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2FD8619A3
	for <sparclinux@archiver.kernel.org>; Mon, 22 Mar 2021 21:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhCVVfd (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 22 Mar 2021 17:35:33 -0400
Received: from mout.web.de ([212.227.17.11]:37189 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230046AbhCVVfT (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Mon, 22 Mar 2021 17:35:19 -0400
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Mar 2021 17:35:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1616448915;
        bh=8O57nGgEajETGYIUnkYM1B02zDnJ+Nk55KcU9sux+LE=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=h9N4X+JnZDdnavw65DCLtFgDpg/1qaT7ZKVy7FE63Z4MGPvip4n2KsokbKAIRmixQ
         jxLQWwGx/cyzurYQWTqMBvr64hQBNh45LWXhWJpQXxMCXkkEAPBtRraXPsvqt4EtqW
         /2v0rdGsXgm4C7Qm5f8S8E/s+BYYITY3m2bvTUY8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.30] ([87.155.239.151]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6UxL-1lZwes3tCl-00yTIt; Mon, 22
 Mar 2021 22:30:05 +0100
To:     Sparc kernel list <sparclinux@vger.kernel.org>
Cc:     debian-sparc <debian-sparc@lists.debian.org>,
        Christoph Hellwig <hch@lst.de>
From:   Frank Scheiner <frank.scheiner@web.de>
Subject: Regression in 028abd92 for Sun UltraSPARC T1
Message-ID: <9ffdf604-ce04-9200-65c9-dd8921a45038@web.de>
Date:   Mon, 22 Mar 2021 22:30:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zLttw/P9oxwmuiaanaJHutRp99oz3ab3/gR0cuoDmLC4djmVhEg
 xG54Gkcfk15fBSkuowY1B1WjgvcJ04j/ipfH7VZOCcP6aZPta6UVEIglrmbvfZlf4mHjViX
 JSOaZIy2pIFI9Pjd6VIjs+kfLAME80DnKzm+ux+JX16qqtoKYfboYaatUfd0HMPeK+nMmIt
 Mh1sNBdXwy5j+bvW+mp6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ql36dnQiUV8=:T2CQ3dEUSeyJiquEBxdMPu
 +ruY/PUoiFjJZ46pmwKzf7pPVxNAoPQVrXa5DQ74gsPQ7fcR1fooE8KbmFfyvuYA9Ep3m1EBr
 ynzNbJ7XvUT46F2y15xFYn4uCxpw7k7s3GCjnLbQVcPPNFvDJbp7/rEaQsXsWavdXJKVMWHLX
 PGFPpINvaglxCPK2ucHZ5dEa7g52S36VHFYNPas2erxV5TRHKkr7XL1Z6R76RO4hlYNdQMvhe
 n9TuIk/VJmCjLycH9qlg3SRlHhOs/DR5OMPcjRqsobclMEGTYJciH+Gt3zmABcChDiJAis9b3
 EU0/HiugaeH9n32Bn/Jg89Z7UY7kDVgjgMFBig0p95YgLWNpQCzZ/J20PnA7RrMaXUQoXo4hT
 s2Ookeb3Qck6jhe+UZH8ZcUwFcRQdJ8hTIGqdwFX+qidw4/gpu/2mcrEYS6glH5WO7w6JoMKQ
 l5sFoUsLGB0bTV7RCIIhPRoUUGf6+rmtNhIb3k7WyyeRWCXp4H1ep1G0i8wGqKU+IcVVnHOuy
 xFrnGCIBO8jVU6nQCJuMNc7OJdcu8HX4BZAeAsLFuJzvc8ynS+AF1//Qow4xKRN+OrbawZcTC
 gBrp+sJVmrOQkeOJU83thKKPdXQjH1qR7WuKZDTrEbPyNJmh/7zaWurqhU4A1+FnULPJU4xxe
 mGOIDUqN2Prvlb4AB62Gbw24fUa289kC4X+gFanYgqKLbeOVQJeR8LTGXhlNk2Ts1ChvSvGiB
 zifxBfOslOqxb+Ew9xnIKHqOPIwruPbuFvtz3SoixIcplMT1le/GVtjoqO1oqYyt1dacm2n8C
 loo9Jsp8fnbLWayAE7fT/2SrfRM5Knwojnh9MJf9m/oC3s6vLiMtSwvzmMUvPxyjGHiQ2PENb
 nUJRC/baLs0VK2WttcCOeiCEDD4tO65wo5Oq4H6+uymPkcKoRgAg06gdcih6vg34gwHWKIIVX
 DMSqJOkYZSHuuaDx0Ieu9dIJx2frQirYJUeaC4xFZmbpRdamq+3UlM9MeKQ4jajOHPuxkZVsy
 O8z0CgRZUuOMXXkSpdQLJvzpsVUVxdmc3DLD/zgOg7uj/1BxOpO2aKeI/7fTrV7tdcD51IKGj
 GQs7NoPRl8Jn7eHMZ2j6cLAPaBvUaKtLdUOoPf8M0OccvqFRj7Qm+fkcvaejyB1/9rtNEskRv
 5nor2dYjZo0gYgd2nc3AUA06HPnGsEwyVGxulfTuxIvTD1atktwy6XlyX5sUXLpxahTKIBlmq
 bLE4Ng5xeyhFwI/lR
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Dear all,

Riccardo Mottola first recognized a problem with 5.10.x kernels on his
Sun T2000 with UltraSPARC T1 (details in [this thread]). I could verify
the problem also on my Sun T1000 and it looks like this specific issue
breaks the mounting of the root FS or maybe mounting file systems at
all. This affects both booting from disk and from network.

[this thread]: https://lists.debian.org/debian-sparc/2021/03/msg00004.html

I bisected the Linux kernel between:

bbf5c979011a099af5dc76498918ed7df445635b (good)

...and:

3650b228f83adda7e5ee532e2b90429c03f7b9ec (bad)

...and the process identified:

028abd9222df0cf5855dab5014a5ebaf06f90565 ([1])

...as first bad commit.

```
commit 028abd9222df0cf5855dab5014a5ebaf06f90565
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu Sep 17 10:22:34 2020 +0200

     fs: remove compat_sys_mount

     compat_sys_mount is identical to the regular sys_mount now, so
remove it
     and use the native version everywhere.
```

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3D028abd9222df0cf5855dab5014a5ebaf06f90565

Details about the bisecting on [2].

[2]: https://lists.debian.org/debian-sparc/2021/03/msg00042.html

So far this only affects UltraSPARC T1 processors. I didn't see that
problem on a T5220 with UltraSPARC T2 and I also didn't see that problem
on a Sun Ultra Enterprise 450 with UltraSPARC II when testing a recent
Debian installation media with 5.10.x kernel some weeks ago. Other
UltraSPARC processors weren't tested yet. I plant to check UltraSPARC
IIIi and maybe others if time allows.

****

Do you maybe have an idea, what could go wrong with 028abd92
specifically on an UltraSPARC T1 processor?

I can provide a full log of a broken (network) boot process if that's
useful, I just need to re-create it. IIRC the kernel oopses for each
hardware thread (similar to what Riccardo wrote on the debian-sparc
mailing list above) and then stops.

Cheers,
Frank
