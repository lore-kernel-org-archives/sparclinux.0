Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3E7C433FE
	for <sparclinux@archiver.kernel.org>; Tue,  4 Oct 2022 20:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiJDUia (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 4 Oct 2022 16:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJDUi3 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 4 Oct 2022 16:38:29 -0400
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Oct 2022 13:38:25 PDT
Received: from mail.sf-mail.de (mail.sf-mail.de [IPv6:2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD2225C73
        for <sparclinux@vger.kernel.org>; Tue,  4 Oct 2022 13:38:25 -0700 (PDT)
Received: (qmail 12975 invoked from network); 4 Oct 2022 20:31:44 -0000
Received: from p200300cf0734f300d8b1e5991a827345.dip0.t-ipconnect.de ([2003:cf:734:f300:d8b1:e599:1a82:7345]:35454 HELO daneel.sf-tec.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.38dev) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPSA
        for <sparclinux@vger.kernel.org>; Tue, 04 Oct 2022 22:31:44 +0200
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     sparclinux@vger.kernel.org
Subject: Issues with hw crypto and random support on Niagara2
Date:   Tue, 04 Oct 2022 22:31:41 +0200
Message-ID: <8766364.HtAsB3eGq2@daneel.sf-tec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7305911.2g4n36Rzat"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

--nextPart7305911.2g4n36Rzat
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: sparclinux@vger.kernel.org
Subject: Issues with hw crypto and random support on Niagara2
Date: Tue, 04 Oct 2022 22:31:41 +0200
Message-ID: <8766364.HtAsB3eGq2@daneel.sf-tec.de>

I recently upgraded the kernel to 5.19.12. The first thing I noticed 
afterwards was that the boot took nearly one hour and spewed lots of warnings 
about crng_init=0. As a workaround I did that:

# grep -n quality /usr/src/linux/drivers/char/hw_random/n2-drv.c 
770:    np->hwrng.quality = 5;

This has solved the issue for me, boot is now down to ~2min again. I wonder if 
I'm missing something obvious like another driver that I should activate?

Then I noticed that the hw crypto support from drivers/crypto/n2_core.c fails 
to load with -EINVAL. From looking at the code I think this is because 
statesize is not set for the hash algorithms, so registering the first one 
(md5) fails and nothing else is tried. I then set NUM_HASH_TMPLS to 0 so they 
were never attempted, which resulted in the second loop succeeding:

[   40.561230] n2_crypto: n2_crypto.c:v0.2 (July 28, 2011)
[   40.561361] n2_crypto: Found N2CP at /virtual-devices@100/n2cp@7
[   40.561506] n2_crypto: Registered NCS HVAPI version 2.0
[   40.562493] n2_crypto: ecb(des) alg registered
[   40.562567] n2_crypto: cbc(des) alg registered
[   40.562687] n2_crypto: cfb(des) alg registered
[   40.562760] n2_crypto: ecb(des3_ede) alg registered
[   40.562833] n2_crypto: cbc(des3_ede) alg registered
[   40.562906] n2_crypto: cfb(des3_ede) alg registered
[   40.563007] n2_crypto: ecb(aes) alg registered
[   40.563084] n2_crypto: cbc(aes) alg registered
[   40.563156] n2_crypto: ctr(aes) alg registered
[   40.563890] n2_crypto: Found NCP at /virtual-devices@100/ncp@6

Maybe someone with the knowledge about the right statesize could send a patch? 
I'm open for testing. This is probably broken for a very long time, i.e. 
8996eafdcbad149ac0f772fb1649fbb75c482a6a (kernel v4.3).

Greetings,

Eike
--nextPart7305911.2g4n36Rzat
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCYzyYLQAKCRBcpIk+abn8
Tm25AJ0dOwyEcvPUIzF/5eX7f/yurpI46wCfVhHwl/5TswD7Ek3diTJcXZo1UGc=
=FyJQ
-----END PGP SIGNATURE-----

--nextPart7305911.2g4n36Rzat--



