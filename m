Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46684341ACA;
	Tue,  2 Sep 2025 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832700; cv=none; b=FjF31Mxf0pj2jcyVIsn1r5Pm0wQyMqUWMdI5Lqt7zzr9CsbPJo3Q2S+uHK8mOctZFZLjtGOKoiXb0yFB1TvGQ5w8NRkmTcX0cGxjvHzu7smetFauJ6qBcvEkocm1xaU4To2db0Ql36Ij2xtoQcdHIKEjgKR2OgE36QDN632UzRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832700; c=relaxed/simple;
	bh=FgitMAAoOhA5lo7QdDI/SWtzNreexFtLTd0/+ORe/0E=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=I5W7ZDvnAU6B0ZR2s1Prr2J1KVk1J8aLHjD+iq1nBQ/sLSSpomVbRVbldVjVSY/bct+JzAdANK5tq6YvmIJ03FpI2wd6zfD7dgQ8Oh2vwQucXwAcvG9hc8KtqgFiSFu5Qv2kgtiqAF//YhfwnToZSUHL15e1h3cQ45lI7D0g74w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactcode.com; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=KE93m39F; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactcode.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="KE93m39F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Sender:Content-Transfer-Encoding:Content-Type:Mime-Version:References:
	In-Reply-To:From:Subject:Cc:To:Message-Id:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Xyvh4aBmlBZr6bvS2J/XyOahxkkf4YdZmzZ2T9a1nPY=; b=KE93m39FoALcvuOMPakjdLeJoU
	Chzys3iGNuqT9DS+BmnZh7ymWrLwA977nzgorwr4QEjKlqDILeD5xT7VPUHM4c9xkOo62VSFIRbEa
	+LVL5jfyhWK0pwitXXOvhhybMcU9XYigyMNr35xfKbK0oFt39lW3KGh9f2+UJXDiLbpcEpUxQIMrW
	v9kMZqpDcuG0c6404GmD1gxhA1JaVbaP/auh5Yd2NLW0jQtqv+m9jPNx7x1zE8e84zEReYi9Lwu4n
	ws204hRtUmujyA3PZMn3KOq4bayWql8q7tb9bsUiWQmVwmtqKbiiew1GTk0vSquuskOjJckFpOF5t
	IgC8zXrQ==;
Date: Tue, 02 Sep 2025 19:04:59 +0200 (CEST)
Message-Id: <20250902.190459.1097165280513668946.rene@exactcode.com>
To: glaubitz@physik.fu-berlin.de
Cc: kernel@mkarcher.dialup.fu-berlin.de, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, andreas@gaisler.com, anthony.yznaga@oracle.com
Subject: Re: [PATCH 3/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for Niagara
From: Rene Rebe <rene@exactcode.com>
In-Reply-To: <1d32418278ac11e4a2f65c8b6bcd4c90143a1451.camel@physik.fu-berlin.de>
References: <cf4e16f7846a3324521828e71c0676b9c524ebbf.camel@physik.fu-berlin.de>
	<20250902.185101.101005511917098882.rene@exactcode.com>
	<1d32418278ac11e4a2f65c8b6bcd4c90143a1451.camel@physik.fu-berlin.de>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: rene@exactco.de

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

> On Tue, 2025-09-02 at 18:51 +0200, Rene Rebe wrote:
> > From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > =

> > > Hi Rene,
> > > =

> > > On Tue, 2025-09-02 at 18:40 +0200, Rene Rebe wrote:
> > > > Hi,
> > > > =

> > > > From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> > > > =

> > > > > Fixes: 7ae3aaf53f16 ("sparc64: Convert NGcopy_{from,to}_user =
to accurate exception reporting.")
> > > > > Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-ber=
lin.de>
> > > > =

> > > > Tested-by: Ren=E9 Rebe <rene@exactcode.com> # UltraSparc T4 SPA=
RC T4-1 Server
> > > =

> > > Thanks for the testing! However, this actually needs to be tested=
 on a SPARC T1
> > > as both T2 and T4 have their own implementation that is being use=
d. Testing on a
> > > T4 will therefore not invoke this particular code unless you modi=
fy the kernel in
> > > head_64.S to employ the Niagara 1 code on Niagara 4.
> > =

> > Ah right, sorry, IIRC you wrote that :-/
> > =

> > > Do you happen to have a SPARC T1?
> > =

> > Unfortuantely not. A T2 user might have one, but I could also modif=
y
> > the kernel and use the less optimized T1 code if that helps, ...
> =

> I have done that already to test the Niagara 1 code on Niagara 4.
> =

> However, it would be nice to test on a real T1. Unfortunately, I have=
n't found
> anyone yet who got one. If you could ask your users, that would be gr=
eat.

someone in our Discord probably has one in the basement or attic, but
the chances of them turning just that system on the next days or weeks
is probably rather slim.

I guess testing all the "popular" systems: vintage collected
workstations and affortable more modern higher performance T4 servers
is all we got for the near future for this patches.

       Ren=E9

> Otherwise, we will have to go with the current level of testing.
> =

> Adrian
> =

> -- =

>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

-- =

  Ren=E9 Rebe, ExactCODE GmbH, Berlin, Germany
  https://exactcode.com | https://t2linux.com | https://rene.rebe.de
