Received: from outbound.pv.icloud.com (p-west1-cluster3-host3-snip4-10.eps.apple.com [57.103.66.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB62526F46C
	for <sparclinux@vger.kernel.org>; Mon, 14 Jul 2025 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507310; cv=none; b=lmNrc1vSj+I3criT/k8U4VGQSS1C5PNLCMyxCU0FmFEq9a/XLr/Nf3HLlaMkToz1M7Hh7ig/B5D8lkbpXgI9Oft9hPJQH7OgF7xYuJkUH6kgr4Ah2hq8Cq/TRHe6M3zIq2P9Ov0UxBV/pDGi3jO5f5fFkuCu/TRUeh9/i8QWCWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507310; c=relaxed/simple;
	bh=GmLJREgMmOkeIecrSY+/IN5+fI/c8dpwLjgxKhe9ThQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WCwtdou45csXQMDuFjQTpYNk8GW4xL6UCnHUFwmz44RFh5d/DdJngNWk9pPUj9v38oPMQNgUmtwmSnB03dFizkSkRVFjZtIFRHRXQqT+oV92qy5sfercNl/dkTVYOS7CuhGTwStVGnp1DDRPWJpX9XjOQ+f9PPNyPvJkgv+iW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=c7oLF3lk; arc=none smtp.client-ip=57.103.66.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="c7oLF3lk"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 6219C18001EB;
	Mon, 14 Jul 2025 15:35:05 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=NlEAtJr1Bx/RZGVdSX3DjVXIyd/dRfrLp0ZsvLqNLMw=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=c7oLF3lkGaoWWjNUBf6tXwVr3j6jgbrGMq90CSsK/13aCWSIo+A/v7lQwZ7S+tKZt0uYtKB0DKwYcU34jGGl6T0TanWlIZ3zuaxidyQLAADcO5YzebAawFyaAQWbcqFJcSPoHPrh++yGiJHu+g8o6gwe1urgh8Y+s5YPf2hOkus9DCO0MuFAsRbycIsg07EZXgVvbvxQc1rmK4rCxLl2q4f37nS3igtfFSRLPfFXLPTFUb3cpWdJjN8DvZlANj+eElj5qhtTRyuf+j8embemTPVRQYhDXTp5dzMexE9koXfTSKmz0aVvZeKf568wdaQkSW6goDwEBqZRwvCAWWOwdg==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id C296018004A7;
	Mon, 14 Jul 2025 15:35:00 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 14 Jul 2025 23:34:17 +0800
Subject: [PATCH v6 6/8] char: misc: Does not request module for miscdevice
 with dynamic minor
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-rfc_miscdev-v6-6-2ed949665bde@oss.qualcomm.com>
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
X-Proofpoint-GUID: PqswYpUNmBr6YvuF4Saoh2xAbmeigoXf
X-Proofpoint-ORIG-GUID: PqswYpUNmBr6YvuF4Saoh2xAbmeigoXf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MyBTYWx0ZWRfXwQgd2T59rOmN
 OMek1/hivKot52/D/iylgEGlY9iFWzhswTHIpzZSCmpUOvZrH9RP5+2s7mc+O3oU9db3jnvfVUp
 jXk4VZo2/TiQBHpO8EnV9I6mYAt4fAIsYYfmQMiSxtKZ4Tt2VX9dIdy4xi7P2sNm+ZoTGfihH/J
 dKjntu7e/PUMxvkfSNJzd29Xi11lNokdLBZq4QkFwcuZr6tV38EuBcv2DO4GzhUSxbcsuM9D61L
 cD4JOZX35O4GqcMLsdw/kX4IkoFGAn9ARy1Bf/BIQbna/J/0IHdugjcsGkrC3XRGkTr0sQ1+A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 spamscore=0 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2507140093

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

misc_open() may request module for miscdevice with dynamic minor, which
is meaningless since:

- The dynamic minor allocated is unknown in advance without registering
  miscdevice firstly.
- Macro MODULE_ALIAS_MISCDEV() is not applicable for dynamic minor.

Fix by only requesting module for miscdevice with fixed minor.

Acked-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/char/misc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 96ed343cf5c8509a09855020049a9af82a3ede95..a0aae0fc792666a7bdc0ba00da9dc02ff9cead42 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -132,7 +132,8 @@ static int misc_open(struct inode *inode, struct file *file)
 		break;
 	}
 
-	if (!new_fops) {
+	/* Only request module for fixed minor code */
+	if (!new_fops && minor < MISC_DYNAMIC_MINOR) {
 		mutex_unlock(&misc_mtx);
 		request_module("char-major-%d-%d", MISC_MAJOR, minor);
 		mutex_lock(&misc_mtx);
@@ -144,10 +145,11 @@ static int misc_open(struct inode *inode, struct file *file)
 			new_fops = fops_get(iter->fops);
 			break;
 		}
-		if (!new_fops)
-			goto fail;
 	}
 
+	if (!new_fops)
+		goto fail;
+
 	/*
 	 * Place the miscdevice in the file's
 	 * private_data so it can be used by the

-- 
2.34.1

