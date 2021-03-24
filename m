Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1285FC433DB
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 12:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5CDA61A06
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 12:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhCXMtX (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 24 Mar 2021 08:49:23 -0400
Received: from mout.web.de ([217.72.192.78]:56803 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233835AbhCXMsx (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Wed, 24 Mar 2021 08:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1616590106;
        bh=LN4nrnvUl67lAUtbY94oQiZagZDB+iEBuFkLACCJ9wM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SY/aMTT8VIQ7UvYI2rPx9pYrj58Orxi/glo0PIcxppk0YtdwO35Q9+jz/cgQWOgkM
         xLLulYSf8zVWnpSCOb4qE77sA7D9RfPEr6bZ7ndePJbiSb+8hQssijXZwb1D1iGSqS
         a2MGi8pFTh9uTpFr2IjB4zN81h5ONR3F428q29Tg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.30] ([217.247.35.184]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9XUJ-1lVtMj1Ann-00CzQL; Wed, 24
 Mar 2021 13:48:26 +0100
Subject: Re: Regression in 028abd92 for Sun UltraSPARC T1
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Engelhardt <jengelh@inai.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>
References: <9ffdf604-ce04-9200-65c9-dd8921a45038@web.de>
 <186a7992-6e83-dc8a-1cfc-d07bb36935f5@physik.fu-berlin.de>
 <4d033ff9-329e-77e7-20de-720aa65bba3e@web.de>
 <n0n38p9-rn4s-213-n983-9o3o4oo8s54r@vanv.qr> <20210323165721.GA14577@lst.de>
 <d68767c2-e010-f90e-9f2c-bb5250465c58@web.de> <20210324082817.GA2625@lst.de>
 <de572001-6238-8fda-aab4-f2ca443f2057@web.de>
 <CADxRZqz0XkgGHyi_pMDc1w5ZQY8BR0hT11_8aP+WHhQ42+BtLg@mail.gmail.com>
From:   Frank Scheiner <frank.scheiner@web.de>
Message-ID: <0d4c7f72-aeac-41bd-3c63-6197fe2e6a0f@web.de>
Date:   Wed, 24 Mar 2021 13:48:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CADxRZqz0XkgGHyi_pMDc1w5ZQY8BR0hT11_8aP+WHhQ42+BtLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n+3jWK53hKAQQkbzonc/5nAcB37MAcjeGEmL+5BMIdG4u9wT4lw
 tuWIowfm2f6o4VNyBTf8gQpDj9KZIyBni+/yCEYRSAAHvGczdThgfBpfA3v7dw3NmttiZj2
 ccUJ3Hkw3DK/ZYMX1aKTq9oOe5CO4ae4GRLRZOh7rIqG/65TGuZVwORSZPCfUkwNeTUypgp
 F/e2gcmycyE2lMLeSdhJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FmQxwW1R0uA=:nC/35hP3xIGt8etDGhx497
 oYDI32NuQ2k1nXOP5yQ3aMkaK0K4ofR+o3idob37N4Hzdf5NzW8aEPHzBt96KOV14TuAqIli/
 oieUYmVWouSPcL3kWdcncZ6kwanCwUmPC6I5MKq56al2OOBDepJu+sA+lGbTV2bP+QhR4BuPH
 x4i9AV68ozRVe1ZvglUHjx6xBlP894Rd+a7UhIzYCr67orhfdTLptSCLKLXmi3xc16wc9RuPI
 McHVcLJ4n4zNzpkRhiHDwTVC9eeOc9DcLKR+xspCXNyGia0hcmwEZb6ugvA1oAbY8wNsBttJ1
 ytZerD3VdL5p4346xQGuIf/dhUXD16OxCJI56d3UQYKULX4rOsnbBFUJP9LjJKsEE9KYgQLdq
 fdUVS0tQ89a6EAS8agx56W5xdd6NLk8FpmmtipFqTofnmk/hGY6rDLSE6+u5cmv2cyquH4EnR
 hbnS0qvpUr4JyHj5Kexm7dWmkq7Dsp9KmapjtzEsWVl9sAwJzQGcgg13xWrLGVuAE0rN6pqoS
 k1NoIgbKR7LyfvFKm8U4TRIDYKodCPU1u7gvVVaz4aMaJGd1zWKk6QIKNr9JyJ02GXywO+zW4
 I+HcNm18Od8kyKrVeDO+oqCQIdS39rKPpw/aChHaCV+j62HUp5VWQQ+HkfpedzCJeHw1kEq9u
 tR8ehtUJmuMZVWIAUFb7sUt69HhfKLGILm6tD1Bp3f3y2lpI2Y5/OqzrUFgyjhDFe+oORDeuP
 eLqsllWqbNUwDrPKAt2HyQrkscaDpxigi7uuZorzzKHxnnh4AgeZSKD0jDFq4d1AMMJIlYMtD
 Yrp/6KznPynJOI6ViKVag7GS4JVdh0YIVqZlE7l3/Ox1P/UA+tmCb1YX7ld3w/4v1e6J66INB
 9DxzOvmoe6FZ10IPW22w==
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org



On 24.03.21 13:42, Anatoly Pugachev wrote:
> On Wed, Mar 24, 2021 at 3:31 PM Frank Scheiner <frank.scheiner@web.de> w=
rote:
>> Sorry, but I can't install `gdb` on my T1000 ATM, because it depends on
>> "libpython3.8" for sparc64 (see [1]) and "libpython3.9" for the other
>> architectures, but "libpython3.8" is actually not available for sparc64=
,
>> "libpython3.9" is available for sparc64 though:
>> ...
>> The following packages have unmet dependencies:
>>    gdb : Depends: libpython3.8 (>=3D 3.8.2) but it is not installable
>>          Recommends: libc-dbg
>> E: Unable to correct problems, you have held broken packages.
>> ```
>> Something wrong with the dependencies. Any suggestions?
>
> Frank,
>
> you could use http://snapshot.debian.org to install old versions of
> packages, i.e. gdb and libpython-3.8

Of course, didn't think about that. Will try that and report my findings.

Thanks and cheers,
Frank
