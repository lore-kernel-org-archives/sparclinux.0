Received: from outbound.pv.icloud.com (p-west1-cluster4-host7-snip4-10.eps.apple.com [57.103.65.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4612F271A71
	for <sparclinux@vger.kernel.org>; Wed,  2 Jul 2025 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.65.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751458587; cv=none; b=OETbv8U6Ss1Ba9CfEeFYGrxqSRctPhKjQOhnBDmWzarOZ2pAILIbp9C07XtZMRPLriGCR36N7IddHrxPXso8fOF+N44OKI7US6RcY1gdaH+YqnFlYLEp0g593HFHDanNXNvK3a7ZZyoz+XURSsgt/YZE/1nIr9NjSyxifOdwJ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751458587; c=relaxed/simple;
	bh=wFGpDXTdZuxmwa4jC4AUegIxrdfaKn8pxUX8kuIpn9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MT+QtLL70CxKGUrSkdt/xQGucoSiQQTOlWYCfcSHqggno0aVtlxVbl8LpoiUgt9eMrm2m+gwJcmQjzOHK+XHcMUiSGcmT5L0JdE1gPl7y0jkN0wBxCdWzzqw0RF+/QXXBOPewpkBWYJAeA1Qy3NCorexiSTdMP6oD8+kr1A2H2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Y9DFgE1t; arc=none smtp.client-ip=57.103.65.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Y9DFgE1t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=cbt7c0HlAVhmp4PCZp8Pa4hR5RztlzTvRA5ww/nditw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=Y9DFgE1tlr6QsYOsrfK8DeUZa1MvZ+EBQtelAg9jfxk4G0zUtsuErD/1bn4d3DqXs
	 +t6tzO6vzM+UCWF7EkKh3Xmloi3vP+cEo2xU3j3y2FunMxmY8AGMsXo9w6f0hOk1Ks
	 iir6nIh5Vq4/OcnPqjsRoaOSZwlovIc+jQxWbOgh6956YXJntYSz6gDH88/0+QPMn1
	 i4MORW79gTYNZ1NGcqEJtqgjk3BQz4jvkVPdqcKo0oohItBSbIUhQUe7uUUiVLf8jj
	 VrZgWMJcNiDbf/pZXJAIdHNT/zepYClhDQhx4Z60U5TyJIw2E2YY4D/9j4tEA5BMZn
	 hv5rHso85THrA==
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 7BFA61800283;
	Wed,  2 Jul 2025 12:16:21 +0000 (UTC)
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 3C7AF1800284;
	Wed,  2 Jul 2025 12:16:18 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 02 Jul 2025 20:15:33 +0800
Subject: [PATCH v3 5/8] char: misc: Make registering miscdevice reentry who
 wants dynamic minor
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-rfc_miscdev-v3-5-d8925de7893d@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA5OSBTYWx0ZWRfXxvQmbEUr3lYV
 Q/jAAZy9Q/UyyS1Tvrj9giGHSiz6MvSeR4vn5H4L4B9C7FLpV9OKBHZehFEp5LJz74Pn+AX4c1N
 nGSLSjxXg3EH6KYRBdyxKxoxfKVoJsZGsVCXE3izEV+qCUY5zneNWGzgLnujjJEczHfMg/0kMGt
 P8uCXMf1Ar0k9nK4RjQ58C+qxM4I8aHOnM+/bsxd9FrrVPIBWWsT2Nh13SymNGqm4tapN0EBreb
 RblREHOqqzPuptytVcI9zp7HCiF4ocVOMvMDBX6KWq5OMXGjY53YJ5m74LzX1LJWuSkwNnI9E=
X-Proofpoint-GUID: J5D7vvmn1ZmxgFg9wtlErbDfK6A9C36b
X-Proofpoint-ORIG-GUID: J5D7vvmn1ZmxgFg9wtlErbDfK6A9C36b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 adultscore=0 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507020099

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

