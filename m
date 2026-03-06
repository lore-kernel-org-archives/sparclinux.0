Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A4E27F4F5;
	Fri,  6 Mar 2026 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772832220; cv=none; b=ZFu1RLgKixCNXN09AoyXEL60OMwtHTLBmTvvaZgJrRtocqJ+JSKgQwfOqfb2cU6FcW/1fOUieP77Q5n73b6vRVNr4oQrR13U8LQcbItlOz0YnjG9tZ5PE4iRJg6sf8V0Bd2fmcMlKS/UJ7QdElueZCAw5fS7GnCmHTVaJFnCuZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772832220; c=relaxed/simple;
	bh=OuYfbVudPcdD1WrPShIxTEXnVYwKm2phYB5eMZ+H0o8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pWIgQoBp58brt2HE84CQMCGwAVie+Z/y7jF3yy96cEg4wpGNq/O8s3y7dGGu2fnwNaflhSfZYlfTBBejZkhVcur09ds5RtQTKz5E5DFg9Em+OfFx6cZqKpNRZAfOksRRlXyqBV+BPIT9IMY3UC+SdKO+TSeS0RjbLPIRazNx/yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I94WaO42; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I94WaO42"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BA0C4CEF7;
	Fri,  6 Mar 2026 21:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772832220;
	bh=OuYfbVudPcdD1WrPShIxTEXnVYwKm2phYB5eMZ+H0o8=;
	h=Date:From:To:Cc:Subject:From;
	b=I94WaO42tFN+vaFenM3V1l4H6JjVtNcYaspg8KQ9SDlT4s0gUbjrv14TRisqPbzu5
	 nzb9SZ0vjqydlXxZCVCu4IbrSTFB8sxmL8AkKrQiSMZ8FyuXqY10BK0psZpEYdKt8X
	 QBzWuEjG06BqdWVmxVWHLlsRmIX33eaWV3lZMwqabkLt/ALDRxUdDDoVHZMvt3Rc3/
	 j3rUHAB2rG/gjqm3gvLdrHZfLF5RhZIH8EfeObRLMpQ6Eci39nYQLXF80TatHWbXgb
	 svMR6SFT2W8oBFSq9JGRWZ2hPAuRm/03ZKtONHm1BzN9yx/y4vHsZy0r69CZJYpXkT
	 ock2FYdrQ3LxA==
Date: Fri, 6 Mar 2026 15:23:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nam Cao <namcao@linutronix.de>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Han Gao <gaohan@iscas.ac.cn>,
	Nathaniel Roach <nroach44@nroach44.id.au>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Joyce Ooi <joyce.ooi@intel.com>
Subject: [GIT PULL] PCI fixes for v7.0
Message-ID: <20260306212338.GA241358@bhelgaas>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.0-fixes-3

for you to fetch changes up to 9f2c7349b2810c671badfc1adc804f711a83e420:

  MAINTAINERS: Orphan Altera PCIe controller driver (2026-03-05 11:34:21 -0600)

----------------------------------------------------------------

- Initialize msi_addr_mask for OF-created PCI devices to fix sparc and
  powerpc probe regressions (Nilay Shroff)

- Orphan the Altera PCIe controller driver (Dave Hansen)

----------------------------------------------------------------
Dave Hansen (1):
      MAINTAINERS: Orphan Altera PCIe controller driver

Nilay Shroff (2):
      powerpc/pci: Initialize msi_addr_mask for OF-created PCI devices
      sparc/PCI: Initialize msi_addr_mask for OF-created PCI devices

 MAINTAINERS                       | 6 ++----
 arch/powerpc/kernel/pci_of_scan.c | 7 +++++++
 arch/sparc/kernel/pci.c           | 7 +++++++
 3 files changed, 16 insertions(+), 4 deletions(-)
