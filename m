Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0909C433E0
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 13:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6793A619B3
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 13:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbhCXNTp (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 24 Mar 2021 09:19:45 -0400
Received: from mout.web.de ([212.227.17.11]:53505 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233395AbhCXNTk (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Wed, 24 Mar 2021 09:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1616591958;
        bh=1w03lSQawytRMP69tQ0lfbPSn1AnbN0fRl7eLiaxBc4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lIPJtQjroqX4cqFJX17erQbRroSEfsxlE9/NYFzYmyzs3A09NaTvk+IBMy+atJN65
         Wr2oS37lNtQ/pV8L9wpEz776ONJ3epCniMjsn0lH/Cnd7bn8TEkcfApGPfK7PCCU0L
         OxhrN46QvqN5r2p9GZJu/WPTx1DgFf534pXZCj8g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.30] ([217.247.35.184]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M1o3y-1le6Si1Fda-00thPY; Wed, 24
 Mar 2021 14:19:18 +0100
Subject: Re: Regression in 028abd92 for Sun UltraSPARC T1
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jan Engelhardt <jengelh@inai.de>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>
References: <9ffdf604-ce04-9200-65c9-dd8921a45038@web.de>
 <186a7992-6e83-dc8a-1cfc-d07bb36935f5@physik.fu-berlin.de>
 <4d033ff9-329e-77e7-20de-720aa65bba3e@web.de>
 <n0n38p9-rn4s-213-n983-9o3o4oo8s54r@vanv.qr> <20210323165721.GA14577@lst.de>
 <d68767c2-e010-f90e-9f2c-bb5250465c58@web.de> <20210324082817.GA2625@lst.de>
 <8600c0fc-7144-4b38-d6ae-4dbbabb125ba@web.de>
 <dc37860d-168e-4e4e-475e-943556e8484f@physik.fu-berlin.de>
From:   Frank Scheiner <frank.scheiner@web.de>
Message-ID: <2c1d1de8-bbba-02b9-f0b5-d3d6cb089198@web.de>
Date:   Wed, 24 Mar 2021 14:19:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <dc37860d-168e-4e4e-475e-943556e8484f@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dOGG5OC+3UWkHy57OThf2+YPHqJj2ibgOd1XsEs+CAXkxOGJgqL
 T7poWNvX+S5nJaYGEIoh5RQvJWHjKccmMKyzhAUnfp22kJP8Hg3d9lQCrdj61UA4XVvvp2M
 Bfx3GKM489MnpTFGkn9vVK8p3s0FplFwVR+zTgmSeEKCsJR/8oOe6uUMsVhbAjycXeXyupY
 iol19eeVGs1h43arYBlZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W75yARDtqTU=:OGMq6Z5+4WDKkCz0R3B3JA
 tuoFWq/HHcvRAyx1GhGKWSzGxTWfWQPOQR/pd7nE1kbiXUsWt063+iI8227vcWwXTXwRrUFMK
 kPetd43Q+85NVK0QqlMrkkbTGWkSFHcDTTIwt+Wt9FU4GSzCEWaI0bJUZ0cblfP3G3C1DteC+
 3+Yy8bhHW8pl+dIJd3irh7cKo4c0HRYWmeWEDqsqkKwVZZcFWaDoy8z0y3geM+cA9f2mFKIwM
 sDAn7Z43VcvpBXPUVpIbmq8yvgrrBVSndCd6cgnJuuA6RYYDT82plRjjrAVY9Twlc4evCmPjP
 34wTLqgNwaBOyg34oKrWuMHJWlWZoyq5EdmSpiGkrMS4GpYsxn5rkrNejL6CGihowiI5UDShg
 UqJnFPZH9jtHfs2WBWveSRilH9qxOvEaKrJVB8n2TQ+JCkaq3zmlKtXcvegwTbguZ0RJTOGGg
 B4UbdoRjdebN0VSOYAztA3q7cIrBTOP3DLxXd6TrhK+7ev0bDdLnpA5MHyT3q2pA0u7L5M1Yu
 hDFRsENzqRtHyALheLwskIMrrFGRL1erupwHB9m7PEqBXkndDNEOn2IbKpfj3hPIahcDtvF81
 ckZu7AvvdHIeK6CINhkJ/vlZYlKehfS7IFAQMp710zQeX7gUrHrI9+oQKmrav9r1ThDLDlASm
 KfNaHmLXkOfDzQlJgf8SLkLYxDRt3MUAIlkIXCRuUZRMiXX666Em8GOy9za250PHiEq3JrSVj
 tNTtLJYQ7kP/BWPyt+mNuSDI56+4wZ86e/7Rqm97lMhH7vGtr29lWE4vRVNO/QF8E5ukXmy1u
 M2XTbWjnwHmvk3zSikZ/ePka8bN5nwfmgdzRL2JlLA5NIca3fr4GjLzZWT+KPteVUVV/FjPli
 lgXGW97e0CFJySKgSYqww3hnjjYynH7LBDR5BHbxT0E+5xmRDfiZCJEMGsz9xkC3PyX1BRjku
 E28ahfeBjI+CgtXZMdRbnfNxAoh417UsUH1fiuk4k2oCRnH2aTBBefb3AXh9I07ZA/Hl8LhL6
 SOGm9g0Loi6r6+zbnDkkj4HdmbfV3m4IaOPQV9v6IrjBW8DJoEYD5ZHM64sIISYsTvoIZlehi
 pVMRbJqafhBkExWCL5Ie1zbXI8W9A/MzTSnS3y/86RZ1YoXL00M4iQiF1NcgW6R4Ula/IKJ7Q
 b60+usaBb36LgqhSoe1fXaJbmajc7vpFCO/zRLyvHtfN0p7fGrdFHJYc0uosACERCdLNIvOeS
 mHREu6ger19RBpYhO
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org



On 24.03.21 14:16, John Paul Adrian Glaubitz wrote:
> On 3/24/21 2:09 PM, Frank Scheiner wrote:> Kernel sources are not availa=
ble on the T1000.
>>
>> If need be, where do they need to exist and how should the directory be
>> named - `/usr/src/[...]`?
>
> Try installing "linux-source" and the "-dbg" package for your Debian ker=
nel.

But don't I need the source for the kernel at 028abd92? I figured, I
need the sources in `/usr/src/linux-source-5.9.0-rc1+` because
"5.9.0-rc1+" is the version the corresponding modules are installed -
could that be correct?

Cheers,
Frank
