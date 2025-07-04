Received: from outbound.pv.icloud.com (p-west1-cluster3-host2-snip4-2.eps.apple.com [57.103.66.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDF92FCE1D
	for <sparclinux@vger.kernel.org>; Fri,  4 Jul 2025 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635718; cv=none; b=fm5NbRe+kyFfb92bjQILoK0nBJe1TLHnYiwSReLU+d60O2Dxy61K0Fyuq1ObL7zEyNIL0aqsYqkzp8D6lpA6HpnDfSUkbDDiRvMXc7G6kF8sOuAXFygEsyQrXP5+8k440no5ZHAbKpbXa7xWvNu9KY04vzcS1lLbcC1OnIVAIT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635718; c=relaxed/simple;
	bh=GCOMtzNGxPOUXBf3m2hfp4nlIguiGZVOTq0XkcMtEDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P399TcI1Fsq3naPqfMCGUsn/TPPNjiS7rtxq/l5Pe3jjOFvcRXIPENB8rUAsI9v9ARpqLvbexd/Z7koByD/WQkmJ+Vc7IApEyvyHV3QM2Ci8Lz8GUXO3o9lgCelravf3o7Y9efFf8L7LrD8CNzx7TjvMAAayh22LMCnyYbqeIXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=xHW/TqN9; arc=none smtp.client-ip=57.103.66.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="xHW/TqN9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=RqR2RocTuJG7qXywuU1YlEFHpJKHQCBUeEvNifOzZFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=xHW/TqN97XDChCcFruEaaORl5P7pBMQANwXZIuZsgvRrvsNsQaJZsY7+iTHYXuk+y
	 FNaUhP0qCDW1Bq9doKx9IHTTq74M1SXg/6CUnnrH4KzXeEmTALnmAfym5hRT7vi6/T
	 u488695H21lP/m27/SwiLBd0+t0g+mpIOIwrdxowWCz3yVePk/lRDEV2ewBnkLzGSm
	 oFMdFU6CqKVu2xyuim/Xaj+8dJWSmp2ANCfVGYE1AgZeg9dUFHw7Bcuk4ucr2WSCnz
	 mg2U4OiPHNw164T+M3lth0bhckIHlzSKyE9GXim7d+4qTyE04Pju+VboqLLRDI20Md
	 KXXAsgiL/qRmA==
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id AB04718028E0;
	Fri,  4 Jul 2025 13:28:32 +0000 (UTC)
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 6E8D6180349F;
	Fri,  4 Jul 2025 13:26:20 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 04 Jul 2025 21:25:59 +0800
Subject: [PATCH v4 1/8] char: misc: Move drivers/misc/misc_minor_kunit.c to
 drivers/char/
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-rfc_miscdev-v4-1-b48986112d6a@oss.qualcomm.com>
References: <20250704-rfc_miscdev-v4-0-b48986112d6a@oss.qualcomm.com>
In-Reply-To: <20250704-rfc_miscdev-v4-0-b48986112d6a@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwMyBTYWx0ZWRfX8i1W0FpImgL0
 kCnkOwvRyMmSQwMcPlp1Klwf6/FLQV1AQKqKide+5Kipuf4n+jjQsY9SjQFpM6lcLjwquv6ZAVU
 dsG2mugdxc9JFrVbOJlDAsOCAtf2oCwirR/cZov6ui0kSZAJXinJoP3+ftQzgZ+YYalvC/+p8Xb
 rVkzdrTlH9n972Zb+L+fd1YokbzBgC+sFnktsDAqfFy0Njpj74MHW7dMjuezcjQ7wgaB0BzQnl5
 YivT5ll2zW3Xnfr3eq08N4RLt3h/jN72/8bdghiFZgy344nEs7ldTuMPRKi52ER+pHda5LAmw=
X-Proofpoint-GUID: FGd0BYs1e3KRKmcqQgcnTrrfLnABC1a0
X-Proofpoint-ORIG-GUID: FGd0BYs1e3KRKmcqQgcnTrrfLnABC1a0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=914 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2507040103

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

drivers/misc/misc_minor_kunit.c is to test APIs defined in
drivers/char/misc.c, but is not in the same directory as the later.

Move misc_minor_kunit.c to drivers/char/.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/char/Makefile                     | 1 +
 drivers/{misc => char}/misc_minor_kunit.c | 0
 drivers/misc/Makefile                     | 1 -
 3 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index e9b360cdc99a7fee9c70eabcffe9caf763552aa2..7d10d92edcedbff5957d6c5c3426aa9400c94e43 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -6,6 +6,7 @@
 obj-y				+= mem.o random.o
 obj-$(CONFIG_TTY_PRINTK)	+= ttyprintk.o
 obj-y				+= misc.o
+obj-$(CONFIG_TEST_MISC_MINOR)   += misc_minor_kunit.o
 obj-$(CONFIG_ATARI_DSP56K)	+= dsp56k.o
 obj-$(CONFIG_VIRTIO_CONSOLE)	+= virtio_console.o
 obj-$(CONFIG_UV_MMTIMER)	+= uv_mmtimer.o
diff --git a/drivers/misc/misc_minor_kunit.c b/drivers/char/misc_minor_kunit.c
similarity index 100%
rename from drivers/misc/misc_minor_kunit.c
rename to drivers/char/misc_minor_kunit.c
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 917b9a7183aa1db63cc4049c042c3437f6756a1a..94f44e6c2db79dedc3839bbfb53e10cde103fbc6 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -23,7 +23,6 @@ obj-$(CONFIG_SENSORS_BH1770)	+= bh1770glc.o
 obj-$(CONFIG_SENSORS_APDS990X)	+= apds990x.o
 obj-$(CONFIG_ENCLOSURE_SERVICES) += enclosure.o
 obj-$(CONFIG_KGDB_TESTS)	+= kgdbts.o
-obj-$(CONFIG_TEST_MISC_MINOR)	+= misc_minor_kunit.o
 obj-$(CONFIG_SGI_XP)		+= sgi-xp/
 obj-$(CONFIG_SGI_GRU)		+= sgi-gru/
 obj-$(CONFIG_SMPRO_ERRMON)	+= smpro-errmon.o

-- 
2.34.1

