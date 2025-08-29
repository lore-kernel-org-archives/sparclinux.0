Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7261FDA8E;
	Fri, 29 Aug 2025 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482279; cv=none; b=J365BMkKZTioZuF9ANDHj4d9jtt32SEYb7E/LTMEEiX9QP/EFsXvy4dzpqCCcocyGKkhQQNHuvFG4yACpLHF7qpbNV3ByTpm0ae8wMKaKQ8LLsB3q6yYZk1bSFpNnQGNx+h7PUJnergc1yRyVtAnPn8V4nC1lfurjbVLkbb1N/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482279; c=relaxed/simple;
	bh=GY4YcHhXANaRXUN5v/oNVJnbYtXngHQL+dFjSPU183s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KpycIN+ALsRyHjZLo73QfhVW0xIaWHvPohEksdocKCAh+GfbLpdhTOfFPHEZe4nJwvoR0VQovZJPg3QNQzPUY3zLwbbZBD762GjLdxrX1ynERmF6D5mHHWsSYLyn+iBGzQTlYj1L6HdHAMhRrUqEVyvDP5XEtSeZnA/vQaVBSv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=BGQOo6If; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="BGQOo6If"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=lj1esDKPdL4RaCu4uortpISWOMs2R7Lb2+RYaV1G1XI=; t=1756482277;
	x=1757087077; b=BGQOo6If1eq/0RHClTanzxfUJT86btCgeScBzD5ruukPTrYaolwqC0xK81JpV
	gJKX37GSYcaYksZKWk5DwUHxCeqcJUYsHHWSgSEiXD58I6tNMKMb6cHHTXFxmJWRdXiUlDeBXFlYH
	I9d9B1IsA7Oaok0+egBZ2h1d1riKsis0MbRkmaa3XBhwDuK2rji15x/i04tO6yETIg/y1IduErYfh
	drAiRCJLSjq6bhC47YXVzMeH1qqWJHCfnw4KYKD/GVzuQlqNQs/oh6QVG0qJZI9iGifcdzr725gRh
	hiB4ssO4GiVNkj/R5xN6zGFVrpJgxrFiGrqNonspqnsrSaSdGg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1us1HD-00000002HWK-1kXn; Fri, 29 Aug 2025 17:44:31 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1us1HD-00000001gMI-0j29; Fri, 29 Aug 2025 17:44:31 +0200
Message-ID: <1019a5f6d0d097beb15f70acfd695d5add4d6582.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 08/13] sparc64: vdso: Switch to the generic vDSO
 library
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Andreas Larsson <andreas@gaisler.com>, Thomas
 =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
  Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnd Bergmann
 <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,  Nagarathnam
 Muthusamy <nagarathnam.muthusamy@oracle.com>, Nick Alcock
 <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>,  Stephen Boyd
 <sboyd@kernel.org>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Date: Fri, 29 Aug 2025 17:44:30 +0200
In-Reply-To: <7b699dde-2dde-4900-abd6-d902b4cff853@gaisler.com>
References: 
	<20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
	 <20250815-vdso-sparc64-generic-2-v2-8-b5ff80672347@linutronix.de>
	 <0b223e3d-25af-4897-b513-699dfeedfa04@gaisler.com>
	 <20250826074526-a1463084-366a-44d1-874b-b898f4747451@linutronix.de>
	 <271c108b-0fe4-4e7a-9bc7-325e75cf60ab@gaisler.com>
	 <8f31efde-0212-49b9-a0ea-64d5532c0071@gaisler.com>
	 <20250829122023-948f7969-b6b0-4ae2-9c12-71cc39abcf9e@linutronix.de>
	 <7b699dde-2dde-4900-abd6-d902b4cff853@gaisler.com>
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

Hi Andreas,

On Fri, 2025-08-29 at 15:41 +0200, Andreas Larsson wrote:
> I based my config on the SMP config that was in use on the system.
> Produces an tremendous amount of modules unfortunately, so I'll have
> to cut down in the config. Right now the turnaround time for testing
> a new kernel with this setup for this system is quite bad.

You can just use sparc64_defconfig, just make sure you enable support
for CGroups, Sun Partition tables and the Sun virtual disk and console
drivers as well as hypervisor support.

Also, make sure to disable kernel debugging support unless you need it.

>=20
> > * Which toolchain are you using?
>=20
> A toolchain built in Buildroot with GCC 13.2.0. Old kernel headers, but
> I only use it to build kernels. Do you think the kernel headers of the
> toolchain would play a role for vDSO?

FWIW, the latest toolchain is always available from kernel.org:

https://mirrors.edge.kernel.org/pub/tools/crosstool/

> > * This is a 64-bit userland?
>=20
> Yes.

Most if not all SPARC-V9-compatible distributions use a 64-bit userland the=
se days.

>=20
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
