Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CACAC4320A
	for <sparclinux@archiver.kernel.org>; Sat, 24 Jul 2021 06:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DFDB60E9C
	for <sparclinux@archiver.kernel.org>; Sat, 24 Jul 2021 06:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhGXFtB (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 24 Jul 2021 01:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhGXFsw (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sat, 24 Jul 2021 01:48:52 -0400
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Jul 2021 23:29:24 PDT
Received: from mail.sf-mail.de (mail.sf-mail.de [IPv6:2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65055C061764
        for <sparclinux@vger.kernel.org>; Fri, 23 Jul 2021 23:29:24 -0700 (PDT)
Received: (qmail 29130 invoked from network); 24 Jul 2021 06:21:54 -0000
Received: from p548c622d.dip0.t-ipconnect.de ([::ffff:84.140.98.45]:48018 HELO daneel.sf-tec.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.38dev) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPSA
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 08:21:54 +0200
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-parisc@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v2 21/21] dma-mapping: Disallow .map_sg operations from returning zero on error
Date:   Sat, 24 Jul 2021 08:22:28 +0200
Message-ID: <2591613.mvXUDI8C0e@daneel.sf-tec.de>
In-Reply-To: <20210723175008.22410-22-logang@deltatee.com>
References: <20210723175008.22410-1-logang@deltatee.com> <20210723175008.22410-22-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11795432.O9o76ZdvQC"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

--nextPart11795432.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 23. Juli 2021, 19:50:08 CEST schrieb Logan Gunthorpe:
> Now that all the .map_sg operations have been converted to returning
> proper error codes, drop the code to handle a zero return value,
> add a warning if a zero is returned and update the comment for the
> map_sg operation.

I see no comment being touched here.

Eike
--nextPart11795432.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCYPuxpAAKCRBcpIk+abn8
TmEXAJ4y9fSVV7pgh2KPWXQ4YaTcwXP08ACgkfbFqKsGtxv2IZPJJiPcxo/F4Bg=
=swGr
-----END PGP SIGNATURE-----

--nextPart11795432.O9o76ZdvQC--



