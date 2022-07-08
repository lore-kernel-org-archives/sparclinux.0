Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0058AC43334
	for <sparclinux@archiver.kernel.org>; Fri,  8 Jul 2022 20:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240003AbiGHUPV (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 8 Jul 2022 16:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbiGHUPT (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 8 Jul 2022 16:15:19 -0400
Received: from mail.sf-mail.de (mail.sf-mail.de [IPv6:2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6A824F00
        for <sparclinux@vger.kernel.org>; Fri,  8 Jul 2022 13:15:16 -0700 (PDT)
Received: (qmail 16812 invoked from network); 8 Jul 2022 20:13:46 -0000
Received: from dyn.ipv6.net-htp.de ([2a02:560:56c2:fd00:ee0:6d8e:d0a6:3148]:33546 HELO daneel.sf-tec.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.38dev) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPSA
        for <sparclinux@vger.kernel.org>; Fri, 08 Jul 2022 22:13:46 +0200
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     sparclinux@vger.kernel.org
Subject: Re: soft lockups on T5120
Date:   Fri, 08 Jul 2022 22:14:55 +0200
Message-ID: <1924207.KhzlMt9N0P@daneel.sf-tec.de>
In-Reply-To: <63c23957-cfb0-ecdb-babf-31fe19c0661f@physik.fu-berlin.de>
References: <65a62b7c6e752dfb1b46624aa579d5e2@sf-tec.de> <d9e79cfa4b80373e2c54e1358d110335@sf-tec.de> <63c23957-cfb0-ecdb-babf-31fe19c0661f@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5852663.dkOdrDlAOE"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

--nextPart5852663.dkOdrDlAOE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: sparclinux@vger.kernel.org
Subject: Re: soft lockups on T5120
Date: Fri, 08 Jul 2022 22:14:55 +0200
Message-ID: <1924207.KhzlMt9N0P@daneel.sf-tec.de>

Am Donnerstag, 21. Januar 2021, 09:03:35 CEST schrieb John Paul Adrian 
Glaubitz:
> Hi Rolf!
> 
> On 1/21/21 8:23 AM, Rolf Eike Beer wrote:
> >> The kernel currently is 5.10.3, but I hit this for quite a while
> >> 
> >> Here is what came out of dmesg today. I found no signs of trouble
> > 
> >> earlier than this:
> > And here it is again:
> > (...)
> 
> Anatoly found a reproducer for this bug [1]. So it might be an idea to
> bisect the issue with the help of the reproducer.

I can at least tell that my machine also hangs with 4.14.280 and 4.19.244.

Eike
--nextPart5852663.dkOdrDlAOE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCYsiQPwAKCRBcpIk+abn8
TsXaAJ4sTTvPOMW/1iRDZH5vkzIzqpgNpQCfYx3tqaB5ZXXENgejTd1h7Iemiqc=
=PB0w
-----END PGP SIGNATURE-----

--nextPart5852663.dkOdrDlAOE--



