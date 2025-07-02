Received: from outbound.pv.icloud.com (p-west1-cluster5-host8-snip4-2.eps.apple.com [57.103.66.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607B027381D
	for <sparclinux@vger.kernel.org>; Wed,  2 Jul 2025 12:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751458593; cv=none; b=mxuH8G2bkJon8LHn9/Q326omdxuhGyrUjRTB2LGsliZ53xt0DqdvmD76e0MTjhNUJtrJ/ecbuFiHa+gAutguaNJVOJrHTs/Bzp/fLyU47keF9fNsjrRcp6WNA1v+MzpMh1xv1z87UtqIh5mRHpFSMpSCsVBNac4RAV8h6Ibp3pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751458593; c=relaxed/simple;
	bh=abVLHhlrbRD4j7Q9knssLHFcwdKTohtl5aEN2e8X638=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TN5GBGl+9NgqAFd8HTkJqXR9Rk4zbi5f/qCMoxsNdnCJyw7btKxlAPZY2ctYZiKCBji0GaVdXzTCylShO9HJjlYC9msjjgIlSzm0cGnbdQ3Xj5o6nfwNYO17fzo1ZcOAWBZmWT7OivP1A/TSd88I4+KcgEOY3MD3NqGkh2dKf1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=g0RNJi97; arc=none smtp.client-ip=57.103.66.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="g0RNJi97"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=OZilOEgmhkbniE4e1rdKTYefieL2PDjJBxvY1WxL31Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=g0RNJi97ieLB+20HpKaEVYcnN+VvZRAFryRxwcsBBIScgPipb09SDAVJ/hlMLCznk
	 ZVQYYqjIcMo87XQTMo5+fdkQcqesF5Itg/g9vkUKOygq3/ljKEf9wsrWRwtyGNLPA2
	 7Axfa5b6qPHDFln/zdf3HuFsGc1e+SCfi6xHstGzmOtkeZ3bP6VqyylEnXyVlM7zdl
	 9CPRgeGi7tL4iWBoWPT1rbaAsco2TajCxgEnvmjzd9CYPGl2KlzAG12oP0L+3bw1Tk
	 OJJLSUHNe3ui14UNFhvgFNOOhFQb4hgWdDo6uif/IFtejKF0+flzMYrEPHOCoRJ4KM
	 pNSY4W5TrM8Dw==
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id B2DFB1800C8A;
	Wed,  2 Jul 2025 12:16:28 +0000 (UTC)
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 674611800287;
	Wed,  2 Jul 2025 12:16:23 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 02 Jul 2025 20:15:35 +0800
Subject: [PATCH v3 7/8] char: misc: Register fixed minor EISA_EEPROM_MINOR
 in linux/miscdevice.h
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-rfc_miscdev-v3-7-d8925de7893d@oss.qualcomm.com>
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
X-Proofpoint-GUID: WQ4kilVg5vzx9QZl5XL-9ZFRiKSpDEuy
X-Proofpoint-ORIG-GUID: WQ4kilVg5vzx9QZl5XL-9ZFRiKSpDEuy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA5OSBTYWx0ZWRfX+JlrqmYMOzQo
 4THQ0pDWv4AIl6/ti9RhXrJvl5LUMV4Hl75uAHhkbW3h4jmlCC0qcXfYCCd+e+ai4OL3e+crH7/
 jMvl16uA1+wiCJeduSzaUdzgISU25SMhWQdzpUu6wqn8djUUrhTcnnrQ3ZS7WXG2hsacNvXZSpt
 VTgPDuVGTC8wEgqjeNZA17hjL2qSKSeW1LKBm/JOURCGe1BDzNj5HbJh5KLe3mVwpRZ0MGcOObH
 EaxcY3/KtNBHvVJGiM4oRnGHlIq2UYL7fI6V+TOeDXFPbc4/NffF1ayAhjXWpaXAVgfP5aJxY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507020099

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

