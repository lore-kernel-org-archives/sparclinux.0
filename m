Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325C97261D;
	Wed, 16 Jul 2025 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752629113; cv=none; b=RaVN7a4A9VGfBDMAAK2Dtiwq8Ks4iefY4m53nHy249WhTZrFft+lDPMsFx52OLhmnAZT7Eoz0jTUsSAFXnMIC4qSEnwzYCZrUB5tbmJr3MSoJIJg/esJNkTZAAtZB6GoU2/4MUEtjoTQC0Ob1VrHzmENkXbxm2pa0bLe2JHqbks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752629113; c=relaxed/simple;
	bh=fNYH5pMtNWKpvKWpMlvdLaKcssUmmSi/7ZMHPq2T5rY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d2a8IZMnkG6kqEUKOUA57GEWuMJJPu1AqlRh85gPWvXrVU8yALiWn+PrZekqFQdZLqjWIybqhqLTaM5vCR4apGLXhhcYimkUMiBR7vwkURd+WJRRX/vhhCiEke+yoFTmwMA74bmjiKATO4QzKoqS6kTESZKP17u80m14dBVpMzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LQ9CuMef; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LQ9CuMef"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G0g2fU007593;
	Wed, 16 Jul 2025 01:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=9pFkGwZrwv3zrsYOZFYX82G5YATQY
	p9V1hZbViZxohI=; b=LQ9CuMefiPLCe5Nnfh9oIdbyTgPF9jjk9qpFhYTpvlrxX
	s113/oKiL8Hr1hEMrgo0ELzLHLCqbmjT1xvxiXuuQu+gXLvqk2DYiw/o9yBsLuEI
	BvKvMh+WBzdR1nhFofy/kZcV1qhedFnZviNdwRoluErX07r4+bjiT8kSPrQaDFHz
	K6fzgWnE+hyq8ewLlmIs7Nv+r0bbUdIz57XyGXbO8s6ofqlvQ1Mtr3TXtHYmvIa6
	P5toZL6S1iGch6WmbDB/giEYGDnVJtAnwwrfzAZwYs7vAPuDaAw1G5Z3F58uUc6L
	Z2K/gHGKf95PeZC5pU2O+VPEENHt2W91gJ+xA0y1A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1ayxyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 01:24:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FN4Vep023785;
	Wed, 16 Jul 2025 01:24:47 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ue5aqdnk-1;
	Wed, 16 Jul 2025 01:24:47 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
To: sparclinux@vger.kernel.org, davem@davemloft.net, andreas@gaisler.com
Cc: linux-kernel@vger.kernel.org, agordeev@linux.ibm.com, will@kernel.org,
        ryan.roberts@arm.com, david@redhat.com, osalvador@suse.de
Subject: [PATCH] sparc64: fix hugetlb for sun4u
Date: Tue, 15 Jul 2025 18:24:46 -0700
Message-ID: <20250716012446.10357-1-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_05,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160010
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDAxMCBTYWx0ZWRfX/dJbaMEhiZEH iYF9Cp/Wr2y1pqBW/CEKQh+QgSAaFQQyuKLamF3sapLrAm5oEO77fzgoHUAGTkb8MLWj6wzDO2B 0sS5QETBbo8mNoord5b/lnkV8psyIXDxYRbx4AyTMTwXQKnOw4Wm29qFB5Cbpxh6aTE4t1BU5A/
 VaD6bXGq1AZJ9cEPvGd+L4iNn1YjKbm2xOT0SeOK+KnxePVhu2SW2KNNSy+CqVBy+JlDdBkigqT TGgLpITmg9OqF2appA6Utnuvs4LwxIuPSVUi5MohE4wfG61m3zeY3BTkypBBroZ0OEGza6zAy1K aZLD64ukfew8KNAhDWzdocpaM0YHiP2a/2fuEhF3kcd4u+v+u6NAXCBfHGHDyunh39gWw7ZZJjM
 OKAUdwvXOOcVQZEwmhJ0yLZNbE8sAlhthH9w15U3jwh9GvmG+JwemTyC29Xkn2sAdHmSJ02z
X-Proofpoint-GUID: V4RX_4Vjx0g3FDs0KBN9CyOaPwa6SOGy
X-Proofpoint-ORIG-GUID: V4RX_4Vjx0g3FDs0KBN9CyOaPwa6SOGy
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=6876ff60 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=IECoiChgz6jwblPjvF0A:9

An attempt to exercise sparc hugetlb code in a sun4u-based guest
running under qemu results in the guest hanging due to being stuck
in a trap loop. This is due to invalid hugetlb TTEs being installed
that do not have the expected _PAGE_PMD_HUGE and page size bits set.
Although the breakage has gone apparently unnoticed for several years,
fix it now so there is the option to exercise sparc hugetlb code under
qemu. This can be useful because sun4v support in qemu does not support
linux guests currently and sun4v-based hardware resources may not be
readily available.

Fix tested with a 6.15.2 and 6.16-rc6 kernels by running libhugetlbfs
tests on a qemu guest running Debian 13.

Fixes: c7d9f77d33a7 ("sparc64: Multi-page size support")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/sparc/mm/hugetlbpage.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 80504148d8a5..2048b5c42ca8 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -22,6 +22,26 @@
 
 static pte_t sun4u_hugepage_shift_to_tte(pte_t entry, unsigned int shift)
 {
+	unsigned long hugepage_size = _PAGE_SZ4MB_4U;
+
+	pte_val(entry) = pte_val(entry) & ~_PAGE_SZALL_4U;
+
+	switch (shift) {
+	case HPAGE_256MB_SHIFT:
+		hugepage_size = _PAGE_SZ256MB_4U;
+		pte_val(entry) |= _PAGE_PMD_HUGE;
+		break;
+	case HPAGE_SHIFT:
+		pte_val(entry) |= _PAGE_PMD_HUGE;
+		break;
+	case HPAGE_64K_SHIFT:
+		hugepage_size = _PAGE_SZ64K_4U;
+		break;
+	default:
+		WARN_ONCE(1, "unsupported hugepage shift=%u\n", shift);
+	}
+
+	pte_val(entry) = pte_val(entry) | hugepage_size;
 	return entry;
 }
 
-- 
2.47.1

