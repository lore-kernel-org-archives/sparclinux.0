Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5BC1F4176;
	Tue, 13 Oct 2026 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896672; cv=none; b=eJSGU2vNXwbWVbe/+XEYH8rpoxggqWu8DdFVJvzbVK2eMTmd+ruiFB+/U60oN+2KybYJLkGUrDNCKsz4tHjzb5TNwn4X7k2Ng5IwggKcHEWKJhEKrsuXpjFNnPLkKeNzDOhVcWbrWSVH83tuhNCLd0MOHYgOjo9PHfUrTw+aJFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896672; c=relaxed/simple;
	bh=W0tZFjEJB5zsyFKmNq9237R9e92br8yJvNJ7B1NHYoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxcsWHeqYjIj1Z1Q0Ng9uHCNEJE0QB30R7ocizNLYuEl9+d/ALqRcri33JpPmD1dTHuVCk2X1sTACyKrdEYuIOTuwdMoEDIizkP0wnVoH0iosmcnuBxEPog8QiG6WOASOfTvuAbwtgBWOtEXEs7tm+DCM8pLQ1RcCnVEb5Mh3Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CAlpIHMc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CAlpIHMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B311C1F00893;
	Tue, 13 Oct 2026 13:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791896671;
	bh=hW+jPunfJ7Za+BdShY2Xz3GhIHdo+5N8veQ/6QlvyF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CAlpIHMciK1QnMp9J66sGVr2jnbzUbco7OQ8bAp16pZpm8BK7Vv5md1P14960JZwY
	 mcxsrGasnOiiM+SvMOsFeP+UfWirPhZBv7bjXtgYXaGMpa8MWDJsjLe8/usW/4/83F
	 f7pBYbb95IP75Rew2Z4CD4pkkYMNt24Tte82OF54=
Date: Tue, 13 Oct 2026 15:04:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, jirislaby@kernel.org,
	linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org, oleg@redhat.com
Subject: Re: [PATCH v3 8/8] hvc: add an M3000 firmware console backend
Message-ID: <2026101313-plank-outlet-d3da@gregkh>
References: <20261012184826.986050-1-linmag7@gmail.com>
 <20261012184826.986050-9-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012184826.986050-9-linmag7@gmail.com>

On Mon, Oct 12, 2026 at 08:48:09PM +0200, Magnus Lindholm wrote:
> Provide hvc0 through the M3000 Open Firmware pseudo-console, validating
> the firmware model and console endpoints before registering it. Keep
> firmware buffers in locked kernel mappings and serialize their use in
> atomic console contexts through the existing SPARC p1275 interface.
> 
> Poll input while the TTY is open and synchronize close with timer
> rearming. Return zero on no progress so HVC retries buffered TTY output
> but drops stalled console chunks instead of spinning indefinitely.
> A firmware call that does not return remains unbounded.
> 
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
> ---
>  MAINTAINERS                 |   6 ++
>  drivers/tty/hvc/Kconfig     |  10 ++
>  drivers/tty/hvc/Makefile    |   1 +
>  drivers/tty/hvc/hvc_m3000.c | 202 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 219 insertions(+)
>  create mode 100644 drivers/tty/hvc/hvc_m3000.c

I'm guessing this will go through the sparc tree, so:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

thanks,

greg k-h
