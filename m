Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15CCBA4B;
	Sun,  8 Dec 2024 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733660250; cv=none; b=NYCDONPbblawnltcY79lQ9avDbq7gHZhC25EEADHsLD5OhC2kS0PmbK6j05WAj8wuniIWeBXE3Eeet1yaJNTievK8aNQOPip8ETg/mM38+LrP6eAtrtV64IvcChJCtGQ5hVAkOLNRzxPGj3r8a9AsOwtQr0XEJZoiJpWbEXrJ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733660250; c=relaxed/simple;
	bh=U2tsa4KNiH88DbLNHtJhPtmQnaF9sD/Exw764c1i3bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaZWjYiZ+PDhaQITcnmNuil3y1cAUFwODNiXNcRtKQg32QGuMjuY5+wPWquUDlaMfyZLeyX/EWLgMVdyTa/btuL+9eSIPWcrzZgSGCqy0rHOihoDMRu0o9OaqpJh5rxTFU+lO7qqsERSquDotxz0wm5Ut2i7ocUKlRvaYk/W9iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=J0BERIev; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="J0BERIev"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733660246;
	bh=U2tsa4KNiH88DbLNHtJhPtmQnaF9sD/Exw764c1i3bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J0BERIevXivdKxYYwok26jZkBvPaGLzRy7/UK0Mugp1WrFBOdeMzAQcjxvKDu3QjM
	 dwwWLpeUY1acm/Fefvv4afwItgFpPb4rZYGg92sbW0CDqqPBcN4ssCaqmmAKMUckrl
	 D4+2IMBqr4atA+ho6txPQwli3fYeak95Z4rND4w0=
Date: Sun, 8 Dec 2024 13:17:25 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: David Laight <David.Laight@aculab.com>
Cc: 'liujing' <liujing@cmss.chinamobile.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "andreas@gaisler.com" <andreas@gaisler.com>, 
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sparc: Move va_end() before exit()
Message-ID: <c6df0da3-218b-44f8-b68a-9e310192b652@t-8ch.de>
References: <20241206092346.6003-1-liujing@cmss.chinamobile.com>
 <b3596c1fb07e4c6bbe347e742dbb7126@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3596c1fb07e4c6bbe347e742dbb7126@AcuMS.aculab.com>

Hi David,

On 2024-12-08 11:03:23+0000, David Laight wrote:
> From: liujing
> > Sent: 06 December 2024 09:24
> > 
> > There is a static checker warning, so move the va_end call before
> > exit(1). Since the exit(1) function terminates the program, any code
> > after exit(1) is unreachable thus notexecuted. Placing va_end() before
> > exit() ensures that the va_list is properly cleaned up.
> 
> Aren't you just adding 'bloat' to the vdso?
> (It might even be space limited?)

This is about the build time tool "vdso2c", which converts the VDSO
binary into a C file to be compiled and linked into the kernel.
So it can't be a runtime issue.

That should probably been in the patch subject.

> If you are calling exit() then there is no need to tidy up the va_list.
> Much the same as there is no need to call free() or close() all fd.
> 
> I'd probably have written it as:
> 	// va_end(ap);
> 	exit(1);
> 
> 	David
> > 
> > Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> > ---
> > V1 -> V2: Modify the commit information and title description
> > 
> > diff --git a/arch/sparc/vdso/vdso2c.c b/arch/sparc/vdso/vdso2c.c
> > index dc81240aab6f..372e3330850a 100644
> > --- a/arch/sparc/vdso/vdso2c.c
> > +++ b/arch/sparc/vdso/vdso2c.c
> > @@ -90,8 +90,8 @@ static void fail(const char *format, ...)
> >  	vfprintf(stderr, format, ap);
> >  	if (outfilename)
> >  		unlink(outfilename);
> > -	exit(1);
> >  	va_end(ap);
> > +	exit(1);
> >  }
> > 
> >  /*
> > --
> > 2.27.0
