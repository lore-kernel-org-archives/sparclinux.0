Received: from libero.it (smtp-36.italiaonline.it [213.209.10.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDA81E1E04
	for <sparclinux@vger.kernel.org>; Tue,  9 Sep 2025 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757439067; cv=none; b=kUbL1+gzp31Gx2p7MZsQMv8WoQE91JmogB09HwrpI/VWWyD6A3bwVKbqONTltPwHVRh0ULQ83iovhzzy7NW4Anf4dO5brEqYbZaAEsjop/SYo4x17oi1MRZcoWbfPp43zB3Hbji1GhzY9PhNB4z77dReuSRDPSeCoqJV8b1GG2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757439067; c=relaxed/simple;
	bh=T7+2N3YVL/fpsmh09Up1UHrMeYAoGit3sRI8iM6lS2Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Glkze67La338F2UXGpJbBehig5XOVp6QawicQvRc/pDBvq3b0HF46s6cwUgIHlr4cAb1I31qPVsCpNpbvv977l5htxc4ZlTSdbBMpviVOJB+jIEEE/0uAT/aSZWhPGy6NERxozYL2yPrbHxkpLqpsWR5wrHQXu11q8YU7gG4ZR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=mSl1Cmpx; arc=none smtp.client-ip=213.209.10.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="mSl1Cmpx"
Received: from [192.168.1.36] ([151.55.182.102])
	by smtp-36.iol.local with ESMTPA
	id w2BIuD611LyOXw2BIuAZMg; Tue, 09 Sep 2025 19:31:00 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1757439060; bh=OKK0w5w5ZcSFkszCWVbDUpiNSdc9Dsi6dEKy1O154DQ=;
	h=From;
	b=mSl1CmpxJSP89Pl6TZeBVtuVRidy/WYyOBU1/8JPU+VPwdUzuPUaI87/9Gw2KyvRW
	 vRDUq0nCs4lRBGZHU0WWBf8BORhvcDzpQU4F6ajEpISTemC9WfuhbIBHr0DBP3u/q4
	 +DUXD2np9GDX4ft0kisvShtQiEf/lOAjzvYbNRo6HIeR8dwDdXTgBS312lZmqYzCed
	 SUJRO+LhV8u4Dp26RUafLAaz1XhzwgIo/bYpb5EirTYhLahsmD5dRDwyJcjQugwXF1
	 zAUfMutPp1/4FgjWVTu+PMgGSpYx+lF3zgDAl1Inu522FalbLQdN7yDOsN/O+0rr2v
	 AUcd6amL1otVg==
X-CNFS-Analysis: v=2.4 cv=HvF2G1TS c=1 sm=1 tr=0 ts=68c06454 cx=a_exe
 a=iX6ltAOv7qHpQETtHTMf+g==:117 a=iX6ltAOv7qHpQETtHTMf+g==:17
 a=IkcTkHD0fZMA:10 a=xNf9USuDAAAA:8 a=ZFF7hlsdwUJkx7iD6TMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
Subject: Re: New test kernel - second attempt
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
References: <9b8530550078b5e89b19e987981d25fee8e18500.camel@physik.fu-berlin.de>
From: Riccardo Mottola <riccardo.mottola@libero.it>
Message-ID: <7515a193-5ae2-69d6-9c6e-c3b6c7459f50@libero.it>
Date: Tue, 9 Sep 2025 19:34:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.21
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9b8530550078b5e89b19e987981d25fee8e18500.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJmvw1l7H67NH7jJgLjodc6HRrYSPmrdRWEpG6eQKPN59+1rUYnIHgksno1PGXndpSi1jSR/2IkQAg7KwzpjV67TpN45ZXs3Gx7VNp4ilZg+OI1NEQzq
 jgktwFptqu5+t4XpSsiuPi1j5jSVA4/lONHgscq1oYoqT2/Uug3DA6xlralRWocTo4Ht7YAqFmZrj1MqXOsnx2Jm5MQLvLriMDgpH285kPFX9lhaeqgji9eu
 R4INi5M31Fw+lMoguqmpX79STpHmuK1nEreSKhUTinkxsbrywOAcbrzEOE568cyM

John Paul Adrian Glaubitz wrote:
> https://people.debian.org/~glaubitz/sparc64/
>
> Don't mind the weird version number, it's a 6.12.3 kernel:
>
> linux (6.12.43-1+nothp1) UNRELEASED; urgency=medium
>
>    * Add sparc64_fix_hugetlb.patch
>    * Add sparc64_fix_copyops.patch
>    * Disable CONFIG_TRANSPARENT_HUGEPAGE
>    * Disable CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS

Sorry, but this is not a good one. On the Sun Fire T2000 i used the 
"smp" kernel and it crashes on boot:
Loading Linux 6.12+unreleased-sparc64-smp ...tect other bootable 
partitions. â
Loading initial ramdisk ...GNU GRUB  version 2.04-16onfiguration. â
Check GRUB_DISABLE_OS_PROBER documentation entry. â
[    2.919995] pci 0000:02:00.0: failed to populate child OF nodes 
(-19)------+ â
[    2.920055] pci 0000:03:01.0: failed to populate child OF nodes 
(-19)      | â
[    2.920103] pci 0000:03:02.0: failed to populate child OF nodes 
(-19))     | â
[    2.920150] pci 0000:03:08.0: failed to populate child OF nodes 
(-19)      |4) ... â
[    2.920197] pci 0000:03:09.0: failed to populate child OF nodes 
(-19)      | â
[    2.995757] pci 0001:02:00.0: failed to populate child OF nodes 
(-19)      | â
[    2.995812] pci 0001:03:01.0: failed to populate child OF nodes 
(-19)de)   | â
[    2.995860] pci 0001:03:02.0: failed to populate child OF nodes 
(-19)      | 100%
[    2.995907] pci 0001:03:08.0: failed to populate child OF nodes 
(-19)      |
[    2.995954] pci 0001:03:09.0: failed to populate child OF nodes 
(-19)      |
[    2.996002] pci 0001:04:00.0: failed to populate child OF nodes 
(-19)      |
[    2.996048] pci 0001:04:00.2: failed to populate child OF nodes 
(-19)      |v
[   10.810326] mptsas 0000:07:00.0: Unable to change power state from 
D3cold to D0, device inaccessible
[   11.147798] NON-RESUMABLE ERROR: Reporting on cpu 
24-----------------------+
[   11.147975] NON-RESUMABLE ERROR: TPC [0x000000001017e034] 
<MakeIocReady+0x10/0x298 [mptbase]>
[   11.148142] NON-RESUMABLE ERROR: RAW 
[1810000000000001:00000010e6e37b64:0000000202000004:000000ea00300000
[   11.148226] NON-RESUMABLE ERROR: 
0000000000180000:0000000000000000:0000000000000000:0000000000000000]
[   11.148307] NON-RESUMABLE ERROR: handle [0x1810000000000001] stick 
[0x00000010e6e37b64]
[   11.148382] NON-RESUMABLE ERROR: type [precise nonresumable]
[   11.148444] NON-RESUMABLE ERROR: attrs [0x02000004] < PIO sp-faulted 
priv >
[   11.148568] NON-RESUMABLE ERROR: raddr [0x000000ea00300000].
[   11.149692] Kernel panic - not syncing: Non-resumable error.
[   11.149772] CPU: 24 UID: 0 PID: 405 Comm: (udev-worker) Not tainted 
6.12+unreleased-sparc64-smp #1  Debian 6.12.43-1+nothp1
[   11.149898] Call Trace:
[   11.149951] [<0000000000eff2b4>] dump_stack+0x8/0x18
[   11.150042] [<0000000000ef1930>] panic+0xf4/0x398
[   11.150121] [<000000000042a48c>] sun4v_nonresum_error+0x16c/0x240
[   11.150217] [<0000000000406eb8>] sun4v_nonres_mondo+0xc8/0xd8
[   11.150320] [<000000001017e034>] MakeIocReady+0x10/0x298 [mptbase]
[   11.150426] [<000000001017e4b4>] mpt_do_ioc_recovery+0x9c/0x1110 
[mptbase]
[   11.150532] [<000000001017d6f8>] mpt_attach+0xb58/0xd20 [mptbase]
[   11.150636] [<0000000010283f30>] mptsas_probe+0x10/0x440 [mptsas]
[   11.150761] [<0000000000ad1fac>] pci_device_probe+0xac/0x180
[   11.150862] [<0000000000b8b8e8>] really_probe+0xc8/0x400
[   11.150956] [<0000000000b8bcac>] __driver_probe_device+0x8c/0x160
[   11.151050] [<0000000000b8be68>] driver_probe_device+0x28/0x100
[   11.151145] [<0000000000b8c11c>] __driver_attach+0xbc/0x1e0
[   11.151238] [<0000000000b8927c>] bus_for_each_dev+0x5c/0xc0
[   11.151328] [<0000000000b8b09c>] driver_attach+0x1c/0x40
[   11.151419] [<0000000000b8a860>] bus_add_driver+0x180/0x240
[   11.772806] Press Stop-A (L1-A) from sun keyboard or send break
[   11.772806] twice on console to return to the boot prom
[   11.773113] ---[ end Kernel panic - not syncing: Non-resumable error. 
]---


the first part "failed to populate child OF node" happens also with 
kernel that do boot and run successfully.

Riccardo
