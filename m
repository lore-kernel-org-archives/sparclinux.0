Received: from outbound.pv.icloud.com (p-west1-cluster3-host7-snip4-10.eps.apple.com [57.103.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77582701BA
	for <sparclinux@vger.kernel.org>; Wed,  2 Jul 2025 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751458574; cv=none; b=X+0jb08l9SZD0jrURppda8VCvlGbLpYyGTDTZURTPaE9dHZUVG27CEsApJIAlFdzQ1FhONuiS0St3KMZT2QXhHvUWeKIt3Q6bvtxSTBTKgcE6hfFizQxcCQuDsrpyto9VPKOSY/Vt+hcD+BIzP8kfkeJWQLtB7eIXoPqI0j4ZAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751458574; c=relaxed/simple;
	bh=GCOMtzNGxPOUXBf3m2hfp4nlIguiGZVOTq0XkcMtEDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DHtF7asfKYKQ0cJUjgiVb2e15a4UVux7lAGrWI24/ewDavqxeW3dbPyY+hBV3++8/GhymK+ell9vRJB7P1PWoRnFSbBZKAa0irtptQR8nVD+rjRgOj2SJfwYr996KIEhjotl/9zBzxwv2DNiz0+eXvirfwTfIVEXsuJ0MUE+KfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Eh/7ipCu; arc=none smtp.client-ip=57.103.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Eh/7ipCu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=RqR2RocTuJG7qXywuU1YlEFHpJKHQCBUeEvNifOzZFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=Eh/7ipCuB037F477F8d6elXXNg3J92aI4Pd6TvTWF/DZkb9FV2UBk0U7b87tz0XnT
	 5UDia5Cobz+MSrgQTpjdtJuxvOQh8UJXaGwvEYSztKCF8hNUdDr5amk+ElxGKHeKll
	 suG1hkZt7hC56Z6YqeZW0eLewT0qwP/3dB6//LF/8BIUKK3Urd3wYqRAXBEczzGb5e
	 x5vQGXcJW3bUF7GZdKpNJKyVBDMTTp1EOY8+TxTrgo+kZ85OTvcVUjYtJ3BiNsGjuT
	 yHwfaBdu6TQX4TK5VLiZTYzoSXEGGBjDHt6UpzAyQwKsvqc8K7Mm2Tym/1xpPpcMIP
	 n3XuofTOs9apQ==
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 8E8D918001C1;
	Wed,  2 Jul 2025 12:16:10 +0000 (UTC)
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 018E018002A8;
	Wed,  2 Jul 2025 12:16:07 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 02 Jul 2025 20:15:29 +0800
Subject: [PATCH v3 1/8] char: misc: Move drivers/misc/misc_minor_kunit.c to
 drivers/char/
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-rfc_miscdev-v3-1-d8925de7893d@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: rt-yOLfEan5MKj4mvMKR0bi2e9OEmHq_
X-Proofpoint-GUID: rt-yOLfEan5MKj4mvMKR0bi2e9OEmHq_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA5OSBTYWx0ZWRfX5jWvyHvcI4k0
 pMqkbXbXet5KK1MW5p/MXHMv19kLDG8Oud1Z/YFNiJ20yefI2r0ckJW5MU8LKT32+I7DwlIHegW
 uEnWvQelZ6H/Ya5h4Mv4b/4LaxP/m9idxQW5y5zn7zt3hRxvVJfBeGD9hxDehlG0BIuEe2HxCZO
 iNKmxxbQcgImhOsC1rrjgUGdRr8Fl9wduHwgYqKr2dPUbZC35oPxF2yrMFvf72mBOxILqbPOOZx
 vTFo6/1aK/pHRLhxji9yazJ7OJqH921FN1rdklCUlqjzQeV1J/6yHGq06VvNhr6cfLXcNMCrs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0
 mlxlogscore=913 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507020099

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

