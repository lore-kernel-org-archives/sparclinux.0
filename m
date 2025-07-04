Received: from outbound.pv.icloud.com (p-west1-cluster1-host7-snip4-5.eps.apple.com [57.103.64.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82236303DD0
	for <sparclinux@vger.kernel.org>; Fri,  4 Jul 2025 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635724; cv=none; b=QH3vv1rGcymmGn4wi1STRKHD3pH8rbV88+sN6O75U29udTJGjIMto7KRpXvJH4vr2jV6wpK+N5jAvtFJ1dYsUvh1SGgsMhvINr2Q37WugVFuBPoBBBj4fgh4Q5zk2iNO1pxUgnFjL7U4XwJZ2BBB//TD2jfn5BnNwEQY2zlEI3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635724; c=relaxed/simple;
	bh=wFGpDXTdZuxmwa4jC4AUegIxrdfaKn8pxUX8kuIpn9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oonEcb63gRlGS5+sW0ckfIuoXCMyjvn1JyDNjnLgAfBS8VGmUehNlr9ze94d1JB/sIV2+TjpRGPN/QPtAo5qIBs4cEchayQHFPqoDjVI7hAmD9QMuEhI5Xo94xXp7bVqFOl5AKD8hEguSHx+Xcl8438QRy2PECgqOnRfT1jmQCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=HnaJ8NMF; arc=none smtp.client-ip=57.103.64.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="HnaJ8NMF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=cbt7c0HlAVhmp4PCZp8Pa4hR5RztlzTvRA5ww/nditw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=HnaJ8NMFc+VYP8r8T45TLZ26zDaZABJAjuodrG76GA7NI2k+1Td7z3TTS/C3YDwbu
	 pu7snHzh1TAdUEN4ng1o9X4mQrU6zoL0F1gupisz56KkIgC6o/St5ZvvpePSHQD5Mt
	 AdbqjhvEl0JaNxOUT8qhcLpi7U7efSSWxDfsMqYHd1sgmBVyk549UiP2mwqzPsjGwe
	 ZYCJcOl3RMnZpfe0M3K9uzJlw3a5cJyL0Dcnx+LG5yj9HSCcZEZiLXKkj/pdpQdurL
	 ou9hPFaW2Slmia2ODgmpseQZA5H3YcAPjtbV3qEY6qujdj5smm6x3X/MFy/+4F0hzu
	 sCHvI7p1R/2zg==
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 4E0231800F94;
	Fri,  4 Jul 2025 13:28:40 +0000 (UTC)
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id E90831803C44;
	Fri,  4 Jul 2025 13:26:30 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 04 Jul 2025 21:26:03 +0800
Subject: [PATCH v4 5/8] char: misc: Make registering miscdevice reentry who
 wants dynamic minor
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-rfc_miscdev-v4-5-b48986112d6a@oss.qualcomm.com>
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
X-Proofpoint-GUID: a-iVs9U9UV9OuytPZirYj8aUJKBqtP1R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwMiBTYWx0ZWRfXz5X44wgqsz15
 kXv3nVARY7F98D+c79RT7+0/U6ZbuI8msh/lqisV0bgxrSJTCz5BpaoLueYw1pEolUEhMok4UN2
 NVS3CdvhH+fFB2C/mBD5oXJZi2OQumXN9T48SvueUKVKNAlV5xzDKdl11HqOH2OwX/2SZJMWj3Q
 iyPWsqtu7IefFk4nh8QhxZzpucOUjP4P/Zqykwe197whrhjRbcO/VJQ8BxQs/IX95/AHX0Cn/oO
 D8Gw/zNEYGoEuzFYiHCVLDvUJN9iODgxDvfJdZOTC4rB7509VrFiS0CM2vs42l6k+dn7woPLY=
X-Proofpoint-ORIG-GUID: a-iVs9U9UV9OuytPZirYj8aUJKBqtP1R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507040102

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

misc_deregister() frees dynamic minor @misc->minor but does not reset it
and cause kunit test case miscdev_test_dynamic_reentry() failure:

| Invalid fixed minor 257 for miscdevice 'miscdyn_a'
| #miscdev_test_dynamic_reentry: ASSERTION FAILED at misc_minor_kunit.c:639
| Expected ret == 0, but
| ret == -22 (0xffffffffffffffea)
| [FAILED] miscdev_test_dynamic_reentry

misc_register()/misc_deregister() are sometimes invoked by driver's
probe()/remove() separately, which has reentry requirement.

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

