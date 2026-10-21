Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792614620;
	b=RfJZPbkLvM71c98f/IlYt5q1p3/ma9+TOcQf1/5gqnLQc9oD7tFaF+vpRNpKykhhODzv
	 XB5pQuD8XMstsnw++lNPRgsYS0IP52ueodgmVrhdXLJSpuFQ6TRvZEu9r8qV2qKqxj3SG
	 mIo+D5jMfhVldQI0p19eF6sS0Cd//hqdqI7xgr3x5lveOjZLL6Siu4t4nxzV4k9VWlRO+
	 tyuBBcEQA6ffFTGI3R5vUSQ9KQAL/usG1ueBcJocW0nPRKAENs94SI2D5YPbAMMNe7BDB
	 yovXoJmXZdqCxEnE1TkFCMB2NmTTzbP8LKTENZ3MNgaWQbCLRt2QORy8uq1VyEDmfqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792614620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=1/Tn+NIx4tdDy1sazjm+66tf6KeWLd+iSCtDVa0loeg=;
	b=eOeMhXI/dBjm88QWq/gye0Vn0txrgroaUJ2I8VXz7hcVKo0OCown5JafFRhow6n9GhMM
	 0WlNsx2pDe2qYREOezd0FepEeZ4S9ubHd4FogOy+sofYq4NsP8qihZiCLjBs70LRgOyvl
	 gcjM/ZJYc7fZUvTuHDVQb0rPP/d6jT6TAR45ELqHd7YSaW+0E1AoguK+3orv8x34YrTxB
	 VNoC9mxIMgQvrTYnePnd7pElfo2eCLA3B9ojDUADuNCxqEZOV5IJKcPXtrM19MuMLbx3w
	 aJ+tO2+uQxOvJXm1keZTJFOyTeun8oSgAQPKtduYVMs+mtXVd/yxyBDb7Ifi2KHWhaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NGztUjXB;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BE2606A31D
	for <sparclinux@vger.kernel.org>; Wed, 21 Oct 2026 20:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9BE2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NGztUjXB
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e5fb79ce82so6348795ad.0
        for <sparclinux@vger.kernel.org>; Wed, 21 Oct 2026 13:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792614619; x=1793219419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1/Tn+NIx4tdDy1sazjm+66tf6KeWLd+iSCtDVa0loeg=;
        b=NGztUjXBKhQgYrXnfbtLvSf1T40pglhTVvHHVVL7AzdgZ0ghWMKeIwrdTCzQ/G5ec5
         ppkqnwGG5Flx3SpF7l2QzwmxIYbgGA5lUFvhwVNWAaAfIxRA6uME3XYS7nPjWAn4khIM
         0IbB7ZkFj7yc2ChLp2ZDi711Ni6ZBZC5W8k8oVbWqelkcGtX3qQXdh4NK3CBJlmTwAj/
         OyhyTNsBEmxbInnlxBwHWY5KvzkpmQ8db8PZbdItrOFg8g2MwhtpXpZqXbUD7kdHfMcd
         YWmHgc+gAsJEJV0DMlRegD3SV/BhDn0YvrWlbARJ6ATh/Q3Gd1T2rnyT6ZXIyEHsJsXM
         KbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792614619; x=1793219419;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1/Tn+NIx4tdDy1sazjm+66tf6KeWLd+iSCtDVa0loeg=;
        b=2tJzfZ2D951pEu9gZ6mqXimKXCg+D77IADmPo/KJ/zMnJ4qZE2UqKEWvEBCW5MQuXV
         x+uQEoha6EONnDkyflGtbAhwzR8w18mFO73lJjFVS+C+plDuu2dd9whzcv3usWoLYtyR
         5TGu0sbwi7bdVokAD/nmXdbdLqMhHDs4pFA46y9q96K9Tx+KUwNlxsLGoYi7vkYHQgNE
         tzG14Ho/ERPuhtxA8QVU+dJcl+S5F32VkL68pmexUGNK+ajTK+Y4/271SAowXrgOj54H
         gUhp93Yufatmk9hJTnOYhKwnOHCAMjL6w1PO4jhk95On8fBYmU3iLM+7JxLJn8w3qk1E
         Mrlg==
X-Forwarded-Encrypted: i=1; AKwUvBwHa3vgnyim4B10CMtPf9F6z3EWtHwXLUywW9nIzs92zyfIIYSBD6Q6OD/v2errybPDvRKoB+iVE8Pz@vger.kernel.org
X-Gm-Message-State: AFq9FYI8ARKZfIeyD64rcrLbvjvTw8TdlUsWEQoRtDP3kDV4hZ9UwEPk
	8nj4gmBhYEJfLaJBE8UZfAr0lY4ULHs0jk35XYV5ty9RbGJ4/SGILPUS
X-Gm-Gg: AYBFou3iGfEylZix+JNKngiw9sVzee8j/hhtt1GN9bRy+SDtbx71zn8gpiJ3MaZvMlg
	lFlkjVsf2AuReyRNHRpLA4uXX4wSfdOqAPCN0KuL6AWRVIubiGarrLZPb3OLI02dFllNh+krODP
	2d7bIOBPFSqqgLyU4B/dIOA9brcbA1lCgMuAry/m2+g3nxF3e51SZhExO/mM40LvlWtLg1c/mLe
	iN+Pzt/7GkkRm6f0IGcZf8PFWXQO+6w7yxgIe1iMOLlgQM5ikKH2rZZZHiNbOUNPgpWJ+LRVEQG
	C6nJcip3ie5DeQB2GdQHNe5ft9pOnQgX4FHLP/hawOQBXj2itxLGqTWc+cVG6uSJNEArMcl24DU
	ibSFBXdPfcLytZvNAg6X34JhoLKpK6e6WEWs2cBQ4vdy1+gUubkQ7PSEUXzC6y7gx1+FqQR2BLs
	ITxETznN2Ysvld3UqDp0tDddKDe0Y7U9cIlqsNigWO6Gua9SJts0Mz5ywo/7vmSAv8o3lhPITLg
	qS4t6B7LtbbQ/divKfKEElt42EkYmpGeTCDSDXArNyNU129Tb05dVomR3bVDV66T0tGhfARQ+Ox
	ldtbnR3e2lJtu21Rrw==
X-Received: by 2002:a17:902:d552:b0:2e9:7ff5:5459 with SMTP id d9443c01a7336-2ea439f4ad4mr28663555ad.15.1792614619097;
        Wed, 21 Oct 2026 13:30:19 -0700 (PDT)
Received: from [192.168.21.192] ([24.18.106.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b49caa7sm15515825ad.69.2026.10.21.13.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 13:30:18 -0700 (PDT)
Message-ID: <e8f08d9a-8b67-4c7a-8ef5-1ed38351e499@gmail.com>
Date: Wed, 21 Oct 2026 13:30:19 -0700
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] sparc64: Use relaxed ordering for DMA_FROM_DEVICE
 mappings on sun4v
Content-Language: en-US
To: Stian Halseth <stian@itx.no>, Andreas Larsson <andreas@gaisler.com>,
 "David S . Miller" <davem@davemloft.net>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261013133731.1795299-1-stian@itx.no>
From: Tony Rodriguez <unixpro1970@gmail.com>
In-Reply-To: <20261013133731.1795299-1-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/26 6:37 AM, Stian Halseth wrote:

> sun4v IOMMU and ATU mappings carry a relaxed ordering attribute, but
> dma_4v_map_phys() and dma_4v_map_sg() set it only when the caller
> passes DMA_ATTR_WEAK_ORDERING. Some network drivers do, storage drivers
> do not. Without it every device write into memory is strictly ordered,
> which on a T7-1 (M7) caps DMA reads at about 280 MiB/s per PCIe device
> while writes run at full speed.
>
> Set the attribute for every DMA_FROM_DEVICE streaming mapping. Devices
> report completion through coherent memory or an interrupt, which stay
> strictly ordered, and a strictly ordered write does not pass the writes
> before it.
>
> T7-1, fio 1M sequential read, QD32:
>
>                        before        after
>    NVMe (PM1725, x4)   281 MiB/s     3169 MiB/s
>    SATA SSD (mpt3sas)  278 MiB/s      502 MiB/s
>
> Closes: https://github.com/sparclinux/issues/issues/114
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
> Tested on a T7-1 (M7) and a T4-1:
>
> - T7: fresh RAID1 on two NVMe drives, 192 GB fio crc32c write+verify
>    and md check: no errors, mismatch_cnt 0.
> - T7 and T4: file checksums on the SAS boot mirrors identical to a
>    strictly ordered kernel; no new messages in dmesg.
> - 4k random read and sequential writes unchanged.
>
>   arch/sparc/kernel/pci_sun4v.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
> index 61f14b4c8f90d..4dd17b65dd6cc 100644
> --- a/arch/sparc/kernel/pci_sun4v.c
> +++ b/arch/sparc/kernel/pci_sun4v.c
> @@ -403,7 +403,7 @@ static dma_addr_t dma_4v_map_phys(struct device *dev, phys_addr_t phys,
>   	if (direction != DMA_TO_DEVICE)
>   		prot |= HV_PCI_MAP_ATTR_WRITE;
>   
> -	if (attrs & DMA_ATTR_WEAK_ORDERING)
> +	if (direction == DMA_FROM_DEVICE || (attrs & DMA_ATTR_WEAK_ORDERING))
>   		prot |= HV_PCI_MAP_ATTR_RELAXED_ORDER;
>   
>   	local_irq_save(flags);
> @@ -503,7 +503,7 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
>   	if (direction != DMA_TO_DEVICE)
>   		prot |= HV_PCI_MAP_ATTR_WRITE;
>   
> -	if (attrs & DMA_ATTR_WEAK_ORDERING)
> +	if (direction == DMA_FROM_DEVICE || (attrs & DMA_ATTR_WEAK_ORDERING))
>   		prot |= HV_PCI_MAP_ATTR_RELAXED_ORDER;
>   
>   	outs = s = segstart = &sglist[0];

Tested-by: Tony Rodriguez <unixpro1970@gmail.com>

Tested on a Sparc S7-2 with a Samsung 2TB EVO SATA SSD.
No functional issues or major regressions were observed.

