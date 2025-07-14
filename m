Received: from outbound.pv.icloud.com (p-west1-cluster5-host12-snip4-10.eps.apple.com [57.103.66.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A425E262FFC
	for <sparclinux@vger.kernel.org>; Mon, 14 Jul 2025 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507285; cv=none; b=ShyUL7NfEyqOFjN11NUYxQdfqvtOzPhbP7EJ/M5Xx7I+3hl5iOd6xmCva4z4NCdwPY3/chdZnpQDY74dWoxTgazH4iFWvXKQOH6f6hu4pUPZXQiJR2EIWmL6tJv3sj/Kwk27WbM8qQom0BEda5kZADnVhPOO3ppRV5oMSvmqVnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507285; c=relaxed/simple;
	bh=OMJ960bvppJHmuxurYcPegcppYFhep1C7c8Zh6iOOpk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HtbPAaUNoaUp6lP/2QuNeZiqIckYJSuFlpk9Dvj1UsLYiYKDaGhExbcVJX0CfpKhc+6Hlx6XFNNHNKvvkyRwIJKrkLxk5rvz0u1TLzCrWmHtKaO1rp5lkwfahkbwoibZLoR7kpdmrmfwX+GeUxxb/PJVHDA8W+stoD9uv2o2mS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=KVqwbiAp; arc=none smtp.client-ip=57.103.66.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="KVqwbiAp"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id C87BB18001EB;
	Mon, 14 Jul 2025 15:34:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=hBBSdHG6C4hu+CJ0dF0ErxXT1O8dBj60X44ZNFpkvdo=; h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:x-icloud-hme; b=KVqwbiApcPAQCJj9QyL6mRLGeGQaBiABFBLeJtIcGEdVUiKNT2gMBQPhzyj0B1kTIRvlmg0Ml/2mpkVFPnVBCYfyYlrtqRvCzQm1KICH7hcJHVgeltXidlte/K0eZk4zFpZIxKKMJHosODxHCsWPIRTJbBsjywtUXOKk2lkRDyqR+/zttePEeglphv+pF3zzNNkeNAow03HgBdFLNKQMpTlC08I9ak+a7rhm3xJtHIMo/EeAiQHAIOZSgzlemlAP60cjKnDSFBlCfgDx2SRRzsZpLSH7ObzN3C2O8XTr8kLMdYGZB8rKeQ75btD6F7nPfOFwrG5bO9sHczqagEWl9g==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 7631F180048B;
	Mon, 14 Jul 2025 15:34:35 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v6 0/8] char: misc: Various cleanup for miscdevice
Date: Mon, 14 Jul 2025 23:34:11 +0800
Message-Id: <20250714-rfc_miscdev-v6-0-2ed949665bde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHMjdWgC/3XQQW7DIBCF4atErEsEM4DtrHKPqKowg2ukOrSQo
 laR716cTe022SC9xXz6xZVln4LP7LC7suRLyCGe6zBPO+ZGe371PFDdDARo0QjJ0+BeppAd+cJ
 REyFK4RonWL14T34IXzft9Fz3kOLEL2Py9tcwIDZGkVzygSxo0gIsNseY8/7j0765OE37+izyG
 PIlpu9bZoHFv19UgAuOvgfoB43Y+//aElZwTcCWwEpQ29Ug37Qd0gNCrQm1JVQletV2rZESyNg
 HhF4R8s+36IXATgnoGuqluUPM8/wDsHq32sABAAA=
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
X-Proofpoint-GUID: -GNrbL7e7Wx9NMW9jXIRRYp_WPn0eSG4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MyBTYWx0ZWRfX82GmQmd4G3zA
 ig8cvQTRiThq6IXW9eJMY8LXqW3VJU3TCPEc5Ry+U5RuYOYSt7AKIIG2Wt2nl8X0/pOjUb8MPnD
 RSPMYITh6hHSwUB9EWCiUELicKyFvoki/ygDn/gToIpXBwbbizuz3AXs/W1pNaXNNNLg+KoVPFa
 90n6yEDzyRangKn7SZtXGX+g23BkIgRARJ+uaAxY8EZow2j7vbM5sfcsEieNg1TDi2kj+zHRLmn
 kaYyeEa75xlgml2Cl5h4JQcay9JEyowVsR3gnCTWmjciEFPRa2bhLvhz6Buf81m1J7mrEfNO8=
X-Proofpoint-ORIG-GUID: -GNrbL7e7Wx9NMW9jXIRRYp_WPn0eSG4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=968
 spamscore=0 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507140093

This patch series is to do cleanup for:

- Miscdevice APIs
- Miscdevice kunit test cases
- Drivers which use miscdevice APIs

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Previous discussion link:
https://lore.kernel.org/all/20250620-rfc_miscdev-v1-1-fda25d502a37@oss.qualcomm.com

---
Changes in v6:
- Correct title and commit message as cascardo's suggestion for [PATCH 5/8]
- Link to v5: https://lore.kernel.org/r/20250710-rfc_miscdev-v5-0-b3940297db16@oss.qualcomm.com

Changes in v5:
- Replace space with table in fist patch's Makefile
- Correct title and commit messages
- Link to v4: https://lore.kernel.org/r/20250704-rfc_miscdev-v4-0-b48986112d6a@oss.qualcomm.com

Changes in v4:
- Fix WARNINGs reported by "kernel test robot <lkp@intel.com>"
- Link to v3: https://lore.kernel.org/r/20250702-rfc_miscdev-v3-0-d8925de7893d@oss.qualcomm.com

Changes in v3:
- Drop the change which allocates 4 fixed minors for watchdog
- Correct tile and commit message
- Link to v2: https://lore.kernel.org/r/20250701-rfc_miscdev-v2-0-3eb22bf533be@oss.qualcomm.com

---
Zijun Hu (8):
      char: misc: Move drivers/misc/misc_minor_kunit.c to drivers/char/
      char: misc: Adapt and add test cases for simple minor space division
      char: misc: Disallow registering miscdevice whose minor > MISC_DYNAMIC_MINOR
      char: misc: Add a case to test registering miscdevice again without reinitialization
      char: misc: Make misc_register() reentry for miscdevice who wants dynamic minor
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
base-commit: db15ec7abd33ce245120f36be91f56f0ba0b247e
change-id: 20250701-rfc_miscdev-35dd3310c7c0

Best regards,
-- 
Zijun Hu <zijun.hu@oss.qualcomm.com>

