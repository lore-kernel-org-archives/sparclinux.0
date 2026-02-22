Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9508F139D0A;
	Sun, 22 Feb 2026 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771757241; cv=none; b=RhrsB5LepK/0stKm1XvQkTUf6B8g9UEEo9IPHpwvAj+EVntYid8Uhqw9AUiaO66WE2iljuMSU7jmIEDm8TPU1jk+3rAnIkWQztIgYv+kSNnYMR35kSYmAMQynbiHNlSwSnKgsshFhbVBOj7vN2jNXTEvy/omEVUQZu2rUiJZlnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771757241; c=relaxed/simple;
	bh=nqlRcXiOrgmmh1J1IG/5ShuAhnerofiLI85Nvxw+sno=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=oqUgMmuYh1paGdYZtVt7p751hIGpVgah3NEKo9/0cBaIfjb69aKlzCRrx7lasud10i3iPqMIpvStzxOhCpB99xHJ9lYq4bSmuxe5uHmkcImcxojEjvkD9mjKOPAKVy/bUsC+MiJP8XKDxCEj2PmrxOxTSXa2DwOGNtig/VV3vLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GXDYPCZR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GXDYPCZR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61M9Q4sP1191295;
	Sun, 22 Feb 2026 10:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LJp35H
	GeCC/QoZ+G2FrR1PRICT1zOYfUStWUZU0Gvl8=; b=GXDYPCZRgslkc831myUoFU
	t/ldie2IsErQF/gwOzZU6nSIwVgOANXgX+cTlGABk6v3eHaEXO488ui5FOuThUO8
	eo6lx9bDJM5gsLXtZ051OFDDDoN/ZktY3rdbjjh5oMN7D5t3QJ6H2xSC2ViuCRTr
	57eV7uSrgb3X30PTiXNtFlAfubhwEiYkCgLFoXtT81PccLGlMEpYRlUtnydP1/dh
	buYYxmcVPL4AdeLfSVuR/KAYgJOwAgeobmWhNhvvot6zjjAMlAx0BfvPHKvS+e4M
	SX4xTnIJQCPi5QKR7sEsSWH8GOmkMcvy6maZ2BUXsVT1UhxMaj3tq9VMsTJuw7eQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4cqkqe4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Feb 2026 10:46:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61MAjilI027887;
	Sun, 22 Feb 2026 10:46:58 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr1gvc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Feb 2026 10:46:58 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61MAkvsN24707728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Feb 2026 10:46:57 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 329A258051;
	Sun, 22 Feb 2026 10:46:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17DC75805A;
	Sun, 22 Feb 2026 10:46:53 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.255.192])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 22 Feb 2026 10:46:52 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCHv2 1/2] powerpc/pci: Initialize msi_addr_mask for
 OF-created PCI devices
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20260220070239.1693303-2-nilay@linux.ibm.com>
Date: Sun, 22 Feb 2026 16:16:40 +0530
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        sparclinux@vger.kernel.org, wangruikang@iscas.ac.cn, tglx@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, gjoyce@ibm.com, helgaas@kernel.org,
        davem@davemloft.net, andreas@gaisler.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A2FC12D-E147-4402-A464-A1D0ED97C496@linux.ibm.com>
References: <20260220070239.1693303-1-nilay@linux.ibm.com>
 <20260220070239.1693303-2-nilay@linux.ibm.com>
To: Nilay Shroff <nilay@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: fsPTYuw7lnrajAeKRj1GB09fuZq9Hn5k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDEwMSBTYWx0ZWRfX96ZSZwe33ZMC
 4PwrAP7XZo7ci6m9gME3EEKt5f0a+6qq05moVG5yLMut6ppjD51n8n3r/9rKtswcm6VErQKthdH
 Sm3uLMzLf9Qj0k+jBvJmvSS4si6bMi8ZADVeWcV1iL4P7M9zh2fb5kohtoE6Wd7wqPwDG622c1y
 TvaEqzdJUE2GrCxn0awiip69IZfd20rFcLfI2ieG5Bj427ayUnPldiR4TeChgoOGtkncf5nhm9j
 w5XoCOcjfWySqMEfeYSOK0RLsfeC0JuqgnUk7STvZJtiYgUFsJYrVZWYil1+3qIAOguG43cb6yu
 Bx75K0oJUJnTM0LtHKU9wPZeYaNE2cHuAtj6KDYVqbVoA5l7o+l8/z+tcv2EeHl9UHIt4TsvzVv
 E9QsABsYMmLDh/KdqL5fO0w3XQr7+mIX5GHkPQv/D8UAb5XTXUphQcPY8IKHGCzWz/KcVQTQzlQ
 t1twN1waniegAkByLuw==
X-Proofpoint-GUID: KR_JaLaFKumuIt6V_5WTf90MDqskkmrN
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=699adea3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=Lv3gO9uK54Osj9JKH68A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602220101



> On 20 Feb 2026, at 12:32=E2=80=AFPM, Nilay Shroff =
<nilay@linux.ibm.com> wrote:
>=20
> Recent changes replaced the use of no_64bit_msi with msi_addr_mask.
> As a result, msi_addr_mask is now expected to be initialized to
> DMA_BIT_MASK(64) when a pci_dev is set up. However, this =
initialization
> was missed on powerpc due to differences in the device initialization
> path compared to other (x86) architecture. Due to this, now PCI device
> probe method fails on powerpc system.
>=20
> On powerpc systems, struct pci_dev instances are created from device
> tree nodes via of_create_pci_dev(). Because msi_addr_mask was not
> initialized there, it remained zero. Later, during MSI setup,
> msi_verify_entries() validates the programmed MSI address agains
> pdev->msi_addr_mask. Since the mask was not set correctly, the
> validation fails, causing PCI driver probe failures for devices on
> powerpc systems.
>=20
> Initialize pdev->msi_addr_mask to DMA_BIT_MASK(64) in
> of_create_pci_dev() so that MSI address validation succeeds and device
> probe works as expected.
>=20
> Fixes: 386ced19e9a3 ("PCI/MSI: Convert the boolean no_64bit_msi flag =
to a DMA address mask")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
> arch/powerpc/kernel/pci_of_scan.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/powerpc/kernel/pci_of_scan.c =
b/arch/powerpc/kernel/pci_of_scan.c
> index 756043dd06e9..fb9fbf0d1796 100644
> --- a/arch/powerpc/kernel/pci_of_scan.c
> +++ b/arch/powerpc/kernel/pci_of_scan.c
> @@ -212,6 +212,13 @@ struct pci_dev *of_create_pci_dev(struct =
device_node *node,
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
> /* Early fixups, before probing the BARs */
> pci_fixup_device(pci_fixup_early, dev);
>=20
> --=20
> 2.52.0
>=20

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Tested on an IBM Power System LPAR (pseries).

On an unpatched kernel, all LPFC functions failed MSI/MSI-X setup with:

[    0.175139] Running MSI bitmap self-tests ...
[    1.521630] lpfc 0152:60:00.0: arch assigned 64-bit MSI address =
0xffff3840 above device MSI address mask 0x0
[    1.536203] lpfc 0152:60:00.0: arch assigned 64-bit MSI address =
0xffff3a00 above device MSI address mask 0x0
[    1.536318] lpfc 0152:60:00.0: 14: [    1.521874] 0:0484 PCI enable =
MSI-X failed (-5)
[    1.536321] lpfc 0152:60:00.0: 15: [    1.536251] 0:0488 PCI enable =
MSI mode failed (-5)

After applying this patch, lpfc driver probe completes successfully and
MSI/MSI-X setup works normally.

[    0.206925] Running MSI bitmap self-tests ...
[    3.040737] lpfc 0152:60:00.1: 1:3238 Reducing IO channels to match =
number of MSI-X vectors, requested 32 got 2
[    4.162067] lpfc 0152:60:00.2: 2:3238 Reducing IO channels to match =
number of MSI-X vectors, requested 32 got 1
[    5.270672] lpfc 0152:60:00.3: 3:3238 Reducing IO channels to match =
number of MSI-X vectors, requested 32 got 1

Regards,
Venkat.=
