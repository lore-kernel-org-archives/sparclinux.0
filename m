Received: from outbound.pv.icloud.com (p-west1-cluster4-host6-snip4-8.eps.apple.com [57.103.65.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA092777E5
	for <sparclinux@vger.kernel.org>; Wed,  2 Jul 2025 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.65.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751458579; cv=none; b=Q8ktGfo1oH5hVADOaPPSKknusyRIxWOSxO327o3goWBXwYBPGjs6tv9XUe4z7uaNzuCpJ3Fcp7kngL+4xp/Gygn+dygWnryZNroIauBAgW/EnWCGQP1jqoQYv/zqtAoNgxROdX6JtQ6Doyfn4ymxhuDdE9MVf/El/Z5tb1YibaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751458579; c=relaxed/simple;
	bh=u82rCBgKlEQYqhu1p86SsS2QRJmrpOTRiKIMamiJcNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qmbT4uU1zxvmeN325tKBXq3XPlUErlBkPSNsvgbuHYaCqPfYkp9EVUDZD8LlnxpjeBVhuhtP7/KH4BidTnwJYtutFMkwV7g5+/IxwL8K9eB8B/yFjJBGJpAth/bapIRJ6/k6DhuoFTP2m518pzXnYs1ThWSTzSD+4TOKH4Syvc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Wso9QrGE; arc=none smtp.client-ip=57.103.65.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Wso9QrGE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=VYM2nGliAAA138H4u5xVRviCZPDvG3NS2VBKVhrf82U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=Wso9QrGELcRXHcT4jeMnoY87NHuBDc/mSWyvBiUSPzt8Oa3vYatOJIuVxRXXr528M
	 WewjiZRrpedvHmH0ADjM1s8lMi3XlcPDNmIOoKeijp85Kkg/jJq/ig61oZY6LA1745
	 m6qtD01NNRvGYcqcfwEKazctvfWeUnQlfqm9tVCDycZL0L5/HI1oV/PJw+pFAqreew
	 etgsicUlxf8r0nJ/OCdxhndJ9Z+VuxyenRCylhJb5zPysiFiCosLezy+1xbreuYAIn
	 w6b5OpjLId39Oqy4dkMipzZp4Fino/zfhXHa9x9LD7v9P2JQPrSneMEWKKomvGMUTl
	 VuxHwWPhnrJ+Q==
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id D343D180030C;
	Wed,  2 Jul 2025 12:16:15 +0000 (UTC)
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 194371800284;
	Wed,  2 Jul 2025 12:16:12 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 02 Jul 2025 20:15:31 +0800
Subject: [PATCH v3 3/8] char: misc: Disallow registering miscdevice whose
 minor > MISC_DYNAMIC_MINOR
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-rfc_miscdev-v3-3-d8925de7893d@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA5OSBTYWx0ZWRfX+oRnsUYkj5bF
 weo5PVwXdVnu863gISpHSepdoICJ8aLW3ZzxUYgebK/tXmolF9tgZ9P8Be1hnPdqEai5EhDBIMP
 4buaKTisk1byBiEqkW6s2/AAwHHghgx0i9ed4tn92PE1TLzFU5/qxK1esFeSvTqTMNwICvBw1jM
 lJXygEo9m+Mn2oK58sPw7qDjrklLWLz+c0C3it4OSiH6ywLBwIb4KLtT/Y/hBgqtgewvi5n6vlJ
 T3wlM9cEntOwzVfg8ScYshk9drhG/u3fb0CfofB0NEoQK7fb4gwdukNZ3t6zAEUS/6pZ5W57k=
X-Proofpoint-GUID: z4HtHDGY6k9B87KKBCpBnIStB98aPXD9
X-Proofpoint-ORIG-GUID: z4HtHDGY6k9B87KKBCpBnIStB98aPXD9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507020099

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

