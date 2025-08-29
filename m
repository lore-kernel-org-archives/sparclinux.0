Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4601831A54E;
	Fri, 29 Aug 2025 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756481068; cv=none; b=YdL9UYEYx33jd4+ZIFghVTuCAOW3f0g3hV3mvdkuJ3kZDIObLgWSw50mpEIIV/Eqs/FPlonHIiKPEW66dgfHeLWetcyc37yjo12XPg5HYbVd+9c8zDmsXFosaTs71pd/KYYHJdZsSxndC4s903AUvEL0TNVMV/F1xLWWPgVn1AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756481068; c=relaxed/simple;
	bh=WvP1a9OWWAcMBRUFia1F+cqtBVlgQRekpMrS3ZSE8sw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MlPxAscqtThr/0FSKSnU3uhctjVn3x/UWATI7u803w6Vyank8TmXDu0MBQ6P91P1SBzEXJ9KWSl4sNiii+/SEIZ+5Xb0Qj/O/mdxlx9Fldx/k8lkEYkNYyAnXj2AuEBZuJhJFWSsz8OQtjnRUMnm/cO+3XRv10wmKB4TGbV7emM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=DVrkOPsB; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="DVrkOPsB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=mX735Q/4XZFX7y4hr5+ILgyC8bFLHmYhBKqs8glVQIw=; t=1756481065;
	x=1757085865; b=DVrkOPsBM8D1mSplzLQ2vAAH+nh8DUF1gQXbv80v+kgxnCFKidGnDhZxYBsy4
	K/2lIa2RU73tjO9mYBocFtVPUlgBRKXtXO1rFn7jQYRrsZiE+nkjkXTQUPZdS/mCrF3V+icYmFQBu
	bXd3ZWM6x6NjqUR4lmu8tujYDDHf0dC+PNXrAe+ecL1nvvsyr4asQGWHj5PE7XMJlGk+8+sx8u1UC
	lP3z7uWDAqs/FcV1FbnhMIKXZwdl3grYSP/+ZMAdei74YAzOkN0YNMcz5/dphp5+QQ2biV4iC/Bz/
	OGrkJlRkT8Zxt0fruqls570m0ftd5mvh7L0Hqc60wILZGbj19Q==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1us0xd-00000002BDq-1tAj; Fri, 29 Aug 2025 17:24:17 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1us0xd-0000000141v-0pmk; Fri, 29 Aug 2025 17:24:17 +0200
Message-ID: <7dd79e0407696f975d545d78b3083ef06a838082.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 08/13] sparc64: vdso: Switch to the generic vDSO
 library
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski
 <luto@kernel.org>,  Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Arnd Bergmann <arnd@arndb.de>,  "David S.
 Miller" <davem@davemloft.net>, Nagarathnam Muthusamy
 <nagarathnam.muthusamy@oracle.com>, Nick Alcock	 <nick.alcock@oracle.com>,
 John Stultz <jstultz@google.com>, Stephen Boyd	 <sboyd@kernel.org>,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Date: Fri, 29 Aug 2025 17:24:16 +0200
In-Reply-To: <20250829124314-288d0445-a744-4022-93bf-7da255182411@linutronix.de>
References: 
	<20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
	 <20250815-vdso-sparc64-generic-2-v2-8-b5ff80672347@linutronix.de>
	 <0b223e3d-25af-4897-b513-699dfeedfa04@gaisler.com>
	 <20250826074526-a1463084-366a-44d1-874b-b898f4747451@linutronix.de>
	 <271c108b-0fe4-4e7a-9bc7-325e75cf60ab@gaisler.com>
	 <8f31efde-0212-49b9-a0ea-64d5532c0071@gaisler.com>
	 <20250829122023-948f7969-b6b0-4ae2-9c12-71cc39abcf9e@linutronix.de>
	 <b7ab1bdca349208532804d0d5e5af56817cd25c6.camel@physik.fu-berlin.de>
	 <20250829124314-288d0445-a744-4022-93bf-7da255182411@linutronix.de>
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

Hi Thomas,

On Fri, 2025-08-29 at 12:52 +0200, Thomas Wei=C3=9Fschuh wrote:
> On Fri, Aug 29, 2025 at 12:40:59PM +0200, John Paul Adrian Glaubitz wrote=
:
> > On Fri, 2025-08-29 at 12:37 +0200, Thomas Wei=C3=9Fschuh wrote:
> > > In the meantime I installed a full Debian, but the bug is still not
> > > reproducible in QEMU.
> >=20
> > Please keep in mind that QEMU emulates sun4u (on UltraSPARC II) while
> > Andreas was testing on sun4v (on Niagara 4). There might be differences=
.
>=20
> I am aware. Unfortuntely I don't have anything else available.
> If anybody could test this on real sun4u that would be great.
> Or teach me how to use sun4v QEMU without it crashing on me.
> In the past you offered access to a physical machine.
> Does this offer still stand? Does it also run into the bug?

We have a SPARC T5 in the Debian project that can also be used for that mat=
ter.

It's currently out of service and will be back online next week if all goes=
 well.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
