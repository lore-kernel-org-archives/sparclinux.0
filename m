Received: from outbound.pv.icloud.com (p-west1-cluster2-host2-snip4-7.eps.apple.com [57.103.64.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375E9248F7D
	for <sparclinux@vger.kernel.org>; Thu, 10 Jul 2025 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148636; cv=none; b=TLxjI80r3jYF5H8/23IQzBDzsl/wcqec4pXWcqJN5lLu5ML8y/pK7Widx2JynbGGt/3S96zs53eiBQUT5ep0EDBCx/EKNKTgqqW4FRVO+9qOny/eo3gcbjIkJftSQN9uuz//5v+77luHNuA2xvwakFQmfjSKOUKxEXmJUaClaaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148636; c=relaxed/simple;
	bh=7jhKZUFyuZhEw6VIXU65rDKomSBChFoAaONNO/+cm5w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FDgWR0ZHyHjmw0VVQ8+28xylJgW95x9i70RpIfpqqk1rcd5IwoPOysTVK66GGN/rFE1xqhANNfqukGyA+z1Ktvz++Sk0UcWqCvwz7aVBOd/iN+Fv8VV0HqVa54oqUdDUFFqWCedR9o5cuflPyH+Qt0LjBJ9Z0tJYrcq/Pj7eDUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=zd2Xw1ck; arc=none smtp.client-ip=57.103.64.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="zd2Xw1ck"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 71F6B1800183;
	Thu, 10 Jul 2025 11:57:11 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=6TmzOUQ4GH9aW+xdMYh3n7mk7LO31oxqs+N8LbGY1hc=; h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:x-icloud-hme; b=zd2Xw1ckU/DwPkPvlm+n6wNV5LKDKZRGM0SjoFF4sYOFS69FehtjQcD5s+v57J5WuefUhSSA22c5Yv6vGfvN/pVkMUM4DKiTC3yBknr4zKsPuDgZowcgHuU4uIwj0e9wDaS4bWpo3s3pICUoz5vpKvTQjrW44fZZGIuFSZza1kQrWUfOmLscfJ8N2wNExkHnKNKCOZTNc0Vmb8x3MY9zihc/iDM26BKCYHe6JV/MBqTMn2NE6+4yxcr8H/ZjsgWp7iP2n/o9zx6XHeKiFaCTi1JQCOj/QGmsyQTx9thn+GDXMIwTUP7E0/nDKAXkl1OiS25p9j/S4qU/hYhNZB5fsg==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 8E7BB18001AD;
	Thu, 10 Jul 2025 11:57:07 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v5 0/8] char: misc: Various cleanup for miscdevice
Date: Thu, 10 Jul 2025 19:56:43 +0800
Message-Id: <20250710-rfc_miscdev-v5-0-b3940297db16@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHuqb2gC/3XOTWrDMBCG4asErasgzVj+ySr3CKXImlEtqKNWS
 kVL8N0rZ9OYppuBbzEP71VkToGzOOyuInEJOcRzHeZpJ9xkz68sA9UtQIFRndIyefcyh+yIi0R
 DhKiV65wS9eM9sQ9fN+30XLdPcZaXKbH9NVpQG6NoqaUnC4aMAovdMea8//i0by7O876eVZ5Cv
 sT0fcsssPqPiwpIJZFHgNEbxJH/amtYwXsCtgRWgvqhBnHXD0j/EM090WyJphJj0w99qzVQax8
 Qy7L8AJUNyFJ9AQAA
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
X-Proofpoint-GUID: 6JKPoQ45ogP2JeNHHvSeu3SmqkprQ1SJ
X-Proofpoint-ORIG-GUID: 6JKPoQ45ogP2JeNHHvSeu3SmqkprQ1SJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwMiBTYWx0ZWRfX3725bFWHMOvJ
 CyRILXHALnQeJLuJ5GmzzdOX5iI3YLpeLeOqRw6+sA4WxR0YH6CHryOFumb4j9b540WqGHi3KQb
 KJTh1gXaEV0oZhOrdTLM8aXaxCqEom6Zc8U+v0bhSwhFdvUesseWYINDaH2P44Yu4b8EHag1D13
 6Xy9CDfRI4gsfod8/fhJR+fSptI8QqVLYx/1lD1Nci0pHkm/K9xZ+RMkL5h3SbO/6sVGVRuaRyy
 FSosQCU77au0R5u8+JrMXu0pDEIchHAY1qictFzk8KIOxLkicoXYbli7E9F1u7iNukcPX8EIk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 clxscore=1015 mlxlogscore=977
 suspectscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507100102

This patch series is to do cleanup for:

- Miscdevice APIs
- Miscdevice kunit test cases
- Drivers which use miscdevice APIs

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Previous discussion link:
https://lore.kernel.org/all/20250620-rfc_miscdev-v1-1-fda25d502a37@oss.qualcomm.com

---
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
      char: misc: Fix kunit test case miscdev_test_dynamic_reentry() failure
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

