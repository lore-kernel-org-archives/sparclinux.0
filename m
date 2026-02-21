Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F01732571B;
	Sat, 21 Feb 2026 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771691822; cv=none; b=M8pEqGa8LapDotqz9izhRZi755Fnu69ytBNLvWxu5AtA5AHc9+koBUYGVm7C23p/cT7ropXUT2RyAmBFl+5A4GtIxzqegBIjzChQZuXjna9uGW1sDRDaPucAXElW7bYq4GdoxDnbl/9KwO7YzobtOpNQ1jrzJNIZHBtMthU/0r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771691822; c=relaxed/simple;
	bh=eE2b6J8MoKoJciV+vNZFu4wv1hIVgksS6b0uGzsvRYo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=t6ELXLwM9drLGRggQMX35BCsjCQO7FCEwzGaRvKjw2oLcbKlYEam5XCnF/oCjWa58jekI9xg/tMZLm1CG+fk3WWQhtHd+ycHvvSSQh8aQ4PpbCiZs/zkyDZpbAvQf8H0kRGxA8sNTegNZc5OMOJwJfcUIHsXlbrJLgF8nmbn4Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [58.38.117.196])
	by APP-03 (Coremail) with SMTP id rQCowABnTOMQ35lplLf9CA--.17993S2;
	Sun, 22 Feb 2026 00:36:33 +0800 (CST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCHv2 2/2] sparc/pci: Initialize msi_addr_mask for OF-created
 PCI devices
From: Han Gao <gaohan@iscas.ac.cn>
In-Reply-To: <20260220070239.1693303-3-nilay@linux.ibm.com>
Date: Sun, 22 Feb 2026 00:36:22 +0800
Cc: Han Gao <gaohan@iscas.ac.cn>,
 linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org,
 sparclinux@vger.kernel.org,
 wangruikang@iscas.ac.cn,
 tglx@kernel.org,
 maddy@linux.ibm.com,
 mpe@ellerman.id.au,
 npiggin@gmail.com,
 chleroy@kernel.org,
 gjoyce@ibm.com,
 helgaas@kernel.org,
 davem@davemloft.net,
 andreas@gaisler.com,
 "Han Gao (Revy)" <rabenda.cn@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <47EB6E53-3E20-4E95-A329-928E5BDDFB81@iscas.ac.cn>
References: <20260220070239.1693303-1-nilay@linux.ibm.com>
 <20260220070239.1693303-3-nilay@linux.ibm.com>
To: Nilay Shroff <nilay@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-CM-TRANSID:rQCowABnTOMQ35lplLf9CA--.17993S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1fXr18CFWkJr1UWFWDtwb_yoW8CF4Upr
	Z7CFn3trWUt347Ga9xAr1UZFyjgan8u3s3Wr98K34IqryI9r10vrnrWrWjkw4jqrsYka1F
	va9YvrWjqw1DWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_JwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUeq2_UUUUU=
X-CM-SenderInfo: xjdrxt3q6l2u1dvotugofq/1tbiBgwFDGmZySEWPgAAsz

Tested and passed on SPARC Enterprise T5220.=20

Without this patch, the e1000e would use intx.

Tested-by: Han Gao <gaohan@iscas.ac.cn <mailto:gaohan@iscas.ac.cn>> # on =
SPARC Enterprise T5220

> On Feb 20, 2026, at 15:02, Nilay Shroff <nilay@linux.ibm.com> wrote:
>=20
> Recent changes replaced the use of no_64bit_msi with msi_addr_mask,
> which is now expected to be initialized to DMA_BIT_MASK(64) during PCI
> device setup. On SPARC systems, this initialization was inadvertently
> missed for devices instantiated from device tree nodes, leaving
> msi_addr_mask unset for OF-created pci_dev instances. As a result,
> MSI address validation fails during probe, causing affected devices
> to fail initialization.
>=20
> Initialize pdev->msi_addr_mask to DMA_BIT_MASK(64) in
> of_create_pci_dev() so that MSI address validation succeeds and PCI
> device probing works as expected.
>=20
> Fixes: 386ced19e9a3 ("PCI/MSI: Convert the boolean no_64bit_msi flag =
to a DMA address mask")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
> arch/sparc/kernel/pci.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
> index b290107170e9..a4815d544781 100644
> --- a/arch/sparc/kernel/pci.c
> +++ b/arch/sparc/kernel/pci.c
> @@ -355,6 +355,13 @@ static struct pci_dev *of_create_pci_dev(struct =
pci_pbm_info *pbm,
> dev->error_state =3D pci_channel_io_normal;
> dev->dma_mask =3D 0xffffffff;
>=20
> + /*
> + * Assume 64-bit addresses for MSI initially. Will be changed to =
32-bit
> + * if MSI (rather than MSI-X) capability does not have
> + * PCI_MSI_FLAGS_64BIT. Can also be overridden by driver.
> + */
> + dev->msi_addr_mask =3D DMA_BIT_MASK(64);
> +
> if (of_node_name_eq(node, "pci")) {
> /* a PCI-PCI bridge */
> dev->hdr_type =3D PCI_HEADER_TYPE_BRIDGE;
> --=20
> 2.52.0
>=20
>=20

