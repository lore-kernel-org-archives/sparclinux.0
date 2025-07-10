Received: from outbound.pv.icloud.com (p-west1-cluster1-host10-snip4-10.eps.apple.com [57.103.64.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFE227056A
	for <sparclinux@vger.kernel.org>; Thu, 10 Jul 2025 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148663; cv=none; b=C8S1HVb1rn6QQjIy1uz+3EU80VjTjX4PkSd1QqpN/dlH3UD855yE4EXxHPSEpvDyy5yWCr8Q8ZokJrWchaHeU9NlPPMV1CwPB/ohxGm81WIx3pwFTBxnnbfaEc6GFLJKc53y4QiAVa3cH/Z4elGtv4UTM5SbBK5CaM9m01iDiUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148663; c=relaxed/simple;
	bh=abVLHhlrbRD4j7Q9knssLHFcwdKTohtl5aEN2e8X638=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XUUxMZshK7FrR6r2rT06AXQVqJM9SPq+gRSlOa3dV7EYsUahdRXj3mohAkmZXC4GRofwFdmb4idVDI6GyTWIMM3gGTblr7cx8Rom81bQGd88Siz7Ol77fCmQRdS0TmgoIdmdZZuOLd31ExAksK3Tg9NzutATtgcAamoaRWbv/nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ejeLSOvH; arc=none smtp.client-ip=57.103.64.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ejeLSOvH"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 33DA01800183;
	Thu, 10 Jul 2025 11:57:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=OZilOEgmhkbniE4e1rdKTYefieL2PDjJBxvY1WxL31Q=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=ejeLSOvHg3QtFnQvv2zWkPlPLnTm8Nq7u9flnaE5ywr20UuOree12xLzBrZFvH1RcTK7gXrhcafwZxKYv9rY+FR4s8oi34PaloBoPz0v6eqSNLCR4ILm3CBa6Ehtmk6wTwrWRT/cb8s2GsD6DxcxQQ9vsvst0Cxz5KOFPuUJL9JcN2cDX4MFr36GxN+VcKMsA7a50FWlHBW/J0R1n6+MmUgIpSjFgTAOpZNOnyyIXulpdbmunP9467gIQDSLkCHOC691wGPDA5UPjwx90bl+4XXMk31zNbM6jABC5ji7BKbknWmPtcUNBy0kGRDFIqG79+n8DgHJOOR7DUBNAwBM5g==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id C303B1800197;
	Thu, 10 Jul 2025 11:57:32 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 10 Jul 2025 19:56:50 +0800
Subject: [PATCH v5 7/8] char: misc: Register fixed minor EISA_EEPROM_MINOR
 in linux/miscdevice.h
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-rfc_miscdev-v5-7-b3940297db16@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwMiBTYWx0ZWRfX2UM//PYvtK+p
 6AV7mCgK0IZH2nOjx7ZelyxCG9tJ1IzlG638Clq6xaPReg8BJN4/VTHtaaSX18gdG1Z2YKDlaKm
 CqILeqCMKUpXeiBC4jRbu7uTPdL0A/YG45ECtOsqgK7b5TtO4CZp84fnJISwjpd8v0iwYhqdTFv
 0NN71j/bQm9pIJkekoNDyHr4Ex0m5SeooGsAGi+iarlzvDg4fN+8ylUznkktyGRt4yH49+IRwAB
 OSuziD3kss5syOn61eJVsZKTPj6x+pvy451PM6lkFNQgLeMEdt4pMNVnBptUzYPvuYdlKIoAE=
X-Proofpoint-GUID: YNBUX40kAdJcjY5TUps3ReVPa2VSeuAt
X-Proofpoint-ORIG-GUID: YNBUX40kAdJcjY5TUps3ReVPa2VSeuAt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507100102

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

Move fixed minor EISA_EEPROM_MINOR definition to linux/miscdevice.h.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/parisc/eisa_eeprom.c | 2 --
 include/linux/miscdevice.h   | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/parisc/eisa_eeprom.c b/drivers/parisc/eisa_eeprom.c
index 443b15422fc179c7379082bb165ea2bb80785fb3..601cbb22574fd64b0c6be568442d5064d38a2c20 100644
--- a/drivers/parisc/eisa_eeprom.c
+++ b/drivers/parisc/eisa_eeprom.c
@@ -15,8 +15,6 @@
 #include <linux/uaccess.h>
 #include <asm/eisa_eeprom.h>
 
-#define 	EISA_EEPROM_MINOR 241
-
 static loff_t eisa_eeprom_llseek(struct file *file, loff_t offset, int origin)
 {
 	return fixed_size_llseek(file, offset, origin, HPEE_MAX_LENGTH);
diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index 565b88efeb23d02b7d91df1cd7df4bdcf2898224..7d0aa718499cc1867790e98eb6b84c1673091905 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -70,6 +70,7 @@
 #define UHID_MINOR		239
 #define USERIO_MINOR		240
 #define VHOST_VSOCK_MINOR	241
+#define EISA_EEPROM_MINOR	241
 #define RFKILL_MINOR		242
 
 /*

-- 
2.34.1

