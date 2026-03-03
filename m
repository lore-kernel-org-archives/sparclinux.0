Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EA13750CC;
	Tue,  3 Mar 2026 04:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772512193; cv=none; b=X59/m1wYE/iYrTDSmGgvMhnaipU2coMm+kirL3TOQAuDcMA0PUShxLJAAeya6spbfuQO5HBv3CLyjL1IJQYcB0wp6UCujAyx1tP0YCReN4c3u4N81+guFTdCB7MKuDKSGymWIwlRNjE9+OC5gK6/BNOzFISjGWXuDcBGYu3CDQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772512193; c=relaxed/simple;
	bh=VJXjdZufZQx0IQWn3K/fXJJKFc3xrWvDbgfT/Z+ysSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jR/Q1yOx0R09ZbAtr1910rYuXXfisyioCwozcykbqhpJpKDD5blIB9uKiloMfKSsVgP9C4z+54LW8KcTNvEIZXFl48mdJ8ky21W4LipTEyDxK4tFCNGIbP8eESk5pMsUoYZfM1+zpz01s4WvMzflLtCVtIShyEZfIJtW8q/UQgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JZZTJhuf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JZZTJhuf"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622E9tfl2134009;
	Tue, 3 Mar 2026 04:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=M3Cwls
	WTyYhG0plLvfrcHn2FEQPK3YKqObldwrfMvdY=; b=JZZTJhufZNC+EJXpX7W9ps
	zEhBbepbwXrOvsptJqyjnbrgInQj/LMaT88pq4TTN+Ew2BhrFaWWNrWC2a577dkA
	4ZTQmAsnP06/DvR4p/uNZqZ+GXLrOxTDmPwb7ROKUtA6wgOBfu3+Sy05jOj2x4l/
	sLjtHs9EXT3fx7baWRKnoR2ajFXci8mLExnIHvFrLVU1kpQ1HlR+BUEiU371LMOe
	wH7sB9qv45yjwPEjYZmasVWQauXCqkkMiIC8GIX+Ux2iVpcid1k8Kof+KgjlMrCM
	5kZO8bCu+39jQWSyyxrpCwm00Bce0aPqUpNtVDv1JhEEok8zptR8/VjwbWKQDhmQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskbs7ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 04:29:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6231A8fr008769;
	Tue, 3 Mar 2026 04:29:25 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmdd18h0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 04:29:25 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6234TNK762980430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2026 04:29:23 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 422B158106;
	Tue,  3 Mar 2026 04:29:23 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA57658107;
	Tue,  3 Mar 2026 04:29:17 +0000 (GMT)
Received: from [9.43.101.186] (unknown [9.43.101.186])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Mar 2026 04:29:17 +0000 (GMT)
Message-ID: <d8440351-7394-4444-9891-b9af1982bd06@linux.ibm.com>
Date: Tue, 3 Mar 2026 09:59:15 +0530
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/2] pci: fix msi_addr_mask on powerpc and sparc systems
To: Bjorn Helgaas <helgaas@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller"
 <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        sparclinux@vger.kernel.org, wangruikang@iscas.ac.cn, tglx@kernel.org,
        npiggin@gmail.com, chleroy@kernel.org, gjoyce@ibm.com
References: <20260227164427.GA3897611@bhelgaas>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20260227164427.GA3897611@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: _tK77ANu3W9z-VeG8u6qfS6ArfhENUaw
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69a663a6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ox5LE5JcwimiERT94YoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDAyNCBTYWx0ZWRfX7rR2nR3sm76t
 /zBOvAMjTcOezRq7OelIqm9/uihaMyXQN4Jxhx/w+h/63hxsprLvpJUewJyFdtlsRbEKmGl42Cu
 FiWotNMNf+sEox5YlLLujbX3F8RIF4OIy3ujbLClTXA+/CczXTT4GTYPu+RvQkhZfHL5CONNONN
 viQabmw2MdWC8ywmo6LgATVVF8VwIUzM9H3V+M4T/7Gj6QOIzdDXTI5w8/0YIv2I9J9ZLfUtveE
 UuhqH2w6Y7zbrXI4EJb1rx9RI3wsnifhTY/J7ugZ9MyAEcnymD+89+S/3Z35g5SIDWruLN2oZPq
 /KE3jhSMbop1+QB+JA9QHpQjgf88wNrcCDBmcE0KB3bYGUYXIZwrJSQ1hM7jRpMTP+KtnDgUx4N
 PBCEJboKFl+38Qm7OuM3ko0IZ7W7n4ZE22o5FHAcMWHQ2VajYKK49Q2SDrnHYUd4ZX7bJ6ec1jl
 NbX+nnObHz5f82TFmZQ==
X-Proofpoint-GUID: jL6n6PvEWuopqzjVdHNyhffD38DaAC80
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030024


On 2/27/26 10:14 PM, Bjorn Helgaas wrote:
> [cc->to powerpc, sparc maintainers for ack]
>
> On Fri, Feb 20, 2026 at 12:32:26PM +0530, Nilay Shroff wrote:
>> Hi,
>>
>> Recent changes [1] which replaced pci_dev::no_64bit_msi with pci_dev::
>> msi_addr_mask inadvertently missed to initialize the pci_dev::msi_addr_mask
>> to the DMA_BIT_MASK(64) on powerpc platform. Due to this, later the
>> validation the programmed MSI address against the msi_addr_mask fails.
>> This causes pci device probe method failures on powerpc platform. We also
>> realized that similar issue could potentially happen on sparc system as
>> well. So this series initializes pci_dev::msi_addr_mask to DMA_BIT_MASK(64)
>> when pci_dev is instantiated for both powerpc and sparc platforms.
>>
>> The first patch in the series fixes this on powerpc platform. The second
>> patch fixes this issue on sparc platform. Please note that as I don't have
>> access to the sparc platform, this patch was only compile tested on the
>> sparc system. Anyone from the community is welcome to test it who has
>> access to the sparc machine.
>>
>> [1] https://lore.kernel.org/all/20260129-pci-msi-addr-mask-v4-0-70da998f2750@iscas.ac.cn/
>>
>> Changes since v1:
>>    - Initialize the pci_dev:msi_addr_mask on sparc platform (Vivian Wang)
>>    - Some minor cosmetic fixes (Bjorn Helgaas)
>>
>> Nilay Shroff (2):
>>    powerpc/pci: Initialize msi_addr_mask for OF-created PCI devices
>>    sparc/pci: Initialize msi_addr_mask for OF-created PCI devices
>>
>>   arch/powerpc/kernel/pci_of_scan.c | 7 +++++++
>>   arch/sparc/kernel/pci.c           | 7 +++++++
>>   2 files changed, 14 insertions(+)
> These fix regressions on powerpc and sparc caused by 386ced19e9a3
> ("PCI/MSI: Convert the boolean no_64bit_msi flag to a DMA address
> mask").
>
> These fixes have been tested by Han Gao (SPARC Enterprise T5220),
> Nathaniel Roach (SPARC T5-2), and Venkat Rao Bagalkote (IBM Power
> System LPAR (pseries)).
>
> It'd be great to have acks from the powerpc and sparc folks so they
Sorry for the delayed response, yes we tested this from our end.
Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>


> could be merged either by Thomas (who merged 386ced19e9a3) or me (via
> PCI tree).
>
> Bjorn
>
