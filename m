Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33F0331A65
	for <sparclinux@vger.kernel.org>; Thu,  4 Jun 2026 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586875; cv=none; b=SJ03Iag+mslhzlMQCsoD04k+EvzXR7V7YADW6p91W/isqfERTVcPIxNlMBuOmfJcbdwkmINl2MczOVAxGXtqdEa0uzW/EbZ5gCZAmvtJcT0elfBRt+6WE4ytBBhN8QEr9C4nZ3LSZXM3Q2DvE421fjMI+Yi7taFlNQXw6PiUQis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586875; c=relaxed/simple;
	bh=vzKMFnSSlPcCRc7wimY6o+TgtiVDEpgrJTOmOq4+3Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvU3DsSSqoEBuXXtjZJn/fkGU9jkb+VpNMxQJVHIrimIUhLCTvMu6NmEMWidUNo0oPIL0VVtqdvRnESnMkq9yILwSxHVIbgVLwgFYM59Csmdcrw+uY9NsJp+dnfgoGSaW7MGYw4kSQgl6h4xVAGLt1L8Vitji0Flz2R61C/Wa6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O6B+0lcv; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O6B+0lcv"
Date: Thu, 4 Jun 2026 17:27:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780586870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LkSlXgzudMtqbqY+56pBmTZ2AyqZgjPMvXF9NgKtZJY=;
	b=O6B+0lcvZkw+7nBU9bFZa393hEBLH9XSl+d6pOU/4WNdMqFLQZnBEoX87hjGAmLhGnynmR
	6AX/ofLET4LPv5fI8wpwE7NHk5sE/Ig8jYQOhw736jjD+BG5PaU+BB0mRQK0hkTdtRE/LO
	R4t7pfSZN8Kq+G0PnRi9BJmRnNpyqIc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, Kees Cook <kees@kernel.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] sparc: vio: use sysfs_emit in sysfs show functions
Message-ID: <aiGZbzWglHiPIQzA@linux.dev>
References: <20260504181320.143003-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504181320.143003-2-thorsten.blum@linux.dev>
X-Migadu-Flow: FLOW_OUT

Gentle ping?

On Mon, May 04, 2026 at 08:13:20PM +0200, Thorsten Blum wrote:
> Replace sprintf() and scnprintf() with sysfs_emit() in sysfs show
> functions. sysfs_emit() is preferred to format sysfs output as it
> provides better bounds checking.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/sparc/kernel/vio.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
> index 8b4f55047716..b7b06752a038 100644
> --- a/arch/sparc/kernel/vio.c
> +++ b/arch/sparc/kernel/vio.c
> @@ -13,6 +13,7 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> +#include <linux/sysfs.h>
>  #include <linux/irq.h>
>  #include <linux/export.h>
>  #include <linux/init.h>
> @@ -121,7 +122,7 @@ static ssize_t devspec_show(struct device *dev,
>  	else if (!strcmp(vdev->type, "vdc-port"))
>  		str = "vdisk";
>  
> -	return sprintf(buf, "%s\n", str);
> +	return sysfs_emit(buf, "%s\n", str);
>  }
>  static DEVICE_ATTR_RO(devspec);
>  
> @@ -129,7 +130,7 @@ static ssize_t type_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
>  	struct vio_dev *vdev = to_vio_dev(dev);
> -	return sprintf(buf, "%s\n", vdev->type);
> +	return sysfs_emit(buf, "%s\n", vdev->type);
>  }
>  static DEVICE_ATTR_RO(type);
>  
> @@ -138,7 +139,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>  {
>  	const struct vio_dev *vdev = to_vio_dev(dev);
>  
> -	return sprintf(buf, "vio:T%sS%s\n", vdev->type, vdev->compat);
> +	return sysfs_emit(buf, "vio:T%sS%s\n", vdev->type, vdev->compat);
>  }
>  static DEVICE_ATTR_RO(modalias);
>  
> @@ -192,7 +193,7 @@ show_pciobppath_attr(struct device *dev, struct device_attribute *attr,
>  	vdev = to_vio_dev(dev);
>  	dp = vdev->dp;
>  
> -	return scnprintf(buf, PAGE_SIZE, "%pOF\n", dp);
> +	return sysfs_emit(buf, "%pOF\n", dp);
>  }
>  
>  static DEVICE_ATTR(obppath, S_IRUSR | S_IRGRP | S_IROTH,
