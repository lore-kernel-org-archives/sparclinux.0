Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0FE18633;
	Tue, 23 Apr 2024 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.245.218.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861106; cv=none; b=nsXZ5ePDN51ZcIO9MCrnEytA05+8eZ/8wLcEVwf39sZv0otlsZqYECxllGJQdYTUOddeEJotFKHgL81YiGQHdxElmj3VvBnSfY5Qma0h+A3naATa6L1QOC26rmqiPZDVnwOShWxEHi9S4EnVPqtCBEpPEC2NTz0XltyriKrk5vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861106; c=relaxed/simple;
	bh=N89eRTnCH1N/2oc+ooWVrn5cRdrpACplHdyHdeobZgs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=slr6qEbxNnLP3Fno1bDvnDbQt9vEs4wS15il7yrLposUS6fKfPAv7zm5y9KW56LQtZ3IjUAN5CbDm5iMjc27XcJVV2uXMTCcJBHJnDptUzU0QNwWocIvS85+lTEaAriZzd1xM+tSCM92/TdCeDg+DbWZQghAVE3njzmuBi33JkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=13.245.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp78t1713861059twhsxzp3
X-QQ-Originating-IP: PJU0zuqdMCLB46WKpz5MLQwdo2zfMW3mOnPOPYynrlo=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 23 Apr 2024 16:30:58 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: Wyle2N1OIGmB8JVYMGaU1f4HDMwIWzfmqpAIpE1BE/PVFMglJAHoo7a3IQYbV
	TtaCVcEUsA3uf8mO+RInlEy5HxuxcGyrwNyc4fGUJBM5oS8h7tXK87XTqUXQJnjkz3mgsnU
	QVlFCtnVAOVwPgAlM1pCim5H7srS/uRa37NLNiZ9UwtRW6+KsgCW0msRDcBIGk2DUiZywRd
	JJahIQ157wunWDWrrOx/FlHp3xYNVh3GfTWxadN8ZOEM0MQ6aJljlf2k/uUaE/njfhjG1eR
	bmuOv84+FkMX/sqOYF8PuQntx86hbtXFNpZFE3HIC50arJPMJyavb04+lkQ6l5zlP0Dxx0v
	jy14joMc5YyNZxSeUa6H3y5kbIPl75tJZRkgMef4AawlHL/QDaibkxbBI+sdcYbmjPgv91O
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11416567546493999041
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v3 0/6] Remove onstack cpumask var for sparc
Date: Tue, 23 Apr 2024 16:30:37 +0800
Message-Id: <20240423083043.3735921-1-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi,

This is v3 of previous series on removal of on-stack cpumask var for
sparc arch.

Change since v2:

- PATCH[1]:
  - Rename helper, cpumask_any_but_current -> any_other_mm_cpus. (Sam)
  - Add Reviewed-by from Sam.

- PATCH[2-4]:
  - Add Reviewed-by from Sam.

- PATCH[5]:
  - Remove __initdata annotation and related commit message. (Sam)

- PATCH[6]:
  - Change from ":?" to "if else" style. (Sam)
  - Core logic _unchanged_.

- PATCH[7]:
  - Removed due to potentially conflicted with other pending series. (Sam) 

v1:
https://lore.kernel.org/all/20240418104949.3606645-1-dawei.li@shingroup.cn/

v2:
https://lore.kernel.org/lkml/20240420051547.3681642-1-dawei.li@shingroup.cn/

Dawei Li (6):
  sparc/srmmu: Remove on-stack cpumask var
  sparc/irq: Remove on-stack cpumask var
  sparc/of: Remove on-stack cpumask var
  sparc/pci_msi: Remove on-stack cpumask var
  sparc/init: Remove on-stack cpumask var
  sparc/leon: Remove on-stack cpumask var

 arch/sparc/kernel/irq_64.c       | 10 +++-----
 arch/sparc/kernel/leon_kernel.c  |  7 +++---
 arch/sparc/kernel/of_device_64.c |  5 +---
 arch/sparc/kernel/pci_msi.c      |  5 +---
 arch/sparc/mm/init_64.c          |  2 +-
 arch/sparc/mm/srmmu.c            | 40 ++++++++++----------------------
 6 files changed, 21 insertions(+), 48 deletions(-)

Thanks,

    Dawei
-- 
2.27.0

