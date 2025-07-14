Received: from outbound.pv.icloud.com (p-west1-cluster5-host1-snip4-1.eps.apple.com [57.103.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6864026E710
	for <sparclinux@vger.kernel.org>; Mon, 14 Jul 2025 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507306; cv=none; b=bbNVSMIESwAihF1AI7VWrnLVsXhWmcIHSRo/TKxwvWdS6hyJ3zGKjLdiY2Ovf2GNL9hSTXeBz9tZmog1yNe3sKe2byBkfnZW9k0ryUrTr9WvDIlOr1x3ZV1QiWSWtHoNJIZnWdmSiJnUD1NPeJ3YEQxv5d1O6MOz8MCA+z9+qB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507306; c=relaxed/simple;
	bh=eshisZtYAF5M0I/Zut15wV8ExZsTXycJdpBzHiNHH1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PHbeCyuqucViSCkKbowmwKJZcwY5RQfyXbnZcEPyUsRgvypq8sxYwa54ydFkTuyQNzbk9Sgt0QoC+8ICyHn9Rg+EGc/dRnNdGfvvHxqbIn7sV7hkLx7EaeLGo6H2i6pxB22ATvB55ANL7nIcveNMs9OLwoNITqLbJ0EuapiPAik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=TwqYTf6b; arc=none smtp.client-ip=57.103.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="TwqYTf6b"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 1951A18001D6;
	Mon, 14 Jul 2025 15:35:00 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=BCo7Uun6O1breLXuGzMI+t3D8x2YIh7KSj6H+MOUQrQ=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=TwqYTf6bj5RX+JLlCSfqq3FknjM6iAHH28uV1ZiVUYhFHn8Wcim9Ipc5Nz6kBcCKh3TpWp6dMx7z98gXe0hIILfMtSgRC/GUGZJoXNzAtmJ24IkjrOTwPimn3VINzZ4mCs0TH0kWsG0xTFHVGNM53Ew+Kc+bUKDzSwUoHlJcERqwv6piEsl9har024hIxKUjdG+Bnq9hhlp7c68j8Ew4I1Ci+s164TSTW9JOb8B4orUPElHUVCIn9y4lwo7i56ignx5fhEUa4jlgWN/2eeOOOepedJQrtg5/W+OPB04HEllJu/KcmGKCbxhxJKqDPGhZCK1i75KTdFMKkixpCTTt3A==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id E2C641801886;
	Mon, 14 Jul 2025 15:34:56 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 14 Jul 2025 23:34:16 +0800
Subject: [PATCH v6 5/8] char: misc: Make misc_register() reentry for
 miscdevice who wants dynamic minor
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-rfc_miscdev-v6-5-2ed949665bde@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: HNaKUjZ26-DxH1C_2H7Pe8wga-WN7GGw
X-Proofpoint-GUID: HNaKUjZ26-DxH1C_2H7Pe8wga-WN7GGw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MyBTYWx0ZWRfXyjLFBeOX2rTe
 TkR1yBQDUrEzCze/iVhxTemxyhhJeo10nFosoNwj01K27CapgwcuGZVXSTQssP4nRapgcPntZAf
 SbTZweO7pT10ACdNoKMT3Wv9CXC2llQSkPRt2vAQRllQ+JxNNJFFgAJxJSyloHZIZbFeqVlRcZn
 yU+nFBu5XtNKz5j1ortgkBFBPgi4fIveMLbv4qYvP5QZnrIEgOxwGQtBvUYiEyJMGfmMAF+SrKH
 CoTf5pKs88hswiYCr/o9fnKhXNNbhnByEKzP5wU7TYv+ZSzpogfUEtR5Nce3u6mWbNjR+s6cc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506060001 definitions=main-2507140093

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

For miscdevice who wants dynamic minor, it may fail to be registered again
without reinitialization after being de-registered, which is illustrated
by kunit test case miscdev_test_dynamic_reentry() newly added.

There is a real case found by cascardo when a part of minor range were
contained by range [0, 255):

1) wmi/dell-smbios registered minor 122, and acpi_thermal_rel registered
   minor 123
2) unbind "int3400 thermal" driver from its device, this will de-register
   acpi_thermal_rel
3) rmmod then insmod dell_smbios again, now wmi/dell-smbios is using minor
   123
4) bind the device to "int3400 thermal" driver again, acpi_thermal_rel
   fails to register.

Some drivers may reuse the miscdevice structure after they are deregistered
If the intention is to allocate a dynamic minor, if the minor number is not
reset to MISC_DYNAMIC_MINOR before calling misc_register(), it will try to
register a previously dynamically allocated minor number, which may have
been registered by a different driver.

One such case is the acpi_thermal_rel misc device, registered by the
int3400 thermal driver. If the device is unbound from the driver and later
bound, if there was another dynamic misc device registered in between, it
would fail to register the acpi_thermal_rel misc device. Other drivers
behave similarly.

Actually, this kind of issue is prone to happen if APIs
misc_register()/misc_deregister() are invoked by driver's
probe()/remove() separately.

Instead of fixing all the drivers, just reset the minor member to
MISC_DYNAMIC_MINOR in misc_deregister() in case it was a dynamically
allocated minor number, as error handling of misc_register() does.

Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>

---
Thank you cascardo for sharing a real case and help to rework commit
message. (^^)(^^)
---
 drivers/char/misc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index b8e66466184fa21fb66d968db7950e0b5669ac43..96ed343cf5c8509a09855020049a9af82a3ede95 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -288,6 +288,8 @@ void misc_deregister(struct miscdevice *misc)
 	list_del(&misc->list);
 	device_destroy(&misc_class, MKDEV(MISC_MAJOR, misc->minor));
 	misc_minor_free(misc->minor);
+	if (misc->minor > MISC_DYNAMIC_MINOR)
+		misc->minor = MISC_DYNAMIC_MINOR;
 	mutex_unlock(&misc_mtx);
 }
 EXPORT_SYMBOL(misc_deregister);

-- 
2.34.1

