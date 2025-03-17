Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389BB1B0F11;
	Mon, 17 Mar 2025 04:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742185767; cv=none; b=XsOj7pysgCfXsGSApdJonoiR67fVNORccGR1PHdvAfDvSn+xoVyYT3GbmUBla9Y30vZgnw4983eoeBZPyLSNgE8VVoZHrqRJwThfj7exnqTI55tRjTa0azPy1Fk02MensZ63ST6sC43EJ+Zochss8hqRoqIz9lr/3yDY8XBlt/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742185767; c=relaxed/simple;
	bh=3jYGVUq7uZgiXolwju9jzN3CjqHhocS2Q0Jc6ljkDd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BomTGe8TybUv9yE3YVQ7358KwyppyGcrnELFrT7hsKhuJdDte45TxoYIseFQP6Nqq2rU3OE03IqMowO/nVU4wrZmZsOHaVmIARZ8gpWqCa/zVcuqWFab5B/KgpMnir9DrvBWQisPbS5xTwh8hPBPK0MUBMKbaeyKgD6rfgEwsRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sa9fIDuK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sa9fIDuK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286C1C4CEEC;
	Mon, 17 Mar 2025 04:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742185766;
	bh=3jYGVUq7uZgiXolwju9jzN3CjqHhocS2Q0Jc6ljkDd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sa9fIDuKHudF1TNOPy+8ByAv+e0eagvO3VVecHk7x34dJWkSqXj1QzvO8J1Rc4a1X
	 aysnDUQQy+axn/ruFMBWZCgb8eHiofju6EheMOQtoSNMbxOCkG3UWOysvF+qj0/oVi
	 sw7WjB3LdvTTWSJ3deYfPyXCLV9f/9M5zxAElX1E=
Date: Mon, 17 Mar 2025 05:28:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Lin <dtwlin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, greybus-dev@lists.linaro.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>, Johan Hovold <johan@kernel.org>,
	linux-alpha@vger.kernel.org, linux-staging@lists.linux.dev,
	Matt Turner <mattst88@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Rob Herring <robh@kernel.org>, sparclinux@vger.kernel.org
Subject: Re: [PATCH 00/29] tty: cleanup no. 99
Message-ID: <2025031738-fabric-alright-6a32@gregkh>
References: <20250220111606.138045-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220111606.138045-1-jirislaby@kernel.org>

On Thu, Feb 20, 2025 at 12:15:37PM +0100, Jiri Slaby (SUSE) wrote:
> Hi,
> 
> this is (again) a series of cleanup in tty. I am trying to rework
> tty+serial to avoid limitations of devices (so called NR_UART or
> tty_alloc_driver()'s first parameter). And the below popped up while
> crawling through the code. So this is only a prep cleanup.
> 
> * many tty flags are now enums
> * many functions were improved for readability
> * quite a few unused or old code dropped
> 
> In particular, the runtime behaviour of the kernel before and after the
> changes is supposed to be bug to bug compatible (except moxa's ioctl
> and ISA evils dropped). That is, noone should notice.

Were you going to do a new respin of this, or do you want me to take
this as-is and you will send a follow-up ones for the commented-on
changes?

thanks,

greg k-h
