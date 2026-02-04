Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C5D35CBB3;
	Wed,  4 Feb 2026 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770210146; cv=none; b=K//dA6hblajb2PVBMa5dwT2jYfH948K3mjuKBDrjhDTUZ5P8CljfNxN3P3rN0nLO4m3ljR+UUZK8t5IAkYUlNoAnwq4F5pW6ECWTikAETXePtbYkC0KbKWE2RwFuIHDTe/JRGDed8uwMZVPqrCltlf+np7g5vCR0aPXD6d9zxLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770210146; c=relaxed/simple;
	bh=yvX4tuM80VUbNdCl99eBZeEK3XMgu2Qxlx9k8KKx6xA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GbHn5mMoPIkVEyIExu0XEBF/DGWy24PTp8DzjUMARvtj+KykyYd9sQPZ0V1u9jD25NV/yjhqcHShhDR8bdGyjXdW2mMW0HkAYHS63cJqWFVhC1DVx6tzZPMohkwN2q6EJ3jOP8sRHmygGgKjE3rnP9zEiVmBozF9s4KCmqRYX90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=C+BeEMqj; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="C+BeEMqj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=5UvSqYXTKY/sqcEOnw50nirIxjgk8PtyWEkELBIIuUk=; t=1770210145;
	x=1770814945; b=C+BeEMqjjnKn0aZDnCqgOUORZfD0V9ZDe9dmKL+tRR+QKuBddHN1rV8sq1XOJ
	qX4F3o2RsuN3LOHSQV/0WghTEbX79K1wwAdILNHF2dfAOpulINHPG+6nHQQBl0s8Eom474ny+zyj2
	0kWv6I/vZOO3QvOUfYqCUpeSbYpYYIq8INxnH0iXPOt+SfOFpy+g9KjVl8lEhjri2cHnqZj4wj8s8
	95PylD5gg3eQzX3eDY9t9gs5nxvUFDx7vOQRoWTptV9qrgRBEEOUij7W42SZIgATUxVnJPJr32t7t
	mV2hllDnY6VsucKwEqtVu4BltEcoqRPXgZxxj38MUlraiPGHIA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vncWS-00000001eTS-2nn5; Wed, 04 Feb 2026 14:02:20 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vncWS-00000003huV-1uks; Wed, 04 Feb 2026 14:02:20 +0100
Message-ID: <c841c8332c902bf1e28a276de71a4fd79eb2054c.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc: don't reference obsolete termio struct for TC*
 constants
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Andreas Larsson <andreas@gaisler.com>, Sam James <sam@gentoo.org>, 
 "David S. Miller" <davem@davemloft.net>
Cc: Stian Halseth <stian@itx.no>, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 04 Feb 2026 14:02:19 +0100
In-Reply-To: <123e6a3a-6360-45cb-8eef-23b1660b9253@gaisler.com>
References: 
	<99f1a93cf8cd4f0ece8611be2860677084663aac.1759359610.git.sam@gentoo.org>
	 <e11ecaf723594bf01c66fc5c80c25bda0621f34f.1759359616.git.sam@gentoo.org>
	 <87ecqyaefl.fsf@gentoo.org>
	 <123e6a3a-6360-45cb-8eef-23b1660b9253@gaisler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Sam,

On Wed, 2026-01-14 at 10:20 +0100, Andreas Larsson wrote:
> On 2025-10-19 21:18, Sam James wrote:
> > Sam James <sam@gentoo.org> writes:
> > > Similar in nature to ab107276607af90b13a5994997e19b7b9731e251. glibc-=
2.42
>=20
> Please refer to the referenced commit also with "commit", the SHA ID and
> the oneline summary of the commit, like so:
>=20
> commit ab107276607a ("powerpc: Fix struct termio related ioctl macros")
>=20
> > > drops the legacy termio struct, but the ioctls.h header still defines=
 some
> > > TC* constants in terms of termio (via sizeof). Hardcode the values in=
stead.
> > >=20
> > > This fixes building Python for example, which falls over like:
> > >   ./Modules/termios.c:1119:16: error: invalid application of 'sizeof'=
 to incomplete type 'struct termio'
> > >=20
> > > Link: https://bugs.gentoo.org/961769
> > > Link: https://bugs.gentoo.org/962600
> > > Co-authored-by: Stian Halseth <stian@itx.no>
> > > Signed-off-by: Sam James <sam@gentoo.org>
> > > ---
> > > v3: Fix constants.
> > > v2: Fix title.
> > >=20
> > >  arch/sparc/include/uapi/asm/ioctls.h | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > Ping.
> >=20
> > >=20
> > > diff --git a/arch/sparc/include/uapi/asm/ioctls.h b/arch/sparc/includ=
e/uapi/asm/ioctls.h
> > > index 7fd2f5873c9e7..f26befbf690fb 100644
> > > --- a/arch/sparc/include/uapi/asm/ioctls.h
> > > +++ b/arch/sparc/include/uapi/asm/ioctls.h
> > > @@ -5,10 +5,10 @@
> > >  #include <asm/ioctl.h>
> > > =20
> > >  /* Big T */
> > > -#define TCGETA		_IOR('T', 1, struct termio)
> > > -#define TCSETA		_IOW('T', 2, struct termio)
> > > -#define TCSETAW		_IOW('T', 3, struct termio)
> > > -#define TCSETAF		_IOW('T', 4, struct termio)
> > > +#define TCGETA          0x40125401
> > > +#define TCSETA          0x80125402
> > > +#define TCSETAW         0x80125403
> > > +#define TCSETAF         0x80125404
> > >  #define TCSBRK		_IO('T', 5)
> > >  #define TCXONC		_IO('T', 6)
> > >  #define TCFLSH		_IO('T', 7)
>=20
> Please also, like in commit ab107276607a ("powerpc: Fix struct termio
> related ioctl macros"), add the previous definitions as comments in
> order to be able to know in the future what these hard coded constants
> really should correspond to.
>=20
> Don't forget to make sure that the subject gets a [PATCH v4].

Could you send a revised version of this, please?

Debian's kernel maintainer refuses to merge this patch locally unless it's
been merged upstream.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
