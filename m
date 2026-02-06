Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F4D86353;
	Fri,  6 Feb 2026 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770374717; cv=none; b=FQaOBFL8AYNCFYyOiMU6bMp8Pff7buDu6aNg6B04wXXmfh5vsz8g88Mrgweci0P7F/+fR3sDV/eMvsIOvvHnLbbP1jax+Mlz4AB7aXslJ6wcUy/NMjTRh2WWS2bpMC2K1dona7ryw2LGhKd1jcOxF2yOQDRNmYQ3t4YpCC0mbIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770374717; c=relaxed/simple;
	bh=g36gGgJ987iw+9/ldLasHbPw+mEBGkb487CgA9aE00s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UK+/mQjVXpwKRDRHlyMUWc9F3DBPW6YsHcBfHD6V93/e9sEXOH7nCG5XT86v120JmfPjAjr17ZG5yBxevIlZ0zL1g6VsCkrLiFqqpQrymo4UPPCyUxN4+avD/yKQhSadtLnVPzsrXMsSz1s/kIk5A7mY26HAcjmSPpkPxj54Y7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=bP1Wad4T reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="bP1Wad4T"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f6rCd4DHPz1DQrn;
	Fri,  6 Feb 2026 11:38:21 +0100 (CET)
Received: from [10.10.15.18] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4f6rCd23Wqz1DR2b;
	Fri,  6 Feb 2026 11:38:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1770374301;
	bh=VhZbm9gQWN7xq1Fz5NZq8VZ90NrJOYkZWPqsJ/s5DMg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bP1Wad4TZNICU2FOrN8BiolPoBrf6qGYiQcaAJ0BQZS1BtVFR/unXCgk6w34ROPUP
	 UbwaSFJybmrWIGjLC+ACCJyEDIfIcEvA7dXp8fkIj96L7B3QXcOKH+yKwTn50BPSp3
	 r7/Gg8TUA1P5AtcgMilU9pBEfa1ntaUNZa15QZy+7R2adnDisX9kUNYRweL5bDpJWt
	 7Uu5ZypN6Io1tFoXwf22kVYztJVUBQnJ2iKxUuqBtufHXnUve7jhtCoS8HjXOzmgbn
	 nJw+Af2ctaTGubouAfPDXH2zf9O+Rt2bAeLwbpxcFXQjHMalzkWAI6KeYZ7SL9SESx
	 ZSdkAbonIttrg==
Message-ID: <ba8111d4-d695-4ac2-9ccd-5722e6aacd7f@gaisler.com>
Date: Fri, 6 Feb 2026 11:38:20 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc: vio: Replace snprintf with strscpy in
 vio_create_one
To: Thorsten Blum <thorsten.blum@linux.dev>,
 "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260131224413.559324-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260131224413.559324-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-01-31 23:44, Thorsten Blum wrote:
> Replace snprintf("%s", ...) with the faster and more direct strscpy().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/sparc/kernel/vio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
> index 1a1a9d6b8f2e..8c7dd72ef334 100644
> --- a/arch/sparc/kernel/vio.c
> +++ b/arch/sparc/kernel/vio.c
> @@ -12,6 +12,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> +#include <linux/string.h>
>  #include <linux/irq.h>
>  #include <linux/export.h>
>  #include <linux/init.h>
> @@ -378,8 +379,7 @@ static struct vio_dev *vio_create_one(struct mdesc_handle *hp, u64 mp,
>  	 * the parent doesn't require the MD node info.
>  	 */
>  	if (node_name != NULL) {
> -		(void) snprintf(vdev->node_name, VIO_MAX_NAME_LEN, "%s",
> -				node_name);
> +		strscpy(vdev->node_name, node_name);
>  
>  		err = mdesc_get_node_info(hp, mp, node_name,
>  					  &vdev->md_node_info);

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

