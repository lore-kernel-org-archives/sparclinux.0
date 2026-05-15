Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992BD2F7EE6;
	Fri, 15 May 2026 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778867500; cv=none; b=SJh4JrzhbP4Ld0aY0r5vLlK+F1YLT+2uR59JLEL51wpfMTmwUNZfJksYYttTob/PcA+hA98UnlNQ2kjH60khTKIbV9mWHaBlFI00TmgY5xNseA3MxXJITWSknCTo2BBwNpfG/BEWkahGKxks5OWWxOmwGB18wCUS4jyRFHd7j8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778867500; c=relaxed/simple;
	bh=gsQASe5VLtTK1CsE8cqevHSBFe/A5STk4AhJ2klQIWM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UjEv3loxMWJKWezZt17kx/dgMq4y0REYqlVFxXYa0+tjyNjHrc/zLuP3nAphn+ZYXUBsVh+MNEbZ9bIz7Gqb6C9/I8iAIZMM99zB0CRRlGHEAFXOpFQf7/XJaiFiXsKfcGKNfmXkK7/alvBGNl7t7hJwVtKunRhb82aBVPWoVhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=dwPIg/f7; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="dwPIg/f7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=HDc8Rbn6gSc83YkMlQR58q1uD3nHw5WFwhRyJ1E+IXA=; t=1778867496;
	x=1779472296; b=dwPIg/f7kWv2ASd6w8Ond9dTst4U5tVZTXABk4TTpbjKoe5LaAXwx2X40sqr9
	R+4kBWLz37Vy3c2YCvGxtepXVgIJ35c4jNgYW7jkLxLwV2vbKlPJlNvS/0nIOsptCfZuDufLXG4ic
	B8TzFq/eTJz16ZAg5mlwuqilNZm++a2o2ecPlNPqAsSHInUqEOPGUpCdEedqeoJMHuu4i/mpxL4J8
	HrRxiUMfcuM+3W2sM0hw1Wbpb2Lcfm+1UMQy5Wu4o9Gl08YEAVw1v11GVrvuPxhrFBVlqdFfoRU0h
	wT/Xrtp+y1Rephx9d91t+TTmk/unBBjG4m+C1geGVIhnfOYrPw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wNwh5-00000001x7R-3CyX; Fri, 15 May 2026 19:51:27 +0200
Received: from p5b13a134.dip0.t-ipconnect.de ([91.19.161.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wNwh5-00000001Za4-1mX9; Fri, 15 May 2026 19:51:27 +0200
Message-ID: <a0feba9667ac6760f82137cca89afac7da786f22.camel@physik.fu-berlin.de>
Subject: Re: the stuttering regression in 7.0: should I have done something
 different
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas Gleixner <tglx@kernel.org>, Tony Rodriguez <unixpro1970@gmail.com>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>, LKML	
 <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, Thorsten
 Leemhuis	 <regressions@leemhuis.info>, Linus Torvalds
 <torvalds@linux-foundation.org>
Date: Fri, 15 May 2026 19:51:26 +0200
In-Reply-To: <871pfcznw0.ffs@tglx>
References: <ffb44522-f01c-4be3-849d-27dc17fbca7f@leemhuis.info>
	 <D5D19776-C809-4284-9417-F9A860877B98@gmail.com>
	 <1c165caf-36b4-4673-97fd-ed86bef17b88@leemhuis.info>
	 <3332123b-9e11-4895-9ab3-1707fba5815c@gmail.com> <871pfj9cmj.ffs@tglx>
	 <a7a0d78b-435e-43c8-b436-5e7f4dd39dee@gmail.com>
	 <088e6cfa-0167-4748-af6c-458ade2f303a@gmail.com> <878q9p82je.ffs@tglx>
	 <64f465ca-6117-4375-9c4b-af771b8205fd@gmail.com> <87tssb6olo.ffs@tglx>
	 <e45438e7-8501-4c10-95ee-07f118de8a51@gmail.com> <87qznez3tf.ffs@tglx>
	 <0669f754-a313-4aa3-9923-0c374d49feb3@gmail.com> <871pfcznw0.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Thomas,

On Fri, 2026-05-15 at 17:35 +0200, Thomas Gleixner wrote:
> > Thank you again for the debugging guidance and for the feedback on my=
=20
> > original patch addressing the timer starvation issue. It was a pleasure=
=20
> > contributing to the resolution.
>=20
> Thank you for going through the hassle of chasing it down and providing
> the debug data to analyze it.
>=20
> I'm still puzzled how this went unnoticed for almost two decades:
>=20
>    112f48716d9f ("[SPARC64]: Add clocksource/clockevents support.")

My suspicion is that it was previously visible only in certain edge cases,
in particular on machines with many cores and high load.

Case in point: In the past, SPARC LDOMs with lots of virtual CPUs could
crash in rares cases when building packages such as GCC or LLVM and running
their testsuites.

I don't know if Tony's patch fixes this long-time issue that we have observ=
ed
in the past on Debian's buildds, but I think that the chances aren't too ba=
d.

Tony, please clean up your patch and add an elaborate explanation in the co=
mmit
message! Hope to see this fix landed as soon as possible!

Thanks to both of you for hunting this down!

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
