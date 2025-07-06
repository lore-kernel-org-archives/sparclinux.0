Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF5272634;
	Sun,  6 Jul 2025 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751792106; cv=none; b=WG5KVN/c2RnY/a+llTTrf4j6mCwUGdtm4wKelLSNUeLjJgSWkfZDfADnfVcRhbbvAmB6cABFF1eBiPabsnvv6Q3zgTJFooyx7DHGh9MyQ0PRxCLpslQWTJqp35XC3N1/F6QWkbv2Ofb9StvTeQmWF3zKNf9cdslRZFOeHSRqIRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751792106; c=relaxed/simple;
	bh=Trnc6YQCii2ifSQ0e1lYpQ29wCN/FwOKtYG4tvPQ7tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9kASDOHZB3w7ScQiIqAoPKDdpH0713b32FVraAvCPL6WwSbIF/m5nwROXjgtPtNuhj9Xp5FCZeZsNe3yMUDwK6BDEZrvQmj7PobA+GeBe633maYQZagIThwywh8FuhhcfKWhuOV4x28L8Et60Jzd2OiRN523z223k/kL5Tbqyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yP3KcPA1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yP3KcPA1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C10C4CEED;
	Sun,  6 Jul 2025 08:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751792106;
	bh=Trnc6YQCii2ifSQ0e1lYpQ29wCN/FwOKtYG4tvPQ7tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yP3KcPA1pSaZWqAClsvCCOO6YG+XaJRtw0AE0kgedACe1aE+mukt1FuWOjUGiyFzM
	 Ag7fvROy8cBdSqi+WqSExEmPkpPxyYPhnNYCuodWCKJxlhKW95reHo0qO/SBXUfviu
	 +37BsqCI9PsKFQO20VGbWMCcgC61RgV3/M9OTQ9M=
Date: Sun, 6 Jul 2025 10:55:03 +0200
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
Subject: Re: [PATCH v4 5/8] char: misc: Make registering miscdevice reentry
 who wants dynamic minor
Message-ID: <2025070658-brought-shakable-935e@gregkh>
References: <20250704-rfc_miscdev-v4-0-b48986112d6a@oss.qualcomm.com>
 <20250704-rfc_miscdev-v4-5-b48986112d6a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704-rfc_miscdev-v4-5-b48986112d6a@oss.qualcomm.com>

The subject does not make much sense, can you please reword it?

On Fri, Jul 04, 2025 at 09:26:03PM +0800, Zijun Hu wrote:
> From: Zijun Hu <zijun.hu@oss.qualcomm.com>
> 
> misc_deregister() frees dynamic minor @misc->minor but does not reset it
> and cause kunit test case miscdev_test_dynamic_reentry() failure:
> 
> | Invalid fixed minor 257 for miscdevice 'miscdyn_a'
> | #miscdev_test_dynamic_reentry: ASSERTION FAILED at misc_minor_kunit.c:639
> | Expected ret == 0, but
> | ret == -22 (0xffffffffffffffea)
> | [FAILED] miscdev_test_dynamic_reentry
> 
> misc_register()/misc_deregister() are sometimes invoked by driver's
> probe()/remove() separately, which has reentry requirement.

What do you mean?  Why is it required that this is reentrant?  What
in-kernel drivers require this?

> Fix by resetting @misc->minor to MISC_DYNAMIC_MINOR in misc_deregister()
> as error handling of misc_register() does.
> 
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
>  drivers/char/misc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> index b8e66466184fa21fb66d968db7950e0b5669ac43..96ed343cf5c8509a09855020049a9af82a3ede95 100644
> --- a/drivers/char/misc.c
> +++ b/drivers/char/misc.c
> @@ -288,6 +288,8 @@ void misc_deregister(struct miscdevice *misc)
>  	list_del(&misc->list);
>  	device_destroy(&misc_class, MKDEV(MISC_MAJOR, misc->minor));
>  	misc_minor_free(misc->minor);
> +	if (misc->minor > MISC_DYNAMIC_MINOR)
> +		misc->minor = MISC_DYNAMIC_MINOR;
>  	mutex_unlock(&misc_mtx);

misc is being unregistered here, so why are you changing the minor
field?  It's now invalid as it is not registered, so this value should
never be relied on at all, neither is anything else in this structure.

thanks,

greg k-h
