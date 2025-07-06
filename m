Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039A872634;
	Sun,  6 Jul 2025 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751792156; cv=none; b=dLIiqAb3rFLNGUsxBoOHJjhF1EImotyWgn0RoqTibLcpK0FOzIDq0DyqZ4+OkGKSnVWBm9ZnrgAc9I6Zq6Hgxp6zufo+PMlwXax54YeMzb4VKnGTmRblcMl/chv0MgiR+C8ICHFnpfMANKrIHmOLFpTTprCxR+CYk5BoTlWB9TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751792156; c=relaxed/simple;
	bh=/jomRBZFEFrWxsVmsz4Qzt5t65NCA8AV0mjgmFxDLBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGjk6d0FCHaj7q41fA7G3V4U5SCd0APrIwaXAyyhK+N27DHmiFQC/laHRujuxvVmktgpfrMwPFy9sqsfWC/wp3NSBuhwO7CH8Z7g7xve1wr/XGAiKmh+fEBGxqkO4dhE5hYSySrPDqZ+CWQwLDzrxoOaL6TdMeNxvqvyC5JP4zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZKeOOyLD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZKeOOyLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290CAC4CEED;
	Sun,  6 Jul 2025 08:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751792155;
	bh=/jomRBZFEFrWxsVmsz4Qzt5t65NCA8AV0mjgmFxDLBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZKeOOyLDPTvszfdaURYPL6ChilQAqX9c1Z/yPzvwXdFnzvFqL+M5eDdOX9x8oLzn4
	 8PgWNqmzNd8XcANyeTYh5+06cnM9Y9t0UBnQrO6/z5D4Ot83dYciGDeuZqCS3F+k3A
	 VCz9s3QWzMRegMtG5y5WeUEglzHuD2A/zqm/tOn4=
Date: Sun, 6 Jul 2025 10:55:53 +0200
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
Subject: Re: [PATCH v4 6/8] char: misc: Does not request module for
 miscdevice with dynamic minor
Message-ID: <2025070625-voice-stuffing-e2fa@gregkh>
References: <20250704-rfc_miscdev-v4-0-b48986112d6a@oss.qualcomm.com>
 <20250704-rfc_miscdev-v4-6-b48986112d6a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704-rfc_miscdev-v4-6-b48986112d6a@oss.qualcomm.com>

On Fri, Jul 04, 2025 at 09:26:04PM +0800, Zijun Hu wrote:
> From: Zijun Hu <zijun.hu@oss.qualcomm.com>
> 
> misc_open() may request module for miscdevice with dynamic minor
> which is meaningless since macro MODULE_ALIAS_MISCDEV() is not
> applicable for dynamic minor.
> 
> Fix by only requesting module for miscdevice with fixed minor.
> 
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
>  drivers/char/misc.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> index 96ed343cf5c8509a09855020049a9af82a3ede95..a0aae0fc792666a7bdc0ba00da9dc02ff9cead42 100644
> --- a/drivers/char/misc.c
> +++ b/drivers/char/misc.c
> @@ -132,7 +132,8 @@ static int misc_open(struct inode *inode, struct file *file)
>  		break;
>  	}
>  
> -	if (!new_fops) {
> +	/* Only request module for fixed minor code */
> +	if (!new_fops && minor < MISC_DYNAMIC_MINOR) {
>  		mutex_unlock(&misc_mtx);
>  		request_module("char-major-%d-%d", MISC_MAJOR, minor);
>  		mutex_lock(&misc_mtx);
> @@ -144,10 +145,11 @@ static int misc_open(struct inode *inode, struct file *file)
>  			new_fops = fops_get(iter->fops);
>  			break;
>  		}
> -		if (!new_fops)
> -			goto fail;
>  	}
>  
> +	if (!new_fops)
> +		goto fail;
> +

This is fine, but is it going to break any existing users that happened
to rely on this behaviour?

thanks,

greg k-h
