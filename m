Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1984730566D;
	Mon,  3 Aug 2026 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766163; cv=none; b=UhsP4TGPMSjjnsuRwrxk49KF633Jzw1/B1wgR/CCLUvec8cLZ9smAciprq4DR4IxJeo0ovxCj4N06oT4o/0KRR1QLFqM1y8pDgxrJLDGrGi+AAT06XQXr//DUHf28C8du6CwezwEthciggO/0qHaneuivew6KipH3SoYDYKV/e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766163; c=relaxed/simple;
	bh=yl1nxuaUQkr7Tc+vg0n/aqYKEcvTe5GNVWcalyaNklg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMarEBgc6LhDojJaAQv6kUJJvoOFs6WRTIY5qzWGHm+jOHfGj1s8b6431RYyotOcmtbwFwnUPZy4xpkMeHRXrb/Wyv8p0nFw7EmTaEf9ItS1xp7CdehrnN+pfiuuOwtpVeLGKUuSR2hM4qQuUOWAkmBW6P3+GInuNvEaI5BouiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HAwdMg70; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HAwdMg70"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC091F000E9;
	Mon,  3 Aug 2026 14:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785766161;
	bh=zs28fNZpyv0n8GbK0CWykTKHcKPEGrslPM5N3nPnjqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HAwdMg70/GR4kJ06heS2HB5sxfikyCPC9Fp9WGzP7NIt90HlO/16rI2/UswFy1+b8
	 WHV3QCVJs8dsQtOhHM6j/sQjlFk7upD3Yfii2Y7My9B/wCrBDC+5LnECA7L11ijXqK
	 uR8zrljC9/asIryVGV8YI0Xw3umn1035aC/4xAtw=
Date: Mon, 3 Aug 2026 16:09:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Joshua Rogers <linux@joshua.hu>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, stable <stable@kernel.org>
Subject: Re: [PATCH 2/2] tty: vcc: hold port lock when clearing tty pointer
 in vcc_cleanup
Message-ID: <2026080338-imperfect-plant-ef79@gregkh>
References: <20260731-aisle-tty-vcc-v1-0-962e18beb8a8@linuxfoundation.org>
 <20260731-aisle-tty-vcc-v1-2-962e18beb8a8@linuxfoundation.org>
 <f3b571b3-86b3-480b-bde3-dd2e7bead7fb@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3b571b3-86b3-480b-bde3-dd2e7bead7fb@kernel.org>

On Fri, Jul 31, 2026 at 10:32:36AM +0200, Jiri Slaby wrote:
> On 31. 07. 26, 10:15, Greg Kroah-Hartman wrote:
> > From: Joshua Rogers <linux@joshua.hu>
> > 
> > vcc_cleanup() sets port->tty to NULL without holding port->lock, racing
> > with vcc_event() LDC callbacks that read port->tty under port->lock and
> > then use tty->port. This can cause a use-after-free when the callback
> > dereferences tty->port after cleanup has already destroyed and freed it.
> > 
> > Assisted-by: AISLE:Snapshot
> > Cc: stable <stable@kernel.org>
> > Signed-off-by: Joshua Rogers <linux@joshua.hu>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   drivers/tty/vcc.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
> > index 3947bd2b75ac..03ed8c692acd 100644
> > --- a/drivers/tty/vcc.c
> > +++ b/drivers/tty/vcc.c
> > @@ -983,10 +983,13 @@ static int vcc_install(struct tty_driver *driver, struct tty_struct *tty)
> >   static void vcc_cleanup(struct tty_struct *tty)
> >   {
> >   	struct vcc_port *port;
> > +	unsigned long flags;
> >   	port = vcc_get(tty->index, true);
> >   	if (port) {
> > +		spin_lock_irqsave(&port->lock, flags);
> >   		port->tty = NULL;
> > +		spin_unlock_irqrestore(&port->lock, flags);
> 
> For these, I like
> 
> scope_guard(spinlock_irqsave, &port->lock)
>   port->tty = NULL;

Fair enough, that's much cleaner, LLMs really do not know about that
pattern yet :)

thanks,

greg k-h
