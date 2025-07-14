Received: from outbound.pv.icloud.com (p-west1-cluster2-host5-snip4-1.eps.apple.com [57.103.64.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E871266594
	for <sparclinux@vger.kernel.org>; Mon, 14 Jul 2025 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507294; cv=none; b=aq5pPQJFWScoCDl7Vii/u4aVx+ueRTsPky+Zsn6E6WDMJWZgI9rw5Z1cUH8OOOjA+OYms0tFJaTIE5+ZVMGIDlorW4YOoA7ce6CepO64LO+9BxB2Kum7jmj0Vo0SmUz+Fa2PWbcx+oKfBzFMOOVukCLUS0YlNhMG3pjvT1urxBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507294; c=relaxed/simple;
	bh=/AiRylSRcwzhmEunQGArB6XDZj9I/BaM5Nh2Os2DP/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EVPzgTW8vTsaGHZEUVUjX+oUUKpPIa7ckbNvdv414WwQcbxFbU0oaTQoD3ELu5Qq84oYIpoURzHevGzyphDJ+iCEkHnxBRN7HODDA79VQ6sjgtK3mtryg1a9RKuVtKi/HguZk/N/3xKP7JKlWBi4cAykjvF1bmSgunFxecL1Ikg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=DiBVibHL; arc=none smtp.client-ip=57.103.64.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="DiBVibHL"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 36AF1180049B;
	Mon, 14 Jul 2025 15:34:48 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=JeZl4nRCpi5VgV5lnrDHfHn6bzW2jbEiCRbRoFnllBU=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=DiBVibHLx2J7TBJFM/E4yv2t68kD/Vh3VMZ0RFgef5fQ+OUgHHtJp5K0xuM1PShi9nwmhE5yNJzK9xDSemznBEyX6pzrlxfC8LnA52nEzXxADNKKl66yuiebsnG4NmzYrZFTM+VhinlNN7HBj8iC4FD+MyqUUapsGsPbNWgebXY5y3APdbHcEwrFAZ9Po56L7AB6GYHxSiKBacGorr8gQMyzl81nTUxv5LHX6OIIp1P0PDsoKtoYV46FDvF6HSwCsYeINRjZkQVRL+h84bWKMEuzc7pv9HU+aHnqK1N/zF7bblga/xlbzlWrbx96N06Wsvu07P+U9Cfqxnow0u6wTw==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 57E6118004B5;
	Mon, 14 Jul 2025 15:34:45 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 14 Jul 2025 23:34:13 +0800
Subject: [PATCH v6 2/8] char: misc: Adapt and add test cases for simple
 minor space division
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-rfc_miscdev-v6-2-2ed949665bde@oss.qualcomm.com>
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
X-Proofpoint-GUID: YRqWB6wEIstpDcwn_OOWvxFMUoGUXjAV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MyBTYWx0ZWRfXwb9WmfZZRWWJ
 BF48BcC91N1HWrzYzYc/h6lJzDC6q3eP99A8/7p1qLncAqUybar16VbqHZOaGIKTNk7Rgi60TeZ
 j7uf+yXanKd1qbKxc7PBrGW5iG41X3uHEO9C0qIm+/wmCCsNihdyuPjhB+KIruQAM3P9yd/2fqJ
 VUtlyCZeQTKhFMiJGWlImgZb8eOgPIQpLhnd/woNJi8t5QKKemRlLa2hSPW3MzO4J5wTtudHE4/
 Di4WUmChnd+LmzawoEvKInfq40emnlFlZGs62aGaGmRSWP+De6XRka4XWIJzjBo/crx4EBv2Q=
X-Proofpoint-ORIG-GUID: YRqWB6wEIstpDcwn_OOWvxFMUoGUXjAV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506060001 definitions=main-2507140093

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

