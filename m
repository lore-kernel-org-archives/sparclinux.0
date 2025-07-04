Received: from outbound.pv.icloud.com (p-west1-cluster4-host4-snip4-10.eps.apple.com [57.103.65.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A2B2FCE22
	for <sparclinux@vger.kernel.org>; Fri,  4 Jul 2025 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.65.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635713; cv=none; b=BYh0qt7HGcQIeUSTaIQS1kZYbebwBgYscDA3iGaxnUre3v+nPT2E+kkGUd4p69enLyRz8mWVicnXKIPLWS0jIwcOjqqE1//5iMkV93Oj8FAnKjLin8BdOD5IZIqCI+o8WFN750Xfrs34W6XJoq9yFTeT3DuDVuhluLA8ocfX3Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635713; c=relaxed/simple;
	bh=B7J7r+kp0FdeBYkdCMOT9IqDwzIoMXCjzi9wi3C3nSU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gYdU8CUEwg4mu2LxgAwSFMhcgZQgOiYntb0QPUxUMcnHeMqolqukOqRbnmSsRAlvyFFkrIsE+1ND0XOgzeB/C0e+CkoecKjQuILey29v2Mjd8M9KMq7fUdDb+cA1Z8Y4o2K7pu7tCZzNaEKYB+gGGOAKoxhIQHmRan0zr1kw/pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=XRith5QT; arc=none smtp.client-ip=57.103.65.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="XRith5QT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=o98sS6Gv5S9JP0hy8nw2ZgcY2yF3TmukVAMQ8/REpqI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:x-icloud-hme;
	b=XRith5QTvehKIh6g3r8oQ4gn4bGjWlvuRy0G1fnZUuzjGsVD7/Gd0/KQd18LIS3nL
	 xQw33cKcM7+58kd/TUK9w3uo8YmmXpzikx4v3sIF963n7zlVQb17aYe6ABWFUVgnvx
	 47O9na/SZArqmOPmLQgF2Cd8f6h/QzMIEY8O66wYrZiw9njsmYn5fXc2E6rapGmIKO
	 5jV+zV8hAIWF4F0bRun2a4SBNTrnmAhFzzg5KXgJ5VmqgAWlobFnfzRTUhVO4VQOV0
	 nma4WvkOwk+fJ9vP6W9a9XAIDBEoYl3ut+g1WLtA57D6pQu2+NWCnYyY6MYqPzAjF5
	 RUFfsI4q9tRkA==
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 976C918001E8;
	Fri,  4 Jul 2025 13:28:29 +0000 (UTC)
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 8379A180349A;
	Fri,  4 Jul 2025 13:26:17 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v4 0/8] char: misc: Various cleanup for miscdevice
Date: Fri, 04 Jul 2025 21:25:58 +0800
Message-Id: <20250704-rfc_miscdev-v4-0-b48986112d6a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGbWZ2gC/23OQQrCMBCF4atI1kbSGWNbV95DRNJkYgO20USDI
 r27qRstdjPwFvPxv1ik4Ciy7eLFAiUXne/zWC8XTLeqPxF3Jm8GAqQoRcGD1cfORW0ocZTGIBZ
 Cl1qw/HEJZN3jo+0PedvgO35rA6mvsQExMVLBC26NAmmkAIXlzse4ut7VWfuuW+Uzyq2LNx+en
 8wEoz9flIALjtQANFYiNvSvjWEJfwmYEpgJU9U5iMqqRjNDDMPwBrlEORg6AQAA
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
X-Proofpoint-GUID: zhBHMFU_UMChf7pdWTnHuDh5mCOF-RJB
X-Proofpoint-ORIG-GUID: zhBHMFU_UMChf7pdWTnHuDh5mCOF-RJB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwMiBTYWx0ZWRfX838+/1C5I3uV
 FNWd3n8bkW7Mi37J07uUMlcSksNP9E3YGrcghCEvnAw+kI4RZBmLEItrrXQjcCDDtQx+O4CljYx
 AaO85bKC4eqmR9H1zhWoYxM79lerdyGMSi2KtLI/gI6TR+CW0SJDgPobesL+Z39ncJN2skZeaoc
 V+l0LGF/UhqPDToKqm1zpD9SpIFX4+GJ5iFB61xwDwrUQuVqid0HzwpnFOuu9nr6zOiHoa+/ITh
 DBwUX5DiFoRYlb8dcO3BR29vr+GeHSwkUwnBYQmqkM7Xic1Khrt5OdXa+0XMkPeJfrDaVYYYE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 clxscore=1011 malwarescore=0
 mlxlogscore=894 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507040102

This patch series is to do cleanup for:

- Miscdevice APIs
- Miscdevice kunit test cases
- Drivers which use miscdevice APIs

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Previous discussion link:
https://lore.kernel.org/all/20250620-rfc_miscdev-v1-1-fda25d502a37@oss.qualcomm.com

---
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

