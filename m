Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF36563FCB;
	Wed, 14 Oct 2026 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998019; cv=none; b=TmR46xWc8hIJ4IvEGpk6as6AVWJeYOYg8cLJu8VpWsiY6Etwq55Di9brtxN1VNpPFgqVivu6gXaX2OGBDv/yeJZ59cyHa+Dk6pFUtsmyvcQfeR/3xXLZnHxEsXmhpdaEogDwa6wsjDnCONL1EVeYc9EP6d417+YYuK6uD9+NTSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998019; c=relaxed/simple;
	bh=7+/A0LoacZHohjvN4wXEm3+Dk2UyCqNWrHEmAESILnU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FV/2GlRM7sZYcHnC3KZNhkcVFOBC45+2c/QKFvEpA/SiAqMMdEhhdeFIr8L+ifQC2u+qexWNqXRqp4R+Q2ImsIhp3NljRrPMUcPp3DZLFTejZuVRR7er9fdgKOIqsgo3rtwYweU4XELQXpO0gtO3eWOW+E5TCOOwK1SEHQCHXoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3551b1+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3551b1+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0391F000C4;
	Wed, 14 Oct 2026 17:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791998011;
	bh=TIXKZ1EmqWU/VUc5XZWDJM5gBsBtYEI+Xauv3IN18ZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=X3551b1+kerHLKkgoLyynluZRnT89nmMlG9rlmLWW8V9C4QCUneI15E6Pz3rcKqf9
	 mHnyjzbkFavDjWlFHf3RQCcLasCJq9HAfrPjw3hWkHHxXB/PP60RQaugTlwBPfl59b
	 pouU/CIq0JT/xXxfgqJ8zi10vGqVshJB/NPqD4ah7IwicwPdAhINXhJbu3uBmxBBWH
	 0eoTAFzK4Rtfqjsqm1ipr19biNYZmoLMgRC76IWxb4YPVFWDAFGMFWxDgGABfGSWKF
	 jUMX9Z2ufQqTXjt7hhXt2o9rt+9NtBSFpf0Cr2/CbUP18y1wdK41b5qjpg8KBgtQSP
	 ipexh62I4hXbQ==
Date: Wed, 14 Oct 2026 12:13:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stian Halseth <stian@itx.no>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Andreas Larsson <andreas@gaisler.com>, linux-pci@vger.kernel.org,
	sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Tony Rodriguez <unixpro1970@gmail.com>
Subject: Re: [PATCH] PCI: Set supported_speeds in set_pcie_port_type()
Message-ID: <20261014171330.GA1640628@bhelgaas>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007131304.309511-1-stian@itx.no>

[+cc Tony]

On Wed, Oct 07, 2026 at 03:13:04PM +0200, Stian Halseth wrote:
> sparc64 and powerpc create PCI devices from the device tree in
> of_create_pci_dev(), which calls set_pcie_port_type() but not
> pci_setup_device(). Since d2bd39c0456b, supported_speeds is only set in
> pci_setup_device(), so it stays 0 for these devices.
> pcie_get_speed_cap() then returns PCI_SPEED_UNKNOWN, max_link_speed
> reads "Unknown", and the failed link retraining quirk passes
> PCI_SPEED_UNKNOWN to pcie_set_target_speed(), which warns on a SPARC
> T7-1:
> 
>   WARNING: drivers/pci/pcie/bwctrl.c:125 at pcie_set_target_speed+0x284/0x2e0
> 
> Set supported_speeds in set_pcie_port_type(), which all three paths
> call.
> 
> Fixes: d2bd39c0456b ("PCI: Store all PCIe Supported Link Speeds")
> Closes: https://github.com/sparclinux/issues/issues/109
> Signed-off-by: Stian Halseth <stian@itx.no>

Applied with Tony's Tested-by to pci/enumeration for v7.4, thanks!

I added a stable tag since d2bd39c0456b appeared in v6.13.

> ---
> Tested on a SPARC T7-1: before, max_link_speed reads "Unknown" and the
> warning above appears with CONFIG_PCIEPORTBUS; after, all 23 PCIe
> devices report their real speed and the quirk lifts the 2.5GT/s
> restriction without a warning. Not tested on powerpc.
> 
>  drivers/pci/probe.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..52a79b033b069 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1651,6 +1651,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  		pdev->aspm_l1_support = 1;
>  #endif
>  
> +	pdev->supported_speeds = pcie_get_supported_speeds(pdev);
> +
>  	parent = pci_upstream_bridge(pdev);
>  	if (!parent)
>  		return;
> @@ -2074,9 +2076,6 @@ int pci_setup_device(struct pci_dev *dev)
>  
>  	set_pcie_untrusted(dev);
>  
> -	if (pci_is_pcie(dev))
> -		dev->supported_speeds = pcie_get_supported_speeds(dev);
> -
>  	/* "Unknown power state" */
>  	dev->current_state = PCI_UNKNOWN;
>  
> -- 
> 2.43.0
> 
