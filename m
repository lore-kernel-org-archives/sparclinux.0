Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034691B394F
	for <sparclinux@vger.kernel.org>; Wed, 17 Sep 2025 12:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110574; cv=none; b=jIkbDwQw0W+npIWOBk7kuJRvG5vA50iQBnNQXPG2nBCjOBJeU7gJhc/7Wdl7R3TepV/tQRlzpOdoBm0beHW0NN2NBFEzx+TpoGQdFS8jTK0nn8fiulRISkYURTisFo0t79vNwtdevfbO5wZi+4BjDY3pAqfuv9B/RAJimyye4zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110574; c=relaxed/simple;
	bh=KEO+/1mei+vHnCuFB9BA36WBQcRRzMr9mUQ7AQWeQ+o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nlkv2jQdWwSVjCD1HoM+ExeDiWo0mli/NUYAjcYvHbQxGRggq7khpQTWywqvg+Od2ksQ2yTiCF2/hjp7kQOP+qwsY42S6i6KMgO9C59nxNEv1KNFWF+ZsAo9pP6vw4cTFMwNSqamRfEkUcZt8amidzEIaI5n+Y4fVlU5lvletLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=S/7YTQ40; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="S/7YTQ40"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=XNVohqNsH4rJQOIstzdKmtXqVlKWYq1anQTeBinkE5c=; t=1758110570;
	x=1758715370; b=S/7YTQ40JSaqboOrEWygNdaq+XaztMBzAPRE0Ml7eujAyjpiY/yLFXRWqSMwe
	DG1WYG4jYBS25Dn4AYg5jfJIBlnCG+QLmvRFUZ9AwhJ2IDkM6rPqfqx3RJCKVQbBBviWZpMXlFMlq
	v7DhJ0t/oe8iC6nvTdoLzI+x1Fh8E0aCsSutIoLp1WT8GMw/xYMqTWHpx3Y/4ENcNGuVwI98IRywl
	z6PmdVeY8k/QOC3rqDgvS+CQmz61xsmO7yQ9CHZ7keUeH/VdaYVeQn35UncMh/V6I98zraBQQqgHa
	lUVGKzAVibFOarm3nx9PaaARpWSx7/GRoHllXBOLd2QmvPnIOA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uyqrx-00000003DoP-2ikx; Wed, 17 Sep 2025 14:02:41 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uyqrx-00000002fqC-1pzm; Wed, 17 Sep 2025 14:02:41 +0200
Message-ID: <4207162c8254a2b8f423db485f974ca00ae355a3.camel@physik.fu-berlin.de>
Subject: Re: New test kernel - second attempt
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Riccardo Mottola <riccardo.mottola@libero.it>, 
 "<debian-sparc@lists.debian.org>"
	 <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
Date: Wed, 17 Sep 2025 14:02:40 +0200
In-Reply-To: <74380961-4a1b-95a7-96f5-448737356082@libero.it>
References: 
	<9b8530550078b5e89b19e987981d25fee8e18500.camel@physik.fu-berlin.de>
	 <7515a193-5ae2-69d6-9c6e-c3b6c7459f50@libero.it>
	 <73e81a8280b345ee09df0dfa9f0e21148144722f.camel@physik.fu-berlin.de>
	 <74380961-4a1b-95a7-96f5-448737356082@libero.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Wed, 2025-09-17 at 13:47 +0200, Riccardo Mottola wrote:
> John Paul Adrian Glaubitz wrote:
> > Keep in mind you may have to keep the machine off for a longer time or =
reset
> > the NV-RAM. We've got multiple reports now of machines that became stab=
le
> > after that.
>=20
> With the added experience of console wizardry, I attempted a "cold first=
=20
> boot" of the system into this kernel:
>=20
> Debian GNU/Linux, with Linux 6.12+unreleased-sparc64-smp
>=20
> I performed from full power-off (pulled socked plugs) direct poweron,=20
> cycle and first fresh boot into that kernel.
>=20
> It still crashes this way:

Can you try this upstream kernel:

https://people.debian.org/~glaubitz/sparc64/

Copy vmlinux-6.17.0-rc5+, config-6.17.0-rc5+ and System.map-6.17.0-rc5+ int=
o /boot.

Extract mods-6.17.0-rc5+.tgz somewhere and move the "6.17.0-rc5+" folder in=
 the
mods/lib/modules directory into /lib/modules, then run:

$ update-initramfs -c -k 6.17.0-rc5+ -v
$ update-grub

Then reboot into this kernel and report back.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
