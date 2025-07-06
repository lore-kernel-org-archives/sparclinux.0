Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB49E1A841C;
	Sun,  6 Jul 2025 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751791948; cv=none; b=B7BFdM75CrUJtwYeGfuSGOEhYTVr3w2AYQmY7o36XHb+OwU3ENcXCFu2xuL4vTpq04KIQ0gkHCR6R4D73M+GBaCFC/8tLdlTE7KeoogZNPKxDk+H0xKtnJ0xQkwwybCcd7USEy779KQDHYFhVJzryNtdrzL7h5GrnSQBQr9xLI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751791948; c=relaxed/simple;
	bh=/52eSGJiuIp2nJFKEc5QjCAGJ6KX4vtAlOJZMwbqzPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjbuA7mSpZssw/WgdvE07AFWZUPqETbdrbJmm5SzZuUFwql7cikJ3RXCpoEJrQ9zmBzI9xLq3UcgDQk4KdtUO7lk8O7EOHQgJ6Jb3eBKWK8QJQBqyA295auA5sVztWpA2GwsMsAe6Z28P15cBiKptKYa2PpVGkHXLX3c70yhbKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NFQF+O7H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NFQF+O7H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76BCC4CEED;
	Sun,  6 Jul 2025 08:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751791948;
	bh=/52eSGJiuIp2nJFKEc5QjCAGJ6KX4vtAlOJZMwbqzPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NFQF+O7HxToY3pXypocbiuUh8NDr8yz8lWBomfYr42mDX1DM0f6ZdvhWA7gzkE/ts
	 XKzbSoUBN8KJaWhK1LOgBxq9KKDiOIZe+waFMON+8NIYaoELSQoqexxNN+zdVHvty9
	 NtzOnkBbJ2ne995Lu9qbc6rzKz9ufl6q5rUPq8iU=
Date: Sun, 6 Jul 2025 10:52:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	sparclinux@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: Re: [PATCH v4 2/8] char: misc: Adapt and add test cases for simple
 minor space division
Message-ID: <2025070643-ammonia-unshaven-2d3f@gregkh>
References: <20250704-rfc_miscdev-v4-0-b48986112d6a@oss.qualcomm.com>
 <20250704-rfc_miscdev-v4-2-b48986112d6a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704-rfc_miscdev-v4-2-b48986112d6a@oss.qualcomm.com>

On Fri, Jul 04, 2025 at 09:26:00PM +0800, Zijun Hu wrote:
> From: Zijun Hu <zijun.hu@oss.qualcomm.com>
> 
> Adapt and add test cases for next change which Regards minor

"Regards"?

> which > MISC_DYNAMIC_MINOR as invalid parameter when register
> miscdevice, hence get a simple minor space division below:
> 
> |<  255 : Fixed minor code
> |== 255 : Indicator to request dynamic minor code
> |>  255 : Dynamic minor code requested, 1048320 minor codes totally.

I'm sorry, but I really can't parse this changelog text.  Can you try to
reword it a bit differently?

thanks,

greg k-h
