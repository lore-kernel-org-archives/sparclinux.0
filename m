Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A8414C580;
	Wed, 19 Jun 2024 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806056; cv=none; b=ZQjuJ809F6t9aEF2hRUAtBHy81zokGMDytyaNDzj7oBmgoXY5wFX5JI7t1j6wk1DOcPOEklH1KjKpvFSNl4pgh/DVRFw9uNqGtckIUQa5TIWcF7Hw8uB8uwd2sTNE4EMih7wlJJLfebbgdN80KrayhrFziF2r9/rfbWmQbGruz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806056; c=relaxed/simple;
	bh=BannQxuGb7L81QzUW/BivTpX0jkVmOfmk8EpiJVP+dU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=SW7PCcW8kfAFWpWIXgwKZ6/pNOiDaeFySFNQvpPCCFQYQHjgxljzLp4jIt5525ZMy2FKoVFlUqZgndaqsOWGO1b5VEdvR0ysUNXznBewyvLZ7cwOlQyWDxdxDdCZAe4v22lU45PTFNVI/rn4sSe9JiYRqxldDzkmJ/gfIVEur3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KWgX3dUq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KWgX3dUq"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JA86nO001112;
	Wed, 19 Jun 2024 14:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=uT9WOc23yyjxbZYeVirEYJ
	d+uYfhgJqGB4qhWUVA2eI=; b=KWgX3dUqq477BIp/MgxBL5MsUQstXBpeqO0pI+
	v6aQcl3qmSlxchRTlE6FjOCRVa5C4WuFanxJeTvz/5N/7AjKHJd5X1ownZfFPQww
	Uxc9X7bVmc9P1WykM++02AlHZA6J0DsJDI3gyPxLu0r9wG0PPefU4G1F/QQzkTTt
	ntNHhqFruOlEJAG7LIFyw6ciAglh/Atlu5OPQ2waBiDZ/C7XBlnYSgGvXBlN3dXg
	lh06liRQdhjdynFeuOc/qq9n5d/DXrgnFBKx6G5llQPnGPmFQr3Mjugh7Z9uvutj
	zPv8Mf6G3raApHxgWQclLEkzBVGdXROthGM/GI1UGniAiL0Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuja29wrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 14:07:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45JE7RgS017551
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 14:07:27 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Jun
 2024 07:07:26 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 19 Jun 2024 07:07:26 -0700
Subject: [PATCH] sbus: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240619-md-sparc-drivers-sbus-char-v1-1-85acadb8f789@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAB3mcmYC/x3M0QrCMAxA0V8ZeTawtk7RXxEf0ja6gKsj2cZg7
 N+tezxwuRsYq7DBvdlAeRGTb6lwpwZST+XNKLkafOvP7cXdcMhoI2nCrLKwGlqcDWur6LuQ2YV
 IVxegDkbll6zH/PGsjmSMUamk/r/8SJlXHMgmVtj3H8E4OQeLAAAA
To: "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson
	<andreas@gaisler.com>
CC: <sparclinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Aki17MSar_FqXHG9zFIgw8qne8Hcm4gy
X-Proofpoint-ORIG-GUID: Aki17MSar_FqXHG9zFIgw8qne8Hcm4gy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=745 suspectscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190106

With ARCH=sparc, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/sbus/char/envctrl.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/sbus/char/flash.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/sbus/char/uctrl.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/sbus/char/bbc.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/sbus/char/bbc_i2c.c | 1 +
 drivers/sbus/char/envctrl.c | 1 +
 drivers/sbus/char/flash.c   | 1 +
 drivers/sbus/char/uctrl.c   | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/sbus/char/bbc_i2c.c b/drivers/sbus/char/bbc_i2c.c
index 3192dcb83b86..d7fcde692f46 100644
--- a/drivers/sbus/char/bbc_i2c.c
+++ b/drivers/sbus/char/bbc_i2c.c
@@ -418,4 +418,5 @@ static struct platform_driver bbc_i2c_driver = {
 
 module_platform_driver(bbc_i2c_driver);
 
+MODULE_DESCRIPTION("UltraSPARC-III bootbus i2c controller driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index 491cc6c0b3f9..b543e9bcc785 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -1130,4 +1130,5 @@ static struct platform_driver envctrl_driver = {
 
 module_platform_driver(envctrl_driver);
 
+MODULE_DESCRIPTION("SUN environment monitoring device driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/sbus/char/flash.c b/drivers/sbus/char/flash.c
index 05d37d31c3b8..ddd449dfda31 100644
--- a/drivers/sbus/char/flash.c
+++ b/drivers/sbus/char/flash.c
@@ -211,4 +211,5 @@ static struct platform_driver flash_driver = {
 
 module_platform_driver(flash_driver);
 
+MODULE_DESCRIPTION("OBP Flash Device driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/sbus/char/uctrl.c b/drivers/sbus/char/uctrl.c
index cf15a4186d03..3c88f29f4c47 100644
--- a/drivers/sbus/char/uctrl.c
+++ b/drivers/sbus/char/uctrl.c
@@ -431,4 +431,5 @@ static struct platform_driver uctrl_driver = {
 
 module_platform_driver(uctrl_driver);
 
+MODULE_DESCRIPTION("Tadpole TS102 Microcontroller driver");
 MODULE_LICENSE("GPL");

---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240619-md-sparc-drivers-sbus-char-253de13ba713

