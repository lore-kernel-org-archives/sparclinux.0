Received: from outbound.pv.icloud.com (p-west1-cluster5-host12-snip4-10.eps.apple.com [57.103.66.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960C1279DDE
	for <sparclinux@vger.kernel.org>; Wed,  2 Jul 2025 12:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751458595; cv=none; b=ajnqXXAyaw/FZWzColOmIEvmZ4N+BkmDVtR4AXuu8wCG4xWYojlILHX4bnBfXq+J9GceW/I8MBgnthcpRCiv0Wy1Bj1r6klxjIi2Y/9ytP8o5jvi/SXe/1Dh4eXXk1JTZ/MBNL7HeTr0cHdRIHoFBudmXv7tOuJYQYI4fbYrFag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751458595; c=relaxed/simple;
	bh=rUPc6HarIFgYCi5PCcb/6kreZya/jVbJye2++gX7mpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LXETsWsGZeDc2UugrmAGa1JfcDcVslMpi55zV8MjhXRNlgX863SL0Clx947FIWgu5QpItalV0gAmvDkYqZlnWALYBTPcX7+3xXVIeNBcs9ztXKcJ6ImsmJGiK4SvMWkZ/LeeKwjYEN4ZVdXrBUWLWgA1V03urcRllCjbqfzujJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ygTm1hMl; arc=none smtp.client-ip=57.103.66.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ygTm1hMl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=MxR3vmUTXOypUpeb+mW6WO9zX6HevJTvOmfA6oc0iJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=ygTm1hMlAgK3bOAbflYvbUoUF2HQHzhCEjMeszabytsCrEmSfEmfziaOzro5ljQql
	 uzDm5mcmcHKZ2fTc6+2z7+qa1WIaNr5P78GZJ199ULDOjE1zeH6wK2zBQGcdbOkohI
	 9CAtBvxUyp3nE1zjeo12EHEPodyHXYhnN0PaUNBFYmBOggHzzyD0mqGht5x6c03h2L
	 VYvOj/xdR/XZaHs/rp3tl+pONK5M9e9NOi6Laxg3Q0SeKyVAyttB6bt+9tqjpaJn5s
	 gkfWnnmBcxm5o+WygaZeiexTp//rCNU57ZKM4PLXC5qhFlklu9amr6g+RT7sfSy7dy
	 Z+UvPYZ9AAyOw==
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 83A96180030C;
	Wed,  2 Jul 2025 12:16:29 +0000 (UTC)
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 5B86B18001DF;
	Wed,  2 Jul 2025 12:16:25 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 02 Jul 2025 20:15:36 +0800
Subject: [PATCH v3 8/8] sparc: kernel: apc: Remove macro APC_MINOR
 definition
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-rfc_miscdev-v3-8-d8925de7893d@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA5OSBTYWx0ZWRfX7jPqGiP88Bvt
 Mrf1fBR0qVNhm09VK837cmQ4sdZUtGUMbl7z2TGTkB7cD60w3wvDQAT+wEGHIU93q8Y/LvtZ74T
 STWYXmjeCBLQBEc/KORCrdGkRxzZbpXMq5h+vDTEKUW9MSdAgW7IDWz0FhH4LEfP05a48Kah6ZS
 k7LB7SwLis2pH6s/Aa+1SXiFpornkcpKetRdbq8i5UDiX6ZEIjF4P/yICUcW5tnx6TfsBWmoOvo
 MInE3+vN5yM4z/fATQUbKCPvcCt5AaEA918+QilAkz4b9j8se7Bz1HnIhoEU1XtIqj1hJALBg=
X-Proofpoint-GUID: peyGdAL9Mvibq29xXykg2jRsJePrf_mP
X-Proofpoint-ORIG-GUID: peyGdAL9Mvibq29xXykg2jRsJePrf_mP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506060001 definitions=main-2507020099

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

