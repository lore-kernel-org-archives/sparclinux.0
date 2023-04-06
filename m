Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA21C77B73
	for <sparclinux@archiver.kernel.org>; Thu,  6 Apr 2023 19:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbjDFTeA (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 6 Apr 2023 15:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236739AbjDFTd6 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 6 Apr 2023 15:33:58 -0400
X-Greylist: delayed 1601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Apr 2023 12:33:53 PDT
Received: from mail.sf-mail.de (mail.sf-mail.de [IPv6:2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A697D6E82
        for <sparclinux@vger.kernel.org>; Thu,  6 Apr 2023 12:33:52 -0700 (PDT)
Received: (qmail 22137 invoked from network); 6 Apr 2023 19:07:16 -0000
Received: from unknown ([2001:9e8:6dc6:3c00:76d4:35ff:feb7:be92]:59950 HELO eto.sf-tec.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.38dev) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPSA
        for <arnd@arndb.de>; Thu, 06 Apr 2023 21:07:16 +0200
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     arnd@arndb.de, daniel.vetter@ffwll.ch, deller@gmx.de,
        javierm@redhat.com, gregkh@linuxfoundation.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 00/18] arch: Consolidate <asm/fb.h>
Date:   Thu, 06 Apr 2023 21:06:57 +0200
Message-ID: <2675533.mvXUDI8C0e@eto.sf-tec.de>
In-Reply-To: <20230405150554.30540-1-tzimmermann@suse.de>
References: <20230405150554.30540-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12183111.O9o76ZdvQC"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

--nextPart12183111.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: [PATCH 00/18] arch: Consolidate <asm/fb.h>
Date: Thu, 06 Apr 2023 21:06:57 +0200
Message-ID: <2675533.mvXUDI8C0e@eto.sf-tec.de>
In-Reply-To: <20230405150554.30540-1-tzimmermann@suse.de>
References: <20230405150554.30540-1-tzimmermann@suse.de>

Am Mittwoch, 5. April 2023, 17:05:36 CEST schrieb Thomas Zimmermann:
> Various architectures provide <arm/fb.h> with helpers for fbdev
                                  ^ *lol*

Eike
--nextPart12183111.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCZC8YUQAKCRBcpIk+abn8
Tg14AJ9zd7fmAHjabsNv4XQ0wrtRdP3wSACcCiALyhR78u5AwNndFsBEhTvFQg8=
=2czj
-----END PGP SIGNATURE-----

--nextPart12183111.O9o76ZdvQC--



