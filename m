Received: from outbound.pv.icloud.com (p-west1-cluster2-host10-snip4-8.eps.apple.com [57.103.64.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958AC27FD59
	for <sparclinux@vger.kernel.org>; Tue,  1 Jul 2025 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383572; cv=none; b=N6LRMVuTawuHu+kohvIlCOmonjVcilFI4jj5ZpG7Z7TgZv1IMWhStQPZcKNO2Zh0SUZwnCprh8tcu3dEZPbmlI/CeVNVbPxsydV2mgBnBcScYVgZ0lmSR00vziJ9UpcqMX9wJyBJLylq6gT/e8RFqG2hENV/iFgC41Cf58vem9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383572; c=relaxed/simple;
	bh=62XEhsy5uPCNQwMRXCl5rGVlHkddr4eSr34tMBzBo4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fFYebq8PNmgAkJ6J/JIACdUhmLoC3nkG5ODqt3AhVoONdupuLsxwZ64LYqz54mpnQTsIp+V6mxnmN6R5mWktC1uRRy1wTA5veafkYh75EG3i+0DH50exlvMVROMtAcCWuZBig4U4j06PND6TtnxPqNLahQ4IeA3NoMopwp3blnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=nriFppWQ; arc=none smtp.client-ip=57.103.64.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="nriFppWQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=72KEeLvk6Vfw5F8f1KBloI4BaJ3XA9Td2M8KicUsaV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=nriFppWQjHblssNXkUQngl072g8k1KlDsSYPU73ygp2QbOyvjQRCW2xA0sZg897LO
	 7zTnU95Xj6q4uZc2k9zzV6ZSIwXy1mBhv99jJIkgXf0FzpXVEeaG18zhZuWw8CeXbQ
	 0UKcPasVtVNAg+1Lq2/5+iCSv1EKOWIjw4jVnzLw9K4mepWsq4B8hb2fRKVIp1Xdda
	 8rPw7F5cAuJ814nsbC+FV7A66hXxxBI+EgnWA4je2nLqbT0aoquKw6OfdAWzuXIMG2
	 wXV3lGC1gfGONhOpVVPvA2jSdhKT+rMQTfM++WvSiGlJZFaXKxXlT/Xq/vqo/ju6LI
	 i7vHkSWs7hinQ==
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 030E61800151;
	Tue,  1 Jul 2025 15:26:08 +0000 (UTC)
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 91239180018A;
	Tue,  1 Jul 2025 15:26:04 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 01 Jul 2025 23:24:47 +0800
Subject: [PATCH v2 9/9] sparc: kernel: apc: Remove macro APC_MINOR
 defination
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-rfc_miscdev-v2-9-3eb22bf533be@oss.qualcomm.com>
References: <20250701-rfc_miscdev-v2-0-3eb22bf533be@oss.qualcomm.com>
In-Reply-To: <20250701-rfc_miscdev-v2-0-3eb22bf533be@oss.qualcomm.com>
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rudolf Marek <r.marek@assembler.cz>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, 
 Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, 
 Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDEwMyBTYWx0ZWRfXxOn/YC0PGwtx
 yjKRNtxFyLKCrCSjmwrTpeZ75KsvDBsiSUnoLjG71aX1aEvhjgwdfemzn24HhM7wqCEjRn/srrn
 g2kgl1ownmz6hD38MWyslgo9a9T+/L6YaIUlRAdaCY2YWrxI1QDWdgn1qkTwJRx7eav9T+CYbO7
 ngL9sQ/Hegwyjd7hWfkXmVuMnAadYqW0aLcZTfPEoD+8X8UzbH7NHlAQqFxqT+aYhVq5JxN0hWO
 jhoe2wsk9tOXdAs+eHd6oA9O8D9gVd9qHXjNCAJISxDYZWgYgIgIYF9FFibHobY5wFQJNzT7g=
X-Proofpoint-GUID: DFL0JiX4eCNleGno7AR2_y_aHPBisCd4
X-Proofpoint-ORIG-GUID: DFL0JiX4eCNleGno7AR2_y_aHPBisCd4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506060001 definitions=main-2507010103

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

Macro APC_MINOR is defined as MISC_DYNAMIC_MINOR to request dynamic
minor, but its name 'APC_MINOR' looks like fixed minor.

Remove the macro defination and directly use MISC_DYNAMIC_MINOR instead.

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

