Received: from outbound.pv.icloud.com (p-west1-cluster1-host12-snip4-4.eps.apple.com [57.103.64.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D616924E4AF
	for <sparclinux@vger.kernel.org>; Thu, 10 Jul 2025 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148643; cv=none; b=Y++ZwVGoBxCzp2bswPEQoehZjmYqYom//AiFHlu6qPd8b90BQarFzZjdZl80/eRmSVmIvnT2+uFVKWp4lc39sedhvTidqpZZlvA+Msy4hnVJgsoirtpea31dpaq/k3hBie12YOSCk1fxwbfdtkHHy9jSPNANvhLP8C5u5mQTfTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148643; c=relaxed/simple;
	bh=/AiRylSRcwzhmEunQGArB6XDZj9I/BaM5Nh2Os2DP/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f1lbUXLnExXV/zHO0XETYOD9cDnVpFGIGlCmWX8cBmd3bEDDA17dbRBbh8HDkfbZLRt+b5XC5E7PVx+RQj1kDFKWMA2V4D5zOSx2U2FkylL8TL0Sv/w3HuGOpB1GAh+ByIeRQUBzPeDS7bC+nu0TExO0Qg+q2BPl6WYxM8oAPDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=reVkxMh3; arc=none smtp.client-ip=57.103.64.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="reVkxMh3"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 93A0418001A1;
	Thu, 10 Jul 2025 11:57:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=JeZl4nRCpi5VgV5lnrDHfHn6bzW2jbEiCRbRoFnllBU=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=reVkxMh3wR5F7JLePOE3WfzNwK07sV+o6sr/T/MYP0chZU9IxeOi4D911RPKgymYI2h+lLVj1/GFm5zD6EfOqi+2ip1lm0J/sWTpFhYPg6abSUWV2DpW+FlqyrzURIdWtIms29LndYU5WttcXTDGdxkhQxrmJl7P4thUOzAzFYdca2vBLEo8caDPbpPOiWAhhSvmn9snmi7b4L/Vb2TFHxWdbcqktZ+qhgsdXKSYRWBwcFH2hdG+TWyWUq3KdVFVjZooZ5MtO0HAi50mnK3QkWPUu7KXO2ql1b3EWuiPaO2aYvorqQTIm3VsbV6q6/QKRrB4edU9JzOFu1D74bLgRA==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id AC2B81800199;
	Thu, 10 Jul 2025 11:57:14 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 10 Jul 2025 19:56:45 +0800
Subject: [PATCH v5 2/8] char: misc: Adapt and add test cases for simple
 minor space division
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-rfc_miscdev-v5-2-b3940297db16@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwMiBTYWx0ZWRfX8aNwZVync/eX
 ze8qJwf5K48vS+rkAYVmaohXrMTuUYDxrpfdCqwR5LWttq0M9v0fPbo9wlPCaBNdvvATRJjbxv3
 051ZNYGZmPtgp7XB0J4O3H7msIUxglLBiNzDbwOTvRCrNlfXGvQqSANGY2nndhGujjG8dhhRiE1
 uQLfik3kftq2Ux07AdbVPHKJdmEhg1oXOuHIe4RhCiZw1mlW4/KU9guwwooVLeNiw7SD+Cf9Wyq
 bMPFsioY2/xOe70e9/uQOA+tiZwupfLJRxElfZAwDlVWGk3KiiXqSdUFiyfG4HKMnMIfUuxZ4=
X-Proofpoint-GUID: 9vN-WiEoBfto4pKXGU00CvuCduiURLL1
X-Proofpoint-ORIG-GUID: 9vN-WiEoBfto4pKXGU00CvuCduiURLL1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2507100102

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

Adapt and add test cases for next change which regards minor whose
value > macro MISC_DYNAMIC_MINOR as invalid parameter when register
miscdevice, hence get a simple minor space division below:

<  MISC_DYNAMIC_MINOR: fixed minor code
== MISC_DYNAMIC_MINOR: indicator to request dynamic minor code
>  MISC_DYNAMIC_MINOR: dynamic minor code requested

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/char/misc_minor_kunit.c | 51 +++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/drivers/char/misc_minor_kunit.c b/drivers/char/misc_minor_kunit.c
index 30eceac5f1b6402b0f918af6f56602ed1a6c14ec..3184f383bea8c77cbca69ff5e315ea5de2d5512e 100644
--- a/drivers/char/misc_minor_kunit.c
+++ b/drivers/char/misc_minor_kunit.c
@@ -7,12 +7,6 @@
 #include <linux/file.h>
 #include <linux/init_syscalls.h>
 
-/* dynamic minor (2) */
-static struct miscdevice dev_dynamic_minor = {
-	.minor  = 2,
-	.name   = "dev_dynamic_minor",
-};
-
 /* static minor (LCD_MINOR) */
 static struct miscdevice dev_static_minor = {
 	.minor  = LCD_MINOR,
@@ -25,16 +19,6 @@ static struct miscdevice dev_misc_dynamic_minor = {
 	.name   = "dev_misc_dynamic_minor",
 };
 
-static void kunit_dynamic_minor(struct kunit *test)
-{
-	int ret;
-
-	ret = misc_register(&dev_dynamic_minor);
-	KUNIT_EXPECT_EQ(test, 0, ret);
-	KUNIT_EXPECT_EQ(test, 2, dev_dynamic_minor.minor);
-	misc_deregister(&dev_dynamic_minor);
-}
-
 static void kunit_static_minor(struct kunit *test)
 {
 	int ret;
@@ -157,13 +141,7 @@ static bool is_valid_dynamic_minor(int minor)
 {
 	if (minor < 0)
 		return false;
-	if (minor == MISC_DYNAMIC_MINOR)
-		return false;
-	if (minor >= 0 && minor <= 15)
-		return false;
-	if (minor >= 128 && minor < MISC_DYNAMIC_MINOR)
-		return false;
-	return true;
+	return minor > MISC_DYNAMIC_MINOR;
 }
 
 static int miscdev_test_open(struct inode *inode, struct file *file)
@@ -557,7 +535,7 @@ static void __init miscdev_test_conflict(struct kunit *test)
 	 */
 	miscstat.minor = miscdyn.minor;
 	ret = misc_register(&miscstat);
-	KUNIT_EXPECT_EQ(test, ret, -EBUSY);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
 	if (ret == 0)
 		misc_deregister(&miscstat);
 
@@ -590,8 +568,9 @@ static void __init miscdev_test_conflict_reverse(struct kunit *test)
 	misc_deregister(&miscdyn);
 
 	ret = misc_register(&miscstat);
-	KUNIT_EXPECT_EQ(test, ret, 0);
-	KUNIT_EXPECT_EQ(test, miscstat.minor, miscdyn.minor);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+	if (ret == 0)
+		misc_deregister(&miscstat);
 
 	/*
 	 * Try to register a dynamic minor after registering a static minor
@@ -601,20 +580,32 @@ static void __init miscdev_test_conflict_reverse(struct kunit *test)
 	miscdyn.minor = MISC_DYNAMIC_MINOR;
 	ret = misc_register(&miscdyn);
 	KUNIT_EXPECT_EQ(test, ret, 0);
-	KUNIT_EXPECT_NE(test, miscdyn.minor, miscstat.minor);
+	KUNIT_EXPECT_EQ(test, miscdyn.minor, miscstat.minor);
 	KUNIT_EXPECT_TRUE(test, is_valid_dynamic_minor(miscdyn.minor));
 	if (ret == 0)
 		misc_deregister(&miscdyn);
+}
 
-	miscdev_test_can_open(test, &miscstat);
+/* Take minor(> MISC_DYNAMIC_MINOR) as invalid when register miscdevice */
+static void miscdev_test_invalid_input(struct kunit *test)
+{
+	struct miscdevice misc_test = {
+		.minor = MISC_DYNAMIC_MINOR + 1,
+		.name = "misc_test",
+		.fops = &miscdev_test_fops,
+	};
+	int ret;
 
-	misc_deregister(&miscstat);
+	ret = misc_register(&misc_test);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+	if (ret == 0)
+		misc_deregister(&misc_test);
 }
 
 static struct kunit_case test_cases[] = {
-	KUNIT_CASE(kunit_dynamic_minor),
 	KUNIT_CASE(kunit_static_minor),
 	KUNIT_CASE(kunit_misc_dynamic_minor),
+	KUNIT_CASE(miscdev_test_invalid_input),
 	KUNIT_CASE_PARAM(miscdev_test_twice, miscdev_gen_params),
 	KUNIT_CASE_PARAM(miscdev_test_duplicate_minor, miscdev_gen_params),
 	KUNIT_CASE(miscdev_test_duplicate_name),

-- 
2.34.1

