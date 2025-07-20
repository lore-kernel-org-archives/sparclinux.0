Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87C93D6F
	for <sparclinux@vger.kernel.org>; Sun, 20 Jul 2025 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753023794; cv=none; b=TCI/92KPfKs22cIpetzxiO9OdoKT/1AYGvdt/Sff+CVE1Rpb22D3xZkVbNMGRjE79Blr3gJ4a4OXvTbx7T6zrIiuNa1axT9Kmax9YokpYaoKgBvltKpxao9VipztBBHzY3Ga+KWF7vSP1cmBk534C+mFJ1DFU680Z5KtL3Ju9Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753023794; c=relaxed/simple;
	bh=z5iheq0MsCxhZz8Cq4wNrZJBOLwChcpz8nX6QbzziUE=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=FBXFnpkvCch7Mn2xobsQSBaIugFKczfJCtAXPNkJ9LA77BbNnfqM9/yVJ8+K6UU+fbDyZ95IdlD2S2UbgX0IwNpVwI2zW+G87EDo+iIRz8XirwUShngKnBS6r7Ix/wIzSqq72Uwv/UakPp7YgZcj90isxga3qGjGeVolgQ8m+ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=LHgdKx6t; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="LHgdKx6t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=d4M+DCDjP+EqUUyWvgQ3W5FA406wjWQJkv077a079Nw=; t=1753023790; x=1753628590; 
	b=LHgdKx6tFzmVjKaTUH28hrEiVhNswpdUw97K2hAOGOxvueLGVYOuGaJmSPdIaFjhYwkjQb436Lq
	MZP1eVgdoODQE9WsfyKRp8wBjptef9QRvMIEKZyPlelTniaGxVfSFvsERKL7xgtykNBgZNLC2oTAU
	gfoBP3qo8ssPb1kuio5yKrzFbBTyr2Hz+lUNGJVluoqqAoypb6pGETIJ0QqpeT6MCXIPoXiRc0hLk
	qza4qAyWDR5DxDto8YuoTmd/+F6Ajqe7SU7L9k7+sl2A7HVzbk6YM7t6gy/WC+Xstg7hSCavQoRrw
	xnFZZy4JO9a9vnPEuxtLfjGC1eWG8FH43iBQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1udVZ8-00000001TIU-3abN; Sun, 20 Jul 2025 17:03:02 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1udVZ8-00000004A0C-2gFE; Sun, 20 Jul 2025 17:03:02 +0200
Message-ID: <087ac21b8faf451cd7119d0919a6be717df946c9.camel@physik.fu-berlin.de>
Subject: Kernel stacktrace on sun4v during boot
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: sparclinux <sparclinux@vger.kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Date: Sun, 20 Jul 2025 17:03:01 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

I noticed a kernel stacktrace on sun4v starting with Linux v6.12 with the D=
ebian
kernel (see below). I tested multiple kernels and was not able to reproduce=
 the
issue with older kernels and interestingly also not with v6.16-rc6, so this=
 issue
may have been fixed with v6.16.

In order to make sure the issue is not hidden by configuration differences =
between
the Debian and upstream kernel, I built the exact same configuration like D=
ebian
just with kernel and module signing disabled.

So, either the issue will be fixed with v6.16 or Debian is carrying a local=
 patch
which introduces this issue (unlikely as Debian does not have sparc-specifi=
c patches
in its kernel package.

Adrian

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

[    1.917534] ------------[ cut here ]------------
[    1.917573] WARNING: CPU: 0 PID: 267 at lib/kobject.c:734 kobject_put+0x=
64/0x240
[    1.917609] kobject: '(null)' ((____ptrval____)): is not initialized, ye=
t kobject_put() is being called.
[    1.917627] Modules linked in:
[    1.917647] CPU: 0 UID: 0 PID: 267 Comm: kworker/u256:8 Not tainted 6.12=
.38+deb13-sparc64-smp #1  Debian 6.12.38-1
[    1.917658] Workqueue: async async_run_entry_fn
[    1.917672] Call Trace:
[    1.917676] [<0000000000f11864>] dump_stack+0x8/0x18
[    1.917688] [<000000000046e15c>] __warn+0xdc/0x140
[    1.917697] [<000000000046e2d8>] warn_slowpath_fmt+0x118/0x140
[    1.917704] [<0000000000ec8024>] kobject_put+0x64/0x240
[    1.917712] [<000000000072d98c>] sysfs_slab_release+0xc/0x20
[    1.917726] [<00000000006dc91c>] kmem_cache_destroy+0xdc/0x1a0
[    1.917741] [<00000000009593c4>] bioset_exit+0x144/0x1e0
[    1.917753] [<000000000097a8d4>] disk_release+0x54/0x120
[    1.917766] [<0000000000b94a0c>] device_release+0x2c/0xa0
[    1.917776] [<0000000000ec8088>] kobject_put+0xc8/0x240
[    1.917784] [<0000000000b94c74>] put_device+0x14/0x40
[    1.917791] [<000000000097ac58>] put_disk+0x18/0x40
[    1.917799] [<000000000140c2c8>] floppy_async_init+0xbec/0xd10
[    1.917811] [<00000000004a0cc8>] async_run_entry_fn+0x28/0x160
[    1.917818] [<000000000049091c>] process_one_work+0x15c/0x3c0
[    1.917828] [<0000000000490f24>] worker_thread+0x164/0x3e0
[    1.917837] ---[ end trace 0000000000000000 ]---
[    1.917996] ------------[ cut here ]------------
[    1.918007] WARNING: CPU: 0 PID: 267 at lib/refcount.c:28 refcount_warn_=
saturate+0x18c/0x1a0
[    1.918032] refcount_t: underflow; use-after-free.
[    1.918043] Modules linked in:
[    1.918059] CPU: 0 UID: 0 PID: 267 Comm: kworker/u256:8 Tainted: G      =
  W          6.12.38+deb13-sparc64-smp #1  Debian 6.12.38-1
[    1.918069] Tainted: [W]=3DWARN
[    1.918073] Workqueue: async async_run_entry_fn
[    1.918080] Call Trace:
[    1.918082] [<0000000000f11864>] dump_stack+0x8/0x18
[    1.918090] [<000000000046e15c>] __warn+0xdc/0x140
[    1.918097] [<000000000046e2d8>] warn_slowpath_fmt+0x118/0x140
[    1.918103] [<00000000009d4d2c>] refcount_warn_saturate+0x18c/0x1a0
[    1.918111] [<0000000000ec8134>] kobject_put+0x174/0x240
[    1.918119] [<000000000072d98c>] sysfs_slab_release+0xc/0x20
[    1.918128] [<00000000006dc91c>] kmem_cache_destroy+0xdc/0x1a0
[    1.918135] [<00000000009593c4>] bioset_exit+0x144/0x1e0
[    1.918143] [<000000000097a8d4>] disk_release+0x54/0x120
[    1.918151] [<0000000000b94a0c>] device_release+0x2c/0xa0
[    1.918158] [<0000000000ec8088>] kobject_put+0xc8/0x240
[    1.918166] [<0000000000b94c74>] put_device+0x14/0x40
[    1.918173] [<000000000097ac58>] put_disk+0x18/0x40
[    1.918181] [<000000000140c2c8>] floppy_async_init+0xbec/0xd10
[    1.918189] [<00000000004a0cc8>] async_run_entry_fn+0x28/0x160
[    1.918196] [<000000000049091c>] process_one_work+0x15c/0x3c0
[    1.918204] ---[ end trace 0000000000000000 ]---

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
