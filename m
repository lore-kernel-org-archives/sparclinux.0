Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AD6ECAAD5
	for <sparclinux@archiver.kernel.org>; Mon,  5 Sep 2022 14:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238069AbiIEO3C (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 5 Sep 2022 10:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbiIEO26 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 5 Sep 2022 10:28:58 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Sep 2022 07:28:54 PDT
Received: from mail.sf-mail.de (mail.sf-mail.de [IPv6:2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0685A88C
        for <sparclinux@vger.kernel.org>; Mon,  5 Sep 2022 07:28:54 -0700 (PDT)
Received: (qmail 31722 invoked from network); 5 Sep 2022 14:22:24 -0000
Received: from p200300cf0709290076d435fffeb7be92.dip0.t-ipconnect.de ([2003:cf:709:2900:76d4:35ff:feb7:be92]:51814 HELO eto.sf-tec.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.38dev) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPSA
        for <sparclinux@vger.kernel.org>; Mon, 05 Sep 2022 16:22:24 +0200
From:   Rolf Eike Beer <eike@sf-mail.de>
To:     sparclinux@vger.kernel.org
Subject: 4.14.291 hangs in futex()
Date:   Mon, 05 Sep 2022 16:22:11 +0200
Message-ID: <1904651.PYKUYFuaPT@eto.sf-tec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart21592057.EfDdHjke4D"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

--nextPart21592057.EfDdHjke4D
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Rolf Eike Beer <eike@sf-mail.de>
To: sparclinux@vger.kernel.org
Subject: 4.14.291 hangs in futex()
Date: Mon, 05 Sep 2022 16:22:11 +0200
Message-ID: <1904651.PYKUYFuaPT@eto.sf-tec.de>
MIME-Version: 1.0

While my other problems with the T5120 locking up are still there I noticed 
another error symptom when using 4.14.280 and 4.14.291: sometimes one of my 
nightly build CMake processes hands like this:

strace: Process 53402 attached with 2 threads
[pid 53402] restart_syscall(<... resuming interrupted futex ...>) = -1 EINTR 
(Interrupted system call)
[pid 53402] futex(0xf50fdb28, FUTEX_WAIT_BITSET|FUTEX_CLOCK_REALTIME, 53451, 
NULL, FUTEX_BITSET_MATCH_ANY

The process uses 100% of one CPU at this point, but can normally be killed. If 
I don't detect this in time, i.e. for a few hours, then the next build will 
start and the system will lock up as usual. I have not seen this with other 
kernel branches yet.

Any ideas?

Eike

--nextPart21592057.EfDdHjke4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCYxYGEwAKCRBcpIk+abn8
Ts8gAKCYFiL4PcNTm7fJDv7eI7PBBEWE8wCgiBD7rIqYY8e8b5WG372m4M5xWZY=
=OjRW
-----END PGP SIGNATURE-----

--nextPart21592057.EfDdHjke4D--



