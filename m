Received: from outbound.pv.icloud.com (p-west1-cluster2-host11-snip4-1.eps.apple.com [57.103.64.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264A2299949
	for <sparclinux@vger.kernel.org>; Thu, 10 Jul 2025 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148667; cv=none; b=qsJ/zi+1zunSQm43RdprV3L5v0LLksn3CPa293bmtALhv2T1rV8OFm3wFEP0Qw0oa0JnCQZsg0PgZmQ6oQsWSxz1UEVlrAYEWFIc+9tu5V6Zks0isvm/RJlxzsVH5sTSGD85cF32NhNnDHKBdpzMjMdPBVvsgW+/vRWIl2/cKQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148667; c=relaxed/simple;
	bh=rUPc6HarIFgYCi5PCcb/6kreZya/jVbJye2++gX7mpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C29c9LCNB2ZzSR5OIoXwEHqNYVpEVZUzjJwRZ0jFgvEj5Gd7uZdF4WRKRhBZONSmqQyLXjB9016/5XTwkA3IGT3dgN6mXvoeHmbJdxd4SInkLogNVzqTzzlECyzB2fDtHWqDJGqBnpXEZEQGvh0vd51Obhx9uwSfDpp9b7jUVPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=XGm4H9E+; arc=none smtp.client-ip=57.103.64.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="XGm4H9E+"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id B912A180019E;
	Thu, 10 Jul 2025 11:57:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=MxR3vmUTXOypUpeb+mW6WO9zX6HevJTvOmfA6oc0iJM=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=XGm4H9E+eeuvM1OZhXB05wdbNN+kl9lBzQf3eA7dxlvz4IeFFE16Nbx4AVkACGxTzwAZUtyrhGOm3SucvrmUd7sE8DD4XsGeNfSDVmTdPXyhs9V0EuNl0WWnUO65T86k2n7UghABDaM2LtZp7sJnoya2xkpADBdPMC/MZDS7pxWK91MzB4jff9uzqiigGXLOJTnIftG+mVFwy5jjrbeHnLTYFVyOg9R7ftrwIhuFTGIlKEUztCxJK9dMjEfMkBAJQkM6yE8F4enG39E0NuguHQyi0BZRYsv/2eisp/cIrA453UxYTwXue4ZhD2FiHr+iS8//0BejtkcxsSxsnQnB+w==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 7E06718000AF;
	Thu, 10 Jul 2025 11:57:36 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 10 Jul 2025 19:56:51 +0800
Subject: [PATCH v5 8/8] sparc: kernel: apc: Remove macro APC_MINOR
 definition
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-rfc_miscdev-v5-8-b3940297db16@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: XzD6-IKcDD6HZSrXuec3CEZvteRfvgZP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwMiBTYWx0ZWRfX+FU3dhL/LRLX
 RFEmphM6sMFjUOtFcKdOyZWsmISnAzedq9pAGue1BmSLpGjMXf/gsT/qdBoWRGutRIC2lFbCh1e
 m5WnVuN3ITjDhhKC6XW8IkB0lEHfUnW1M44gUDzm+cQtHPkTJIh6rQRhow/v/5MML6Hrxn9uhyI
 FbD7al7vbEDt1W9JpDFOPiOLEPgm0pLpVTnMp6a/7R5eYVl/Co3EW9gVVQnHDMdbRjvKip7EKQ9
 lLnO05CIs4/qMzP9d5Tj2EIO6MY0GsE/1c76SH4FlSE5aAJKIzYuUAIa3LRlU/fW/ce+FHx5U=
X-Proofpoint-GUID: XzD6-IKcDD6HZSrXuec3CEZvteRfvgZP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507100102

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

