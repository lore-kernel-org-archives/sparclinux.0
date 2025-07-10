Received: from outbound.pv.icloud.com (p-west1-cluster5-host2-snip4-10.eps.apple.com [57.103.66.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E49B258CE2
	for <sparclinux@vger.kernel.org>; Thu, 10 Jul 2025 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148650; cv=none; b=KyMKkfA4pZQ8EEsH26sQCItQavQ1idqqMfAjndYcOrlYH5lrOsHC4E3UEdmm79UApHHp1jt68HriX6vKEHVEZisW+0o/LzzG/BftoNrp1wOcXYcBHFbGv5Zj0sIwmUqZ5Htw/MdVfMUu8i1j775HB8sWyvuYsyvAiq6zZ67fh7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148650; c=relaxed/simple;
	bh=wKm5Ok1D3zI9n6oV/H9sgCnwtCpc6AvdeR7Tt6S9+jU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kDrQRLSFyIqbOMYJgPEynMGnKNeU2YHX3+HHgBI1MjfQJ3Cn8SzL2cyWhqAxybidEYaBjYZvjpduXiZNp8fRaBtd2Yug8rhuFXhPUJ5fKBhrkpu1tMGQfYOOdxphRRQoKoOgYNBkJtF1/frL573upB8WMGgKcmO+NDgriswuyHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=B+SuO5bh; arc=none smtp.client-ip=57.103.66.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="B+SuO5bh"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id EA7D31800199;
	Thu, 10 Jul 2025 11:57:25 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=J5y+0r7klm10pX3hlor2G5tej0Jv9rOx8255KUf0j6Y=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=B+SuO5bheY405MnVzSaQPNBye54Z8YLjomj7mWIW7GS9LTksoq7orq2bdEOsqw27smZ5NsfNDVaZdvxPAuyfPUUVE97tIEADQiQznsFzBT/SUfXFG/7gLvbYqgaRhdvjXVdYg9/DjdcCxlUbdW6GTIW0QBv1y6aLW+Frh5Pxbpj9mNnxMxc++H1PD54RmiMzUJHyv7JWj9J9LJumdk0/AYtGAzMJrPSr4CHm4YNCe4pP9vDhqSJdv+8kXgT14a8XWnirLN6+XeEvaLHZmyr7/GtOpge8YfKpdXZn3srsJbVNzfzTDty6eMQWtqy7zUVcXd2212u4xHUsgSYnrqvRdA==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 3CA1118000B8;
	Thu, 10 Jul 2025 11:57:22 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 10 Jul 2025 19:56:47 +0800
Subject: [PATCH v5 4/8] char: misc: Add a case to test registering
 miscdevice again without reinitialization
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-rfc_miscdev-v5-4-b3940297db16@oss.qualcomm.com>
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
X-Proofpoint-GUID: Rv-wiHaEWA-6rhr_aT8ESYmcOD0-UsqM
X-Proofpoint-ORIG-GUID: Rv-wiHaEWA-6rhr_aT8ESYmcOD0-UsqM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwMiBTYWx0ZWRfXxLTChYuUuuiN
 ykC/HUUr5OpT29x6zS6WN5jW2ctw9Izc0ENYjDi7YFBG5R6PK5uibAH80F+lQ3VDf5PeoTUtu6W
 OsoOdVhDIIBc00KolMHp06krGNgxxM33VWZF9m4CLAZ62EUn8ct2lvRipiu2viFK8POpytTQR0F
 e1hxFIlcyHvI8Od+dGjzYAuxg4/6kkm+WINohGqDVXYApvxfHjnf8L1bnhPOJgQ/qee6/t/k0WE
 xNHBqHUkIrWGWjItJNAypdC8htdwlrqsiOwOkLm016PSZVQ2ZY3u21RLAupq5gHBIAJl6pWas=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 clxscore=1015 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507100102

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

For miscdevice who wants dynamic minor, add a cast to test if it can be
successfully registered again without reinitialization:

1) Provide Both miscdevice @dev_A and @dev_B want to request dynamic
   minor by initializing their minor to MISC_DYNAMIC_MINOR.

2) Register then de-register @dev_A.

3) Register @dev_B.

4) Register @dev_A again without reinitialization.

5) Check if @dev_A can be successfully registered.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/char/misc_minor_kunit.c | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/char/misc_minor_kunit.c b/drivers/char/misc_minor_kunit.c
index 3184f383bea8c77cbca69ff5e315ea5de2d5512e..6fc8b05169c5754b96588088471a844a2e2ee29b 100644
--- a/drivers/char/misc_minor_kunit.c
+++ b/drivers/char/misc_minor_kunit.c
@@ -602,6 +602,49 @@ static void miscdev_test_invalid_input(struct kunit *test)
 		misc_deregister(&misc_test);
 }
 
+/*
+ * Verify if @miscdyn_a can still be registered successfully without
+ * reinitialization even if its minor ever owned was requested by
+ * another miscdevice such as @miscdyn_b.
+ */
+static void miscdev_test_dynamic_reentry(struct kunit *test)
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

