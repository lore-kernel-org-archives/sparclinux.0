Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891933AC00;
	Mon,  2 Mar 2026 23:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772492874; cv=none; b=k/HSeXhdUxjcxwspRyGJrR5NU6hTm/XMKIKB6sxq4yhGf3+dV6/H2THdeZOIGe6ZT1Xo68bQL3JMLhf3B1W/AqIM2yYd4WEbjhtP8KxthjkisDYKPEbHJ9h8ecn+JumCV+Xxvjy3AWaBZz6KEr0MvHpnWbK2WL/kWfo4EI6uIkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772492874; c=relaxed/simple;
	bh=nzWc5hLi+XmBuDD+BGsrmDcYrcD7xRFj1OgmUPYza+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=u0bdE3OL6SrLAqEV6sWvLOHxV7vexNoClE1VANeOk1Tq+xIFLKs6UPRu2GuzlGNL5+1v4rKYObb2sASoPc7fpfkprEY1jzyleDZ+H8GFHFMZjHvsxKVGdDG+oGt4zYKaerCHSC2k8/oAaFVYVQteEV/s4tZTaWVaKQNXTL8iCOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojWXYkOY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojWXYkOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D773C19423;
	Mon,  2 Mar 2026 23:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772492874;
	bh=nzWc5hLi+XmBuDD+BGsrmDcYrcD7xRFj1OgmUPYza+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ojWXYkOYIKhn66nudcCk8Y/GU6W3TuYnBtpvFJsKP2MnMtUbhRvAyX1WWGXRHTlkg
	 dj0a58+jJyhag958yoJSG5aBih25/HAQPYB/SWsBk7+1gBf4tNcMwW2IF/f0WKZVrH
	 FmsmboQmUEc+jI5i3NKgdLX84p5QHExSeRJMGYU+7j/vjoATBqnJUAqekrzVElXPL5
	 TfKX6Kc2DTA72Qs3MkYquLMNDmXvsndf0lmdAuV9mI36OQi8nOGT/zhzwskVfQPCCV
	 xMRliO/w+Ea1EfUpIflOIigUDCXaBQRapBeDWEv7f2hCpVmP5cp9vQzuiBQsi3HHWE
	 N3scqRm5dCqDg==
Date: Mon, 2 Mar 2026 17:07:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	sparclinux@vger.kernel.org, wangruikang@iscas.ac.cn,
	tglx@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, chleroy@kernel.org, gjoyce@ibm.com,
	davem@davemloft.net, andreas@gaisler.com,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Han Gao <gaohan@iscas.ac.cn>,
	Nathaniel Roach <nroach44@nroach44.id.au>,
	Venkat <venkat88@linux.ibm.com>, Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCHv2 0/2] pci: fix msi_addr_mask on powerpc and sparc systems
Message-ID: <20260302230753.GA4034944@bhelgaas>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220070239.1693303-1-nilay@linux.ibm.com>

On Fri, Feb 20, 2026 at 12:32:26PM +0530, Nilay Shroff wrote:
> Hi,
> 
> Recent changes [1] which replaced pci_dev::no_64bit_msi with pci_dev::
> msi_addr_mask inadvertently missed to initialize the pci_dev::msi_addr_mask
> to the DMA_BIT_MASK(64) on powerpc platform. Due to this, later the 
> validation the programmed MSI address against the msi_addr_mask fails.
> This causes pci device probe method failures on powerpc platform. We also
> realized that similar issue could potentially happen on sparc system as
> well. So this series initializes pci_dev::msi_addr_mask to DMA_BIT_MASK(64)
> when pci_dev is instantiated for both powerpc and sparc platforms.
> 
> The first patch in the series fixes this on powerpc platform. The second
> patch fixes this issue on sparc platform. Please note that as I don't have
> access to the sparc platform, this patch was only compile tested on the
> sparc system. Anyone from the community is welcome to test it who has
> access to the sparc machine.
> 
> [1] https://lore.kernel.org/all/20260129-pci-msi-addr-mask-v4-0-70da998f2750@iscas.ac.cn/
> 
> Changes since v1:
>   - Initialize the pci_dev:msi_addr_mask on sparc platform (Vivian Wang)
>   - Some minor cosmetic fixes (Bjorn Helgaas)
> 
> Nilay Shroff (2):
>   powerpc/pci: Initialize msi_addr_mask for OF-created PCI devices
>   sparc/pci: Initialize msi_addr_mask for OF-created PCI devices
> 
>  arch/powerpc/kernel/pci_of_scan.c | 7 +++++++
>  arch/sparc/kernel/pci.c           | 7 +++++++
>  2 files changed, 14 insertions(+)

I applied both of these to pci/for-linus for v7.0 since they fix
regressions.

Thanks to Han and Nathaniel for testing on sparc and Venkat and Nam
for testing on powerpc.

Let me know if you have issues with these or prefer to merge via
another tree; I'll be happy to drop.

Bjorn
