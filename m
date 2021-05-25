Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F606C47084
	for <sparclinux@archiver.kernel.org>; Tue, 25 May 2021 09:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A1C61378
	for <sparclinux@archiver.kernel.org>; Tue, 25 May 2021 09:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhEYJ0A (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 25 May 2021 05:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbhEYJZ7 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 25 May 2021 05:25:59 -0400
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 May 2021 02:24:28 PDT
Received: from mail.sf-mail.de (mail.sf-mail.de [IPv6:2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691E0C061574
        for <sparclinux@vger.kernel.org>; Tue, 25 May 2021 02:24:28 -0700 (PDT)
Received: (qmail 19418 invoked from network); 25 May 2021 09:16:11 -0000
Received: from mail.sf-mail.de ([2a01:4f8:1c17:6fae:616d:6c69:616d:6c69]:34074 HELO webmail.sf-mail.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.37dev) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPSA
        for <sparclinux@vger.kernel.org>; Tue, 25 May 2021 11:16:11 +0200
MIME-Version: 1.0
Date:   Tue, 25 May 2021 11:16:11 +0200
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     sparclinux@vger.kernel.org
Subject: Re: soft lockups on T5120
In-Reply-To: <63c23957-cfb0-ecdb-babf-31fe19c0661f@physik.fu-berlin.de>
References: <65a62b7c6e752dfb1b46624aa579d5e2@sf-tec.de>
 <d9e79cfa4b80373e2c54e1358d110335@sf-tec.de>
 <63c23957-cfb0-ecdb-babf-31fe19c0661f@physik.fu-berlin.de>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <c024bc4bb808a9c5717ec60bcde2e6d4@sf-tec.de>
X-Sender: eike-kernel@sf-tec.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Am 2021-01-21 09:03, schrieb John Paul Adrian Glaubitz:
> Hi Rolf!
> 
> On 1/21/21 8:23 AM, Rolf Eike Beer wrote:
>>> The kernel currently is 5.10.3, but I hit this for quite a while
>>> 
>>> Here is what came out of dmesg today. I found no signs of trouble
>>> earlier than this:
>> 
>> And here it is again:
>> (...)
> 
> Anatoly found a reproducer for this bug [1]. So it might be an idea to 
> bisect
> the issue with the help of the reproducer.

As there was at least one fix in recent kernels referring to opcode 
decoding: I still see the soft lockup with 5.12.4, and this time I did 
not run the gcc testsuite AFAICT.

Eike
