Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,TRACKER_ID,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE66C433EA
	for <sparclinux@archiver.kernel.org>; Tue, 23 Mar 2021 22:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F1F61879
	for <sparclinux@archiver.kernel.org>; Tue, 23 Mar 2021 22:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhCWWSO (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 23 Mar 2021 18:18:14 -0400
Received: from mout.web.de ([212.227.17.11]:46583 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233874AbhCWWSF (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Tue, 23 Mar 2021 18:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1616537862;
        bh=I82ch+gR3zgFGLejKeRa8yzXLf/j+oCjXcGxMBXRegM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YaQxWHgvsi3igkS0IR6vMDOuTi30Nh9p8bLK7Wv8fx9t+hpmlEHA2l6i3PZt3LKqt
         TiwjXOo3AvG+M/Zxw4+P2aDYwbCfeak0edZD8MFpQZircD8b6w7h7CJcxEu2FdvlSj
         jx7Jxa/eV959R1OQflkOd5Qw2KCiPKdCau6M0aOQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.36] ([217.247.33.250]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M43GU-1lOpLJ3qwy-000HWd; Tue, 23
 Mar 2021 23:17:41 +0100
Subject: Re: Regression in 028abd92 for Sun UltraSPARC T1
To:     Christoph Hellwig <hch@lst.de>, Jan Engelhardt <jengelh@inai.de>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>
References: <9ffdf604-ce04-9200-65c9-dd8921a45038@web.de>
 <186a7992-6e83-dc8a-1cfc-d07bb36935f5@physik.fu-berlin.de>
 <4d033ff9-329e-77e7-20de-720aa65bba3e@web.de>
 <n0n38p9-rn4s-213-n983-9o3o4oo8s54r@vanv.qr> <20210323165721.GA14577@lst.de>
From:   Frank Scheiner <frank.scheiner@web.de>
Message-ID: <d68767c2-e010-f90e-9f2c-bb5250465c58@web.de>
Date:   Tue, 23 Mar 2021 23:17:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210323165721.GA14577@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y9FYD7qXDqeTZ7xDroTyLLaFX0tmHa9hEJB/KiXW2fjEbWYi4Bm
 CNFn7BVuLIIyFYPeiGStROE505aBgw7dgFTjub14qNxvxMikyfebsnnp6QF9MFEPjs16RxL
 1rK4H0nl7ohkLGsVYbTFsrWM4XYLdlhA9/zmbxujJovn5UHLzki04XK3wRMtw6uMNugmSe2
 uzNb3vuysAwWU6KO4TA6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UKvzq6XVMI8=:2AusOWi0/SFbQl8JfhEJax
 XdP+4m1Ujl8eAfDEQvijMCe3YBMpo/4Y8+rLCsbe434rCZsC6ifSimSDR2gxPJaj/e1N8SBwK
 OHP54BuK/Uw10b4yKVklJJpL4UL+tZTG4Vo3OJIEX53w59twfwO+8wcc8aHyG5E3lN1Fb0du4
 PUUPUtZnQv9dKKdup9AIARG8Y+GOABP8/yMmtEp8wYYDpFSu1Epv8502vOKATjxZr12naxbsV
 UyNiqztTMyun4FmDO/1DMW2xC1GRsSu+CP9KT6vkyC9aTN7ez6F3VSQMrt0MVuU5jbX+EaDwL
 uiQAyrOA+9HYtEeVRUL40vFoD5efoSedXXIibZqOvS7L6T3J2yL4VAORwpFdZApiQzWyV3FOr
 uGteARIVKp/cE7yRfVik6XABiVQgox89iQDMu1emZWjUQXWr4K9nH21y5ng74A5SPgVRuIomI
 a24CCpnJWcTW0W6Vu9iqAarYmBLRIqLXO0wmC8kH+jrEREbPjM9F1S9P2D1RAVdbzccAvsveT
 jmhmTGystX/MskJRE8p7WgobueVav5lOAcXappgeGlzj2vu2Hqch6wdEGhXH0ttuQItIXzpdy
 dG6mZUrgRAaCvetxyCqEjSm74hnkq7N5tnWuRjNJaeY9I6EM5kTkhsB4H8V5DcmCIV5kuk1Yb
 SEbRpryi/8r/PaXwX8Zjf64R9NIP1DYKD26HmEhINhFCqa/wMbsZqt9Fvwv5tWefk6Yvdf6o0
 o5MR7CPVM9GhYePC3Be0B6ZRCUEsn3ApnjT34VNx4AVJC8DS84BS0+6Y7oP91aLlbVzJtpxnF
 cUMlr/kTopdQ7E83oXbI8KTFQJECgqEmN/+RepEhK19KY6V2MVEacJkvUj5aflKLXQZzWzs+h
 eWOJRLXiry1bkC6IzyObouBPido+W5J1F/BED9EDYaOGWwB1sMmz2hNmqdda6eCj6DH9/cIc1
 Ui8XkcVsboM8Td88ck7RvF44mQEN1yEHbckXOc2GhTEPybwecpTxBQOKOb0oBwjMRktX1JtG9
 2GZYRoxZ483LWTeZU2w636s4MDu/f9LuAtR9YTBdl1lXMp0FLxmgErt961gmhdrLFVH+XdZB4
 UmSoaHsNXNxfu0KmucqWe6AnWG3SggkQi6HTreFaCpqJpa2IbpxzYE6i64QWfGcu0QtheQ0E/
 lxzamJd2OEHtvCpCU6dIuYh/QOlH2FTzDAGomGspeciHcjFsiMIBWcRRAA8ixwmHdt1k7eaYr
 oxOBvSOwjxMH3W4rS
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 23.03.21 17:57, Christoph Hellwig wrote:> Frank, can you double check
that commit
> 67e306c6906137020267eb9bbdbc127034da3627 really still works, and
> only 028abd9222df0cf5855dab5014a5ebaf06f90565 broke your setup?

So I manually checked out both 67e306c6906137020267eb9bbdbc127034da3627
and 028abd9222df0cf5855dab5014a5ebaf06f90565 and recompiled both (doing
`make [...] mrproper` before each run).

The results didn't change from the ones from the bisecting process:

67e306c6906137020267eb9bbdbc127034da3627

...is working and:

028abd9222df0cf5855dab5014a5ebaf06f90565

...is broken on my T1000.

As I don't know how big attachments can be on this list, I put the logs
on pastebin.

A log for 028abd9222df is here:

https://pastebin.com/ApPYsMcu

A log for 67e306c69061 is here:

https://pastebin.com/uGLXX7RS

Cheers,
Frank

