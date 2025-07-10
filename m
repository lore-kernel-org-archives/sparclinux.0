Received: from outbound.pv.icloud.com (p-west1-cluster1-host11-snip4-5.eps.apple.com [57.103.64.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F7624A046
	for <sparclinux@vger.kernel.org>; Thu, 10 Jul 2025 11:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148656; cv=none; b=qBP5j4CTX13apfK1d6K26PZoWAhvrJiTU+6iH3D3ikmDIg17P6jYdE7WkRPF54xRTqvFf/sUAov+SueuGddCK/y4gQtPesmdtK7m/2V80BARY06KuHVRhhb/Hro7+0MQDtuEifTxZtMjFcYtMD2Ky9V6IWcf4n5kMzADS7zV2KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148656; c=relaxed/simple;
	bh=X9OQrTfMazN+NOC8O7iQbD+k8RA1ANyXx8NHfXOifaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OjgjsGflv+ZufR7o1xZWo9ftYJ94c81x/r5VpD0M6HdtynFTXO0mN/YT3f7zCVwuqJ2IOmT1f6vqzy3j+or0ltvFaqtPn4EDjRiCvcpdmlqJ8npKsAVP5Nb6Po45zmlA1a4R/w/nteKQT0IcAbnbqIkQHvVc1c9xLwjBYv17iig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=0l+MYjq/; arc=none smtp.client-ip=57.103.64.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="0l+MYjq/"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 2CCBD18001A1;
	Thu, 10 Jul 2025 11:57:29 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=h01q+I9/z1aXWESorcEyCaV2BwxffHtiLprEGYJaan4=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=0l+MYjq/fXTKLzpSht1IJwY+sUarQiEVExWDtEAli7OPiwpI5dCArSDuFyiKkC8jjlacqvZp8J0rsw0CICWnWuSjUQ3TMNlI4mgvGyu9HSltjQOdT+tdW1ciOdHWOpRMjPZcn7EFxBx0ExsxnU/6DAP9yppUZzD2Pa3YacbjqCTvHdqesYKYzH0sTTdkOSxhpQreS1TzwHXstvrZi7Hka3na7ZlKPq5lL0+zhcq+vr54HjL22ixksXTkYbiek0GeBWcdVVAFksP2OmUggkgYaHFoBLe1GbEzXrh5oSwPK5arj4CvT8SL7GocbaMkvqFkNeWXMl4XKg3FM0/U0+tj2A==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 902051800225;
	Thu, 10 Jul 2025 11:57:25 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 10 Jul 2025 19:56:48 +0800
Subject: [PATCH v5 5/8] char: misc: Fix kunit test case
 miscdev_test_dynamic_reentry() failure
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-rfc_miscdev-v5-5-b3940297db16@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: wrDy-7ftnUx8c1COvO3x4XWVCotc2zQG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwMiBTYWx0ZWRfX0Wba0P9Tydb5
 SXM3XG3rhKk7dbovulu3sG51VcjUcFMJovMlcsCHapLR5SLKyHanVj3V4+T2nfbbY4+d5b9C54e
 OmZIzg6IF45G/+vEadUUv3/iBsEiMzM864/JXQ5ITHNTV8m8qQrSgEYWsEtSIPHBXcIODyaXdRp
 GrhYWRoRIwzmofJgnjVFuFOdvpJBXgyedBbp/K17rvcD/Z21IJSdDR8mTf1bdtLUEZN8nq/KHwY
 /6qsEf1Oy4+cQlM6Gsnm7GRuUhhiPy1vWbwn64kfODzjqrRQewf4tP0jGeAgu2Hf7hdu60d3U=
X-Proofpoint-GUID: wrDy-7ftnUx8c1COvO3x4XWVCotc2zQG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507100102

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

misc_deregister() frees dynamic minor @misc->minor but does not
reset it to macro MISC_DYNAMIC_MINOR, so cause kunit test case
miscdev_test_dynamic_reentry() failure:

Invalid fixed minor 257 for miscdevice 'miscdyn_a'
\#miscdev_test_dynamic_reentry: ASSERTION FAILED at misc_minor_kunit.c:639
Expected ret == 0, but
ret == -22 (0xffffffffffffffea)
[FAILED] miscdev_test_dynamic_reentry

Fix by resetting @misc->minor to MISC_DYNAMIC_MINOR in misc_deregister()
as error handling of misc_register() does.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/char/misc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index b8e66466184fa21fb66d968db7950e0b5669ac43..96ed343cf5c8509a09855020049a9af82a3ede95 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -288,6 +288,8 @@ void misc_deregister(struct miscdevice *misc)
 	list_del(&misc->list);
 	device_destroy(&misc_class, MKDEV(MISC_MAJOR, misc->minor));
 	misc_minor_free(misc->minor);
+	if (misc->minor > MISC_DYNAMIC_MINOR)
+		misc->minor = MISC_DYNAMIC_MINOR;
 	mutex_unlock(&misc_mtx);
 }
 EXPORT_SYMBOL(misc_deregister);

-- 
2.34.1

