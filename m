Received: from outbound.pv.icloud.com (p-west1-cluster2-host8-snip4-4.eps.apple.com [57.103.64.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAA5277CBB
	for <sparclinux@vger.kernel.org>; Wed,  2 Jul 2025 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751458583; cv=none; b=rNGzds1OM2d1zltYzebmyC3pGrvnYmv3T8B5HwqC6kzUT0qCeRk0NQjq40fe56EW/fqT7wruoygJTS0KoXjafyfi5hi73zPRzFVdDaDTVa9us/iBPp1idSKCW9yRNlz2QRks0pBdVm+XYWY2wUBo/nd100jgbMRqumtj/r2I/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751458583; c=relaxed/simple;
	bh=+/JsE8myi0XHHT50WY/Nol1Co+hPKThwPGO+1OZRN0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=shc8lEuD1KZI13C9tVX8bNYcTSmhcjiiRG1T+jnrjWMMlvxxC/bN8pg71O7Jscv25Rqrzs1zmO4vL+U12m77wYFtPsibY4YHxD/36tZTA7hK3DC55xVl3r0YAqoHsj4odRYD6UIyiqOpgsWxoK/qco3zqsFUPsRpqioj0yHrHGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=p/ILYXLN; arc=none smtp.client-ip=57.103.64.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="p/ILYXLN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=CZy5/vDPG3HZvwIBs14wKw3g5IIvXPS7GeL0SSSRvtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=p/ILYXLNKjpwXwa/E/CxWalvuoY6G5VMmFU1J5xMQjVqvQFYC3i8P4r7Wjlqzfv8G
	 OdRLQZhZIqV1zRUi/0nbWlQLd0PQbTSgNzHbPru2g/ezRCNRL2ASDHZyPB8dpsBE8j
	 eHciSKMzcXJDPG3HBrLveBc85YE1RdQzfC+ZP+32cXKFSgggLI3cLSlTWDEOXoR0Il
	 Rk5jFDE+7q+dWHWWKByebjZkjhzp/fbJsgnTY4zrWb/odmqak0cjzoBvViAF7hAvKn
	 2g5MgejStLTxKQRN21D37ngX7ZxNxjYgTn8MmNX4KinB2kcBPxDurlOAM/BLAz4hy8
	 k4CePbHBvDoog==
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 96F851800C83;
	Wed,  2 Jul 2025 12:16:18 +0000 (UTC)
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id A0D8618002AD;
	Wed,  2 Jul 2025 12:16:15 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 02 Jul 2025 20:15:32 +0800
Subject: [PATCH v3 4/8] char: misc: Add a reentry test case about dynamic
 minor request
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-rfc_miscdev-v3-4-d8925de7893d@oss.qualcomm.com>
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
X-Proofpoint-GUID: A_SSvGMospJKfIYpJqUcCzdkI97bjkRS
X-Proofpoint-ORIG-GUID: A_SSvGMospJKfIYpJqUcCzdkI97bjkRS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA5OSBTYWx0ZWRfXzrbx4CvmPvU/
 Hk6TTJhSho8+2y4UX4s2un5VqAPEhXM/RWGas/yOhOY87i3qg1VmY7EF0XTuXlBdImoh5d/USli
 QRTunG5C9tzcZaOTDdPNQOXrCT/u5JSY4OqxXdMzC5IsrzQy1ckpYVRAVr8VvsCxhiph2UboL/B
 1ennpTDqXbfG155IOUQccbDI/Dm390JacmORbvF2xA8wGADXLALByY6HgD8pomHhrcUXd1EpI/7
 H7leczO13Spr76hPY/xacSfKIefAq4xTtYuVz5ZAYx2Ro/DUFcOvzYGYmRoo8+cLG28PdUiks=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507020099

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

Add a case to test reentry about requesting dynamic minor:

1) Provide Both @dev_A and @dev_B want to request dynamic minor by
   initializing their minor to MISC_DYNAMIC_MINOR.

2) Register then de-register @dev_A.

3) Register @dev_B.

4) Register @dev_A again without reinitialization.

5) Check if @dev_A can be registered successfully.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/char/misc_minor_kunit.c | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/char/misc_minor_kunit.c b/drivers/char/misc_minor_kunit.c
index 81e2ef488a6f6ae7138c7dd8bcbeffe38aa65933..9f1f77c04f9f1be56bc94cab4127ecb941e128b2 100644
--- a/drivers/char/misc_minor_kunit.c
+++ b/drivers/char/misc_minor_kunit.c
@@ -602,6 +602,49 @@ static void __init miscdev_test_invalid_input(struct kunit *test)
 		misc_deregister(&misc_test);
 }
 
+/*
+ * Verify if @miscdyn_a can still be registered successfully without
+ * reinitialization even if its minor ever owned was requested by
+ * another miscdevice such as @miscdyn_b.
+ */
+static void __init miscdev_test_dynamic_reentry(struct kunit *test)
+{
+	struct miscdevice miscdyn_a = {
+		.name = "miscdyn_a",
+		.minor = MISC_DYNAMIC_MINOR,
+		.fops = &miscdev_test_fops,
+	};
+	struct miscdevice miscdyn_b = {
+		.name = "miscdyn_b",
+		.minor = MISC_DYNAMIC_MINOR,
+		.fops = &miscdev_test_fops,
+	};
+	int ret, minor_a;
+
+	ret = misc_register(&miscdyn_a);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, is_valid_dynamic_minor(miscdyn_a.minor));
+	minor_a = miscdyn_a.minor;
+	if (ret != 0)
+		return;
+	misc_deregister(&miscdyn_a);
+
+	ret = misc_register(&miscdyn_b);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, miscdyn_b.minor, minor_a);
+	if (ret != 0)
+		return;
+
+	ret = misc_register(&miscdyn_a);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, is_valid_dynamic_minor(miscdyn_a.minor));
+	KUNIT_EXPECT_NE(test, miscdyn_a.minor, miscdyn_b.minor);
+	if (ret == 0)
+		misc_deregister(&miscdyn_a);
+
+	misc_deregister(&miscdyn_b);
+}
+
 static struct kunit_case test_cases[] = {
 	KUNIT_CASE(kunit_static_minor),
 	KUNIT_CASE(kunit_misc_dynamic_minor),
@@ -611,6 +654,7 @@ static struct kunit_case test_cases[] = {
 	KUNIT_CASE(miscdev_test_duplicate_name),
 	KUNIT_CASE(miscdev_test_duplicate_name_leak),
 	KUNIT_CASE_PARAM(miscdev_test_duplicate_error, miscdev_gen_params),
+	KUNIT_CASE(miscdev_test_dynamic_reentry),
 	{}
 };
 

-- 
2.34.1

