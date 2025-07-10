Received: from outbound.pv.icloud.com (p-west1-cluster1-host10-snip4-2.eps.apple.com [57.103.64.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987042641F3
	for <sparclinux@vger.kernel.org>; Thu, 10 Jul 2025 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148658; cv=none; b=fTNSUL0dd7ILlRir4VyvnB3OZh/6g0x0JnLpNodDcw93957F4MsXaXiBR2IANdTXYgiuAgu4/z7LAou2JFt8q2FWMtzOnVSjxjF3STypybEoWT5QyHPwu2Ppks2gMjSQmvKhD/hce0pSd/B5fOpIAClbD48yCYgGiThyhAGsnnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148658; c=relaxed/simple;
	bh=HOk5fiqeXIR/ipCrBr2Il/m2vT6iGRMi0m6ERmiMgUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O+pfF3Ct9xw+JOndILYOnzs+43ciU/v8s0pHEgqsIB++vMnuoV7bNDJIhvzzCMLTvtFCFqQOfUFhvgvEBq7f90p/fqMMppP55qYcWiwVKt3ypeeXUVpjuD6YBDqW3GxOQClfNOyTnKqHAetpnj5Kkv2pSaKb02iJxD40JpLhsvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=1Ouyf+9q; arc=none smtp.client-ip=57.103.64.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="1Ouyf+9q"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 5D11A18000BD;
	Thu, 10 Jul 2025 11:57:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=wzi47B2ICOPWnlLyd3+COp0dbO4Ufhz2sX65uYDk28c=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=1Ouyf+9qMta8zMLa8nxK0mSXFKBdr5uK1LEIk2cqgsbgJqcbI7EuQHTC/huuqdAJZoBYO6lUil4qz23pOmWoEZFTve3XmBSVuRdsxvP/HkhQDuwYskeWCvF68TLieshwudI/Ne7NK2102jZvXfxO8wFJEXRyFnC0vh+VjzGibS04YN3yj8SrFtYofduMoDJ5DrOEoR5e1yhUUpKzKgWb6mUWr9imOKnqW8U4WJW8qlv9UoFT518Z11kLjiSJg5ORxEaGAYhwe5DhCg02WKBfFDU5Oc2ZCSbdylXKLVWl6vi81lcPcsXm9lr1cPjaq6LGOFG0hqa7t9Ny7i9riPdn7g==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id B40571800183;
	Thu, 10 Jul 2025 11:57:29 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 10 Jul 2025 19:56:49 +0800
Subject: [PATCH v5 6/8] char: misc: Does not request module for miscdevice
 with dynamic minor
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-rfc_miscdev-v5-6-b3940297db16@oss.qualcomm.com>
References: <20250710-rfc_miscdev-v5-0-b3940297db16@oss.qualcomm.com>
In-Reply-To: <20250710-rfc_miscdev-v5-0-b3940297db16@oss.qualcomm.com>
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
X-Proofpoint-GUID: mfPvsMVAFl5zvf331vs_2f3_yB7d2odV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwMiBTYWx0ZWRfXzBJEaWLz++gt
 9QQz06Oydn2KJ8I8/KEdXftPQsg3hyGto30fGFh7oCc0N5crfUHkK3GaHga3gC6ANy1gSvaiWwH
 lJSwWiIZubUZcpVTENFx4bwjbvkY84nKwMfPevc8U2O8pvvLsBxCoxR4QoFMKI+5CY5lf4nZUdL
 YtYNJvrztnqAD5n1CVM5yYNjxoRFGlKIOk+kVvc/fCzwZk7vTEhwAD0gpbWl/xsIDI3PbBsVcBY
 xFrToaWGNDcCkCjOZIj8V0YzQQUEfp/IqJlb/xjNPWC6Q4TOQJBRPbLw9RHji5mtFNERHSMfE=
X-Proofpoint-ORIG-GUID: mfPvsMVAFl5zvf331vs_2f3_yB7d2odV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507100102

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

misc_open() may request module for miscdevice with dynamic minor, which
is meaningless since:

- The dynamic minor allocated is unknown in advance without registering
  miscdevice firstly.
- Macro MODULE_ALIAS_MISCDEV() is not applicable for dynamic minor.

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

