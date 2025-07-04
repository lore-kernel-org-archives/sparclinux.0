Received: from outbound.pv.icloud.com (p-west1-cluster4-host5-snip4-10.eps.apple.com [57.103.65.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2612FCE2B
	for <sparclinux@vger.kernel.org>; Fri,  4 Jul 2025 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.65.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635719; cv=none; b=XLN3bxKKzpoXOTmonIlldVSrztqQnJUmOtEIOrZT3KffFtpLay/TscU/B94UNygGjiZ3rAIcxEhg6BC5DzQaastEnafpsMgIxqVEvG2d3BNpLWFTPJpvB+QMpq/PzmULhUBR7KfVkcpmZXBr5AKG2EavARHHWMwVOsDyrbbfjb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635719; c=relaxed/simple;
	bh=FyJgHYQRSike9Y5he0/tpJNQq216KNkAke3W74dkf/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EOIpHisPUg16B77tZGrFII5HhF6DHZ4ilmU72finGC/YlMMwdjMZuEO2D3NsHD/s3n1IL6WKJZqgqa4yyQP5+lREgVDwIwx4oZesS5lYZ7euS/MV1tR1jQevtZyUO8Yqdwam4PKqctmU42L2FM2rK8x5TQMNoRb/v1KPdwIDn6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=hwIWUw5e; arc=none smtp.client-ip=57.103.65.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="hwIWUw5e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=img6kI6qDl6d+Oujtn4iBGfny39yRj7iBTcBIlKJQeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=hwIWUw5eIttHHn6SlckAPoGLnGid9pk1D8wkIUlg1ev7LFYnK8vGsDcBbHi4WmBta
	 Oe8Nu/bWCuaj7kNYq5W995OE6K/dDYbxXiDOcWxw/DXXl3xwbwEZtSZudmgK+RWnH3
	 YozJbrMwhh2XnyDVWQRfcrxUCjzcbUCbmGr+GVEC0oiN09kFzDAf6Ux4Uh0WwATp1A
	 9Ud5VDjRHhKrmJh500lGdBvxa1ITZARcTy+U+7aIXEmvvlGmGUZwa3xMA3sGEDoJ4q
	 akO88MXcK6Fg4kw8M6IJ/HdmJD9xae+8DpQfYoXf35COEQDtdLAeKLD/bsRCc4w9Ym
	 wvbvs3pk6Ewig==
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id A793D18028D0;
	Fri,  4 Jul 2025 13:28:34 +0000 (UTC)
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id F13E818034AC;
	Fri,  4 Jul 2025 13:26:22 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 04 Jul 2025 21:26:00 +0800
Subject: [PATCH v4 2/8] char: misc: Adapt and add test cases for simple
 minor space division
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-rfc_miscdev-v4-2-b48986112d6a@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: zl6owmPiKTNPw4jds7YKolxY1DqlDDF2
X-Proofpoint-GUID: zl6owmPiKTNPw4jds7YKolxY1DqlDDF2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwMiBTYWx0ZWRfX8bLbqYpxR1vV
 5Ta9LhdBJfygfVTQxFX6u6C2VnafhCoU32EX+n8Gj17TT+vY0R1zx6VK6nEe0ZhPp8PYJu+MvSf
 LHBkzr/sgv5PEIVa7aJaGbRMCRx6mb4YvLEpYsfNB/SXU/g/aLf9o07l4Tr4aHe0Y+QaO/RfzLP
 r4qXHkPjBgCg6fJLhXSXf/0Vyn+r1mOj6Bn1EIAOlKPnEDF7CowTrC+kFbiWIyn3y0NihRs5qSH
 T4eA2kgWXFRzjR1lxzuyEDbQa37//dF4xVk/twPt0XcU+xZo+aMFImUKtVKWPO02ExslQvA3Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506060001 definitions=main-2507040102

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

Adapt and add test cases for next change which Regards minor
which > MISC_DYNAMIC_MINOR as invalid parameter when register
miscdevice, hence get a simple minor space division below:

|<  255 : Fixed minor code
|== 255 : Indicator to request dynamic minor code
|>  255 : Dynamic minor code requested, 1048320 minor codes totally.

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

