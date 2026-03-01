Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF68320A04;
	Sun,  1 Mar 2026 07:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772348408; cv=none; b=tELZR/ia6BsVEEFSVMNXV67a+WcEhXNGkL54IPiGQ8slpZq94piG/ksh0X1qDFu7Xi/7HfYYxMfEied6CafcY8w37QbozCt/zUspOIzX1ZSiE4gRjf9lskq4NDaYn82Csz1oGOlqy9QJuqYazNMgQ8jdcSsdXUK0M3R8Rs5XTHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772348408; c=relaxed/simple;
	bh=I8EQo/NbWjLKrDlFxdsKTBfRrpz+7VWtsvEBPsnJquA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oXJpdQibQjRED/i5JwaakUxAeKo0yrBWsIh2LXYgEubxH6/O6xqhBT9YILn+F9fR+dDwnvtRi/ugTGr0+C/Zmd8n//k0aHdOUajRrgAhIBcELeqv0OXFlYAGwqdv2mi5C74qIkVwU+5pmc1VkEmUBiYuTxfUvXoJKS9Sftj5P4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UHCNbsgy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SYECe4KG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UHCNbsgy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SYECe4KG"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772348402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I8EQo/NbWjLKrDlFxdsKTBfRrpz+7VWtsvEBPsnJquA=;
	b=UHCNbsgyx/6ZWOygB5rCjnV9ylgVGph4Q5rD/PkSl7E0vMV/eNKHF9wjEkasjXBawmTFMH
	1XAOi+vz7QdZMPANg1U1iAgm6GHCoF6780fRGrXjBloae1sbrc9We+lxIfPGHloYzit0mQ
	F1NxWo14CeIBA5SCTjai1giJithnZ5+0uKQPm55mcRxZ4vJcCkjw17BStPo6Q9jVcBR7ZP
	o1c+ZHWH4y6obBA/9uz1oXmvhOHPpFuF/XvI0wZF/qWlJLFZlfn4aOQ7voc9WR3ZCCwoUR
	1YNNIU4gWryB+TMZruvP3n6EMBTmfJj/Qg/hgEf7yE1JiIcC2p/mjlxTh2Pqxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772348402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I8EQo/NbWjLKrDlFxdsKTBfRrpz+7VWtsvEBPsnJquA=;
	b=SYECe4KGSP/zVd5WloNpXB8nNRX4FTDjfqx+O8v978PDMMwI/6lozc9SiZmc4D2Obd7nw6
	6A+ARbmoW+JjGyDA==
To: Nilay Shroff <nilay@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, sparclinux@vger.kernel.org
Cc: wangruikang@iscas.ac.cn, tglx@kernel.org, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, gjoyce@ibm.com,
 helgaas@kernel.org, davem@davemloft.net, andreas@gaisler.com, Nilay Shroff
 <nilay@linux.ibm.com>
Subject: Re: [PATCHv2 1/2] powerpc/pci: Initialize msi_addr_mask for
 OF-created PCI devices
In-Reply-To: <20260220070239.1693303-2-nilay@linux.ibm.com>
References: <20260220070239.1693303-1-nilay@linux.ibm.com>
 <20260220070239.1693303-2-nilay@linux.ibm.com>
Date: Sun, 01 Mar 2026 13:59:46 +0700
Message-ID: <87a4ws6nml.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nilay Shroff <nilay@linux.ibm.com> writes:
> Recent changes replaced the use of no_64bit_msi with msi_addr_mask.
> As a result, msi_addr_mask is now expected to be initialized to
> DMA_BIT_MASK(64) when a pci_dev is set up. However, this initialization
> was missed on powerpc due to differences in the device initialization
> path compared to other (x86) architecture. Due to this, now PCI device
> probe method fails on powerpc system.
>
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
> Fixes: 386ced19e9a3 ("PCI/MSI: Convert the boolean no_64bit_msi flag to a DMA address mask")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

I ran into this problem today. Great that it's already been fixed.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Tested-by: Nam Cao <namcao@linutronix.de>

Nam
