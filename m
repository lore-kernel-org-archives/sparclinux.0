Received: from outbound.pv.icloud.com (p-west1-cluster2-host6-snip4-6.eps.apple.com [57.103.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7740526FDA5
	for <sparclinux@vger.kernel.org>; Mon, 14 Jul 2025 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507314; cv=none; b=u2OijeSmjkwe3b2QfH9kD2AlMUS6GCkOTzBluFDCWrvM0PH3oOQYRiZaf30TxlOyBJh4RK8It7gz7bIhLcGR8wCP0NUHCPj3JJYOqx2xUSVnfSy4v2baMaJqw+lqIDVAEzs+8KgRcDwj6/Dq87zCjFAoekZZbLCgJ/JHmdyd7nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507314; c=relaxed/simple;
	bh=abVLHhlrbRD4j7Q9knssLHFcwdKTohtl5aEN2e8X638=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OLTUicYmyHcScIwISMvieMiPWNzJfnTd9g8OhAl+vgG1s58/gjdcM6p7kixgFtry6I2sRdVujGy3t93KDTfqzwQR1Su5XOScA7H8fC4CkiqgM1RxpsUnS4+ZeUnKPPTfhSMT+hXuoQQsJr8aJYy9boG+2dS9lBTUhXUUHQqszCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=kNg+BrQo; arc=none smtp.client-ip=57.103.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="kNg+BrQo"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 39EAD1800200;
	Mon, 14 Jul 2025 15:35:09 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=OZilOEgmhkbniE4e1rdKTYefieL2PDjJBxvY1WxL31Q=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=kNg+BrQoXkvffPGUi5n/9f/Jnc0+GwYbCdzztqGR7RZMah3BQQiubSxG9AWaQIpmm0XlbZ2Jr3nUkOZUA0Iuc+hw9wDPmJWibDqpRzO2zak33beBDUYSuvnLps5uf7rPLbKL/3tKq+gBaFTXjVk2Iw9xRhMJs1b5vh30GoEvoexUP/pUHP7dy9GkFTHnJaln3rL5J5rQ0odmQAYrNq9H4Xk7iVkZczzQa+rwbCogo4GYyAIaDZ1tReHyH/EOHIMjiwgu56OkJXVozucdgBSBOE7sbErTUzuRe4W+NJfxirwiYOM8Zw3ELvr5woUWA5A0EfphU+5IKhjFtcrtBPbwWA==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 17CEB18004AE;
	Mon, 14 Jul 2025 15:35:04 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 14 Jul 2025 23:34:18 +0800
Subject: [PATCH v6 7/8] char: misc: Register fixed minor EISA_EEPROM_MINOR
 in linux/miscdevice.h
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-rfc_miscdev-v6-7-2ed949665bde@oss.qualcomm.com>
References: <20250714-rfc_miscdev-v6-0-2ed949665bde@oss.qualcomm.com>
In-Reply-To: <20250714-rfc_miscdev-v6-0-2ed949665bde@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: A_SWEXpZH4lOMO2gf5QVLjFiD8bnOcy1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MyBTYWx0ZWRfX+MdopjM0NIx9
 EMB4s6jqLmSqVVkQubV6RlLcZPwNwmZhlGNndnOAQbD2tyge+G3kYHi58diHkFGIfANHGRtkn5B
 dZ3PP/nMdX5yRbLs4JZb0KZ2P7MOjQaOjXSyx4TijQ33eubTWkE99ESGIJP87oZp6HOBzuY6dFb
 mcfmATHZH6FXcVCM5XCvJHWrg40IItNRwFLsfTnNueWbLOR4a75E6ly/xDmBlrxSgmp1c76fVP/
 ImdtX6nJGzUXNuExgG52wAgykHSCeszpevcnpzQAwdd64KumBIc9rIQSgkr1jpFSvOBpyaGNA=
X-Proofpoint-GUID: A_SWEXpZH4lOMO2gf5QVLjFiD8bnOcy1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2507140093

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

