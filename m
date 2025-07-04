Received: from outbound.pv.icloud.com (p-west1-cluster3-host11-snip4-4.eps.apple.com [57.103.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFB4302CB6
	for <sparclinux@vger.kernel.org>; Fri,  4 Jul 2025 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635723; cv=none; b=pxUTmTZcwFvq5X0Px7+W1eHRfdED2OrHw95a2Spj671HW8WWaXiXeljq8Q+iEAOHKGJQir9rQb5dC5DJxkGfOHvvo88D9FOZRLjlThAtfeH1em1E032Qf7boU+QcmCUQSmjN2etw1dZRCbCIBIUzYguGyqeL4JeSqYSNr3tSPJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635723; c=relaxed/simple;
	bh=u82rCBgKlEQYqhu1p86SsS2QRJmrpOTRiKIMamiJcNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZipSokOGgGw28Q8M6IyPLpmk/lbAao8H0nDGUo9XW+HqAgTNcZi8T8FU54tPjsBC02C5YUi2DKiO7Xv8RqELq0zthFxguSGqYOivRve0qMJX/y3Nlfp8l6ZOdd22cxVgMO/qi0gKr/6u9WzOdE9q8KlO6SfwaWHyadgrWxl1ynI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=lFbX1O8y; arc=none smtp.client-ip=57.103.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="lFbX1O8y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=VYM2nGliAAA138H4u5xVRviCZPDvG3NS2VBKVhrf82U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=lFbX1O8ycZJUVmg5cYxfFS3pMHZO8mSO3bN1rHA62VFOah1h0Olvski/Wszv2QwCN
	 yI6q5KKksZSxLkqxSQ5XRzzRiYelr69hQObBYOpjqKBPwCNuwZKKUPCppUfTU5TZzX
	 3eLOMz9cp45VlEuJTACvSc20T96wQl6IIRGUOKCaxRF4mjcphCVemAXNFIjqvji+Rc
	 +uN2fBRloVGFNikvphMWreMW9jERi5NtWF+8j13iYOJMaJW9cbMLprbiCljUzsjSAJ
	 aPF1EWybu5i8xuj8+ASmMY36D429oSoH7QWzNiFWGh6Rs7jqGZQZtrHgSvFAqruiDB
	 +ME6kB/2GsJWw==
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id A9FEA18028EF;
	Fri,  4 Jul 2025 13:28:36 +0000 (UTC)
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 80BF018009A9;
	Fri,  4 Jul 2025 13:26:25 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 04 Jul 2025 21:26:01 +0800
Subject: [PATCH v4 3/8] char: misc: Disallow registering miscdevice whose
 minor > MISC_DYNAMIC_MINOR
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-rfc_miscdev-v4-3-b48986112d6a@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwMiBTYWx0ZWRfX6tLq5hXGlmUh
 5Uyab4RYm/1IeWDctYM354HL4eu8nMLJasddRSeLMb/pAnApsNLd1pAthp/18obTwycWwH4RQXh
 jNrcYBZ8/oKz+7BE7kHWYoijkDml/wB/oEcAw8l/FCK273JHilpL8jkZ2VgiKRyR2h3JveG9LP/
 V6nvTgKY85ElnsfN1NzJ61hu2Trb43QeGb5dydyqum1ZgVR9H2MXxBvI7eJPkgx3sGyKxS76/9s
 Y8YNrvhNE4tkBeVC64Kd38BBZGXxqHrIlqVzpU2nHorwzLx67H2CSZMaK4y1Qxyi8i18IQuJo=
X-Proofpoint-GUID: BD9PdP3dEwO_fti-tuoPSQGC3sWam4-5
X-Proofpoint-ORIG-GUID: BD9PdP3dEwO_fti-tuoPSQGC3sWam4-5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507040102

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

Currently, It is allowed to register miscdevice with minor > 255
which is defined by macro MISC_DYNAMIC_MINOR, and cause:

- Chaos regarding division and management of minor codes.
- Registering failure if the minor was allocated to other dynamic request.

Fortunately, in-kernel users have not had such usage yet.
Fix by refusing to register miscdevice whose minor > 255.

Also bring in a very simple minor code space division and management:

|<  255 : Fixed minor code
|== 255 : Indicator to request dynamic minor code
|>  255 : Dynamic minor code requested, 1048320 minor codes totally
And all fixed minors allocated should be registered in 'linux/miscdevice.h'

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/char/misc.c        | 6 ++++++
 include/linux/miscdevice.h | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 558302a64dd908aee30341547a5413df1af71459..b8e66466184fa21fb66d968db7950e0b5669ac43 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -210,6 +210,12 @@ int misc_register(struct miscdevice *misc)
 	int err = 0;
 	bool is_dynamic = (misc->minor == MISC_DYNAMIC_MINOR);
 
+	if (misc->minor > MISC_DYNAMIC_MINOR) {
+		pr_err("Invalid fixed minor %d for miscdevice '%s'\n",
+		       misc->minor, misc->name);
+		return -EINVAL;
+	}
+
 	INIT_LIST_HEAD(&misc->list);
 
 	mutex_lock(&misc_mtx);
diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index 3e6deb00fc8535a7571f85489c74979e18385bad..565b88efeb23d02b7d91df1cd7df4bdcf2898224 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -71,6 +71,14 @@
 #define USERIO_MINOR		240
 #define VHOST_VSOCK_MINOR	241
 #define RFKILL_MINOR		242
+
+/*
+ * Misc char device minor code space division related to below macro:
+ *
+ * <  255  : Fixed minor code
+ * == 255  : Indicator to request dynamic minor code
+ * >  255  : Dynamic minor code requested, 1048320 minor codes totally.
+ */
 #define MISC_DYNAMIC_MINOR	255
 
 struct miscdevice {

-- 
2.34.1

