Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2781C6FE1
	for <sparclinux@vger.kernel.org>; Sun, 19 Oct 2025 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760889296; cv=none; b=ER2AX/aa73QtVgYp/WZihgzHAiWZYarptE0X53Iepe3nzazMoXkqPPP3qjv0dicFoEVKD4Hu1BlPw2IMIjx6+G4IDKvRvsLfN4J6/Qe1uC2hxK/GmBIKjvGexjQ4IYEYXdhTV3t/xvkrKNPuI7vNvcT5Cw0RFvrj6dUF6+HmSBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760889296; c=relaxed/simple;
	bh=Kv8FykNjZdNKdaZQuWaJHnq1gsN2uv1owuehLPeqsaA=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=LvflwtdgEwVJab54zFcRumtwo8fKc8EOkmyOoUNjZAQyK2CL4nLpTj/vQQW55lz4ORheCsJDY+6fBnh/JTaUyDWWHWJ/brGWFdMxFK2SSyLKs+oq0lptZdo6UN1Qh/kG6yo5s/QyW8XnnOT4W6fYxBqs5M0Da16pf01vSWpkQXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Z5UpwKXh; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Z5UpwKXh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=91BFXC8YCib5eeoZoKJfLdi2FZJ7lm49DhQVoKX3uB0=; t=1760889293; x=1761494093; 
	b=Z5UpwKXhcoNaJcGK6IZy7Mnzwn9aJKYmabDNmL/7gssTVWWDf6updxd+GmbMN+bTKod0N7gde2F
	BvElj5vEUUhNdVszwORPpTtIFycY2cHn1fXMkJwKZdnWfV7fHiaSB6T9WbkzZhSv9aDhZOTz1icAW
	QfRtcN2sZm1zZiX5oPtxcVnalxrcn2LErlooYNLHurNAE47hl25HWmTxgSTt25nhhnIGhmUV1z0L2
	KFW6ugrr37gsw2Y0qA0kE9Md6rYLy8mc7arL53Ad4CsUMOK88OB8XRrla8vlIBQcNQ/clfY0269q3
	icDGKrMKXiMj+oj4DvNq1rZ5gYox+seEfLTQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vAVgg-000000036qU-2gQ7; Sun, 19 Oct 2025 17:51:14 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vAVgg-000000006LC-1kdN; Sun, 19 Oct 2025 17:51:14 +0200
Message-ID: <e61027c249c88484a77d2e1dd2a42d2bc1e2ac06.camel@physik.fu-berlin.de>
Subject: New Debian sparc64 test kernel for stack corruption issue
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
Date: Sun, 19 Oct 2025 17:51:13 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

NRoach44 on the #debian-ports IRC channel has determined that turning off
the following two configuration options in the Linux kernel,

- CONFIG_SLAB_FREELIST_HARDENED
- CONFIG_SLAB_FREELIST_RANDOM

fixes the following crash:

[   25.528376] Kernel panic - not syncing: corrupted stack end detected ins=
ide scheduler
[   25.528384] CPU: 149 UID: 0 PID: 2305 Comm: (udev-worker) Tainted: G    =
    W           6.17.3-1760771931-debmod #13 NONE=20
[   25.528395] Tainted: [W]=3DWARN
[   25.528399] Call Trace:
[   25.528403] [<0000000000433cd4>] dump_stack+0x8/0x18
[   25.528419] [<00000000004297ac>] vpanic+0xdc/0x318
[   25.528429] [<0000000000429a0c>] panic+0x24/0x30
[   25.528436] [<0000000000be2280>] __schedule+0xa8/0x7bc
[   25.528445] [<0000000000be2b60>] schedule+0x24/0x4c
[   25.528452] [<0000000000be6970>] schedule_timeout+0xc8/0xe4
[   25.528459] [<0000000000be3318>] __wait_for_common+0x78/0xf0
[   25.528466] [<0000000000be3550>] wait_for_completion_timeout+0x1c/0x2c
[   25.528473] [<000000001005e2f4>] usb_start_wait_urb+0x68/0x128 [usbcore]
[   25.528502] [<000000001005e468>] usb_control_msg+0xb4/0xf8 [usbcore]
[   25.528518] [<0000000010051180>] set_port_feature+0x44/0x54 [usbcore]
[   25.528530] [<00000000100530f0>] hub_power_on+0xc8/0xe8 [usbcore]
[   25.528543] [<0000000010054fd8>] hub_activate+0x12c/0x644 [usbcore]
[   25.528557] [<0000000010059438>] hub_probe+0xdd4/0xeb0 [usbcore]
[   25.528570] [<0000000010062360>] usb_probe_interface+0x234/0x26c [usbcor=
e]
[   25.528585] [<0000000000a10a40>] really_probe+0x1ac/0x3b0
[   26.606260] Press Stop-A (L1-A) from sun keyboard or send break
[   26.606260] twice on console to return to the boot prom
[   26.628265] ---[ end Kernel panic - not syncing: corrupted stack end det=
ected inside scheduler ]---

I have created UMP and SMP test kernel Debian packages to verify this:

https://people.debian.org/~glaubitz/sparc64/

Could someone test this kernel? It works for me in a SPARC T4 LDOM.

FWIW, the kernel does *not* yet include the fixes for accurate exception re=
porting [1],
so expect that the kernels may not be stable on older UltraSPARC systems. T=
he fixes for
that will be included in 6.17.3 or newer or 6.18 or newer.

A GitHub issue has been opened for this bug in [2].

Adrian

> [1] https://github.com/sparclinux/issues/issues/1
> [2] https://github.com/sparclinux/issues/issues/14

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
