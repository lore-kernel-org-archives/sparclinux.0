Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79461C8634;
	Fri, 20 Feb 2026 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771571014; cv=none; b=u0n48akUrJ8tU3AKN4HkpPFQ7AnRVmHSjIaSD7ojHWoU9y1opzsvW6Sn1nnu/kb04C52Ip9tsLLEUv+BeFAtE1GpHx17jY+57zWfbyKM9LPqvUF3eRddgBxg6QzeXWB5YQtpmuol09uAPxC3wZI+nsKlkhUiFcgDpnzxg+Zqex0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771571014; c=relaxed/simple;
	bh=jL5p0OPc8gviXf9v5QGhYVE4y+gL/CoY/yp+M8RTbZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b0old+8i5J5xLuutYA60YkzB6nsQRyIiIAJ98d9fWf2vUCPKMabKXmhGywZeBHcJjvkP2AUAgS21JAF8ohz9/Mk15+6yGGos6Uo5bm1D25hRtdLNzRlDt2IV1dst7V9/sHUD/PHs03Al5GVsBBGP3tvd9EXlz3N1r1wGWft3WeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e8718+gp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e8718+gp"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JMM23c1271197;
	Fri, 20 Feb 2026 07:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=9ZQ/AXgj3qXjXBXbOZFZ/gpXw6vzsJvSBlTkhasAW
	/g=; b=e8718+gpueMX9S6BRPxwFi87lndujXYrijNBx6dwxBs4Q1/Y3sfuuot/B
	PJt2nt2eQRalwNpZPF17NinZGtJKvjnrWQoTUREw/5tqh/po0XJPMqoRb17hYbwi
	QNuiMtI5AeuAiL3l0SOLiUs/AVFvYC9MgmNegJ8TRMoc1qkC5aDMDG/fbONb2mGX
	KdJyVs2cA2DMRLnVpWFFdf9sz5YSIFjz9yGS8xZDFh4WZ9WV9Y2iZAYu+swLE3w5
	8v7xvu06KMm3qqgwceT0BpShtawQ8dLtkqPhiWTJPBnjZNef58JGbvRxAd5ekoys
	4EQ0BeWVRNB9oNCp97qrSEalXNVcA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4krcnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 07:03:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61K3wkL5001391;
	Fri, 20 Feb 2026 07:03:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb2bqegs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 07:03:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61K737xo45941126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 07:03:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFF5C20043;
	Fri, 20 Feb 2026 07:03:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F83C20040;
	Fri, 20 Feb 2026 07:03:01 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.111.50.5])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Feb 2026 07:03:00 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        sparclinux@vger.kernel.org
Cc: wangruikang@iscas.ac.cn, tglx@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        gjoyce@ibm.com, helgaas@kernel.org, davem@davemloft.net,
        andreas@gaisler.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 0/2] pci: fix msi_addr_mask on powerpc and sparc systems
Date: Fri, 20 Feb 2026 12:32:26 +0530
Message-ID: <20260220070239.1693303-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDA1NyBTYWx0ZWRfX8SfcUII9E4v6
 wE5oK4sWy8Psfc3YqT6yGi8NBBTjlv5ggn5RYccGrOAec+BtxMb1CxNlDfwhjwf+TUx/JMgLFfd
 zE0lW+yyPGSgEMmm8+xMTrkUX1zu6ruKCAlIVcqcoDSOmb/dARJRjbw7E2R6KGR2GB+CkE7EPGq
 pQlImzrf07rxNV2vdfMuVeL0YTaIya82DHyx/SjeKiLs/PlNW/niCtVtPZDKgO3CwRl6w55jDbs
 KiuVJxajLXUxFx381VirV7aloID/Z5fdBphZNeuj+OO3djqJqsMjjwrZM49c9KjQx83vEfeu/5t
 CXn7kBIS7gmXrfT08I1Bj7PHLv/2nWy9ZwI+7bIudBnPeazE2QyrsorCHShGahwPUwScSNpE7nR
 yAiImPP0oa1edkOekuvf7MvTY/2dxT+cN0tmEBl1heOxfILUFZdKTvsKPZogT3nGD8BEFCzSwBb
 kj9amcEeKlNQfYwm1jA==
X-Proofpoint-ORIG-GUID: JRidqch_C7uYEkMP_xY2JTPdFE77Mj7k
X-Proofpoint-GUID: 31nQogI8sxKE3Phs7mGlsZbfAqExsNAg
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=69980730 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=PpxxDPt2hjBrRrFdXa0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_06,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200057

Hi,

Recent changes [1] which replaced pci_dev::no_64bit_msi with pci_dev::
msi_addr_mask inadvertently missed to initialize the pci_dev::msi_addr_mask
to the DMA_BIT_MASK(64) on powerpc platform. Due to this, later the 
validation the programmed MSI address against the msi_addr_mask fails.
This causes pci device probe method failures on powerpc platform. We also
realized that similar issue could potentially happen on sparc system as
well. So this series initializes pci_dev::msi_addr_mask to DMA_BIT_MASK(64)
when pci_dev is instantiated for both powerpc and sparc platforms.

The first patch in the series fixes this on powerpc platform. The second
patch fixes this issue on sparc platform. Please note that as I don't have
access to the sparc platform, this patch was only compile tested on the
sparc system. Anyone from the community is welcome to test it who has
access to the sparc machine.

[1] https://lore.kernel.org/all/20260129-pci-msi-addr-mask-v4-0-70da998f2750@iscas.ac.cn/

Changes since v1:
  - Initialize the pci_dev:msi_addr_mask on sparc platform (Vivian Wang)
  - Some minor cosmetic fixes (Bjorn Helgaas)

Nilay Shroff (2):
  powerpc/pci: Initialize msi_addr_mask for OF-created PCI devices
  sparc/pci: Initialize msi_addr_mask for OF-created PCI devices

 arch/powerpc/kernel/pci_of_scan.c | 7 +++++++
 arch/sparc/kernel/pci.c           | 7 +++++++
 2 files changed, 14 insertions(+)

-- 
2.52.0

