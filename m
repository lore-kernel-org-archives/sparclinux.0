Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A7A222589;
	Mon, 17 Mar 2025 07:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194881; cv=none; b=N9PcXRzMcFUkjD0exx4QUxj+j1+SIBsE0qYbmhlt5ceQdOIG5Tzivlu0gEp26eNvkFKPKRlxy7zLlMGf9+Z2/vBg/9qbGQAjAHksyf/fU5PzzkMl2BFJr/b2YKn0moJZSzF0mgJcbV/ZdDprohFs1l4GtTqn9zQglELAQcWv7Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194881; c=relaxed/simple;
	bh=aBPpmUcGDUxtVqNYBJ0y1S8mhJ2vEs38pfC3bkBgSxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoqIyjcGrz9F5j1VhDDWJnlTMxMb4bcugRbEWhRNyYsQi35MZgMkU0syXmGyfOAs4IYxheAv5Ca/B6d9JtqQo302O0HIWWj5lAGu5mNe+mT69H4Eiqcc7PrK4gaGJ4aXnDpXi32CqVAu+Rm0ji352qq8wPI26Dt5oUI9aqmAlTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F5VBEoTF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F5VBEoTF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E96FC4CEEC;
	Mon, 17 Mar 2025 07:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742194880;
	bh=aBPpmUcGDUxtVqNYBJ0y1S8mhJ2vEs38pfC3bkBgSxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F5VBEoTF11phoho4ypFGxNctozFRv+i9J46Vxp2mq479IyHBO7fyElGFis6V1TKlh
	 5JWjBPsa8D3NCl3F5KnUxekvFFMtb2rKKywyaJAAPgjfrNAeCSeTawyk4V7Xo4vqmT
	 EpbLzb1LWK1bJ6Hq1yoKYAGJNdO1bGYOPi0Q/fa8=
Date: Mon, 17 Mar 2025 08:00:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
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
Message-ID: <2025031738-variable-desecrate-ec2f@gregkh>
References: <20250220111606.138045-1-jirislaby@kernel.org>
 <2025031738-fabric-alright-6a32@gregkh>
 <e8fb71ea-84cb-427a-9dc9-9c44ec0db08f@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8fb71ea-84cb-427a-9dc9-9c44ec0db08f@kernel.org>

On Mon, Mar 17, 2025 at 05:59:01AM +0100, Jiri Slaby wrote:
> On 17. 03. 25, 5:28, Greg KH wrote:
> > On Thu, Feb 20, 2025 at 12:15:37PM +0100, Jiri Slaby (SUSE) wrote:
> > > Hi,
> > > 
> > > this is (again) a series of cleanup in tty. I am trying to rework
> > > tty+serial to avoid limitations of devices (so called NR_UART or
> > > tty_alloc_driver()'s first parameter). And the below popped up while
> > > crawling through the code. So this is only a prep cleanup.
> > > 
> > > * many tty flags are now enums
> > > * many functions were improved for readability
> > > * quite a few unused or old code dropped
> > > 
> > > In particular, the runtime behaviour of the kernel before and after the
> > > changes is supposed to be bug to bug compatible (except moxa's ioctl
> > > and ISA evils dropped). That is, noone should notice.
> > 
> > Were you going to do a new respin of this, or do you want me to take
> > this as-is and you will send a follow-up ones for the commented-on
> > changes?
> 
> I planned to send a v2 on Fri, but did not make it. I will today.

Not a problem, just wanted to make sure I didn't drop these on my side
accidentally.

thanks,

greg k-h
