Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F3D1DED49;
	Fri, 20 Feb 2026 07:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771571043; cv=none; b=SkqOx6kEkeZUgcooNiaFdKSYDTcJ6Hr+cu+w6WA4ajQcg9jMfJvzVpH8G3UUl1o7CYWdFJvISV/d3gAzK2bjpaII9fR1JVpHt7drf0npYorFxef6FwUME7hmuQ0BpkMSp0JItEJ+liXlLPd/mfXDLE1ZASdNXE5M5j4GD8s2hfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771571043; c=relaxed/simple;
	bh=Kv3XksPJ6NHHziHuDVuudX0bOypl6n/QVX60IQJHtUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfjqJ5pHwsZBEGX7vlKAIJRCi6+6meMNYMLXX/3fzLzjo5daLVKMU667cZ+JOyTTl/9zjj2ZnqoYhu6ONynlViQkDo3SupjmzXPDKEGfGFWuuLUveVIkZ4GKLTlcUBWsatZ2ZWekqTFeG/DmlmCEHwx+c5A4QiAceR7BffA3inA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AuD196Ul; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AuD196Ul"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JMJGTq1600890;
	Fri, 20 Feb 2026 07:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=iKj+obBcj1FBHYnJN
	AOO1iLn3NccnfZfOynfiA7dLH8=; b=AuD196UloAxY2BjN4fdy5+RqWd/MwpGmQ
	tUiFdN7da1owxERDjhwDy1n0N1S1BWCtutco21a+BaIF0SCcozsURF/gbSOA19gx
	gaHXUELVGavQZRIEa2p9CbduwIoEjNTgzQ7PfKMdo5liMFOH4LUog3PBRgxrTIe7
	ahGRTlrkzOS45vFyr2ay4W/RJL1EdOsEK0mGzn3eZbitYUtDM2Go0yxywHp+CVJs
	VcRyGDT+Ml7bfj8FhhV9VW2p1LYCWkhEvKq/oeiNPl04/PBHkkuXcbGUCX1ct8Ac
	/PPRW1UTGV4w/pv4gW6Ske95hSXbS5x/DqU0biQyX9k7zogdnxX9w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcr9v38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 07:03:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61K3mCXr017834;
	Fri, 20 Feb 2026 07:03:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb28qe2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 07:03:43 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61K73ddo15663446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 07:03:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDD872004F;
	Fri, 20 Feb 2026 07:03:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD0B820040;
	Fri, 20 Feb 2026 07:03:32 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.111.50.5])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Feb 2026 07:03:32 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        sparclinux@vger.kernel.org
Cc: wangruikang@iscas.ac.cn, tglx@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        gjoyce@ibm.com, helgaas@kernel.org, davem@davemloft.net,
        andreas@gaisler.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 2/2] sparc/pci: Initialize msi_addr_mask for OF-created PCI devices
Date: Fri, 20 Feb 2026 12:32:28 +0530
Message-ID: <20260220070239.1693303-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220070239.1693303-1-nilay@linux.ibm.com>
References: <20260220070239.1693303-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: riq29OTHkboI9wIhbfwCmRziwb-TL0_A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDA1NyBTYWx0ZWRfX1AZ9ODp2Xw1U
 ZGg20jL++1MGLUR5Y4+Bni9u5bJ02WJolfT0GuLHCH9nILqYsJTHIzhMbtIlaGPdD7uWnOlPDAc
 IR0xzamtWRm5RK9b5DrwSOvmUadcWZWyzzMfdftWuNA8bKZyMNbMKbPen1XQnr1L/6PEEiUfMDF
 UOeWVaAx5mdgJ9Lk9YLJQ06Anybq83sOXxBBOUfr7lgMjxiaZAMDjOjQ7Ga0wmULBVxW/2+LapC
 1o5Xtl4w5fDmJR3R5zYj3qhvbHzVO3OHJPIajrorQtb7gxBxsD17HP/JjjGg+nkMQA4CoqfREEn
 vQlqtwL8Zno1wjTxx5quKLwjj/Uxmk4k+Yo/KlgXqC1ztwaLGo56zOLOCSou8uWDguoS9qgIgVE
 MPalmYGLg1e0mIPGg4g3UIPN/2cTjGCgIxSiQqJn0WIkMmx5C4aNp3JM8kVN51FwC3LXjp819Bi
 pwXksNoZTFQ26oQKJBA==
X-Authority-Analysis: v=2.4 cv=UPXQ3Sfy c=1 sm=1 tr=0 ts=69980751 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=RIGF2BdnXd3WRmS9KNkA:9
X-Proofpoint-ORIG-GUID: BCJ3jkwagvaprXW1RTF_hHLgLQ7VF1yb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_06,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200057

Recent changes replaced the use of no_64bit_msi with msi_addr_mask,
which is now expected to be initialized to DMA_BIT_MASK(64) during PCI
device setup. On SPARC systems, this initialization was inadvertently
missed for devices instantiated from device tree nodes, leaving
msi_addr_mask unset for OF-created pci_dev instances. As a result,
MSI address validation fails during probe, causing affected devices
to fail initialization.

Initialize pdev->msi_addr_mask to DMA_BIT_MASK(64) in
of_create_pci_dev() so that MSI address validation succeeds and PCI
device probing works as expected.

Fixes: 386ced19e9a3 ("PCI/MSI: Convert the boolean no_64bit_msi flag to a DMA address mask")
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 arch/sparc/kernel/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index b290107170e9..a4815d544781 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -355,6 +355,13 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 	dev->error_state = pci_channel_io_normal;
 	dev->dma_mask = 0xffffffff;
 
+	/*
+	 * Assume 64-bit addresses for MSI initially. Will be changed to 32-bit
+	 * if MSI (rather than MSI-X) capability does not have
+	 * PCI_MSI_FLAGS_64BIT. Can also be overridden by driver.
+	 */
+	dev->msi_addr_mask = DMA_BIT_MASK(64);
+
 	if (of_node_name_eq(node, "pci")) {
 		/* a PCI-PCI bridge */
 		dev->hdr_type = PCI_HEADER_TYPE_BRIDGE;
-- 
2.52.0

