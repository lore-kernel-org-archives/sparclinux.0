Received: from outbound.pv.icloud.com (p-west1-cluster2-host8-snip4-7.eps.apple.com [57.103.64.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D1C26D4CA
	for <sparclinux@vger.kernel.org>; Mon, 14 Jul 2025 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507303; cv=none; b=jmACBXVvn+qNEChdgYHkv5h1TY6FiFaGwKtcIshLAP2/y3ph0ag3CmvOolHTNrUkN9do/XUKCACUXHfZibRVxXmEsHvwtmeEp1DLmP5L6+Ly6dSw5LkUe4c13vZeUbF8aSTHl4yjc29BNHNEAr40d4Rb3TKQkprDf2DPHSe3ll4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507303; c=relaxed/simple;
	bh=wKm5Ok1D3zI9n6oV/H9sgCnwtCpc6AvdeR7Tt6S9+jU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lur/5oMCtR+Ox9P2sOvIzV5vx/KmhIreWKaebWsfeH5ygg9pZXPR7BYYfyCeDo6GdIbFMc1k/wKRBbdVFc00cRBgWlolRh+zN7bT6EM2YwrFubW3E0d/4IeJpHmdnGqkAZDIbjDzt4XowEoaE6Mqu+bpOCRhSLLjav2J6BYyIhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=a9MJB15w; arc=none smtp.client-ip=57.103.64.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="a9MJB15w"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 9C581180188A;
	Mon, 14 Jul 2025 15:34:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=J5y+0r7klm10pX3hlor2G5tej0Jv9rOx8255KUf0j6Y=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=a9MJB15waNw3lCcuCI+EU7IOe59DBuGuLJULVmR3FMWMCHc9tyS2FKz5q7PnXHMA1vqYkTM7IL6iYste6s1vCrBmcno5VOcRSlYPvXQDtGVcd7fVgA0WshhyWpqaseMQqPPlI1DYClCmHojKbV1AkegmpCoFFroeGy80mqOeyfoFewNGNAixQqLEbPYzwimvPdaypxkjd4NFMNflP5Qkvyvx/9Ei1OU28wDtYZAX+xbeeqHPfqeB+0W4gqPlqO3sqxx02Qec8J4HjhtS9/2kzH4C0AE/ID4e1QVILIVBswbdlMqJv5s9iJqlBPAioNSaGmRkmu675pUDiurBqejkIg==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 9B5871801882;
	Mon, 14 Jul 2025 15:34:51 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 14 Jul 2025 23:34:15 +0800
Subject: [PATCH v6 4/8] char: misc: Add a case to test registering
 miscdevice again without reinitialization
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-rfc_miscdev-v6-4-2ed949665bde@oss.qualcomm.com>
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
X-Proofpoint-GUID: PqOyCh97thQlN21iSEb8dgac6fqGku04
X-Proofpoint-ORIG-GUID: PqOyCh97thQlN21iSEb8dgac6fqGku04
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MyBTYWx0ZWRfX6EGHniU6gdYW
 fX+6aquLvCGR3Vg75ECGAW5XHoyvhn/gKSMVBRai2yQH9xaoUZ2zJS8cZBjOe5gR2JhPAcN5bje
 B02naDuwIQtDsmO5o8x0llrPtL/rl8+vdP6uTDi1333rKnb9POtr1nt0DXTTwU6JVM/BRCnPY4g
 gfzOvrahhv3brqU33GVlERqEMs6PHoUhCfEL3CEM44i+RjmXYFDCHOHFU+QfRpoXDJd4Ddo2ZZD
 Kw1z09LuovIzAhN6Pk/OKeAqSIFjpUmR2ib9cLrArwXmAMj9KEhYAh2t8V+jmBPeYloafrvdQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2507140093

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

