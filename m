Received: from outbound.pv.icloud.com (p-west1-cluster3-host7-snip4-10.eps.apple.com [57.103.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFAA27F728
	for <sparclinux@vger.kernel.org>; Tue,  1 Jul 2025 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383559; cv=none; b=hiw4jbTWO7laF3QMOEo+uZ43stvx+NsB3NQ/9QarSr5V4GPmY8Kmnp1Car0Mzs6NacNCnjt6upgnTOe/JWeqBx6WRleq/prAB24VOOPF6dja8SXWO7ehzVXe4B+0UFxjzXQdGoxZcUGovcwc2I1PsGrdNvoqiF5MLkEn+HidfLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383559; c=relaxed/simple;
	bh=ldfknhlwCWcuoUqnJHEhTy4XSxhklb2aadv2s6gqlmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nijtziGQcUC3dA88icYW0b+Vsss/9fG1PGOs0kgtEXUalPwBakhSrITOMlk0l1Ef2/WGobtY+WsMwAb0FsC+5sGlB6asOSwKek/BK/2sLqgDrzaV9NkzOgo78lxDUEPbyTmoXdoUh7VwbCuuspzR1weReJ3jQUTXWaTlG29ZWvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=U50z4BCc; arc=none smtp.client-ip=57.103.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="U50z4BCc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=3z8k8G78hPHpRDrth8Hd7u7gyNsHougHo2QTHX0bCyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=U50z4BCceGbr57nYxCx/TXgmK4gUuvaB73raF7eLDF0toGwrnCEMq/n4mGOFJAMaQ
	 MGCHUQAI8LD70X/hzrf3lBScxK5+Khaq2TrJzflHzlv4cu03B+Jkd3MAHcMVN4NTyI
	 3CDQ+9H3zsUoSYyNnqzWqBcR1gRKBWfJ228PNJPM1hJASNv+ouKlt/VteVFUtoOOWb
	 f9XVCHgxKINtVgHKWcZRuYTQWBG3uXNsOWrrZlTx6SJmHkSJZPA+1RRsOp5b2WnLcm
	 K6g5/TYTdYSGWsvWtyYybbi1dngkoSU5HW4oRIEUKaNryuE3t+821jVsycItdTq0j4
	 DkFDMrqtcxYdA==
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 507391800159;
	Tue,  1 Jul 2025 15:25:54 +0000 (UTC)
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 9355A1800171;
	Tue,  1 Jul 2025 15:25:49 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 01 Jul 2025 23:24:44 +0800
Subject: [PATCH v2 6/9] char: misc: Does not request module for miscdevice
 with dynamic minor
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-rfc_miscdev-v2-6-3eb22bf533be@oss.qualcomm.com>
References: <20250701-rfc_miscdev-v2-0-3eb22bf533be@oss.qualcomm.com>
In-Reply-To: <20250701-rfc_miscdev-v2-0-3eb22bf533be@oss.qualcomm.com>
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rudolf Marek <r.marek@assembler.cz>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, 
 Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, 
 Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDEwMyBTYWx0ZWRfXx/mpuh9GCEAZ
 /LNAVmDtjDrj8tuYqgKvjc8OKbRLZtyfrtK6GogBNfRqbPEeN7I8daCLv2kfxFrni+DOLQBrfkW
 gzMhYRPgbZtM7avEnuRRWx/QjdLMfIlgY8GhHSpowIAnBDjWqU82mTACUmEjbelFpZIgQxsSePX
 abrl86pd6AvmgkBcLoEf72Ub+RXoMoVZ/C5Y1mSoiBWEn6ZZtNfuJQAe/6aOQthXcnsxrbT/gv1
 5FTd4s1j3L84FB302tUtPU1Gpx+QNR2iOgZX77v3g1kU4l1hrP55IevGoCiPGlvJVla9nSMVs=
X-Proofpoint-GUID: ejVbLjlx1MUlbLcHBYb2y8cS3iogdBtk
X-Proofpoint-ORIG-GUID: ejVbLjlx1MUlbLcHBYb2y8cS3iogdBtk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507010103

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

