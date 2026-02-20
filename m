Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0B61C8634;
	Fri, 20 Feb 2026 07:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771571026; cv=none; b=GYVzaNWHzW3+MJS2qOClUnj9W9cohjUeQsLHX0SC1IqzS4l7tzAkNZzw7ZlP10L97J7Hct22QwALyKrusd7yoMWrHoat5D48Y4jqJaC3al02MXQDIbvGZsASXpbR6uGEfBvUgahcUDEilg5ez1KsnxCa4CcIkOtlxVpnbc3IwO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771571026; c=relaxed/simple;
	bh=7AKtcJ++k7iaMQALzEYqhMDotKYXkyBS4Q5UD4yEGzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRqYaqgntdpa6Wt1rW5qInrVdJBKzIhgCFQOJxqYG1kOTyyBCByTMLSVhDYqjlIQvmrwJSmYmAmBqxeFKvQRR7PpWT6PqEFcKvLn6NJd5OBHNj8+g23MF0IqVo55QiMif9dtbMtT4STwovGLbqE2rsE6U7PPlXWHPPENybTsj0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DmYvcoGV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DmYvcoGV"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JL2IiC1271978;
	Fri, 20 Feb 2026 07:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qh/tU/MZFf3M49yhR
	L/30gCp50nIHWpWmLfk6IS/TOU=; b=DmYvcoGVTjCxODIlXK9yH9IT5M7VxNgum
	pln9GvcQwObk9g/PH8M4cFimo4znD/IVgryqAxuEFg4tmOHWvNUZaeAaPJVFeX7w
	MvXnp1H89sc4u+0TDc6Y5uwjC0CiASdBitX1/oTYcMcD4RoHSgazW6+1Q+ybx3HJ
	Qp8KiShsRPkvHPLaLmIRNJ3N+tozJjr/mVkdHlAU+Ih46Fa1NfM2PYIE7R7/pw5q
	0cAA4kX0erUJwrHoIkxn1yV8zO58yMrU0bQziXY/p6rGZI4CSZva2rushrd/6Yx2
	9Lx6u6n+yg3DZaoiIghqFetFMfBqxoxVVK1g4SXurUGYn7dL+rz3Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4krcp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 07:03:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61K47GB5015660;
	Fri, 20 Feb 2026 07:03:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb45fe45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 07:03:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61K73Oqt53674332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 07:03:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EEFE20040;
	Fri, 20 Feb 2026 07:03:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD96D2004F;
	Fri, 20 Feb 2026 07:03:17 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.111.50.5])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Feb 2026 07:03:17 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        sparclinux@vger.kernel.org
Cc: wangruikang@iscas.ac.cn, tglx@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        gjoyce@ibm.com, helgaas@kernel.org, davem@davemloft.net,
        andreas@gaisler.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 1/2] powerpc/pci: Initialize msi_addr_mask for OF-created PCI devices
Date: Fri, 20 Feb 2026 12:32:27 +0530
Message-ID: <20260220070239.1693303-2-nilay@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDA1NyBTYWx0ZWRfXyNykNqAH2PD/
 WSO32hWruXpQsE50KZzzCs5jVn9/OuEYgzF+zcyn2SMKucbK+HL3EYeUjMtZZFBB6vUiV8mKRpn
 4FfW8DCfcbewMRMx/ZZbIzkCjz2AOmwj5p5/pg1p4zx/WZwtCDsoZ+1n8N7okGsbOZMn3YW2a1R
 EWn6VF40CQ3hLHcvYmVffaPp11fLQWk8EBcGdH9bO673B0+cZFJU3axrZGOMPuomQ2PBmhMgaCT
 4gHC0hEWNUaqpGknHbCu44hsSpA2V2WY0C+1wjrFCpuqtU3FLn48haT5O3vFvcMaMbJOjRWn//p
 v3Lpm4j3kUjyJKoJGcOqiaby308Nxz0iij7knRyTKrT3HpIKFQ/sWDkrgqX4DdsH4W1HeYa4LOI
 apOL+1JqPGg/S78T0ZTDpBq8un6X47+zfbNAul8hgbKlREuO2MDXO8dJztzeRE54q2cIIB1zCN6
 ydzDRwiLSJaJXvUjnGw==
X-Proofpoint-ORIG-GUID: -wdMrEXSFM9LlZlqbt9F4ubvpWCjZcDl
X-Proofpoint-GUID: 2yG9sGPkm4-8BCPkTz5SEspAZ8F06hr1
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=69980741 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=z8HJdAPGTyh_JiJlT3QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_06,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200057

Recent changes replaced the use of no_64bit_msi with msi_addr_mask.
As a result, msi_addr_mask is now expected to be initialized to
DMA_BIT_MASK(64) when a pci_dev is set up. However, this initialization
was missed on powerpc due to differences in the device initialization
path compared to other (x86) architecture. Due to this, now PCI device
probe method fails on powerpc system.

On powerpc systems, struct pci_dev instances are created from device
tree nodes via of_create_pci_dev(). Because msi_addr_mask was not
initialized there, it remained zero. Later, during MSI setup,
msi_verify_entries() validates the programmed MSI address against
pdev->msi_addr_mask. Since the mask was not set correctly, the
validation fails, causing PCI driver probe failures for devices on
powerpc systems.

Initialize pdev->msi_addr_mask to DMA_BIT_MASK(64) in
of_create_pci_dev() so that MSI address validation succeeds and device
probe works as expected.

Fixes: 386ced19e9a3 ("PCI/MSI: Convert the boolean no_64bit_msi flag to a DMA address mask")
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 arch/powerpc/kernel/pci_of_scan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 756043dd06e9..fb9fbf0d1796 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -212,6 +212,13 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
 	dev->error_state = pci_channel_io_normal;
 	dev->dma_mask = 0xffffffff;
 
+	/*
+	 * Assume 64-bit addresses for MSI initially. Will be changed to 32-bit
+	 * if MSI (rather than MSI-X) capability does not have
+	 * PCI_MSI_FLAGS_64BIT. Can also be overridden by driver.
+	 */
+	dev->msi_addr_mask = DMA_BIT_MASK(64);
+
 	/* Early fixups, before probing the BARs */
 	pci_fixup_device(pci_fixup_early, dev);
 
-- 
2.52.0

