Received: from outbound.pv.icloud.com (p-west1-cluster2-host2-snip4-3.eps.apple.com [57.103.64.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4C22FCE1D
	for <sparclinux@vger.kernel.org>; Fri,  4 Jul 2025 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635722; cv=none; b=umym3ztJxDqsqKK5hV8NflOUuHMQ5f1OrXYLbKY1EitTJus+Nngz/zcXuzJ46bS8vQ+MwQYetwy91lBXPYPkCoHZ1VgHhL1fL5hAXfRYa/rTJ7RszvdtH+QmiUGQsb1iLMwePDUdtQdjDZ3hGtwIk6hdE+4/TQF6bNHUXYEwIZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635722; c=relaxed/simple;
	bh=Ah1h1MYr5pdLZyF54NnuMiud/JHO5vb1eGeLlI4vUc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uL0SRJN4CbAP5NQkL6ACs8IdMffsoeTAfH12BMDU4/r13vrFHViPj2T3AxSawcQSwsvGvVBBphyJYXRn57p0dTsSqjgKOyWcjqzpyL6d9W0vA23YcShERLWBMAMZZJPCPB1GYKm8R3CsRmjxkbD4V2u36gQ5xW0zAj4B4siviNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=QU0zetjO; arc=none smtp.client-ip=57.103.64.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="QU0zetjO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=9BOoKJ740v44GBBYsjlH7Kn4WUaAIwfCUT/4UqUeD1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=QU0zetjONGmH8cQj0Vcxfop/FnOm+XzM516wxg+XRra4NSj4bcUD5p824rdlftLui
	 0Ca2tUwoej0YwO9DD2QNx4NgCHnPpJhe/6pD0k4b1lxQXSct5U1yvt2GxOM2iXjwsI
	 EFvMEPMo1gNtqNhCB4EhztMdRvLdy3Cpz/Nf9gMWzwMn/wdhstSjKYVnaVo+zcFRdO
	 EbKBFE34WHAvuiMhEyjaTH97OODNkoJm6SsaWtLIYWj3skuJT9bLZPs8mVc09jbNsf
	 Rb6u/LdlUdrV5pkfMjCnqhRu875clw0AUIncYm0uNa5r3HoTtXh8/nu7ItRHs18jMi
	 t6FPfB4Mu3ONw==
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id AD6B21801F9C;
	Fri,  4 Jul 2025 13:28:38 +0000 (UTC)
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 0D4BE18001E1;
	Fri,  4 Jul 2025 13:26:27 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 04 Jul 2025 21:26:02 +0800
Subject: [PATCH v4 4/8] char: misc: Add a reentry test case about dynamic
 minor request
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-rfc_miscdev-v4-4-b48986112d6a@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: JgRGpDozAPJOEHPw9-U-5qyHOPF7uyZO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwMiBTYWx0ZWRfX+KlhE77/pLG+
 AK5Pzy99vhIL+i70f5VPZK2esItjgsXsYleTs3wMlofZUlaUZz2/+KG3osPbH13JzHk6vaJa6cU
 StBaciaBDUoDUMkdJc/JeipbRA8lNkke8jL9UTS1nokiAzeK3VQ3j7ga3dYdsVAn4cFauslAmPl
 5KtQSxUuejvXiI0aCK0mlCYz6Qbjq2yFk9zbFS8GQYTh1dY3CeGt6ueWj5f8XVET50YaeREMnP1
 fRHlbWDI0FTjUSuHGLjQ4L1eiyf+lHOYdj1ySjze7VAOASfzhPnrqe8030briQ9afnub3i3oE=
X-Proofpoint-GUID: JgRGpDozAPJOEHPw9-U-5qyHOPF7uyZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507040102

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

