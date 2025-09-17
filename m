Received: from libero.it (smtp-31-wd.italiaonline.it [213.209.13.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FAC2C21E2
	for <sparclinux@vger.kernel.org>; Wed, 17 Sep 2025 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.13.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758109445; cv=none; b=Kg2nySH5Wx67RrqfTsyd9uQU+Cg07SUrN0jzWg6dhvlU4pDPriWwWgMG4KgtusAZd5bS2pE4uyPkaMZirLcGMSNBHq8PPGyg/3EexKSSy8JiUSCajg7OmtYf3OvrZGwTbNczydWrKE7MhDBEdAdS2rs9HBn65/T6tSWS+97g4mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758109445; c=relaxed/simple;
	bh=uPsCMSxefjQ9mV+x77uwprZmLt1rgqhWMHDSvES80mg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JnhsK231hT20Mx9mQKDUCyDxQGTxGr6qLQomiFcUTUFoH5Wcc/gzFP5CcqAvkjIjBRcF+/KcMrWl9TcrCMJhyuNQtWONlkw61RY4AcZXSzwfHMu29owyL8I/moscW/KopAnDKbl3axyMfi9HppO2vPSV3Ap7dd8R1SyrJzhudJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=YpxFaVkD; arc=none smtp.client-ip=213.209.13.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="YpxFaVkD"
Received: from [192.168.1.36] ([151.65.2.228])
	by smtp-31.iol.local with ESMTPA
	id yqZruZ9dX90dByqZrucbtc; Wed, 17 Sep 2025 13:44:00 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1758109440; bh=+E3CbhWYtg5VPxiHUrtkDEuG30eS/dqZmlrwNSLO8zk=;
	h=From;
	b=YpxFaVkDX3gtTFJ+FWYSNSwWD/YWWwvm2ZUsNgcm+mcg3onloEoCAdsECbJm3cg80
	 J3FEJhmNmC0/WgWwd621tNchLo+SWUF5RHcc9NL69zSMy78Bvoeu+MIOqdhyoI7JHY
	 KUMHldH9NqpiS6kMokcp6oiQ3GhF46msnJ2AcR0LkWmbOKHH6n6oQf+kyXLDtN+J7X
	 +wrFpBUXQQHbtvE2YbRUxqsn1igJdMU7HxNmddA/z0BIw378h5iei/Sfwd6nEgwHG5
	 fQzJBOUqKQVlYn3SG/bcUAOPyBuLtrIF6ZSxwUwiANeaLsGvRsIIrPfc6W2w6CU6M7
	 +Crhm7RiVZpow==
X-CNFS-Analysis: v=2.4 cv=bNoWIO+Z c=1 sm=1 tr=0 ts=68ca9f00 cx=a_exe
 a=fUUb/luldTa8vXwyIFcL2Q==:117 a=fUUb/luldTa8vXwyIFcL2Q==:17
 a=IkcTkHD0fZMA:10 a=r4ov-uDk87zQOrktkg4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Subject: Re: New test kernel - second attempt
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
References: <9b8530550078b5e89b19e987981d25fee8e18500.camel@physik.fu-berlin.de>
 <7515a193-5ae2-69d6-9c6e-c3b6c7459f50@libero.it>
 <73e81a8280b345ee09df0dfa9f0e21148144722f.camel@physik.fu-berlin.de>
From: Riccardo Mottola <riccardo.mottola@libero.it>
Message-ID: <74380961-4a1b-95a7-96f5-448737356082@libero.it>
Date: Wed, 17 Sep 2025 13:47:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.21
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <73e81a8280b345ee09df0dfa9f0e21148144722f.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfH2vxOVp+tDRdrpB3GBgeFozBWjpVJ8saeXfslqgPcayjZUZbPmWI0HgRlmk3/T8N5hwKfe7ysYW2Be+o3s34pfCCkthvkc2vfLyzP8hp9EaylKRjkC2
 o4d71GEt9yPbIf+k6H+KWAZtDaZIrR2pw1oas1ePxhqeBKW+wyGdsql270lTtZSkDuEW7PUdNIIVysqEmE+N5otFyGtiwmThqLoXiiFZ7jrYAJY8UGc21ZOr
 9C0tGPYlbChTps3ggUBvg+MUbcqkB+1+hD0aTMVSPTTf3u1xzY87RMRkkpsqlX3D

John Paul Adrian Glaubitz wrote:
> Keep in mind you may have to keep the machine off for a longer time or reset
> the NV-RAM. We've got multiple reports now of machines that became stable
> after that.

With the added experience of console wizardry, I attempted a "cold first 
boot" of the system into this kernel:

Debian GNU/Linux, with Linux 6.12+unreleased-sparc64-smp

I performed from full power-off (pulled socked plugs) direct poweron, 
cycle and first fresh boot into that kernel.

It still crashes this way:
[   10.828819] mptsas 0000:07:00.0: Unable to change power state from 
D3cold to D0, device inaccessible
[   11.166450] NON-RESUMABLE ERROR: Reporting on cpu 
4------------------------+
[   11.166573] NON-RESUMABLE ERROR: TPC [0x000000001017e034] 
<MakeIocReady+0x10/0x298 [mptbase]>
[   11.166810] NON-RESUMABLE ERROR: RAW 
[0410000000000001:0000000cccd2fe4c:0000000202000004:000000ea00300000
[   11.166895] NON-RESUMABLE ERROR: 
0000000000040000:0000000000000000:0000000000000000:0000000000000000]
[   11.166978] NON-RESUMABLE ERROR: handle [0x0410000000000001] stick 
[0x0000000cccd2fe4c]
[   11.167051] NON-RESUMABLE ERROR: type [precise nonresumable]
[   11.167114] NON-RESUMABLE ERROR: attrs [0x02000004] < PIO sp-faulted 
priv >
[   11.167238] NON-RESUMABLE ERROR: raddr [0x000000ea00300000]
[   11.168363] Kernel panic - not syncing: Non-resumable error.
[   11.168443] CPU: 4 UID: 0 PID: 406 Comm: (udev-worker) Not tainted 
6.12+unreleased-sparc64-smp #1  Debian 6.12.43-1+nothp1
[   11.168569] Call Trace:
[   11.168622] [<0000000000eff2b4>] dump_stack+0x8/0x18
[   11.168712] [<0000000000ef1930>] panic+0xf4/0x398
[   11.168791] [<000000000042a48c>] sun4v_nonresum_error+0x16c/0x240
[   11.168887] [<0000000000406eb8>] sun4v_nonres_mondo+0xc8/0xd8
[   11.168990] [<000000001017e034>] MakeIocReady+0x10/0x298 [mptbase]
[   11.169096] [<000000001017e4b4>] mpt_do_ioc_recovery+0x9c/0x1110 
[mptbase]
[   11.169202] [<000000001017d6f8>] mpt_attach+0xb58/0xd20 [mptbase]
[   11.169305] [<0000000010283f30>] mptsas_probe+0x10/0x440 [mptsas]
[   11.169431] [<0000000000ad1fac>] pci_device_probe+0xac/0x180
[   11.169532] [<0000000000b8b8e8>] really_probe+0xc8/0x400
[   11.169625] [<0000000000b8bcac>] __driver_probe_device+0x8c/0x160
[   11.169720] [<0000000000b8be68>] driver_probe_device+0x28/0x100
[   11.169814] [<0000000000b8c11c>] __driver_attach+0xbc/0x1e0
[   11.169908] [<0000000000b8927c>] bus_for_each_dev+0x5c/0xc0
[   11.169998] [<0000000000b8b09c>] driver_attach+0x1c/0x40
[   11.170089] [<0000000000b8a860>] bus_add_driver+0x180/0x240
[   11.791693] Press Stop-A (L1-A) from sun keyboard or send break
[   11.791693] twice on console to return to the boot prom
[   11.792002] ---[ end Kernel panic - not syncing: Non-resumable error. 
]---

At a quick glance the error seems the same as my previous report, but on 
CPU#4 and not CPU#24


Now that I know to switch to alom, I tried "hot reboots" quickly and to 
see if something changed.

Run 2: CPU 17
Run 3: CPU 14


Then I did Poweroff/Poweron (did not pull the socket though)
Run 1: CPU 9
Run 2: CPU 0


I would say it looks "random" and interesting is the last one, CPU 0: it 
looked that it was always a higher number, but well I guess with 32cores...

And I stop here, not going to make 32 reboots to find out !

Riccardo
