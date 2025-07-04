Received: from outbound.pv.icloud.com (p-west1-cluster2-host1-snip4-1.eps.apple.com [57.103.64.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ACB3074A3
	for <sparclinux@vger.kernel.org>; Fri,  4 Jul 2025 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635728; cv=none; b=m0gwLErJkC7i9t2piEMFeUbfoFeWV6gDW5kvVcW5Ivuzhy+QYp1r/Cavm8nTd88c5YjoWXsGvpd8sk/WXWn/o3qvCQ3BwOpsUagTCmKU6DtNLk0GBrNXlrA136HyT08LYsjDIGI/OdmFtRGMXqPtA1lpErz/vN3CoNEKbV7KYXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635728; c=relaxed/simple;
	bh=ldfknhlwCWcuoUqnJHEhTy4XSxhklb2aadv2s6gqlmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H0dhcOKnPQ4LaEnSd4D8ofE7yzfrZ7J7Zz6nwxnYOhkfwapxadoB6xh8FOTOeyzP/2yX9Ahu/f8Pw6vSgMlq9dG2/V8PpOw4MfqPv05mvP9DU4gIiQWRb3IGu57oumv5999x08AkLjVckPNavQYpdU2vd+B/YkicaIAzAbHy95o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=KEfVUV4w; arc=none smtp.client-ip=57.103.64.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="KEfVUV4w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=3z8k8G78hPHpRDrth8Hd7u7gyNsHougHo2QTHX0bCyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=KEfVUV4wFWYZ06waF2k9DVQxSBJDlG+o7H48wj5NLvmVlb9m4ZQ4IEJ1u+47j21Gq
	 Pvueijv8a1P9oKVa+EFS5aCAFOsiEpmO4hylHpMghUti70UaG3sBfbbZsPa9xFzlBK
	 x+9PBGqoeAdxqx4tSozJbUO0NtilNjtjEEerOZkntWuS00FnoTLZExx89v3tE+iRrz
	 7Umkp1l1izQXV/Sy/TtuUu2Kt0MACSnO6yBOHqr3apE9kOVpqrwVEXY6GVX2r2gPEt
	 KWgNXMRBC6FQAAkl2o3NqnJC3b+OlMlr9pzSDU+GbE6BTVAAm+6UIs4UW3JPDy9PzL
	 c26ZqXsb3GAfg==
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id A5E2A18028EC;
	Fri,  4 Jul 2025 13:28:41 +0000 (UTC)
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 7603018034B5;
	Fri,  4 Jul 2025 13:26:33 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 04 Jul 2025 21:26:04 +0800
Subject: [PATCH v4 6/8] char: misc: Does not request module for miscdevice
 with dynamic minor
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-rfc_miscdev-v4-6-b48986112d6a@oss.qualcomm.com>
References: <20250704-rfc_miscdev-v4-0-b48986112d6a@oss.qualcomm.com>
In-Reply-To: <20250704-rfc_miscdev-v4-0-b48986112d6a@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwMyBTYWx0ZWRfXw2OdTwNdYEXV
 6GGv3S9qMhktRTOoIhOAoFs2LwLkkFRCc0hQIP8eDcSQLhTTztES5zRPDYV4pwtc6YTICXRGTHd
 ezoFngALQzYmfF5iqQxGMk0qJ5sWsawJG/Ot/hs/Pz5acSkntSTdA/yKAtWxqfoSwMxqVUuvhFD
 7hM8+Ksdv25j+FF+6h8NErZjpKXKFO2T9wYTWzICUdK4N/504Ff2Y6pyTKSBbYWwxrCvaiuWmfB
 ksXjyjNV72R9I08TrVRK1AFbr28MVkYpgbcohZO96OCOckvML8b5RaobGUn/ETUIwEnL2K3h8=
X-Proofpoint-GUID: CA8Q0r3CiIl2M-NDR4mbCu2ueG6UYIIo
X-Proofpoint-ORIG-GUID: CA8Q0r3CiIl2M-NDR4mbCu2ueG6UYIIo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506060001 definitions=main-2507040103

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

