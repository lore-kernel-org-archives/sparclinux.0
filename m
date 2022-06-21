Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A754CCA473
	for <sparclinux@archiver.kernel.org>; Tue, 21 Jun 2022 20:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245194AbiFUUHA (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 21 Jun 2022 16:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354033AbiFUUHA (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 21 Jun 2022 16:07:00 -0400
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Jun 2022 13:06:58 PDT
Received: from mail.sf-mail.de (mail.sf-mail.de [IPv6:2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744A9B47
        for <sparclinux@vger.kernel.org>; Tue, 21 Jun 2022 13:06:58 -0700 (PDT)
Received: (qmail 22095 invoked from network); 21 Jun 2022 19:59:40 -0000
Received: from p200300cf071172002c3293fbd3f2e91c.dip0.t-ipconnect.de ([2003:cf:711:7200:2c32:93fb:d3f2:e91c]:57784 HELO daneel.sf-tec.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.38dev) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPSA
        for <sparclinux@vger.kernel.org>; Tue, 21 Jun 2022 21:59:40 +0200
From:   Rolf Eike Beer <eike@sf-mail.de>
To:     sparclinux@vger.kernel.org
Subject: Re: soft lockups on T5120
Date:   Tue, 21 Jun 2022 22:00:04 +0200
Message-ID: <331172124.8M8bRjPRla@daneel.sf-tec.de>
In-Reply-To: <c024bc4bb808a9c5717ec60bcde2e6d4@sf-tec.de>
References: <65a62b7c6e752dfb1b46624aa579d5e2@sf-tec.de> <63c23957-cfb0-ecdb-babf-31fe19c0661f@physik.fu-berlin.de> <c024bc4bb808a9c5717ec60bcde2e6d4@sf-tec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart18608765.9dvKgp9iWo"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

--nextPart18608765.9dvKgp9iWo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Rolf Eike Beer <eike@sf-mail.de>
To: sparclinux@vger.kernel.org
Subject: Re: soft lockups on T5120
Date: Tue, 21 Jun 2022 22:00:04 +0200
Message-ID: <331172124.8M8bRjPRla@daneel.sf-tec.de>
In-Reply-To: <c024bc4bb808a9c5717ec60bcde2e6d4@sf-tec.de>

Am Dienstag, 25. Mai 2021, 11:16:11 CEST schrieb Rolf Eike Beer:
> Am 2021-01-21 09:03, schrieb John Paul Adrian Glaubitz:
> > Hi Rolf!
> > 
> > On 1/21/21 8:23 AM, Rolf Eike Beer wrote:
> >>> The kernel currently is 5.10.3, but I hit this for quite a while
> >>> 
> >>> Here is what came out of dmesg today. I found no signs of trouble
> >> 
> >>> earlier than this:
> >> And here it is again:
> >> (...)
> > 
> > Anatoly found a reproducer for this bug [1]. So it might be an idea to
> > bisect
> > the issue with the help of the reproducer.
> 
> As there was at least one fix in recent kernels referring to opcode
> decoding: I still see the soft lockup with 5.12.4, and this time I did
> not run the gcc testsuite AFAICT.

I'm meanwhile at ~1 lockup per day. Affected are both 5.17.5 and 5.4.195. Will 
try 4.19 next.

Eike
--nextPart18608765.9dvKgp9iWo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCYrIjRQAKCRBcpIk+abn8
TnFpAJ9YTLNBPWjAIDkIVxWTX6iIIkfIsACgi6B/aFh5H36pUuqIdIi+GScHan4=
=f0jx
-----END PGP SIGNATURE-----

--nextPart18608765.9dvKgp9iWo--



