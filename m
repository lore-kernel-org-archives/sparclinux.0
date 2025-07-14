Received: from outbound.pv.icloud.com (p-west1-cluster5-host5-snip4-10.eps.apple.com [57.103.66.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0B2265CC5
	for <sparclinux@vger.kernel.org>; Mon, 14 Jul 2025 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507290; cv=none; b=h8A2UDDmsvCamQ9iQPQs1MqAN2zNCHZSv2lrKsznvU1cLkUA430R2LmTgy/Kj0H9KWVOYhiVaP7ZUqeQsTSMW1H170MNf9Qr+PDjARZ/Ac0iD5zkCijGwOUqEIxn+FIcjR7kkRNk7F4JX8xChaOqI6vRdg4wa4tvyG2zZNt8bIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507290; c=relaxed/simple;
	bh=1Rhoe7BHxRF/MuarYDxZKPJyK9zbtaR0YOq3N+f0hSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jIydfxG4v/xY3VHa0y3m/Bz63nazQqWrN1l4QngPJzjMyTleSAmkH53Tw2gVFi9oLVJOcapti4j7GVZTOU+WPSD7Xi0o9Lyr+Ug5SHjJtyjaKkHSnpXPsAK0cmghGiY0/yGG/Hk5dCAid28uM16v3SyRNg2E3V6gyWI1sHeW26o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=pgninnp4; arc=none smtp.client-ip=57.103.66.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="pgninnp4"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 8190618004B8;
	Mon, 14 Jul 2025 15:34:45 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=3cxFlBecLs+olRGOsshuIdceYjGpKxI6JcAkEkmJa30=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=pgninnp4Cy8NiifPte6Sc5Oo3xNMRQ6jmY3JLYJDP6g0+Bg9iI71G/pWC33fB13ODyJHKE4bcqVkDqV/1ucbarB1pVCotOs7SLbY4NWIBLPY7I6R8YQ+zpUCxOz6dPM7jYBBtqo7awwcIuGmnSuyXBuPRZbQRlM2jaN3Wo/40LcyhRoSCFnxzdXX2w62LynZsMKA16dXxO87pazeWgO5NxxjFGuERDl+ZdR8wZ9l45+w3Ot9cC/jg54pR6nPz+hbFp3e8qeSajPD60oFQ2FqWibl44oxUqX/Ad8586S/kYesD/KyeMOHCumk3tp4w0rrKKilIUKVCmxi/YVGqHBlwQ==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 5B7E918004B9;
	Mon, 14 Jul 2025 15:34:39 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 14 Jul 2025 23:34:12 +0800
Subject: [PATCH v6 1/8] char: misc: Move drivers/misc/misc_minor_kunit.c to
 drivers/char/
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-rfc_miscdev-v6-1-2ed949665bde@oss.qualcomm.com>
References: <20250714-rfc_miscdev-v6-0-2ed949665bde@oss.qualcomm.com>
In-Reply-To: <20250714-rfc_miscdev-v6-0-2ed949665bde@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MyBTYWx0ZWRfXypSaXGJZQrSz
 hj6OZS9PrvESYtKA4P+C8XG9F+kR7voe+k6kfNS550Ak5PQzOllyHXPl/3pD8ypElrzGDlXdyc2
 tGrxAvhvltP1GSy8XQyfy+narLBfL6GIEQ7lr0Xt+Mw+sReuPYBsWw5siWvqSlEVveW3/ZuGc8c
 CtVuQ3uhKa7axRmdtunxQ+qJePELhQ7jTH2KlLiUaFb/6a+pqy+z/U5dVEoqz5uV9il50AThkcX
 hfgGZ3JwiqISpb+1aIPqbST6zVo6JIs6RvtG2F+5yN2JefWLPOMC9Gg3uScWTDPKJOra/gNOM=
X-Proofpoint-ORIG-GUID: XrslPMHi9w6wP2WTHeNKJIponVMCJMTG
X-Proofpoint-GUID: XrslPMHi9w6wP2WTHeNKJIponVMCJMTG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=935
 spamscore=0 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507140093

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
index e9b360cdc99a7fee9c70eabcffe9caf763552aa2..1291369b9126511ff41a06f956af4bb1de7ea4b2 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -6,6 +6,7 @@
 obj-y				+= mem.o random.o
 obj-$(CONFIG_TTY_PRINTK)	+= ttyprintk.o
 obj-y				+= misc.o
+obj-$(CONFIG_TEST_MISC_MINOR)	+= misc_minor_kunit.o
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

