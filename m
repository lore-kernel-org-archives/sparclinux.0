Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E39EB64DA
	for <sparclinux@archiver.kernel.org>; Fri, 16 Jun 2023 15:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345853AbjFPPpd (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 16 Jun 2023 11:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345680AbjFPPpa (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 16 Jun 2023 11:45:30 -0400
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C0B295C
        for <sparclinux@vger.kernel.org>; Fri, 16 Jun 2023 08:45:28 -0700 (PDT)
Received: from [213.219.167.32] (helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1qABdf-0003NW-FR
        for sparclinux@vger.kernel.org; Fri, 16 Jun 2023 17:45:27 +0200
Received: from ben by deadeye with local (Exim 4.96)
        (envelope-from <ben@decadent.org.uk>)
        id 1qABde-006pQX-37
        for sparclinux@vger.kernel.org;
        Fri, 16 Jun 2023 17:45:26 +0200
Message-ID: <3e8b48661bb81ceaff9c286d4e44618d9769cfd7.camel@decadent.org.uk>
Subject: Re: [PATCH] sparc: Fix invalid .section syntax
From:   Ben Hutchings <ben@decadent.org.uk>
To:     sparclinux@vger.kernel.org
Date:   Fri, 16 Jun 2023 17:45:13 +0200
In-Reply-To: <ZIyBGdriWti6AsvH@decadent.org.uk>
References: <ZIyBGdriWti6AsvH@decadent.org.uk>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-zGwIaC8sUGhp6MVe4/2R"
User-Agent: Evolution 3.48.2-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 213.219.167.32
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org


--=-zGwIaC8sUGhp6MVe4/2R
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2023-06-16 at 17:34 +0200, Ben Hutchings wrote:
> From: Ben Hutchings <benh@debian.org>
>=20
> gas supports several different forms for .section for ELF targets,
> including:
>     .section NAME [, "FLAGS"[, @TYPE[,FLAG_SPECIFIC_ARGUMENTS]]]
> and:
>     .section "NAME"[, #FLAGS...]
>=20
> In several places we use a mix of these two forms:
>     .section NAME, #FLAGS...
>=20
> A current development snapshot of binutils (2.40.50.20230611) treats
> this mixed syntax as an error.
[...]

Actually this is currently only the case for m68k; the mixed syntax is
still accepted or sparc.  But it would not be surprising if this
changed for sparc as well.

Ben.

--=20
Ben Hutchings
The most exhausting thing in life is being insincere.
                                                 - Anne Morrow Lindberg


--=-zGwIaC8sUGhp6MVe4/2R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmSMg4oACgkQ57/I7JWG
EQlVZQ/+LKvGYUsrCJ6USg0SS1lpzThu6VlrjRUqB4P1z0UB+K42eDMEPUr4qEzI
jXXh2wQ42IR8xaXn3GfYgX9Y4SjfCG5FJE5tXB3QZsmq4dizLjnOS3eWdM6Pqsgh
qOp8iudrlKcfT3Pn2f4GtHsNBUSi3rT43u33sqGJxDjfRrdc8B2OJBqGn7aJ13Qf
QsSzdwOX/M5WwJDtekBNLuoU47rJNOn/snMsJA7O5nnnobkChY2NjrpzOTkrenKe
okIqSNX699kwpsUj0myHHc4m3e0V3bDzvKs7NEMvjlMxZ1pH3RFY5TduIJjwo1FN
LPuuujn6APT/Dd4jBFAxA3FbL/mI3p68He2tHbIFjPysOllFsyNGGwhB7bQ2AmRA
qDX2ixEHM6dSuVoPKe56a/8jPHVz8p7j5qdGE+Y3qJvB46up7m3kmaQqnCkCuGha
R3lVa0R2kaUykipSoIaRz5ix1uQf904LzFLkz9F0/XtddcOf2/gcIX0z4M/cv70/
UQm4dhsCI+Icdf+uTu2r8asdg8DMpCwgheJSM/BMpaK4OlIMEubEpRfs5er6R01K
BwclsatDIcubEf1dBuFddafYJa8iH8vId/iHudWsuLOZsr/BVnGXPQmfpwcWCPCW
MUxwvXpzzgt8uQab9TmD7SopI/1f8Fx02Gdx5OZ0+CuIB+9+xn8=
=OfBh
-----END PGP SIGNATURE-----

--=-zGwIaC8sUGhp6MVe4/2R--
