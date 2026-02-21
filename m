Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51F722425B;
	Sat, 21 Feb 2026 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771694580; cv=none; b=NIOz++8hDWVUwr7uYW7Ymn2N3Au3eZOEqa1VD0gBmtLUkHUUVtgPzZeSs1J2ahWzK28QNMigQqpeP04Dgo3LyU7DVlIZxOvpcu6lxu4dzN/p2G3ZA+xwdlX0Sqe6Xl18QGNZmgdtWGm1Ovd31lkMPXhx6O4CF5Z1v+pnzvbaqRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771694580; c=relaxed/simple;
	bh=4kBh681Zl5dh4JAlW4ItAfNRFHVCMsu5JKZKbKpLEBw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ITgsRB8QG7LCxU3Kqj6VeQJ4G5QykbZX+cpKcKP34EeE7y75xpEj9xjQMSBzoiwI13GMc38RT+2GztKBA9s9W55wjPL4v3mQy+HsUvI+9uc42//tprcwsRKl+jj8kjdMJKN7+ik6ObmQBkO6Fjlc7iFI69DxVVEXMqt8MCYmBk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [58.38.117.196])
	by APP-05 (Coremail) with SMTP id zQCowABn9gme6JlpUK_QCA--.9783S2;
	Sun, 22 Feb 2026 01:17:19 +0800 (CST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v3] sparc: Fix page alignment in dma mapping
From: Han Gao <gaohan@iscas.ac.cn>
In-Reply-To: <20260218120056.3366-2-stian@itx.no>
Date: Sun, 22 Feb 2026 01:17:08 +0800
Cc: Han Gao <gaohan@iscas.ac.cn>,
 sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 Leon Romanovsky <leon@kernel.org>,
 "Han Gao (Revy)" <rabenda.cn@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <09CAA464-18E7-4206-A315-C25E7DF789E8@iscas.ac.cn>
References: <20260218120056.3366-2-stian@itx.no>
To: stian@itx.no
X-Mailer: Apple Mail (2.3864.400.21)
X-CM-TRANSID:zQCowABn9gme6JlpUK_QCA--.9783S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw13XFW7XFWUCF18JF43Jrb_yoW5JrW3pr
	97CrnxtF4UKa4rAas7Jw409F1DZw4DWry3W3Z0k347Zw17Xr15WF18ursIgrnFqrZ5CayS
	kF4qvFySya1UC3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
	W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFylc2xSY4AK67AK6r4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfU8PEfUUUUU
X-CM-SenderInfo: xjdrxt3q6l2u1dvotugofq/1tbiBwsFDGmZydUfvQAAsL



> On Feb 18, 2026, at 20:00, stian@itx.no wrote:
>=20
> From: Stian Halseth <stian@itx.no>
>=20
> 'phys' may include an offset within the page, while 'base_paddr' is =
already
> page-aligned. This caused incorrect DMA mapping in dma_4u_map_phys and
> dma_4v_map_phys.
>=20
> Fix both functions by masking phys with IO_PAGE_MASK or subtracting =
the
> page offset, covering both generic SPARC code and sun4v.
>=20
> Fixes: 38c0d0ebf520 ("sparc: Use physical address DMA mapping")
> Reported-by: Stian Halseth <stian@itx.no>
> Closes: https://github.com/sparclinux/issues/issues/75
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
> Changelog:
> v3:
> - Use IO_PAGE_MASK for alignment in both dma_4u_map_phys and =
dma_4v_map_phys
> - Align phys before the loop in pci_sun4v.c
> - Drop masking inside iommu_batch_add()
>=20
> v2: https://lore.kernel.org/all/20260217171104.5643-3-stian@itx.no/
> - Add Fixes tag
> - Add Closes tag
> - Trim commit message to 80-column lines
> - Remove newlines
> - Subject: Remove the "iommu/pci_sun4v:" (generic sparc patch, not =
specific to sun4v)
>=20
> v1: https://lore.kernel.org/all/20260217150350.3541-2-stian@itx.no/=20
> ---
> arch/sparc/kernel/iommu.c     | 2 ++
> arch/sparc/kernel/pci_sun4v.c | 2 ++
> 2 files changed, 4 insertions(+)
>=20
> diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
> index 46ef88bc9c26..7613ab0ffb89 100644
> --- a/arch/sparc/kernel/iommu.c
> +++ b/arch/sparc/kernel/iommu.c
> @@ -312,6 +312,8 @@ static dma_addr_t dma_4u_map_phys(struct device =
*dev, phys_addr_t phys,
> if (direction !=3D DMA_TO_DEVICE)
> iopte_protection |=3D IOPTE_WRITE;
>=20
> + phys &=3D IO_PAGE_MASK;
> +
> for (i =3D 0; i < npages; i++, base++, phys +=3D IO_PAGE_SIZE)
> iopte_val(*base) =3D iopte_protection | phys;
>=20
> diff --git a/arch/sparc/kernel/pci_sun4v.c =
b/arch/sparc/kernel/pci_sun4v.c
> index 791f0a76665f..58ca4148f86b 100644
> --- a/arch/sparc/kernel/pci_sun4v.c
> +++ b/arch/sparc/kernel/pci_sun4v.c
> @@ -410,6 +410,8 @@ static dma_addr_t dma_4v_map_phys(struct device =
*dev, phys_addr_t phys,
>=20
> iommu_batch_start(dev, prot, entry);
>=20
> + phys &=3D IO_PAGE_MASK;
> +
> for (i =3D 0; i < npages; i++, phys +=3D IO_PAGE_SIZE) {
> long err =3D iommu_batch_add(phys, mask);
> if (unlikely(err < 0L))
> --=20
> 2.53.0
>=20
>=20

Tested-by: Han Gao <gaohan@iscas.ac.cn> # on SPARC Enterprise T5220


