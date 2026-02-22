Received: from arcturus.nroach44.id.au (arcturus.nroach44.id.au [45.32.188.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB091684B4;
	Sun, 22 Feb 2026 06:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.32.188.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771740092; cv=none; b=By8UfEnQH4KrUfvylawaKYYjwObOgH0wHBHETStoM2XeD/+sTYBG2/D/ki/HXwpWegm/QxdoKciGm4Up6ulko1VVKSLb1k1QTnv1QtIgNAWtBeHjnvRptbtI5V6tv0CfMEMMM/6NJML+HRetNYYJo0e9nzVyOgcHLh0OyLYjCkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771740092; c=relaxed/simple;
	bh=8U/bP+r/4Svx2WVB+nx4JWF9ZuYunuY2P74myov9U9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ogOYXU5qvCoa5rSbS1tRJ6MLD2qCHnsHs4Z9YQjQ8d/ox8ePHolyXUN85XEZdL0Q5FdgLrtLmCxGZjsNi7O35RjYH0olDm7WufccJk54pZcVpdBcnhwdD7mUZyWdgOoWy5fOpa7kyt9IvLEPxDvt7cpvGR/4oD0pXIHa2uKGvAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nroach44.id.au; spf=pass smtp.mailfrom=nroach44.id.au; dkim=pass (2048-bit key) header.d=nroach44.id.au header.i=@nroach44.id.au header.b=lYoxtbEF; dkim=pass (2048-bit key) header.d=nroach44.id.au header.i=@nroach44.id.au header.b=lYoxtbEF; dkim=pass (2048-bit key) header.d=nroach44.id.au header.i=@nroach44.id.au header.b=f7CdgK4d; arc=none smtp.client-ip=45.32.188.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nroach44.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nroach44.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nroach44.id.au header.i=@nroach44.id.au header.b="lYoxtbEF";
	dkim=pass (2048-bit key) header.d=nroach44.id.au header.i=@nroach44.id.au header.b="lYoxtbEF";
	dkim=pass (2048-bit key) header.d=nroach44.id.au header.i=@nroach44.id.au header.b="f7CdgK4d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nroach44.id.au;
	s=dYX2HNEqNNRL; t=1771740081;
	bh=8U/bP+r/4Svx2WVB+nx4JWF9ZuYunuY2P74myov9U9c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lYoxtbEFYlerjWodnF1gIb4Fpy6/liV0u49L1y2slpSE1B5l1WYcvoY+Kmc9Hk35G
	 is+AfTLn04kR8fkoaDnlokzcSU9okWCw4OcsJ9Cegnq9jBz6r4+LYR8qChwYLhuE6L
	 1Z30JqMAgPV7Fp5HE+JM6o+rofAGke/dhOLYHIXuTsfv1anRT7Big3NF/iRIGpIJz0
	 OhVMlydSsVD/hjymAwrkd3/dglXZuVdlt0s+9VGd9nFlP7IFVvNMPQrt9WDUWoQ93W
	 futKe8WNu5FIxWfvhFJpFpslLNFzyU0fo1BRzYO21uUGOyp0LdoxdZz1VwDvilwbsr
	 7FDAhtadpgt+g==
Received: from arcturus.nroach44.id.au (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by arcturus.nroach44.id.au (Postfix) with ESMTPS id 1FB4E30D0D;
	Sun, 22 Feb 2026 14:01:21 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nroach44.id.au;
	s=dYX2HNEqNNRL; t=1771740081;
	bh=8U/bP+r/4Svx2WVB+nx4JWF9ZuYunuY2P74myov9U9c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lYoxtbEFYlerjWodnF1gIb4Fpy6/liV0u49L1y2slpSE1B5l1WYcvoY+Kmc9Hk35G
	 is+AfTLn04kR8fkoaDnlokzcSU9okWCw4OcsJ9Cegnq9jBz6r4+LYR8qChwYLhuE6L
	 1Z30JqMAgPV7Fp5HE+JM6o+rofAGke/dhOLYHIXuTsfv1anRT7Big3NF/iRIGpIJz0
	 OhVMlydSsVD/hjymAwrkd3/dglXZuVdlt0s+9VGd9nFlP7IFVvNMPQrt9WDUWoQ93W
	 futKe8WNu5FIxWfvhFJpFpslLNFzyU0fo1BRzYO21uUGOyp0LdoxdZz1VwDvilwbsr
	 7FDAhtadpgt+g==
Received: by arcturus.nroach44.id.au (Postfix, from userid 5555)
	id 071AC30D11; Sun, 22 Feb 2026 14:01:21 +0800 (AWST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nroach44.id.au;
	s=dYX2HNEqNNRL; t=1771740068;
	bh=8U/bP+r/4Svx2WVB+nx4JWF9ZuYunuY2P74myov9U9c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f7CdgK4d4wk8Sj0Cp0KAfzNKCLJMCZEqVglBumfnfjMFcv0jBT/GFwUHPLd5+lMfA
	 ZCSxOdbcRY3WRaRDAGcDxoOLEziGwC4xyD/OhMCm+OJtf3bnKC0TM+igKtnFWyNclI
	 Na+1WTJSitA73Cx/cqdR7bTXJLP7k5CY+3XpZMIbzxvNOHhtZ47b0rsuS3m0T6zXBc
	 Z9zAZZpxkhGEQHl+bAhPnUHf8cZZXfGYPZZYJn1XnkHVbPo9ABKcHQhQiQMWT9f9IF
	 8Lxyc6WsaoAb7S9RYgNC6OuP/ZzpZ3OEZ5X5cEg0ycIAZAuqfYQl+M23WUkT9Xz282
	 uD4wR+AG3cpPw==
Received: from [IPV6:2403:5814:4228:10:3a62:38:7f97:4cc] (unknown [IPv6:2403:5814:4228:10:3a62:38:7f97:4cc])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by arcturus.nroach44.id.au (Postfix) with ESMTPSA id 3719E2E659;
	Sun, 22 Feb 2026 14:01:07 +0800 (AWST)
Message-ID: <dd9f072a-9db8-475f-a7a6-3cf5c5ec45bd@nroach44.id.au>
Date: Sun, 22 Feb 2026 14:01:05 +0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/2] sparc/pci: Initialize msi_addr_mask for OF-created
 PCI devices
To: Han Gao <gaohan@iscas.ac.cn>, Nilay Shroff <nilay@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 sparclinux@vger.kernel.org, wangruikang@iscas.ac.cn, tglx@kernel.org,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, gjoyce@ibm.com, helgaas@kernel.org, davem@davemloft.net,
 andreas@gaisler.com, "Han Gao (Revy)" <rabenda.cn@gmail.com>
References: <20260220070239.1693303-1-nilay@linux.ibm.com>
 <20260220070239.1693303-3-nilay@linux.ibm.com>
 <47EB6E53-3E20-4E95-A329-928E5BDDFB81@iscas.ac.cn>
Content-Language: en-US
From: Nathaniel Roach <nroach44@nroach44.id.au>
In-Reply-To: <47EB6E53-3E20-4E95-A329-928E5BDDFB81@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/2/26 00:36, Han Gao wrote:
> Tested and passed on SPARC Enterprise T5220.
>
> Without this patch, the e1000e would use intx.
>
> Tested-by: Han Gao <gaohan@iscas.ac.cn <mailto:gaohan@iscas.ac.cn>> # on SPARC Enterprise T5220
>
>> On Feb 20, 2026, at 15:02, Nilay Shroff <nilay@linux.ibm.com> wrote:
>>
>> Recent changes replaced the use of no_64bit_msi with msi_addr_mask,
>> which is now expected to be initialized to DMA_BIT_MASK(64) during PCI
>> device setup. On SPARC systems, this initialization was inadvertently
>> missed for devices instantiated from device tree nodes, leaving
>> msi_addr_mask unset for OF-created pci_dev instances. As a result,
>> MSI address validation fails during probe, causing affected devices
>> to fail initialization.
>>
>> Initialize pdev->msi_addr_mask to DMA_BIT_MASK(64) in
>> of_create_pci_dev() so that MSI address validation succeeds and PCI
>> device probing works as expected.
>>
>> Fixes: 386ced19e9a3 ("PCI/MSI: Convert the boolean no_64bit_msi flag to a DMA address mask")
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>> arch/sparc/kernel/pci.c | 7 +++++++
>> 1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
>> index b290107170e9..a4815d544781 100644
>> --- a/arch/sparc/kernel/pci.c
>> +++ b/arch/sparc/kernel/pci.c
>> @@ -355,6 +355,13 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
>> dev->error_state = pci_channel_io_normal;
>> dev->dma_mask = 0xffffffff;
>>
>> + /*
>> + * Assume 64-bit addresses for MSI initially. Will be changed to 32-bit
>> + * if MSI (rather than MSI-X) capability does not have
>> + * PCI_MSI_FLAGS_64BIT. Can also be overridden by driver.
>> + */
>> + dev->msi_addr_mask = DMA_BIT_MASK(64);
>> +
>> if (of_node_name_eq(node, "pci")) {
>> /* a PCI-PCI bridge */
>> dev->hdr_type = PCI_HEADER_TYPE_BRIDGE;
>> -- 
>> 2.52.0
Tested-by: Nathaniel Roach <nroach44@nroach44.id.au> # SPARC T5-2
