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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E2EC433C1
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 13:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A1161A0A
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 13:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhCXNJ4 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 24 Mar 2021 09:09:56 -0400
Received: from mout.web.de ([217.72.192.78]:34599 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230481AbhCXNJZ (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Wed, 24 Mar 2021 09:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1616591343;
        bh=v3VCEvvtBAWWvhKpUZwaX4gMnERxXqUb0ZtFynitJVE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DpmDeIW5nHqoR1oa/fUE4EbfnJzP14DeNgtQapW1bAfQ3+PSQEbfGWVqY8SclDYVn
         /gHtI4vpz7w8uzpujajHBIi4WjOUEqUUFrM/iqldd7TSkgzgvG1rWHUamNznkcZILZ
         db2yDICdf0jJ1Qf4FKctAjAgLFBSQ+KUat/KfOJI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.30] ([217.247.35.184]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Laky4-1m4wVT1ZXc-00kOks; Wed, 24
 Mar 2021 14:09:03 +0100
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
Message-ID: <8600c0fc-7144-4b38-d6ae-4dbbabb125ba@web.de>
Date:   Wed, 24 Mar 2021 14:09:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210324082817.GA2625@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V7mPPu6NhDT5KEF8ODEE4hMWBDG899393DxL9cHm0LveW9YcRpZ
 L/AWu7nEBU0wVxWnxOKF/99EP6vwfNuzVDCxmrvY51AkTCybx9lSODWwEX19hBDhvD0cymB
 tqTh9H0V9ZbLAifaRwSgaAgwMakeN0XUXzt1pWyFYiTqyHg9JJDjz7XSh27uUw1HcLcbrNU
 TmryGfWS+iuK0FB3wkU1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZOunttsvSc4=:etsmQ1rJIt1RrowHXcnMIt
 8JgfN9YyN+hKOgh7uu+hCEeED8/5RqPu+D8W85dXgwUDwIGnMCCmXDChxljs8Nm4VWbLx53BF
 35AvzKCtTC+aW2uUlaoUoVvxjED50kKkYsgMxSWDFZlxYlqdxYCsSIhlcrda+rYNijz/rfWZn
 eHES4gUwatqgAylSQRi9CPQ10m2HzC3S5R+gUId/X59u3El+urMScHGnro0tzZhFJ9UscgXGh
 t30+7PAi0s6dnH/h5Jigmoen2RD2nqTMVy/bWaz31OSizGgBtz2up/IFxVo+IDlPUgl2YbNRd
 GuPWWaswquTwBAGDuAz8PihM3aAeCPqxgHQtT2A1u7gAd4wsOoMPxayvD32nWfZgpxIxZTHoZ
 M3yJU05Wrk6WgOgg0pGYZeTodAhBYeQkL4OfwVtor7tOkgNeXMQjPeZnokrTs2ZBVW7/rc0xX
 lkp0PWmUEQquWWB/NYQarOhFwRZ8pdRRrDYcLVRz/l0l6yOe/knC0pv0h/yErXR6FdKolNYE/
 lF2iFXNo0e1OZxvO+RzrX3iStw75dDmbfGLsA0Mdi0TqUldYed6jS5LxerTrJiwu/BMvg1R5p
 /jEFeqlmFvfG8W5ACxw655jyLlUjj0jjNbT/9bLF4sDdJ7y4b5TRzcI+iAwuqoSfMYrS0tSAL
 Ejg7ysHibzPTp/6K1iOsyblVjUg5rZN4Z4HhyQCCWmkTGnVoZVU+K+gj63vkRXr1eU+vaEcrQ
 v19mZHCIlzafb9GmhKbF83XhSLg72zcBbkwXYoGxKSHpXEBiNBAavPyVyXoDAlyWlGqVYkswN
 YyFv5M7zDP8MZfi7IA8X1TA46feN5+Hc2+4Md17GAxaxxtJPJpgVEHAp7Y+YjHCs4QsQuITBk
 1oaT2zZMDnCQvD5fKUjA==
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

This is what I get:

```
root@t1000:~/kernels-in-question# gdb vmlinux-028abd9222df-new
GNU gdb (Debian 9.2-1+b1) 9.2
Copyright (C) 2020 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later
<http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "sparc64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
     <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from vmlinux-028abd9222df-new...
(gdb) l *(sys_mount+0x114/0x1e0)
0x6c6380 is in __se_sys_mount (fs/namespace.c:3390).
3385	fs/namespace.c: No such file or directory.
(gdb)
```

Kernel sources are not available on the T1000.

If need be, where do they need to exist and how should the directory be
named - `/usr/src/[...]`?

Cheers,
Frank
