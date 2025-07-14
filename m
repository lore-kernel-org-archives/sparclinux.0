Received: from outbound.pv.icloud.com (p-west1-cluster6-host5-snip4-10.eps.apple.com [57.103.67.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76795265284
	for <sparclinux@vger.kernel.org>; Mon, 14 Jul 2025 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.67.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507320; cv=none; b=J6d6c16/f+NvK2d7XCc9EFhZB6BBwkZ/w8VDyaVfGUlscjPveTBt+2jCLPgHBW6ULjthBuUanqYLC5iAK2jJQ4GmFQmCHP0TK9TJ1T/cNzw5KES84xGVUzKhykK3r4b6T6273WJ/Ycr9vjXnIYMTAnH1XZCSgOk/mmQKndgs/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507320; c=relaxed/simple;
	bh=rUPc6HarIFgYCi5PCcb/6kreZya/jVbJye2++gX7mpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MWu3obL2WAUmCOgpXOtvTiXPco8BZY0JjR70I7Axql95nVi8vN77iORetxDONffRsIDS8eqBgAw0ZBVw5WzMFYh520Cql5eEsMz2viEsimg4v01gVSA67GA6c4r/InBinNsGNoOyOzBxEsKxHxnfV2ahDAFv05n1vMA4hlZR6Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=xbD9u5Fj; arc=none smtp.client-ip=57.103.67.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="xbD9u5Fj"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 5240B18004BC;
	Mon, 14 Jul 2025 15:35:13 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=MxR3vmUTXOypUpeb+mW6WO9zX6HevJTvOmfA6oc0iJM=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=xbD9u5FjnQyANUrmKm4jq+QkelC03JFjr828Ui2YO4h85h+vm22GwNY3Kea6aC6Q+Exrxksz+eIZeWEiLcG6zyim/IOjeUmrKjiLPV1otAPR6k1R1LdNdnyvf//l74cmbectrQmZ8L/aSHEIP8R++U26F1CzWb6NOCr/lID/LfSU0JgEJDf6eIM9STaC74bjuJS6ZBZXSU4Tf3Vl/oJ3hbboqMiFKMHxFPE7wlpALBplewQGHRA7BTgiMvR+swWTL1Y8suDaWE+Z7+8CPH6kfJXTUfSeofjPqhwJfkZWwpjBUSorivA2vQM8jZmSBamh9RiDcmQpg1bIa2wdiGY4dg==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 2DBFB18004AF;
	Mon, 14 Jul 2025 15:35:09 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 14 Jul 2025 23:34:19 +0800
Subject: [PATCH v6 8/8] sparc: kernel: apc: Remove macro APC_MINOR
 definition
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-rfc_miscdev-v6-8-2ed949665bde@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MyBTYWx0ZWRfX151xmLBW09/b
 K6SHkvSFhVdFlcP1XXLoCRvCCPNoIyN/0q/Cs7GGvom4FL+32RH2LKxuUf9LplGAGxGwmLlNV5R
 5UPkQrBSDYtQM5TqbMYBtUHGKIM39bgLS07h9EZsYZEfAh820uyVThm+tqB5XjofiECAOCYsIOb
 XihCJcAwPrYWa/5zSpFwSm6e51fkSrjiiyO31iAiGuv0ucA1T8LF334p5Yq7Y5Qlg3LMgpUrB8U
 PypG1/xMlf1QNxxN8RJIWEoU/EX6C6bjva90eV/Wa8KtZ3bv00pksSZtnFxwgsvjexwv13RTw=
X-Proofpoint-ORIG-GUID: CZIDtwtu-DxiERIJsUoSJz_qQvAo2zwW
X-Proofpoint-GUID: CZIDtwtu-DxiERIJsUoSJz_qQvAo2zwW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506060001 definitions=main-2507140093

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

