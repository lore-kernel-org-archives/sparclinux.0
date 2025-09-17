Received: from libero.it (smtp-31-wd.italiaonline.it [213.209.13.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1184E2FFF9C
	for <sparclinux@vger.kernel.org>; Wed, 17 Sep 2025 13:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.13.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116119; cv=none; b=B1g3tURGZqkZhX++/GmnStEM6vXMQ88zwuIQ1VBwQHf8o/3iSMm36w9E2Vbpy4oY2+D/AZwkaKOyKITkTnrUg+SkypcvWp8E+H47Yog3Td9cFTbZ9GnHpqDt8+50F2xTWSh1YUTegmgEIeBBtgrONh1L/EeQzD37Lg/Wbw6Wwdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116119; c=relaxed/simple;
	bh=EI27L5KPlOQ8c7aeHnUC/aFtcs02j4QZZUkYxjMNKEY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=s68M4T48fDWAXR0KO6rbjDwuc8oX4ZIkh52XDAZCMS66daecv+ZG6EVltgVhfHUuoshEtkKFI0iMwuIi/MGzz5hMI+bwOXqAHvD+Vq9bHPhIY72byiUnon9ExZ60EgSO2Ltpg7k7JIU4k7kJDlYCJIBpPnvtA81tCYzoRF3I0/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=QVLZavbs; arc=none smtp.client-ip=213.209.13.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="QVLZavbs"
Received: from [192.168.1.36] ([151.65.2.228])
	by smtp-31.iol.local with ESMTPA
	id ysJWuZoQO90dBysJWud2fS; Wed, 17 Sep 2025 15:35:14 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1758116114; bh=OOEW9LIk399eD+mvCUwAzhRdza88Ggu28ZYzyiH1AuQ=;
	h=From;
	b=QVLZavbsYFwYMjUKxRVely+bh2YeJTOLUFFnmA8HXyU6P1rl2NusCpUh/S4gumO3k
	 Z8qK1AFaUrgZ1Am2QOLsb1IxgU7TWH3AvIl/UxtLpYl852JA2XZksYou0zhv62sZpN
	 oSgFUELrM0VFwCmZOAmLCDvkt3Do4lUY4Ent2uVMwfo500ZZSobsvGj+W8yWPst1LR
	 hA0DRZRoRZJRfEu21wmP+Gaoi0kYrflymzRG9kGNmmZsrRSYeEZDXDZ4nR2192D4Fv
	 RRJ/xkXDgXqssVYco7ams3QfQkALexIZ3OXzO6oduGFiHtL0sxafHCTvdJpxWxEhvJ
	 S8NrreNHN0MOA==
X-CNFS-Analysis: v=2.4 cv=bNoWIO+Z c=1 sm=1 tr=0 ts=68cab912 cx=a_exe
 a=fUUb/luldTa8vXwyIFcL2Q==:117 a=fUUb/luldTa8vXwyIFcL2Q==:17
 a=IkcTkHD0fZMA:10 a=xNf9USuDAAAA:8 a=3pBUwts7Yp8zufEN8hwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
Subject: Re: New test kernel - second attempt
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
References: <9b8530550078b5e89b19e987981d25fee8e18500.camel@physik.fu-berlin.de>
 <7515a193-5ae2-69d6-9c6e-c3b6c7459f50@libero.it>
 <73e81a8280b345ee09df0dfa9f0e21148144722f.camel@physik.fu-berlin.de>
 <74380961-4a1b-95a7-96f5-448737356082@libero.it>
 <4207162c8254a2b8f423db485f974ca00ae355a3.camel@physik.fu-berlin.de>
From: Riccardo Mottola <riccardo.mottola@libero.it>
Message-ID: <a00eb0eb-5276-0f0b-f983-f14d20c62978@libero.it>
Date: Wed, 17 Sep 2025 15:38:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.21
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4207162c8254a2b8f423db485f974ca00ae355a3.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDkPOB7weANiR4SfU/EekaUy4uOMQmi4Q/g+/iPIFyKE60PS3pfU+Jybcp6J8QebNGVompDjjtEqP67FJ7sy97UcEzIYvkB9WJj4NPSkH3ItL3NGzUEy
 bF8Lr8QbSP3JfA5042pDjdP10xAcfxk8g+LTNeoTQxj1fpvXMH9l+4HW7E4alkfnxU+MsdJCH3vNwU2A788ulf4gbCCFFvAWngT0KwYCe0je+y16zWWOK3ba
 japMvjc5GioTy4auClhS9m8+Y3xOIWkL+6dKqV6jCPS0SXf3VcbwxlMxtEy//Ugf

Hi Adrian!

Sure!

John Paul Adrian Glaubitz wrote:
> Can you try this upstream kernel:
>
> https://people.debian.org/~glaubitz/sparc64/
>
> Copy vmlinux-6.17.0-rc5+, config-6.17.0-rc5+ and System.map-6.17.0-rc5+ into /boot.
>
> Extract mods-6.17.0-rc5+.tgz somewhere and move the "6.17.0-rc5+" folder in the
> mods/lib/modules directory into /lib/modules, then run:
>
> $ update-initramfs -c -k 6.17.0-rc5+ -v
> $ update-grub
>
> Then reboot into this kernel and report back.

Still fails, but there is more error reporting:
[    9.358051] mptsas 0000:07:00.0: Unable to change power state from 
D3cold to D0, device inaccessible
[    9.695479] NON-RESUMABLE ERROR: Reporting on cpu 24
[    9.695655] NON-RESUMABLE ERROR: TPC [0x0000000010168064] 
<MakeIocReady+0x10/0x294 [mptbase]>
[    9.695821] NON-RESUMABLE ERROR: RAW 
[1810000000000007:0000000c3414f764:0000000202000004:000000ea00300000
[    9.695913] NON-RESUMABLE ERROR: 
0000000000180000:0000000000000000:0000000000000000:0000000000000000]
[    9.695998] NON-RESUMABLE ERROR: handle [0x1810000000000007] stick 
[0x0000000c3414f764]
[    9.696071] NON-RESUMABLE ERROR: type [precise nonresumable]
[    9.696133] NON-RESUMABLE ERROR: attrs [0x02000004] < PIO sp-faulted 
priv >
[    9.696238] NON-RESUMABLE ERROR: raddr [0x000000ea00300000]
[    9.697323] Kernel panic - not syncing: Non-resumable error.
[    9.697391] CPU: 24 UID: 0 PID: 296 Comm: (udev-worker) Not tainted 
6.17.0-rc5+ #1 NONE
[    9.697476] Call Trace:
[    9.697517] [<0000000000436b54>] dump_stack+0x8/0x18
[    9.697595] [<00000000004294c4>] vpanic+0xdc/0x310
[    9.697663] [<000000000042971c>] panic+0x24/0x30
[    9.697726] [<000000000043aea0>] sun4v_nonresum_error+0x140/0x200
[    9.697812] [<0000000000406eb8>] sun4v_nonres_mondo+0xc8/0xd8
[    9.697901] [<0000000010168064>] MakeIocReady+0x10/0x294 [mptbase]
[    9.697995] [<00000000101684e0>] mpt_do_ioc_recovery+0xa0/0x11b4 
[mptbase]
[    9.698101] [<0000000010167748>] mpt_attach+0xae8/0xca0 [mptbase]
[    9.698204] [<00000000101bc010>] mptsas_probe+0x10/0x440 [mptsas]
[    9.698333] [<0000000000b380d4>] local_pci_probe+0x34/0x80
[    9.698433] [<0000000000b39094>] pci_device_probe+0xb4/0x200
[    9.698520] [<0000000000c05e48>] really_probe+0xc8/0x420
[    9.698612] [<0000000000c0622c>] __driver_probe_device+0x8c/0x160
[    9.698706] [<0000000000c063e8>] driver_probe_device+0x28/0xe0
[    9.698799] [<0000000000c066c4>] __driver_attach+0xe4/0x1e0
[    9.698891] [<0000000000c03714>] bus_for_each_dev+0x54/0xc0
[   10.320382] Press Stop-A (L1-A) from sun keyboard or send break
[   10.320382] twice on console to return to the boot prom
[   10.320546] ---[ end Kernel panic - not syncing: Non-resumable error. 
]---


I retried and had the quickness to clear console screen to be sure of 
message and see this:

Loading initial ramdisk .....

[    9.337432] mptsas 0000:07:00.0: Unable to change power state from 
D3cold to D0, device inaccessible
[    9.674834] NON-RESUMABLE ERROR: Reporting on cpu 11
[    9.675005] NON-RESUMABLE ERROR: TPC [0x0000000010102064] 
<MakeIocReady+0x10/0x294 [mptbase]>
[    9.675166] NON-RESUMABLE ERROR: RAW 
[0b10000000000007:0000000cde51497c:0000000202000004:000000ea00300000
[    9.675248] NON-RESUMABLE ERROR: 
00000000000b0000:0000000000000000:0000000000000000:0000000000000000]
[    9.675327] NON-RESUMABLE ERROR: handle [0x0b10000000000007] stick 
[0x0000000cde51497c]
[    9.675399] NON-RESUMABLE ERROR: type [precise nonresumable]
[    9.675461] NON-RESUMABLE ERROR: attrs [0x02000004] < PIO sp-faulted 
priv >
[    9.675565] NON-RESUMABLE ERROR: raddr [0x000000ea00300000]
[    9.676654] Kernel panic - not syncing: Non-resumable error.
[    9.676722] CPU: 11 UID: 0 PID: 305 Comm: (udev-worker) Not tainted 
6.17.0-rc5+ #1 NONE
[    9.676808] Call Trace:
[    9.676849] [<0000000000436b54>] dump_stack+0x8/0x18
[    9.676926] [<00000000004294c4>] vpanic+0xdc/0x310
[    9.676994] [<000000000042971c>] panic+0x24/0x30
[    9.677057] [<000000000043aea0>] sun4v_nonresum_error+0x140/0x200
[    9.677142] [<0000000000406eb8>] sun4v_nonres_mondo+0xc8/0xd8
[    9.677232] [<0000000010102064>] MakeIocReady+0x10/0x294 [mptbase]
[    9.677325] [<00000000101024e0>] mpt_do_ioc_recovery+0xa0/0x11b4 
[mptbase]
[    9.677431] [<0000000010101748>] mpt_attach+0xae8/0xca0 [mptbase]
[    9.677534] [<000000001019c010>] mptsas_probe+0x10/0x440 [mptsas]
[    9.677664] [<0000000000b380d4>] local_pci_probe+0x34/0x80
[    9.677765] [<0000000000b39094>] pci_device_probe+0xb4/0x200
[    9.677851] [<0000000000c05e48>] really_probe+0xc8/0x420
[    9.677943] [<0000000000c0622c>] __driver_probe_device+0x8c/0x160
[    9.678036] [<0000000000c063e8>] driver_probe_device+0x28/0xe0
[    9.678129] [<0000000000c066c4>] __driver_attach+0xe4/0x1e0
[    9.678221] [<0000000000c03714>] bus_for_each_dev+0x54/0xc0
[   10.299883] Press Stop-A (L1-A) from sun keyboard or send break
[   10.299883] twice on console to return to the boot prom
[   10.300200] ---[ end Kernel panic - not syncing: Non-resumable error. 
]---


so still random CPU/cores. Does this help, though?

Riccardo
