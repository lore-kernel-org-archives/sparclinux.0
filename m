Received: from outbound.pv.icloud.com (p-west1-cluster1-host7-snip4-10.eps.apple.com [57.103.64.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FF0264F8A
	for <sparclinux@vger.kernel.org>; Wed,  2 Jul 2025 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751458574; cv=none; b=DQSLE4uIeIJ6z5fQwVqOp5ZpEeOX97aM1Q2518aGHXVSTh96QLloz/gUWmBb4ew62kB1lM/u7UytFmFqD8uD5vAtGFbxgS5aEmi/1Xn9tkOal206Q2+kuylwjcibQcfGD6JuPWXN+P+q2Y01iDOPqRfETfbXcmS0vC+AiRJ2Qjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751458574; c=relaxed/simple;
	bh=qrKJY2wYU/yhK5QTAhlH8URv2UJSsEuIBA9BpxeI22k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lQ/lkESdy4oVY13hwZPTaFbnji1kvlT/cXh0wywYvsgF4FuVjn5y5gWLq/CY3lgPQWlG3L100RZaq/zV26Px0AzzwJ7Z8sqUHeA1Se6kJPPXWUsf6dwOHywtPrOFxyApUzSDIM+vP+9PTwdUZU+7t9ysyr42u+3iWs80AOxC5qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=i/9d4Nvs; arc=none smtp.client-ip=57.103.64.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="i/9d4Nvs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=VRwlDT/BH79/yE2YqJN90DXNi0Yb5SBnT/B8S1o4f7Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:x-icloud-hme;
	b=i/9d4NvsTEjZK8NfbslyPdfyYvxci8D/QGWDvc22xuko+iqIXA8THbd2EImWskLCF
	 tDOKtS27w/U+k1O6ddiJbggj2d4dTc4N5NP5e0GAkTW7DKABDhXbjzfaEk6sda6FzX
	 cZQiILqjJUC0W1yC2yDXU1mer8FRWVQ7t3Y1/e4xIXHVdJeSjnJpoVfOoVsXDHDXLo
	 jnyTJsnZBFwqRH/o54BZAIZYYEVQ6OtPI7ldwCrkammtt4GfzLe3zJviN8yAkzw3vo
	 6mpKapEQgxC2TGserNKvnroel7O5YqpYb27NFiwjmnWq9wPCoEZ4lFZCPRKh38DwJ2
	 ve7eVvvL+RfOg==
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 6D5A3180032B;
	Wed,  2 Jul 2025 12:16:08 +0000 (UTC)
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 698901800283;
	Wed,  2 Jul 2025 12:16:05 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v3 0/8] char: misc: Various cleanup for miscdevice
Date: Wed, 02 Jul 2025 20:15:28 +0800
Message-Id: <20250702-rfc_miscdev-v3-0-d8925de7893d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOAiZWgC/23OQQrCMBCF4auUrJ2STogFV95DiqTJxAZMo0kNS
 undTbsR0c3Av5iPN7NE0VFih2pmkbJLLowlxK5ielDjhcCZ0gw5St7yBqLVZ++SNpRBSGOEaLh
 uNWfl4xbJuuemnbrSNgYP0xBJfYw98i8jN9CANQqlkRyVaI8hpfr+UFcdvK/LWeXBpSnE1zYz4
 +r/X5QROAjqEXsrhejpV+uWZXkDfSiisPcAAAA=
X-Change-ID: 20250701-rfc_miscdev-35dd3310c7c0
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
X-Proofpoint-GUID: IZdpUBihHIUJ4H975Clqze2p8xOWzqIS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA5OSBTYWx0ZWRfX0KKTaG5l8+0e
 AErf9Au7AjAN/RotbYpPiZxHcEppyP6t8dg0KU9dSa/tqijTKwdHjkDQrbyUt/DjHqQ0Oh23c67
 F4PY4/LPppw/f6+HJHE4grjqsRvqvyNGIEjKRhO6KCMXtstE6eOIagO7BDHd/KUJeavAARLMlk2
 N5wZgwHNgr1KPXGZCKSkx2FMcOMoCZOZ0yEntWhVlgKNrBtnST4DPaUwosgofkRSmilhrYyNd57
 7WyVisdz9QuXUWDpdrA+Tb8JxNLSDJnhR+PAaZostkaLYBG2emD43wTrXZv3TdTOALBlHxGEQ=
X-Proofpoint-ORIG-GUID: IZdpUBihHIUJ4H975Clqze2p8xOWzqIS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=990 suspectscore=0 phishscore=0
 bulkscore=0 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507020099

This patch series is to do cleanup for:

- Miscdevice APIs
- Miscdevice kunit test cases
- Drivers which use miscdevice APIs

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Previous discussion link:
https://lore.kernel.org/all/20250620-rfc_miscdev-v1-1-fda25d502a37@oss.qualcomm.com

---
Changes in v3:
- Drop the change which allocates 4 fixed minors for watchdog
- Correct tile and commit message
- Link to v2: https://lore.kernel.org/r/20250701-rfc_miscdev-v2-0-3eb22bf533be@oss.qualcomm.com

---
Zijun Hu (8):
      char: misc: Move drivers/misc/misc_minor_kunit.c to drivers/char/
      char: misc: Adapt and add test cases for simple minor space division
      char: misc: Disallow registering miscdevice whose minor > MISC_DYNAMIC_MINOR
      char: misc: Add a reentry test case about dynamic minor request
      char: misc: Make registering miscdevice reentry who wants dynamic minor
      char: misc: Does not request module for miscdevice with dynamic minor
      char: misc: Register fixed minor EISA_EEPROM_MINOR in linux/miscdevice.h
      sparc: kernel: apc: Remove macro APC_MINOR definition

 arch/sparc/kernel/apc.c                   |  3 +-
 drivers/char/Makefile                     |  1 +
 drivers/char/misc.c                       | 16 +++++-
 drivers/{misc => char}/misc_minor_kunit.c | 95 +++++++++++++++++++++----------
 drivers/misc/Makefile                     |  1 -
 drivers/parisc/eisa_eeprom.c              |  2 -
 include/linux/miscdevice.h                |  9 +++
 7 files changed, 89 insertions(+), 38 deletions(-)
---
base-commit: 626e89412dfb88766d90d842af4d9ec432d8526f
change-id: 20250701-rfc_miscdev-35dd3310c7c0

Best regards,
-- 
Zijun Hu <zijun.hu@oss.qualcomm.com>

