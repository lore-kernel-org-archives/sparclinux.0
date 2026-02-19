Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F32296BAF;
	Thu, 19 Feb 2026 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522311; cv=none; b=qIt/h4ME7mRIPXJBHaKmmEMR4YphRfP42G6xgFBGjp42W3zYCzevzWirxRf9yLbmLu70v0OX9XaZfwjomARrUY6JpM6xboPRJheEgIkfyuSItcE5Dw9sxFPm72J3wOfFHnwG2LyE/nP6YbqqeqZgSfqas8a74LoxLC6EiGn6sq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522311; c=relaxed/simple;
	bh=0dApmxehIq0f8g9XqkVrjuvILuR13XJVXhzmBt9EhFs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=axft+X8WaELV6d2lj+owYoA/tMqf5fR81kZC1WwZgR1+lAt4nrECYuSh93mH2b5vVHhAd6s+bdbjQvBlYJQfDPFTJ54xUgxXYbBRKhsTP9tZuKUjNUkUZZejlbvNreI3UCIDmrPwXabM46Uy6XLWL0YJv644dZaGVYRalsRiovI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EE1AbYSe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EE1AbYSe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC62C4CEF7;
	Thu, 19 Feb 2026 17:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771522311;
	bh=0dApmxehIq0f8g9XqkVrjuvILuR13XJVXhzmBt9EhFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EE1AbYSeKETi2ThDlSv0TnnumMJA/WnZ349B6kNnGdpgA9LW/9+vC7JayIZNWGJSZ
	 hEs+ayWmYXnxhqOQLanbr2uZHkKEDjAA9D6xvTp7fL0IePQVB2XeboRqLwoV82QKtw
	 ZLK5YLmh8GHnmmahCi+0QjAjEZmIk2meP4n3FFiP9rZFrhicOFDwFMY5feIqmkwiq8
	 idKz/foFLrSwzQtL8BkTL9L+4XBl59WRnJSr/iU5D9g3UiZGyX4QrJI2aS36gc0iOv
	 hVOUqM+A9TH5uJeDCATcOfemJe+0O08Cl8OQKJd5zu/yjepam7Xlc5ZNQWHbZ3aFhP
	 QJw4S7nCQjCrQ==
Date: Thu, 19 Feb 2026 11:31:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	wangruikang@iscas.ac.cn, tglx@kernel.org, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	gjoyce@ibm.com, "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org
Subject: Re: [PATCH] powerpc/pci: Initialize msi_addr_mask for OF-created PCI
 devices
Message-ID: <20260219173149.GA3486808@bhelgaas>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217174537.1154686-1-nilay@linux.ibm.com>

[+cc sparc folks, PCI enumeration via OF likely broken]

On Tue, Feb 17, 2026 at 11:15:26PM +0530, Nilay Shroff wrote:
> Recent changes [1] replaced the use of no_64bit_msi with msi_addr_mask.
> As a result, msi_addr_mask is now expected to be initialized to
> DMA_BIT_MASK(64) when a pci_dev is set up. However, this initialization
> was missed on powerpc due to differences in the device initialization
> path compared to other architectures. Due to this, now pci device probe
> method fails on powerpc system.

s/pci/PCI/ to match below.

> On powerpc systems, struct pci_dev instances are created from device
> tree nodes via of_create_pci_dev(). Because msi_addr_mask was not
> initialized there, it remained zero. Later, during MSI setup,
> msi_verify_entries() validates the programmed MSI address against
> pdev->msi_addr_mask. Since the mask was not set correctly, the
> validation fails, causing PCI driver probe failures for devices on
> powerpc systems.
> 
> Initialize pdev->msi_addr_mask to DMA_BIT_MASK(64) in
> of_create_pci_dev() so that MSI address validation succeeds and device
> probe works as expected.
> 
> [1] https://lore.kernel.org/all/20260129-pci-msi-addr-mask-v4-0-70da998f2750@iscas.ac.cn/
> 
> Fixes: 386ced19e9a3 ("PCI/MSI: Convert the boolean no_64bit_msi flag to a DMA address mask")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Looks like this and a similar sparc fix need to be in v7.0.  Would be
great if they could make v7.0-rc1 (Sunday), but that's pretty close.

Thomas, you merged 386ced19e9a3.  I'm happy to merge the powerpc and
sparc fixes, given acks from you and the powerpc & sparc folks, or
feel free to take them yourself.

> ---
>  arch/powerpc/kernel/pci_of_scan.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
> index 756043dd06e9..26ec97ce6b40 100644
> --- a/arch/powerpc/kernel/pci_of_scan.c
> +++ b/arch/powerpc/kernel/pci_of_scan.c
> @@ -211,6 +211,12 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
>  	dev->current_state = PCI_UNKNOWN;	/* unknown power state */
>  	dev->error_state = pci_channel_io_normal;
>  	dev->dma_mask = 0xffffffff;

It's typical to add a blank line between the code above and the
comment below, as was done in 386ced19e9a3.

> +	/*
> +	 * Assume 64-bit addresses for MSI initially. Will be changed to 32-bit
> +	 * if MSI (rather than MSI-X) capability does not have
> +	 * PCI_MSI_FLAGS_64BIT. Can also be overridden by driver.
> +	 */
> +	dev->msi_addr_mask = DMA_BIT_MASK(64);
>  
>  	/* Early fixups, before probing the BARs */
>  	pci_fixup_device(pci_fixup_early, dev);
> -- 
> 2.52.0
> 
