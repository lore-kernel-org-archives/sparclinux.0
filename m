Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517FD2F2C6E;
	Thu, 10 Jul 2025 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752171759; cv=none; b=Kjb4fkgrAYJHOU4v0/Mz2mPFQ2uLORFdjWBP35pMFdz6lMgTYOjniXWf13TFQmZMZJpbFg5p7Bm7dTzfGB1oozTF8sz7yHDdcDBM/0EHX5QTc9y8jTOIlhTFFWMU5XttB+NotEndYc65V1sXuPY9zrV4YLbeKJIcrULAZe/+lFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752171759; c=relaxed/simple;
	bh=h0qKLmDhXIaFsgvlOIN3susDzu/+PPSRV6kLudOs6sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLlHw20pU5ZteOAY+OtxVIcbKl63qtaX0pcxmW290pD+b0rznFIwyvmwGi+b8Ll2nq3ZQUvXq632OhD15UYOcLgGS5hzWnSmZRvkIRRJsgwKNl5mupVa8uxoeM64Gjx2DZ9Szodmj5iiYzTHP/MFKZs6avLRseB8Cz4VaxRO1hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=QfykkzUo; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QfykkzUo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=C2bN5FstwQ/sSqjlVirDz35vgjcAjpul7lMG1TygQe0=; b=QfykkzUoR8knNdGlhwRx6HeWW3
	K0qL4smMy35ewHdsgN+4H+m4pEXkfVAzn7oBcKcmBIC1SoXqkTM3yR36unT5ar3y/bUlsMZ1/V7Vv
	kTgKtdt8h8qEyT+4CPzK+iXG/p+hVrh/PXFm+muJ8iT7mBKKSiWQp7GISlgJTWNxoZNIRBF3BXpVk
	mB2BfeSIBOolti5k/swn7TAZRtZWW6Ja9xuvOCjc9vdNGqBGjfrXMrRu9tpLK8c562oW3PRdN3LhB
	FqcAHctqff5tMSlxSglat2AictAChrPYT1KPUo/HPW7BKQU/XP8t+iyasiBIC+YAbJ3iOenxwmOHX
	LjMYvgig==;
Received: from 179-125-86-110-dinamico.pombonet.net.br ([179.125.86.110] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uZvuX-00F3Dn-L7; Thu, 10 Jul 2025 20:22:22 +0200
Date: Thu, 10 Jul 2025 15:22:15 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
	Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: Re: [PATCH v5 6/8] char: misc: Does not request module for
 miscdevice with dynamic minor
Message-ID: <aHAE103XZl8yqDuo@quatroqueijos.cascardo.eti.br>
References: <20250710-rfc_miscdev-v5-0-b3940297db16@oss.qualcomm.com>
 <20250710-rfc_miscdev-v5-6-b3940297db16@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-rfc_miscdev-v5-6-b3940297db16@oss.qualcomm.com>

On Thu, Jul 10, 2025 at 07:56:49PM +0800, Zijun Hu wrote:
> From: Zijun Hu <zijun.hu@oss.qualcomm.com>
> 
> misc_open() may request module for miscdevice with dynamic minor, which
> is meaningless since:
> 
> - The dynamic minor allocated is unknown in advance without registering
>   miscdevice firstly.
> - Macro MODULE_ALIAS_MISCDEV() is not applicable for dynamic minor.
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
>  	/*
>  	 * Place the miscdevice in the file's
>  	 * private_data so it can be used by the
> 
> -- 
> 2.34.1
> 

Given this should not break any code, as there should be no legit drivers
requesting a minor >= 255,

Acked-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
