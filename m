Received: from outbound.pv.icloud.com (p-west1-cluster4-host5-snip4-5.eps.apple.com [57.103.65.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B4F307AE6
	for <sparclinux@vger.kernel.org>; Fri,  4 Jul 2025 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.65.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635731; cv=none; b=iMroBhTUXBTG80hZlZsQ4Oih9oBpjJnNDSfY6ub01sq8VJ9NzQNjtM0eTTjtdynfjl+GXTEwGSIdEOCXwkXz3ZEzYd42FpZPHeY967WWKm4R6XTkUH5L9YAOsiIRAO+nXTWlbdj+vZIf7Jh9kugRRFnO80h4qR9LSHE3wMp6OgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635731; c=relaxed/simple;
	bh=rUPc6HarIFgYCi5PCcb/6kreZya/jVbJye2++gX7mpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y+12a/wVZuaWIG5Ak1E+JcvT8MxuuShJfPzHpYqzTSi/B/0XG4MPWIFS5AdCqiTWcUHXfePhPIttzvzg+w3AICRoyBg/hUJD45crx5zbaDcfR+LBnjl6N3LUdLi8PGwmirfNtnJQdwvqoCpu5To+H3YZw0Il3bvYAzL6DP7FcNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=LxjpWLCm; arc=none smtp.client-ip=57.103.65.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="LxjpWLCm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=MxR3vmUTXOypUpeb+mW6WO9zX6HevJTvOmfA6oc0iJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=LxjpWLCmH4HovGsbtKkiybuGbTGeQZWsVtYmqnt0CzNJ4zBLciNC9+zuCiN9s00Ur
	 rJUYzDmHoT65aLOqPLljtdfqNFPRv44dKHu/ChmAJlFDRsqMIbJ8sxHT5fdKGY+/UZ
	 rLRzz2QHb/4ZjFx69HW/ljCkpq20YWMI30I8i3KwYqFP4OM40jRHNtl3yUjWr5Mfmd
	 pnCnr/xvuPB2z6nF3vdgKTS/a3STnorZ36uqRBoARue6Zf/dZIK7JzapwiTw+OIW4F
	 srOs7tIk1rISy5fd02X3tT59w/aVtzHf1w7BVxKsud5mEAAj+OUpIa6OXe0D88HgBb
	 vGsMFq3EJJQdQ==
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 4B1BD1800638;
	Fri,  4 Jul 2025 13:28:45 +0000 (UTC)
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id DBBDD1803C5B;
	Fri,  4 Jul 2025 13:26:38 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 04 Jul 2025 21:26:06 +0800
Subject: [PATCH v4 8/8] sparc: kernel: apc: Remove macro APC_MINOR
 definition
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-rfc_miscdev-v4-8-b48986112d6a@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: Z12DxcO4y-Zq33ux5MR8s14ed2G_zkRm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwMiBTYWx0ZWRfX+gCGtyp9jUEs
 bE6OTTDayiibtJ1yKFKkPff8Ro5P9KlpalcLw9K1CYP7AQfKehqpE8ZVDlma6F5wtBzumDGMK8j
 RUfgNRHDSFs/90I21605MXWcM2Nrik0gP2WDjTli23lGyVjUwzZfrco8UtzrEQ41HHRBd+StqyB
 uJqqAED/+FDLsrYG7lS/rasHM2xwEHlio+50tRYNPztr74dt7IeD+CZenWdSOIku/ZYsmZOrJsq
 j8B5g9LzM+HdEmU8btws+Pl0BFoh9l3M+AzepvZ5q5rh463qn9CIV8gcHu7L4pO7msy+QU35U=
X-Proofpoint-GUID: Z12DxcO4y-Zq33ux5MR8s14ed2G_zkRm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2507040102

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

Macro APC_MINOR is defined as MISC_DYNAMIC_MINOR to request dynamic
minor, but its name 'APC_MINOR' looks like fixed minor.

Remove the macro definition and directly use MISC_DYNAMIC_MINOR instead.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 arch/sparc/kernel/apc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/apc.c b/arch/sparc/kernel/apc.c
index d44725d37e30f388bf8cf19d72baf720f94da084..849db20e7165cdf48d4d36cf770dd6aaaa191b41 100644
--- a/arch/sparc/kernel/apc.c
+++ b/arch/sparc/kernel/apc.c
@@ -28,7 +28,6 @@
  * #define APC_DEBUG_LED
  */
 
-#define APC_MINOR	MISC_DYNAMIC_MINOR
 #define APC_OBPNAME	"power-management"
 #define APC_DEVNAME "apc"
 
@@ -138,7 +137,7 @@ static const struct file_operations apc_fops = {
 	.llseek =		noop_llseek,
 };
 
-static struct miscdevice apc_miscdev = { APC_MINOR, APC_DEVNAME, &apc_fops };
+static struct miscdevice apc_miscdev = { MISC_DYNAMIC_MINOR, APC_DEVNAME, &apc_fops };
 
 static int apc_probe(struct platform_device *op)
 {

-- 
2.34.1

