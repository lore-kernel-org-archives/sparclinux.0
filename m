Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FAF33AD92;
	Fri, 20 Feb 2026 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582525; cv=none; b=Im7C67VN4sOJ8qhSjVRbxj8BN1yjtTRO37G1UukVQYkQ2U47IHVmtveuAHwqbdwU0b6S6JLd1L2jBBPCimOM0VnSUSvjZ752WB2grSupKs8lligm8qp6UHfq0ZiTq2QdYbhYNyQDiMSGsP+fK3/vemPmLyXjerJu4yYsssnsPIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582525; c=relaxed/simple;
	bh=2lgbyW9AslNmx1+E8wGxG6uK12LQcIBHxitrz5C72zM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOPudV5/idiRmBHjnDxvirlX28LlorqmKQ4tHTFspIoqhjjKCJ5AgkChXSvrHtij3pjuNst/rhOgfep2TGTkZJE+WjTfb7PGTmSQiFlOsizgRA3LYTnG60Vaa7g2BE7J4zqxE20nlm/kpTTLWZ76r/hIfNitIhE/sH1PJrUHGRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.106] (unknown [123.118.222.47])
	by APP-01 (Coremail) with SMTP id qwCowACH824iNJhpU7hRCA--.28513S2;
	Fri, 20 Feb 2026 18:14:58 +0800 (CST)
Message-ID: <782eaaf6-f7e2-4c15-b4a2-52e7697dbd95@iscas.ac.cn>
Date: Fri, 20 Feb 2026 18:14:57 +0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/2] pci: fix msi_addr_mask on powerpc and sparc systems
To: Nilay Shroff <nilay@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, sparclinux@vger.kernel.org
Cc: tglx@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, gjoyce@ibm.com, helgaas@kernel.org,
 davem@davemloft.net, andreas@gaisler.com
References: <20260220070239.1693303-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20260220070239.1693303-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qwCowACH824iNJhpU7hRCA--.28513S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW8KF13urykAr43uF17KFg_yoW8AF4fp3
	9aqryfKrWUG34xAa12kw17uF1UArnYq34xXrWrt392y3Z0vr1qyr1IyF4UG3WUtrZ7Ka10
	93W29w1vkFn8u3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU8IJPtUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Hi Nilay,

On 2/20/26 15:02, Nilay Shroff wrote:

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

This series is:

Reviewed-by: Vivian Wang <wangruikang@iscas.ac.cn>

With the caveat that I have neither powerpc nor sparc machines to test,
so it really is only reviewed.

Thanks and with apologies,
Vivian "dramforever" Wang

