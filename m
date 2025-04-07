Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43A3219306;
	Mon,  7 Apr 2025 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055426; cv=none; b=GPjh1Pk9VjAOGDId99yHi02ulXFax37zX6DS6sAkMJmDI8w71pm9D2IZROZ9S9Jtl4bkWjnqxwb+yo5rlzkgTz3Xof5gKVINbKAPWIENZT7ilaxVqiU6bJxytnw+xD5MXqdufYCwHzykAJ7JYhPmwfd4Hjf6+Ojn3pJ6FLzTL5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055426; c=relaxed/simple;
	bh=9jrbRtN+zrxPHA1QfQVu0OEc14LJJvK82peW+CJpq7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PRYfWXrvoE6u/+1mTWG2uXVFOKP+nfdjVocECKuuopcUaEctR2g5VNzsrBd+piz3xBisIGzI3X45bKvcc7V6394qZlV//ZrE5N9c9slvgopOan50dzLeytGBtPtoUlBL/OXEMCNy2/Mv4ArVFSTx0Q1Y5QZ0XTxLW0qfb/odg60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=EVH2gCKC; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="EVH2gCKC"
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 1sT0uwjplbbeQ1sT3uSxf9; Mon, 07 Apr 2025 21:49:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1744055354;
	bh=gxsDMgpqSArQXJDXFZiVdjvJKyf3EBPu3MAt6VIqpVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=EVH2gCKCPmH+GFNkr0570pMHkFmP+Al6ZVLv/1OqjkDrfWBo+VHKDdauCoVHMiEpM
	 X+mQ2Ov51Hz3TOLUOGvZzLkGL+ImCV3U0MOqN3ENvzI3afhI4APFH6xyhPvd439UEq
	 GV3b0gxUQIikV3DwMyeV3tHdGhtVAVlZoDi6mzp+Yyv3/FxAcNmrljSxDuNXPxVyrz
	 D14SGNTrign0BcB0t3CZ+dwwmtMpPQSskecW9ha1g8MSfp8u6Sxrv3oNd2K5U3JQoS
	 5JBQAFln3TD901ywT1zFt6R2Agw4nRxh+U+wwcRsy3WpjCbfLdW9G7r9IIoUmcYShs
	 XgC8BAS9Oxtvg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 07 Apr 2025 21:49:14 +0200
X-ME-IP: 90.11.132.44
Message-ID: <e2a4e693-46db-4b1f-87c2-2867a4cb196d@wanadoo.fr>
Date: Mon, 7 Apr 2025 21:49:08 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc: pci: Fix memory leak in pci_bus_slot_names()
To: Salah Triki <salah.triki@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Z_Ox0qp7uuKNUo2U@pc>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <Z_Ox0qp7uuKNUo2U@pc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 07/04/2025 à 13:06, Salah Triki a écrit :
> prop is a local pointer in pci_bus_slot_names(). It is initialized
> by calling of_get_property() so the caller must free prop when done
> using it.

Hi,

can you elaborate why?

It does not look needed to me, and the places using of_get_property() 
that I've checked don't have such a kfree().

CJ

> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>   arch/sparc/kernel/pci.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
> index ddac216a2aff..fa0da8f45723 100644
> --- a/arch/sparc/kernel/pci.c
> +++ b/arch/sparc/kernel/pci.c
> @@ -971,6 +971,8 @@ static void pci_bus_slot_names(struct device_node *node, struct pci_bus *bus)
>   		mask &= ~this_bit;
>   		i++;
>   	}
> +
> +	kfree(prop);
>   }
>   
>   static int __init of_pci_slot_init(void)

