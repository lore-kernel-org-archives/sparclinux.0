Received: from outbound.pv.icloud.com (p-west1-cluster3-host3-snip4-5.eps.apple.com [57.103.66.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD19258CFA
	for <sparclinux@vger.kernel.org>; Thu, 10 Jul 2025 11:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148648; cv=none; b=FrT8pkoiwiMbM1criWdxw9+/TM0W3F6b8DaTujMRmUDEEZf1KQoK2wJ2g0iKqWgPsJjnLuHOVJNAilRnUeyN/waR+QoFTXDCZhUPyjm0pba6j+66hC6v0ClAOC1IIwzgUggyxOmuObChBTJysTh5arZwGhbd2bAB048bsYhNsVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148648; c=relaxed/simple;
	bh=TTuqobUufVwrnwuD1IpvKVLEgpKlWt0plFOqbx/QrjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SXBwQzHcSzJvugYaWC43Or7sdI8mDenqsPzyEUjktaQUJw0xqejjH1Uq0uXRbsqLigHg9+F1Bfate4lUh90sw2DTN26oF03cL7++zEJ5d1fKmBjHr3d0RkXOQcT2bq9J8Hm8a7yppj3R1sZwVj3ij5YCpdg55la9Oc3VPVtKF6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=07nMTyJO; arc=none smtp.client-ip=57.103.66.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="07nMTyJO"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 8614E1800190;
	Thu, 10 Jul 2025 11:57:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=wluaQIx6vNF4mIxEAfAmvtmQ3di1DI0LWcOfCkaux/0=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=07nMTyJOiACRiH53iaTyqlDj4WYV73bSfplennotCYDr77Y9fzOm9JbJhKVwpCSzqCskDdTz7jJ8gku5YT2ONm8koeZd55QooYZpU2E9CWfwQtGw2rOVXJiX0nviMMzt+ZCKwRdlQkk8Yjy7o9vzkjqi7gwj4QKzhwuTclPQMIJNistiVRuM9A6IuYd7gkifLkUeTsbLw9MAH7LRKleazXidf6jRK2ZF7w+jT0j/rNr3aWjYzg1kXk06UgwUD69EhfopO/VnUkqDzSP1hAWi49ygomI7COVU8+SBqGcmW5GcrUoiou8tqCrOz6AWvaFSlZkWlHx61NGA94CScpw5wg==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 737B81800197;
	Thu, 10 Jul 2025 11:57:17 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 10 Jul 2025 19:56:46 +0800
Subject: [PATCH v5 3/8] char: misc: Disallow registering miscdevice whose
 minor > MISC_DYNAMIC_MINOR
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-rfc_miscdev-v5-3-b3940297db16@oss.qualcomm.com>
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
X-Proofpoint-GUID: E9IrM8_A_UBOONPR-mMd7jvmm0kgPyQB
X-Proofpoint-ORIG-GUID: E9IrM8_A_UBOONPR-mMd7jvmm0kgPyQB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwMiBTYWx0ZWRfX8KRPoLX2MOHd
 0bb8GnQB9AysvtdOIDGhSgSuy1mNAil1IypOb7VF/3Fqd8jF/t3qI11rP/v08hzGApQwygMTZRh
 FWAzHKPPgn/v7A/0CDzT9pKLjwrpgU8pk4Udapvu/wK4iAhvwir01TpM0twQ8iVmd+3aENBbhPg
 CF8/e+03uW6VS0ux+9GgT+G20g7JNkupUGeuV0Cc+cuPS9370cNnJ4JcwPjvqfF1ju7VurXQZpg
 Qsl4m3N1P9gw05AaxOK22GGSzCSuCKyvGd1xg3WeR52NKSwCNShe3r0leebrDUK/EPdsRpl/s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507100102

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

Currently, It is allowed to register miscdevice with minor > 255
which is defined by macro MISC_DYNAMIC_MINOR, and cause:

- Chaos regarding division and management of minor codes.
- Registering failure if the minor was allocated to other dynamic request.

Fortunately, in-kernel users have not had such usage yet.
Fix by refusing to register miscdevice whose minor > 255.

Also bring in a very simple minor code space division and management:

<  255 : Fixed minor code
== 255 : Indicator to request dynamic minor code
>  255 : Dynamic minor code requested, 1048320 minor codes totally
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

