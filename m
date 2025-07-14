Received: from outbound.pv.icloud.com (p-west1-cluster2-host8-snip4-10.eps.apple.com [57.103.64.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FC926CE12
	for <sparclinux@vger.kernel.org>; Mon, 14 Jul 2025 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507296; cv=none; b=R0hvfV136dE+dN/K49ovXyxUzycxWrfKV1GK39saaQ8xUaIdODPFmNaO4wNdSkN89vY60yo03H33CLbZv+MZtzFfRfFq/rJpqaThoI6fPwvCpK3NBRXxWJ4Tc+NWVOfZ0P2fUHya3PGoV9xxvyLv4pO04IrCwmWaCsQifZubiNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507296; c=relaxed/simple;
	bh=TTuqobUufVwrnwuD1IpvKVLEgpKlWt0plFOqbx/QrjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OVv8zayfSiCVxnasPLTqY8fHTsVZ07Icwaz+B24+1wil8H2zjItqILstwqQZ98nJNWwAJfmVLtJH/bzVZ0n+kcwvj2pdei0SZkJ9fVXuJwlRMfnn0ewutZAmMUVVZxVE13IFCS4bfS2eCkUFAd0aRoeh+T22TUSqxnr2bF/M5/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Bz+j76Ap; arc=none smtp.client-ip=57.103.64.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Bz+j76Ap"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 6EEFD1801880;
	Mon, 14 Jul 2025 15:34:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=wluaQIx6vNF4mIxEAfAmvtmQ3di1DI0LWcOfCkaux/0=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=Bz+j76ApzBjawY/3TpvihGTDAxWLfwc1I8VLCVMAaMLvsoGvOc5JC0ctaXXbjj9nkAgZrz/1cgnKI8/Ia+5TVXwIuXm4K1AQHXkMx52VQHNx3cxxlnFfSX4jnRWRZrlsDF2vDmh+aYWqsjmJtXrTHxlP3W6cTyqP2sqC/QV2fpENmDBTXi8CsAVkQ1qALiEue6qk3SKyUs2YEMRd64xuyDJzZse9wQ8uaze20y3XQLcMwy6hGchrjxu4+4AksD57IyW18A/t5s45/fOUUVKD1MHvdDnA7UtDAZmxSu62/yz9WEfZz0Ay4AZ9wlZf/ujrK0RLKfIh8u82REKpr0MARg==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id BBD0F180048E;
	Mon, 14 Jul 2025 15:34:48 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 14 Jul 2025 23:34:14 +0800
Subject: [PATCH v6 3/8] char: misc: Disallow registering miscdevice whose
 minor > MISC_DYNAMIC_MINOR
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-rfc_miscdev-v6-3-2ed949665bde@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MyBTYWx0ZWRfX+/898YEU3enI
 D9VTEule/6ak4DxfVWMjjssMMXh2InYWKlTvX4OxHzkXwmC/2tbmF9Fr0R2agQYPwHQ/GerCNhY
 Y0BgeVjPYAszPTKyoytAheLWGQWDZUCCwOGLRKD6mnwj/SeRBoGgzg3eBzV1u4MlTxI7rfrZI5h
 2HOXzLvAxaIK01SVj/LjQ84vAUZ6d4zJwd4eqWIwNXlPks6FkMLjvEPTQa5Kf3u6ni85U9jvDVE
 srN1qk6/9KglhmS6t1fquO0bXMiPm29kMzJRI6hvQkSUz108g9gdKMo9hcvMgmVRsKKWKrNug=
X-Proofpoint-GUID: mt4cdlquCnfqFGgMLV1eLZ1npNrDguKk
X-Proofpoint-ORIG-GUID: mt4cdlquCnfqFGgMLV1eLZ1npNrDguKk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0
 clxscore=1015 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507140093

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

Currently, It is allowed to register miscdevice with minor > 255
which is defined by macro MISC_DYNAMIC_MINOR, and cause:

- Chaos regarding division and management of minor codes.
- Registering failure if the minor was allocated to other dynamic request.

Fortunately, in-kernel users have not had such usage yet.
Fix by refusing to register miscdevice whose minor > 255.

Also bring in a very simple minor code space division and management:

<  255 : Fixed minor code
== 255 : Indicator to request dynamic minor code
>  255 : Dynamic minor code requested, 1048320 minor codes totally
And all fixed minors allocated should be registered in 'linux/miscdevice.h'

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/char/misc.c        | 6 ++++++
 include/linux/miscdevice.h | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 558302a64dd908aee30341547a5413df1af71459..b8e66466184fa21fb66d968db7950e0b5669ac43 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -210,6 +210,12 @@ int misc_register(struct miscdevice *misc)
 	int err = 0;
 	bool is_dynamic = (misc->minor == MISC_DYNAMIC_MINOR);
 
+	if (misc->minor > MISC_DYNAMIC_MINOR) {
+		pr_err("Invalid fixed minor %d for miscdevice '%s'\n",
+		       misc->minor, misc->name);
+		return -EINVAL;
+	}
+
 	INIT_LIST_HEAD(&misc->list);
 
 	mutex_lock(&misc_mtx);
diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index 3e6deb00fc8535a7571f85489c74979e18385bad..565b88efeb23d02b7d91df1cd7df4bdcf2898224 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -71,6 +71,14 @@
 #define USERIO_MINOR		240
 #define VHOST_VSOCK_MINOR	241
 #define RFKILL_MINOR		242
+
+/*
+ * Misc char device minor code space division related to below macro:
+ *
+ * <  255  : Fixed minor code
+ * == 255  : Indicator to request dynamic minor code
+ * >  255  : Dynamic minor code requested, 1048320 minor codes totally.
+ */
 #define MISC_DYNAMIC_MINOR	255
 
 struct miscdevice {

-- 
2.34.1

