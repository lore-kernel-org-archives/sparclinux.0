Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792617923;
	b=Xb/7ZGmbnQbdfeOmUn4XDzUBIJkV1crHQpp/VbHB7UFgtrcDjOR3eiHhuqRpRqb4hUUb
	 QpkTAj1AXshtp+inHEOettfU4b8nSz62JOqCiGCLiV1D7zvwM5vElEM6BhHEGYsl0/e+W
	 wYshHy0H71nv4mPWJo46om0nMZRzPoKPwPaNbNnnwMZSx7liIoJ4/ZVJnWpobR/G5IhyE
	 r1vKWluAA1/JIGWAzk/Ljx+c707aaDJxQ77sIfH2Bay/TqLzxU5QJ+gTlCzpFIiLml+4v
	 6MKweXzGzhHe/tpmpbwkvTy1a7T55y6dfa06oAN23yXjx9nyNQpEm6Q7RIFI+SHzelg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792617923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=XDhuPTrkfsx2EQ87Q60VEaA6HRR45VH3CZ/hmoeLz50=;
	b=c2KefxdxXOPu5HvV9eFEkiH2FkBqL80N8dMmZoaB6ZtxVD3zTT6FwVX6/q5xh7JlpjpY
	 QpECRiLLsYVwuu6TwLmcpeqNBs4sXgXy5O82C1Wb36KWNH2HMRZmgXB8jdP7KnoT8r5f1
	 DXNVO8RHsHMTjGL5fJ+sVOgzJjurhpmxycIfKeIN+htL8+KNNqOpDKarHw5uG9/bkzMgx
	 9DT2BGDnOOEfZerV6NxOA5xT2Z89v058avJFXIGAMnzgmkZ5MxHfhvYqFHEAkt+vMOeUN
	 VYrsO+Rbl45hYxpXtxzPr54V+9krldQPP3L4kwnDryF5voqrabhjb2KrWpAq1ORHyxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VAdLwfUi;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBFE606A31A
	for <sparclinux@vger.kernel.org>; Wed, 21 Oct 2026 21:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EBFE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VAdLwfUi
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso617329a12.0
        for <sparclinux@vger.kernel.org>; Wed, 21 Oct 2026 14:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792617922; x=1793222722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XDhuPTrkfsx2EQ87Q60VEaA6HRR45VH3CZ/hmoeLz50=;
        b=VAdLwfUi3V3D3ww8dDI80MpRrI2XIoWxaWgS15AWkpIWcaawZO1zDKoYAmXohWF8e5
         aGR6b27z4BQlPDMptR+gt3E3A3yjs54YdXVjiC/SQB9CHR5wxvSswQuqgidGx4A2A6oS
         S0rAvQrzSZxn439kmRyxHUuJ1hCE40q3f+SBU5DgzE2hMrhdTA4LiOLR3ZZ3yZ3/5dXa
         oa1/xMEXeUmav5tYcWxnVyP5xm+R+5MqAXTh02EwsL4XErAwblvNVyZ47cqFZPPeJ6qJ
         tD1Uz8HKZT//h/Jig1LBWTYGTXZ85CtfpKdo7FuPdK8G+cOQ/bDHdCVytDtxQX69MZ10
         027g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792617922; x=1793222722;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XDhuPTrkfsx2EQ87Q60VEaA6HRR45VH3CZ/hmoeLz50=;
        b=mZOMgn9hGhlIEOv8h+zzYW7IpZKQJG1oUuIhQ09JpwPSW7ex0YglURFMPR4tSXl9Vw
         jLfPTW3BFjXV2B5WcCmSEL3ZqrzQyk1mNQeaxgrpJk/sJ5A2VPoJwcMIgJFYgvzmWXNK
         q1HxO9UOXZ6T+WBDXGdirdpj//PIHbFZATiN5NwEffB1uqZhcDFdWrXx42eTBvwCcqJJ
         pCaJv2KKFs6IlZZfwrah9iScfwXt5odxyiNiylOVVard7TgPWKfOCfcg66Npx3HHVicJ
         ioBJN2WtI9YwOfRvrIJ2E8pW1R3VHtj2omyQ6w5o9GP8V7u2ogN1/ICql0X4PxGlJIPQ
         isnA==
X-Forwarded-Encrypted: i=1; AKwUvBxrejieisR7r05vqW2ORIMuLkacAfZIxdV99u+q484Y3UKS6P50kQ7FMSKJBaTujfOFRmH2N7p7BE5i@vger.kernel.org
X-Gm-Message-State: AFq9FYKa/zeVb49/UNpWnP54PsMQ8IdKB0xBQYKYjqwhfeSSJ1WFK0vs
	4FHkbXzmnsf2eFk5jVHtb95LkTWAwmpPFjKt2sSWmNTJuWs8kbQzmeDV
X-Gm-Gg: AYBFou3VYmVRYa+iw6UCHH07UvfODJ/RG/LnaVdUuEoAGeFPfzvrv+7WXwN36YQvNqF
	zGqWOEbAGdAfJ/zL6Lb8AJ8vBWKy8zFhXSZBW/46UsDHj0xm7299M+mRUAUqVeamXPuxKI9le1w
	V+Sdze2alULIrsLz6kTkZNn6EoTRTqgZR2re/DN3hAAJudDk386S8nQy0cDy8FyGBdFCgD2HFBI
	nThNHwaxRg4oqD/Q6zl2vv6fWBXGF7Kz1i8k8/MEBhXoOYhMt6Pgiv8CJP1EFDMhtHNgAdRJcG5
	YOJA4QT/l7xDOd5qynxUM7rbcR3cDLWdQ3ezYp3vdWRn8Sanuo00CHlcYxlAZZzwgSmV0P71YXG
	qRAu47LRmQ++XW/UkSXKzeSthg731zniCIaRkRlLQo7BsI0JK2bBuUlHvrjG4ZgxyOrRroTFeE3
	pqd/rcdTK06vvH9OmyJYXQtjGknhbqNX7RTdA5G+cGi678cL14kbcvJSvUL9p5W1w0Q2jGa6S9X
	7XUilZ2qD6kZ2NOu8t1qG2Y1uvzb7EbBryyvOqJRl96W6v+/c+DZv9HF8BMUVrJw1JpvoNVHbKg
	XIv0mi1ozLQi4+umYw==
X-Received: by 2002:a17:90b:5810:b0:3ac:a521:95c with SMTP id 98e67ed59e1d1-3ad87087a43mr2443291a91.58.1792617922393;
        Wed, 21 Oct 2026 14:25:22 -0700 (PDT)
Received: from [192.168.21.192] ([24.18.106.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada48bb3b6sm1081067a91.13.2026.10.21.14.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 14:25:21 -0700 (PDT)
Message-ID: <04b9af90-721e-414e-828d-9fa44ce759f2@gmail.com>
Date: Wed, 21 Oct 2026 14:25:21 -0700
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
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Stian Halseth <stian@itx.no>, Andreas Larsson <andreas@gaisler.com>,
 "David S . Miller" <davem@davemloft.net>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261013133731.1795299-1-stian@itx.no>
 <e8f08d9a-8b67-4c7a-8ef5-1ed38351e499@gmail.com>
 <0892a8803ca20869cd8cc76fcffc9f7543cffd2f.camel@physik.fu-berlin.de>
From: Tony Rodriguez <unixpro1970@gmail.com>
In-Reply-To: <0892a8803ca20869cd8cc76fcffc9f7543cffd2f.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/21/26 1:49 PM, John Paul Adrian Glaubitz wrote:
> Hi Tony,
>
> On Wed, 2026-10-21 at 13:30 -0700, Tony Rodriguez wrote:
>> On 10/13/26 6:37 AM, Stian Halseth wrote:
>>
>>> sun4v IOMMU and ATU mappings carry a relaxed ordering attribute, but
>>> dma_4v_map_phys() and dma_4v_map_sg() set it only when the caller
>>> passes DMA_ATTR_WEAK_ORDERING. Some network drivers do, storage drivers
>>> do not. Without it every device write into memory is strictly ordered,
>>> which on a T7-1 (M7) caps DMA reads at about 280 MiB/s per PCIe device
>>> while writes run at full speed.
>>>
>>> Set the attribute for every DMA_FROM_DEVICE streaming mapping. Devices
>>> report completion through coherent memory or an interrupt, which stay
>>> strictly ordered, and a strictly ordered write does not pass the writes
>>> before it.
>>>
>>> T7-1, fio 1M sequential read, QD32:
>>>
>>>                         before        after
>>>     NVMe (PM1725, x4)   281 MiB/s     3169 MiB/s
>>>     SATA SSD (mpt3sas)  278 MiB/s      502 MiB/s
>>>
>>> Closes: https://github.com/sparclinux/issues/issues/114
>>> Signed-off-by: Stian Halseth <stian@itx.no>
>>> ---
>>> Tested on a T7-1 (M7) and a T4-1:
>>>
>>> - T7: fresh RAID1 on two NVMe drives, 192 GB fio crc32c write+verify
>>>     and md check: no errors, mismatch_cnt 0.
>>> - T7 and T4: file checksums on the SAS boot mirrors identical to a
>>>     strictly ordered kernel; no new messages in dmesg.
>>> - 4k random read and sequential writes unchanged.
>>>
>>>    arch/sparc/kernel/pci_sun4v.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
>>> index 61f14b4c8f90d..4dd17b65dd6cc 100644
>>> --- a/arch/sparc/kernel/pci_sun4v.c
>>> +++ b/arch/sparc/kernel/pci_sun4v.c
>>> @@ -403,7 +403,7 @@ static dma_addr_t dma_4v_map_phys(struct device *dev, phys_addr_t phys,
>>>    	if (direction != DMA_TO_DEVICE)
>>>    		prot |= HV_PCI_MAP_ATTR_WRITE;
>>>    
>>> -	if (attrs & DMA_ATTR_WEAK_ORDERING)
>>> +	if (direction == DMA_FROM_DEVICE || (attrs & DMA_ATTR_WEAK_ORDERING))
>>>    		prot |= HV_PCI_MAP_ATTR_RELAXED_ORDER;
>>>    
>>>    	local_irq_save(flags);
>>> @@ -503,7 +503,7 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
>>>    	if (direction != DMA_TO_DEVICE)
>>>    		prot |= HV_PCI_MAP_ATTR_WRITE;
>>>    
>>> -	if (attrs & DMA_ATTR_WEAK_ORDERING)
>>> +	if (direction == DMA_FROM_DEVICE || (attrs & DMA_ATTR_WEAK_ORDERING))
>>>    		prot |= HV_PCI_MAP_ATTR_RELAXED_ORDER;
>>>    
>>>    	outs = s = segstart = &sglist[0];
>> Tested-by: Tony Rodriguez <unixpro1970@gmail.com>
>>
>> Tested on a Sparc S7-2 with a Samsung 2TB EVO SATA SSD.
>> No functional issues or major regressions were observed.
> Did you also see the vast improvement that Stian has reported?
>
> Adrian

Yes, with certain fio tests.  IOPS have improved:

Note(s):

1) The following output does not include Stian's AES patch (needed to 
test against luks).   Reached out to him about a question regarding 
applying that patch.  In other words, this is a non luks tests.

2)  I also don't have NVMe installed within my Sparc S7-2.

3) Sata SSD will not reach NVMe performance (due to Sata SSD design 
limitation).  However, improvements were noticed with Sata SSD.

-------------------------------------------------------------------------------------
A = Before Patch                  B = After Patch
-------------------------------------------------------------------------------------

A1) Jobs: 1 (f=1): [R(1)][100.0%][r=314MiB/s][r=314 IOPS]
read: IOPS=314, BW=314MiB/s (329MB/s)(18.4GiB/60101msec)

B1) Jobs: 1 (f=1): [R(1)][100.0%][r=544MiB/s][r=544 IOPS]
read: IOPS=543, BW=543MiB/s (570MB/s)(31.9GiB/60058msec)

A2) Jobs: 4 (f=4): [R(4)][100.0%][r=456MiB/s][r=456 IOPS]
read: IOPS=456, BW=456MiB/s (478MB/s)(26.8GiB/60273msec)

B2) Jobs: 4 (f=4): [R(4)][100.0%][r=544MiB/s][r=544 IOPS]
read: IOPS=544, BW=544MiB/s (570MB/s)(32.0GiB/60232msec)

A4) Jobs: 1 (f=1): [r(1)][100.0%][r=36.5MiB/s][r=9346 IOPS]
read: IOPS=9824, BW=38.4MiB/s (40.2MB/s)(2303MiB/60001msec)

B4) Jobs: 1 (f=1): [r(1)][100.0%][r=44.7MiB/s][r=11.4k IOPS]
read: IOPS=11.4k, BW=44.6MiB/s (46.8MB/s)(2676MiB/60001msec)


