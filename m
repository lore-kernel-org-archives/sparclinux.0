Received: from outbound.pv.icloud.com (p-west1-cluster4-host10-snip4-1.eps.apple.com [57.103.65.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEE427585B
	for <sparclinux@vger.kernel.org>; Wed,  2 Jul 2025 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.65.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751458576; cv=none; b=jUC0UUvs1pwERbfHN11kJODF5LttJI9RYI7DHxPcDi6c6hwCgz+Cg3A4Eq7VEcvAyqSBVyRJR2PkkE3EM+EfpKSj2LzQFnBKAdhKPAXgpw3UGLtYGb96BY2Tr5lQo35X6+O9KF7LBBE0tro7Z0xqWCWvbq2UUT/lTI6wNw4Q84s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751458576; c=relaxed/simple;
	bh=t10c3wbLfWLj56jmjaq505ZPwwaPt3mIzV/jqx5DApE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Av+ubfY6ikEwprHZDuMjje8GMN7nquQUXNSBcRKRTsc/uhMZrQr1wkCpMA1Dj+4z6c07SKuZ2RHwa1JIj1sMQkbGPCxkTGALvURBbuQFCtBzKWqiAy/EL0qwK+t/oGzNDsy+c5SzfbaYtElsJpj2KGEUzCYifFxqiSOApY+UGWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=gGUW1koX; arc=none smtp.client-ip=57.103.65.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="gGUW1koX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=IRmMn0pZByR3RrqLBiZD8DYJUMudqkbpZZmmyi3kxio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=gGUW1koXpGXAjvtn+iFPdeuoVJvg75nFiYjBqXEis6AtHVOXIXVOMhoQ1uDuEOHJo
	 LfJ6qwQzWhKtHaunEkYwJsfDH7YZK2SEbZ8OG5b+/+be2f0dgOYJUMUY2U8sc6+SZ2
	 qOqTI92u2YsDzKgnbXgS2vlSBZa7xUo6sL7sP7Bcd/PEBBgPblOwQgKY2rY65o6LCI
	 s12bEFAoNi/BOKSpH0/HaZ0gU4t/U3/Fk1DxD6E8WxhYTiz9oAD5mg0eJuPF7txFSw
	 VTC3q5fpyY+j3V3h4eF2R23QehnAdpPAnAf1DtkTMr9Z6WpjIQBcXFxfOa7CHOX2uL
	 gBvwTjrLRNKUA==
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 25E72180030D;
	Wed,  2 Jul 2025 12:16:13 +0000 (UTC)
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 85CA218002A5;
	Wed,  2 Jul 2025 12:16:10 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 02 Jul 2025 20:15:30 +0800
Subject: [PATCH v3 2/8] char: misc: Adapt and add test cases for simple
 minor space division
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-rfc_miscdev-v3-2-d8925de7893d@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA5OSBTYWx0ZWRfX5tl+K5LAkx4a
 W/hHQBbLm8nnY6MAkkIcKEmOolW2cljnr50XQcTU6c0gfiw1xxEevX4V8VjowbCpmh6M7PIVfek
 fK6tvExZjwsvytDHa5KjrIsunLS2S75OoNKySMFJKx0v4mv3BEaSHVlY0gUaUmWSUeRQJ5+4Oha
 2NQd6BGVTyKp2AccGgtm0DCXiqKjQSFFwWuew3yCU8o5GTF8/t8sArLM42/dc89pBmClbSX16VI
 Sf1f7B69WPYw5wYpCiSOkSWbreUVIov75oKRzaerP5FxtzuJqRUq2b2w6BHgn7SJSrgbbtbgY=
X-Proofpoint-GUID: n2STKvAQMqEoEFFx0J-jN8b6NfkEF72R
X-Proofpoint-ORIG-GUID: n2STKvAQMqEoEFFx0J-jN8b6NfkEF72R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 malwarescore=0
 phishscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507020099

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
index 30eceac5f1b6402b0f918af6f56602ed1a6c14ec..81e2ef488a6f6ae7138c7dd8bcbeffe38aa65933 100644
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
+static void __init miscdev_test_invalid_input(struct kunit *test)
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

