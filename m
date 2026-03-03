Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA3437CD20;
	Tue,  3 Mar 2026 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555454; cv=none; b=VoTzCyay+/8T7WjX7XNnOD+Zq/eqMncZnz7M22iR9chqex5bLgfSnfNaeLkOP3sYChA5XVVg24zvlzWO7URTyCYDeLFIz9/vCF0JkVLlgwWLguyoEp2jPvJnsvsNslsdrh7CKrwasQXEXJ5gv+rG8iAk73RagbVTQj3I+ZrQuxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555454; c=relaxed/simple;
	bh=D2pPg2evVcS3OwEffdyZzwyhu5mGQ3DavyPjm4j33e8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LPMeBRoYqCHvXd5OYrJZxPAc9kWAbJYK+uEifmo4ciaiXFZMmBvr7XlQOTCmVrxAA7mRWrPCIQbtlYVxlInQ/K/eIIR4rr0hMljNiAJab+UVkH86hrfDziskU/GM2ZdRgUZLipNurleqh+vMO5djIOz2uQNI4tJ2QN0dKudYMQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5KbtB6A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5KbtB6A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734E8C116C6;
	Tue,  3 Mar 2026 16:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772555453;
	bh=D2pPg2evVcS3OwEffdyZzwyhu5mGQ3DavyPjm4j33e8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=W5KbtB6A0G2m/2ihT3XDZLZ1J31O6g7kq8xkLz7SMDzdBFPEaAXJKPILxy/5pZFxo
	 VD3ug1zEfyyGRMgzj5yYbUGUZKzDhz1SKIs9+iJ2+oxjTxfCYw+mr5Ol63WP8jwjbY
	 hOosGeo+emjWgCMGDrbFRWEmayrPXfx/NYajhHtgl1eSf02IYfo98sa5MP5S8vw3Q+
	 xRud5IB6QOoqtIOWN2WIT7Bp8uGvpOkxMBuN5JiBEAPQLN/8XocgX22s/sGb2+grKN
	 cHD08FRGQM0Vxkia4iLgppWy+vide3XkHT6UuM+9JIha9+PvKW9BgBN/7aNUr9wbPF
	 bCbzflpQ0R+Bw==
Date: Tue, 3 Mar 2026 10:30:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	sparclinux@vger.kernel.org, wangruikang@iscas.ac.cn,
	tglx@kernel.org, npiggin@gmail.com, chleroy@kernel.org,
	gjoyce@ibm.com
Subject: Re: [PATCHv2 0/2] pci: fix msi_addr_mask on powerpc and sparc systems
Message-ID: <20260303163051.GA4059101@bhelgaas>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8440351-7394-4444-9891-b9af1982bd06@linux.ibm.com>

On Tue, Mar 03, 2026 at 09:59:15AM +0530, Madhavan Srinivasan wrote:
> On 2/27/26 10:14 PM, Bjorn Helgaas wrote:
> > On Fri, Feb 20, 2026 at 12:32:26PM +0530, Nilay Shroff wrote:
> > > Hi,
> > > 
> > > Recent changes [1] which replaced pci_dev::no_64bit_msi with pci_dev::
> > > msi_addr_mask inadvertently missed to initialize the pci_dev::msi_addr_mask
> > > to the DMA_BIT_MASK(64) on powerpc platform. Due to this, later the
> > > validation the programmed MSI address against the msi_addr_mask fails.
> > > This causes pci device probe method failures on powerpc platform. We also
> > > realized that similar issue could potentially happen on sparc system as
> > > well. So this series initializes pci_dev::msi_addr_mask to DMA_BIT_MASK(64)
> > > when pci_dev is instantiated for both powerpc and sparc platforms.
> > > 
> > > The first patch in the series fixes this on powerpc platform. The second
> > > patch fixes this issue on sparc platform. Please note that as I don't have
> > > access to the sparc platform, this patch was only compile tested on the
> > > sparc system. Anyone from the community is welcome to test it who has
> > > access to the sparc machine.
> > > 
> > > [1] https://lore.kernel.org/all/20260129-pci-msi-addr-mask-v4-0-70da998f2750@iscas.ac.cn/
> > > 
> > > Changes since v1:
> > >    - Initialize the pci_dev:msi_addr_mask on sparc platform (Vivian Wang)
> > >    - Some minor cosmetic fixes (Bjorn Helgaas)
> > > 
> > > Nilay Shroff (2):
> > >    powerpc/pci: Initialize msi_addr_mask for OF-created PCI devices
> > >    sparc/pci: Initialize msi_addr_mask for OF-created PCI devices
> > > 
> > >   arch/powerpc/kernel/pci_of_scan.c | 7 +++++++
> > >   arch/sparc/kernel/pci.c           | 7 +++++++
> > >   2 files changed, 14 insertions(+)
> > These fix regressions on powerpc and sparc caused by 386ced19e9a3
> > ("PCI/MSI: Convert the boolean no_64bit_msi flag to a DMA address
> > mask").
> > 
> > These fixes have been tested by Han Gao (SPARC Enterprise T5220),
> > Nathaniel Roach (SPARC T5-2), and Venkat Rao Bagalkote (IBM Power
> > System LPAR (pseries)).
> > 
> > It'd be great to have acks from the powerpc and sparc folks so they
>
> Sorry for the delayed response, yes we tested this from our end.
> Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>

Added your ack to the powerpc patch, thank you very much!
