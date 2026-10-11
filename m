Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAA823BD02
	for <sparclinux@vger.kernel.org>; Sun, 11 Oct 2026 05:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791697497; cv=none; b=glQNO+oAZ4fmLy+eyztRbZO8XlLVUkoMYMQ831OUuceYFscveW6ELc3TNKcH8aKev9dVFJwDfByynNVuCpIX5zsJG0oLEJdlTu94u9o1GyEj6A23k/9rUqzr5mCEM1D72c1epzpkmf4FDEPVJ8UWrHTVujLyQ+/ZIF7sb+nbI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791697497; c=relaxed/simple;
	bh=dCUDHhz4dgapugA1Auq2FlHXDI5hd/sAmskaSQc9Qa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnnfE1/A1Eeh52+GT6sl18NGEbbx0qVww3T29TCthiI/7f4fHu9g3Hi+syU4c9nq0beRvcLFQrpUMomiycwgvnTMBIAPc/oPdIrBB50Zu/yePTJQ5oI5a2IU8EhfY6c90efzNv1uiCDGSq9kBVKawCo+S/wrYSBl1S37HcPhUeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2aY7iBn; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2aY7iBn"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso3222234eec.0
        for <sparclinux@vger.kernel.org>; Sat, 10 Oct 2026 22:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791697495; x=1792302295; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T8diuNZ+zrgNOaX3UMVCcddQtmK2jbIBOVFz+8CGVq0=;
        b=Q2aY7iBnleak2MnUOPpERazeABiRxrc4dX22Uzqxqvv8Yxpc5pWO9kQwa1n/p5e25N
         dvRL6tn7Tu790AWjicHeA8yOU1yKb3YZPQzCifzMp91wRLndXmCag296fiFR53XZ+bLV
         Y9wTshu3Kw4qZzKJQTUDmCJncdqOjvjBvL/iFLTHkhUsik/IkFbsFbMNtn3oYLT/ECCP
         PNeoRu2e+ckktGlV49GLfEhr4Na6pOL9LwB3+zYzTlZmo4rI/r0r8kor9jQMy6Ir5ur3
         brqyFpad0ACTpk0mTDEX8RZWeFnye66FyHRBC0BLCCg7fdCN6HTIoKf/dD4UgY8tUuEQ
         dwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791697495; x=1792302295;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T8diuNZ+zrgNOaX3UMVCcddQtmK2jbIBOVFz+8CGVq0=;
        b=v/i6sDe/KDD6Mjk6/KpWSrJNCpPiaIVnXbDCyf40y1vSoaIn3hH8CkbCZbBJXzhyqB
         c7aJNYEeRMSI0OnhoTnmMgt66FgumO3zqn53Le+UxYkVkOkoGjZduKmpbTPato4U/qQN
         FDRafznoZrHzz6Q/otSQfH5k9DmfXDUMA1CCUsk5Zkkrfnu/ie9rhdmu0LdEoyjVEMQr
         PJQLaZ+/H2ht4a6HGIIdLAjTOGNlHLrfRmxVtonZ4+CxU4IvdbHzC9TWT/ikpsgtmMrE
         SaRwZUG7++n2TZzWEFm5k4KYUSHgVFYj1riMbc8AvZqABnzelanr1IafyjmkDyMN7EsT
         C+Hw==
X-Forwarded-Encrypted: i=1; AKwUvBwiJQ2S+rzhTac6oBpgUMwq6WYOHC9p9FMs/d1w1jCamWY5bsQCeyJ+8CsnEMVTw6mHkWkqRypFaSHk@vger.kernel.org
X-Gm-Message-State: AFq9FYIz44YyCMauq97qjDfCpW/B0PTrR+QXKTIwTnm9irMirh8AYt/G
	ndVB70iOqof7Zu9dSYYe+oHHOtuTStbujVnm/0LikZv6qB+15jAURrnFJmYIrQ==
X-Gm-Gg: AYBFou3hX5zsCCtp5FkNtRLFrXQ+UbL1cblP+65myOmJskfB1STvFHEaF6pVy7ZcnK9
	vPZ+1hUi6l9l/P+DpPJLLRrntr0RcWOXrW/Oix1LPpqA/CtuUU4bURz+PHCA/aUAVTYFLOow3/u
	YWGTNPKquS3YMKuUrCtRzhcAvFII0KfgO3H4A1E99FzqBwrEgD9Y/GI2D+dqwZSzCZoFJ4KLUD+
	yU71IV/1Gsv16AWfjxv0pBmFUqKHQXbkfuTvJRhcRIkektzNHP5oElhZGmoxYwD3uKoXyTL/L9U
	kObwduntPmzI3PSasO165H+FHr8cUFquAKK6qFfamuTUx2WZeE1emN3pxYEntFWBnSxPZ4RpE2y
	2ujDVpEB2Yg9oRxGWzmVT3+Dj8l9/cwl+p1BTT3lNupGX/1ybY0oeqjRUqb601thRmlsm5lGJtk
	7lhcxvbI6KLxgv/In6xYNGxkUCciy3BPhsvA82EbuWToYlRLWayOXA3xU5ZNVGlQjk2yMA6EbiB
	KXSkHPP1lDdn/yee7bO/wTQ4usaJvOYI2L1vJRwvxNAgg==
X-Received: by 2002:a05:693c:8811:20b0:356:7ddb:2e54 with SMTP id 5a478bee46e88-3567ddb2f02mr6808511eec.29.1791697494583;
        Sat, 10 Oct 2026 22:44:54 -0700 (PDT)
Received: from [192.168.21.192] ([24.18.106.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm23485573eec.3.2026.10.10.22.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2026 22:44:54 -0700 (PDT)
Message-ID: <17a20959-44ed-43e5-8414-201120468f2f@gmail.com>
Date: Sat, 10 Oct 2026 22:44:52 -0700
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] PCI: Set supported_speeds in set_pcie_port_type()
To: Stian Halseth <stian@itx.no>, Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andreas Larsson <andreas@gaisler.com>, linux-pci@vger.kernel.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20261007131304.309511-1-stian@itx.no>
Content-Language: en-US
From: Tony Rodriguez <unixpro1970@gmail.com>
In-Reply-To: <20261007131304.309511-1-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

This patch also works on the Sparc S7-2, the correct x8 link is shown 
instead of unknown.

# dmesg | grep -iE x8 | grep -iE link
[    8.421411] mlx5_core 0001:03:00.0: 63.008 Gb/s available PCIe 
bandwidth (8.0 GT/s PCIe x8 link)
[    9.472465] mlx5_core 0001:03:00.1: 63.008 Gb/s available PCIe 
bandwidth (8.0 GT/s PCIe x8 link)
[   14.734746] mlx4_core 0001:04:00.0: 63.008 Gb/s available PCIe 
bandwidth (8.0 GT/s PCIe x8 link)

Tested-by: Tony Rodriguez <unixpro1970@gmail.com>

On 10/7/26 6:13 AM, Stian Halseth wrote:
> sparc64 and powerpc create PCI devices from the device tree in
> of_create_pci_dev(), which calls set_pcie_port_type() but not
> pci_setup_device(). Since d2bd39c0456b, supported_speeds is only set in
> pci_setup_device(), so it stays 0 for these devices.
> pcie_get_speed_cap() then returns PCI_SPEED_UNKNOWN, max_link_speed
> reads "Unknown", and the failed link retraining quirk passes
> PCI_SPEED_UNKNOWN to pcie_set_target_speed(), which warns on a SPARC
> T7-1:
>
>    WARNING: drivers/pci/pcie/bwctrl.c:125 at pcie_set_target_speed+0x284/0x2e0
>
> Set supported_speeds in set_pcie_port_type(), which all three paths
> call.
>
> Fixes: d2bd39c0456b ("PCI: Store all PCIe Supported Link Speeds")
> Closes: https://github.com/sparclinux/issues/issues/109
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
> Tested on a SPARC T7-1: before, max_link_speed reads "Unknown" and the
> warning above appears with CONFIG_PCIEPORTBUS; after, all 23 PCIe
> devices report their real speed and the quirk lifts the 2.5GT/s
> restriction without a warning. Not tested on powerpc.
>
>   drivers/pci/probe.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..52a79b033b069 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1651,6 +1651,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
>   		pdev->aspm_l1_support = 1;
>   #endif
>   
> +	pdev->supported_speeds = pcie_get_supported_speeds(pdev);
> +
>   	parent = pci_upstream_bridge(pdev);
>   	if (!parent)
>   		return;
> @@ -2074,9 +2076,6 @@ int pci_setup_device(struct pci_dev *dev)
>   
>   	set_pcie_untrusted(dev);
>   
> -	if (pci_is_pcie(dev))
> -		dev->supported_speeds = pcie_get_supported_speeds(dev);
> -
>   	/* "Unknown power state" */
>   	dev->current_state = PCI_UNKNOWN;
>   
