Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B11DC433ED
	for <sparclinux@archiver.kernel.org>; Sat, 24 Apr 2021 06:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FA176101B
	for <sparclinux@archiver.kernel.org>; Sat, 24 Apr 2021 06:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhDXGgo (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 24 Apr 2021 02:36:44 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:43349 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230178AbhDXGgo (ORCPT
        <rfc822;sparclinux@vger.kernel.org>);
        Sat, 24 Apr 2021 02:36:44 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1laBtc-001Gjk-Vk; Sat, 24 Apr 2021 08:36:05 +0200
Received: from p5b13a1ac.dip0.t-ipconnect.de ([91.19.161.172] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1laBtc-000KlB-Li; Sat, 24 Apr 2021 08:36:04 +0200
Subject: Re: [PATCH]sbus:char:bbc_i2c:Replaced header file asm/io.h with
 linux/io.h
To:     Shreya Ajith <shreya.ajithchb@gmail.com>, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
References: <20210423065558.d5gy3zpxus6gsyc2@shreya-VirtualBox>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <a1136512-6074-d392-2dde-779f9eddda59@physik.fu-berlin.de>
Date:   Sat, 24 Apr 2021 08:36:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210423065558.d5gy3zpxus6gsyc2@shreya-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.161.172
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 4/23/21 8:55 AM, Shreya Ajith wrote:
> Replaced header file asm/io.h with linux/io.h

I would fix the missing spaces in the subject, i.e.:

"sbus: char: bbc_i2c: Replaced header file asm/io.h with linux/io.h"

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
