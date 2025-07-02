Received: from outbound.pv.icloud.com (p-west1-cluster3-host4-snip4-3.eps.apple.com [57.103.66.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF84277CBC
	for <sparclinux@vger.kernel.org>; Wed,  2 Jul 2025 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751458588; cv=none; b=MXwnPnJeM5ZBkITmdyvvJZJ1clWEHTgeKw7ynnvwvoEKJNxCKQkKblp3qaASpJFxKVX+D5kvGxeaHlSe0ENNvlZWDdf9fELsHO9qpatyPV7KE77z5/FPrZMIfFfNyh0mqw7ne+gdf2YlUMADr8pluS/AsLuMPfw/Nq7n7JgKLTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751458588; c=relaxed/simple;
	bh=ldfknhlwCWcuoUqnJHEhTy4XSxhklb2aadv2s6gqlmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hDlRFeWdUi9iBBnAV9zTr5VNAdelQklntxTPmpBmZoB8nr+hlj2E4m9lOUilU0wB2I1CR94TQokdWvOn6ncs90+leU0klOJP6W7pK7d+Z2qSkJeMlTlNAJUfBm25BB4+GuZHzP0on1Ca/MDsSc1hy0C8uAFfaLFToHTKr9OhAN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=uCPn6t8d; arc=none smtp.client-ip=57.103.66.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="uCPn6t8d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=3z8k8G78hPHpRDrth8Hd7u7gyNsHougHo2QTHX0bCyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=uCPn6t8dH+nJ2w8xcUqRBexV693iW1umxuiEwZAIeoiCaPrcS/YPCkCqzfs+vniaO
	 jkH75jpirK/7/Y3SzmwTIFCbL/EkSz2dUq0CN3D4aLlrHsEB27yFcaRyx5QuvBYh4i
	 K7EDkWgt4UT5HQCIQIpkUM4XT23Smd18/JoXCTELBaLbh+R9FD7q9eAgRl9iLC5l5E
	 zSi5pZkiPNgHH82rpPEAv5bDt01D63iY2qCO4KF2k4L365fHQazaTF0MjKlu3mqgff
	 VMGHQcgS6p569HROzibgrouK6E/zxRquCg+nEjwcvyje36R60Jfx5tbePV5rEk/85O
	 EvmAIhlVtVbTg==
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id A3FBA180033C;
	Wed,  2 Jul 2025 12:16:23 +0000 (UTC)
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id CE22518001DF;
	Wed,  2 Jul 2025 12:16:20 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 02 Jul 2025 20:15:34 +0800
Subject: [PATCH v3 6/8] char: misc: Does not request module for miscdevice
 with dynamic minor
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-rfc_miscdev-v3-6-d8925de7893d@oss.qualcomm.com>
References: <20250702-rfc_miscdev-v3-0-d8925de7893d@oss.qualcomm.com>
In-Reply-To: <20250702-rfc_miscdev-v3-0-d8925de7893d@oss.qualcomm.com>
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, 
 Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, 
 Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA5OSBTYWx0ZWRfX/ml6G1yRNkgO
 +mG5JCm5LnBqWM2VgFHHJ8PQp3gGVWaLxTNJPoV5WJSKuQzW5dx5qU79BAgPVolPq5Qrvc+uzFp
 BJiF8zxuOyJnqcW+L9655kUP6OdLjNFPFbalj4gdzCFwelviBF7kN2CvhufcYrJORZckCRoZjR1
 1JO+rfnxui6FbrqBhLN18h1B0ztgq6sPbpnQLawl+rnUFUC4hEeJQnS4p3S50GQGQvKGSNzSmmu
 0zr6aj4iVbSbLmawaDFrwx+yP4ymvEF0euRESGOFEy4ZcRwtOk6s5OG4QiXAKSUMuq8iRWxco=
X-Proofpoint-GUID: MVRitIxVaY9TnE3NU4-gXT4plGDtZak7
X-Proofpoint-ORIG-GUID: MVRitIxVaY9TnE3NU4-gXT4plGDtZak7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507020099

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

misc_open() may request module for miscdevice with dynamic minor
which is meaningless since macro MODULE_ALIAS_MISCDEV() is not
applicable for dynamic minor.

Fix by only requesting module for miscdevice with fixed minor.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/char/misc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 96ed343cf5c8509a09855020049a9af82a3ede95..a0aae0fc792666a7bdc0ba00da9dc02ff9cead42 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -132,7 +132,8 @@ static int misc_open(struct inode *inode, struct file *file)
 		break;
 	}
 
-	if (!new_fops) {
+	/* Only request module for fixed minor code */
+	if (!new_fops && minor < MISC_DYNAMIC_MINOR) {
 		mutex_unlock(&misc_mtx);
 		request_module("char-major-%d-%d", MISC_MAJOR, minor);
 		mutex_lock(&misc_mtx);
@@ -144,10 +145,11 @@ static int misc_open(struct inode *inode, struct file *file)
 			new_fops = fops_get(iter->fops);
 			break;
 		}
-		if (!new_fops)
-			goto fail;
 	}
 
+	if (!new_fops)
+		goto fail;
+
 	/*
 	 * Place the miscdevice in the file's
 	 * private_data so it can be used by the

-- 
2.34.1

