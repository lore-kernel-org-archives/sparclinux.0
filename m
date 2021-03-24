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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975FFC433DB
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 12:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D6A161A09
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 12:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhCXMbT (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 24 Mar 2021 08:31:19 -0400
Received: from mout.web.de ([212.227.17.12]:44371 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230481AbhCXMbH (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Wed, 24 Mar 2021 08:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1616589044;
        bh=UvSbitkpBAEj3lE9szM/LJOpC6bIa3BnrXae8f9B5i0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lwng5RyhLel+Jnjq32cpH4LiXDQpKOVGGuM1D+cT5FpRtFlAz/LZscn0C9P2R7xaf
         igVROmlGk+uorQOEFgW78U9sg3z1bl/ArmAmFtq/BLk3B4RPqv35+A2NJIs4YkkGnS
         53o3cyytYNLhLKwa2LGKIp/QPPNS8xcfQYFGPEKU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.30] ([217.247.35.184]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjBVv-1lun2H3NYL-00eo7S; Wed, 24
 Mar 2021 13:30:44 +0100
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
Message-ID: <de572001-6238-8fda-aab4-f2ca443f2057@web.de>
Date:   Wed, 24 Mar 2021 13:30:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210324082817.GA2625@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rLgjpNfKTjeYd7k/Ff6dMH0FflFASjLQ3RagWhh7J+Xo502H9Qr
 6MVDStYtOeYrlLLft/WPxXrlTlDfqFBEJ/010A9sxm0JV3lX+UQWwvz2Wk8pzxjvIqIe5zl
 7Fnj8D6GSMpYTnyRVUmAff7WT3iXpMtSNgWgHIJTFcZXaRVZ45MU7r1h/HzVVOTW3gnxVry
 UffgTmHNIygRsLW4vlCCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ku8vJSk788g=:V/X4geuLLtetAKUmDcH2Ko
 YTPj6ioEyzpprGjfV0ucPypOqOPVB41d/eWeOI8+7UDNSR8trMnKiBrVLDss7GA1dw4CGCLTp
 DGKt12a2L3LoDSrc6ndAL8ntz01Eu89cR+QPWm2DSbjr5ndRqM4pskfw8ba6EKFesijzccpGa
 uwKeBXum+9CwdzmY7hC93Wk2b9rT53fQKUrHIlkJyofuhcnxXvd56Kbqr5oT9ag6y59TqEf6W
 9r/Drnxe7nOmIZcmOs80pATDfhZL44weTiDwd/DlLo7K9dfL6Q9k4OtMiCEMZZNiK9lJGvz5u
 WZjyd2dDi/qTKEXzLMDVYKo9y+tz9GYg0ZjEkNclKHr2/8lolfq2fUVnCcgofxVTT3t/OZohY
 XCPb1mH1BUlZcgdUXEBPhLAoGD+/96TvKHDagoxraE0wb4rmVivO1L2N/mgsaH/HLBP4P/Krt
 iJ32gsxbwQWenDzxS0rtUTWMzKciRClL0etuWF48VIdaqlV5gan6QWcYSj/708Y4xZVSl48qB
 zdEguhL3JD5dMlsvW4NNvLvhdVNIgtrN6PqB2cGVTetegSMZB0U6jfLw1AA+Mm4TgTvqa4QLz
 /fAhxb/5Mu1Y+sgRpWWqNcpdGIkO7tAymBe6yKsNIFAm3oVepLLRLK3x2TyaqKAw/63ucqiua
 nhmAuOM2a/msrbdly++Exr3Mf2DSJ4m+H8mqQ9xijZvuasAYQqdtFKqKbhkxnVU6UrKIHYlsh
 CNiPLXbp7F09I4OV2uVYugKQmRUWF9QpEAzgepD2nvbz21zlitJRGAlY9M84bKbD1vYKW1m1I
 y3SUk20rIPzuyApHD6DnZU66mHSGzT9qJuVQBr1zVa5e+tukQOrPS/pjWfivGQ7oXWO/V+At2
 XwcU5I7WTj/HhMY2EhKA==
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

Sorry, but I can't install `gdb` on my T1000 ATM, because it depends on
"libpython3.8" for sparc64 (see [1]) and "libpython3.9" for the other
architectures, but "libpython3.8" is actually not available for sparc64,
"libpython3.9" is available for sparc64 though:

```
root@t1000:~# apt install gdb
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Some packages could not be installed. This may mean that you have
requested an impossible situation or if you are using the unstable
distribution that some required packages have not yet been created
or been moved out of Incoming.
The following information may help to resolve the situation:

The following packages have unmet dependencies:
  gdb : Depends: libpython3.8 (>=3D 3.8.2) but it is not installable
        Recommends: libc-dbg
E: Unable to correct problems, you have held broken packages.
```

[1]: https://packages.debian.org/sid/gdb

Something wrong with the dependencies. Any suggestions?

Cheers,
Frank

