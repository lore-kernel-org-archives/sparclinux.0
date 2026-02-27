Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C552329E53;
	Fri, 27 Feb 2026 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210669; cv=none; b=RjBwooinlQneQZ0fq4sKeXYvjwLvscWZBwOHXUBrFKp3Z5QrUVx1ErkGGZcXQf1YMQzPPtd/u2GM59zxJIIBX1J9AWO5QaVrWSmN7veKaP5foR/b0iUIVQ0nMixnagOefzNJgh3bqyPJXU+Nd/FRYaNId/pVlWfSFn14ZqUwEbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210669; c=relaxed/simple;
	bh=xEv7MiSgAutCAQPuAB/UPxkGdAyG7iqnARAOD3aXtMs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pImUrCGxZ1oA6exusOVV7ATN70hkjlCH/et11oQil0EzpDF1linC92kbWJarMEoFHPmivSC7ESPCqFOLO6zztBiaE8B/MOixHGLN2n9f4z67awv+XHf2fCg2Lxc9APYE23h13xqIxY6g35PMepYu+mO8vdaJO/Y4bssb3mnTIJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfcyS/nf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfcyS/nf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB08C19423;
	Fri, 27 Feb 2026 16:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772210668;
	bh=xEv7MiSgAutCAQPuAB/UPxkGdAyG7iqnARAOD3aXtMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MfcyS/nfYFdd+s763JqDqyw62GRaDDVUV08SyoeW4+f5+86NgmRNeY6xlMPGdWiFq
	 bvsCQpZPtByl0kHoYl6T7DLHLWe0xt8FlS9u7Opa+88SesnH2oaG5ijH3okdeQA+uV
	 IK5qojL4FjuodmKaxkK1i868FP7fQxe9lt+GPe1T/U7CBT0gmgFoHX9rNU9WU+DEdd
	 +LcTflBkLQs1X6PRb7V4bWZlgWiTXASdfIdXxZ1hznJ00xY70wF9bkNQSmXlcwnjTj
	 TSkIGZga0zBn99S4AAusw9Uhmw2iLjZIl9wVaJ7iQwCkDREckw1vlj5wcD2kpOLMlm
	 AUhCNpVQ6RIaw==
Date: Fri, 27 Feb 2026 10:44:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	sparclinux@vger.kernel.org, wangruikang@iscas.ac.cn,
	tglx@kernel.org, npiggin@gmail.com, chleroy@kernel.org,
	gjoyce@ibm.com
Subject: Re: [PATCHv2 0/2] pci: fix msi_addr_mask on powerpc and sparc systems
Message-ID: <20260227164427.GA3897611@bhelgaas>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220070239.1693303-1-nilay@linux.ibm.com>

[cc->to powerpc, sparc maintainers for ack]

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

These fix regressions on powerpc and sparc caused by 386ced19e9a3
("PCI/MSI: Convert the boolean no_64bit_msi flag to a DMA address
mask").

These fixes have been tested by Han Gao (SPARC Enterprise T5220),
Nathaniel Roach (SPARC T5-2), and Venkat Rao Bagalkote (IBM Power
System LPAR (pseries)).

It'd be great to have acks from the powerpc and sparc folks so they
could be merged either by Thomas (who merged 386ced19e9a3) or me (via
PCI tree).

Bjorn
