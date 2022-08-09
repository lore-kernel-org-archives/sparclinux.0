Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3084CC19F2D
	for <sparclinux@archiver.kernel.org>; Tue,  9 Aug 2022 06:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbiHIGVb (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 9 Aug 2022 02:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbiHIGVa (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 9 Aug 2022 02:21:30 -0400
Received: from mail.sf-mail.de (mail.sf-mail.de [IPv6:2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2821FCC7
        for <sparclinux@vger.kernel.org>; Mon,  8 Aug 2022 23:21:28 -0700 (PDT)
Received: (qmail 20036 invoked from network); 9 Aug 2022 06:21:24 -0000
Received: from p200300cf071d2c00e1ce1419df96153a.dip0.t-ipconnect.de ([2003:cf:71d:2c00:e1ce:1419:df96:153a]:41742 HELO daneel.sf-tec.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.38dev) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPSA
        for <sparclinux@vger.kernel.org>; Tue, 09 Aug 2022 08:21:24 +0200
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     sparclinux@vger.kernel.org
Subject: Re: soft lockups on T5120
Date:   Tue, 09 Aug 2022 08:21:18 +0200
Message-ID: <2274833.04s1Uppo39@daneel.sf-tec.de>
In-Reply-To: <1924207.KhzlMt9N0P@daneel.sf-tec.de>
References: <65a62b7c6e752dfb1b46624aa579d5e2@sf-tec.de> <63c23957-cfb0-ecdb-babf-31fe19c0661f@physik.fu-berlin.de> <1924207.KhzlMt9N0P@daneel.sf-tec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1984874.AMu7ar9op3"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

--nextPart1984874.AMu7ar9op3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: sparclinux@vger.kernel.org
Subject: Re: soft lockups on T5120
Date: Tue, 09 Aug 2022 08:21:18 +0200
Message-ID: <2274833.04s1Uppo39@daneel.sf-tec.de>
In-Reply-To: <1924207.KhzlMt9N0P@daneel.sf-tec.de>

Am Freitag, 8. Juli 2022, 22:14:55 CEST schrieb Rolf Eike Beer:
> Am Donnerstag, 21. Januar 2021, 09:03:35 CEST schrieb John Paul Adrian
> 
> Glaubitz:
> > Hi Rolf!
> > 
> > On 1/21/21 8:23 AM, Rolf Eike Beer wrote:
> > >> The kernel currently is 5.10.3, but I hit this for quite a while
> > >> 
> > >> Here is what came out of dmesg today. I found no signs of trouble
> > > 
> > >> earlier than this:
> > > And here it is again:
> > > (...)
> > 
> > Anatoly found a reproducer for this bug [1]. So it might be an idea to
> > bisect the issue with the help of the reproducer.
> 
> I can at least tell that my machine also hangs with 4.14.280 and 4.19.244.

The same happens with 4.9.321. My initial kernel on that machine was a 4.10 
one as it seems.

Looks to me as if the bug has been "always" there, just my load was less so 
the problems have not shown up.

Eike
--nextPart1984874.AMu7ar9op3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCYvH83wAKCRBcpIk+abn8
TrhiAJ9Bix+yREhMTOrtVFLoYsIvYnZQ9ACeNHuLIIHnTqvzwa/ljuTQreZRfFY=
=JqGd
-----END PGP SIGNATURE-----

--nextPart1984874.AMu7ar9op3--



