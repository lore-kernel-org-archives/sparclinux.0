Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3420023EAA3
	for <sparclinux@vger.kernel.org>; Mon, 20 Oct 2025 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983382; cv=none; b=LExSuHqWqmec98QQzIFKBiBJCsRPZXvM/gzxtGUui/pk9aLxDofNObyZ3VsIpjcRyCaAMmEw9lwsD/5YUx6wcFPiwolAkPT+MEopF2B7A1JOgUyUiCL+o2N5rjoYS4l/EbIF5qLUEHqE+D707IrBDrQcUZS5Ns77LnnRPxwc1v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983382; c=relaxed/simple;
	bh=t67pZ78QJzF2RFLqqObdbMmENwwpVvknkqaERlK6ad4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Y/Jst+rSbpg/mz8Bunf69OaB61VfbwfGJ0voj9kUr9ZrCwSsoIEU46CRlA4l0xoNDcNKcZiz/kQpHFBPWVoTCAKyvIQAa7aSPQQRjLU/FiCbB11+rRie/XS911GHBFHgOCevVQhDtiweIa5SRlGXJWgVIy4+U6x9PzCKtbls1ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=IXMz4j2K; arc=none smtp.client-ip=213.209.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="IXMz4j2K"
Received: from [192.168.1.36] ([31.188.89.209])
	by smtp-18.iol.local with ESMTPA
	id AuBAvbepv32S3AuBAvpyg9; Mon, 20 Oct 2025 20:00:20 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1760983220; bh=m7lhKftfZSbQAP5HQgmtvr6Zo4vvIaMIaXIYQ8dGLks=;
	h=From;
	b=IXMz4j2KgkFk6oea11TFIilIcVcs+ONSIpxpoXPsvEx5NPnZBpze79ofn/kk3KQbX
	 FewLt0uilVDqpYLgV6K1orZxJ88HMSdgcXzg8BdxVQXpfE2QmMfCq/CmDpNt88pDh9
	 pXTV7+bG4cqi5tj7YB3uLzwfr/voHyAvfjxb4wjtYkLCWO+5opC9MeRSIyuVP1cI8w
	 f/E68oVrqvzuEL8LBKkt0kFQukKozv/+zjx6YTxmX3ahrHm9SGJ8jBDokcOvz+zT4z
	 gy8S2Q6VXyyCUQ8siR5gk7XkCkMLxnf+TlGK3wCo0TnXFV4i+6ZsudxNIdpNKf9QCf
	 LMF5CkW9nhkiw==
X-CNFS-Analysis: v=2.4 cv=Tu3mhCXh c=1 sm=1 tr=0 ts=68f678b4 cx=a_exe
 a=iu3iJJU9IN5ikVy9A/4XMQ==:117 a=iu3iJJU9IN5ikVy9A/4XMQ==:17
 a=IkcTkHD0fZMA:10 a=xNf9USuDAAAA:8 a=OMDy2dcxeLPeyHGDs_oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
Subject: Re: New Debian sparc64 test kernel for stack corruption issue
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
References: <e61027c249c88484a77d2e1dd2a42d2bc1e2ac06.camel@physik.fu-berlin.de>
From: Riccardo Mottola <riccardo.mottola@libero.it>
Message-ID: <ed13b363-71b7-0467-00eb-c8dedea39eb8@libero.it>
Date: Mon, 20 Oct 2025 20:05:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.21
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e61027c249c88484a77d2e1dd2a42d2bc1e2ac06.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfPmyTF8ZZtT+PWTBbQ1Z9dMzJHTjynR5aZXP4zk43Qb1eu/O0wChGDyBznTjZSryip1i7D20kQPKRsFxNHbCxleM5yw+7LlNA39YDhj5VPvy4Benq9yC
 jVtXohL9yfPSEsaKH3K4IquQ7lE+vgNSVtt/AYVTQA7xqey0h4Rl0mDPTCdo0Ly1sqaqqXB9BwqYWbpxu0YlgLzJQWBh9i+ngJG8/WjEzD/UsLY4hAsXr85H
 AjosG/AbH3mNSYwAPUH08Lx2XnOKXbs6pUIk2afe9WNd6RwcGrvkjiIf8mW5z4X9

Hi Adrian!"

John Paul Adrian Glaubitz wrote:
> I have created UMP and SMP test kernel Debian packages to verify this:
>
> https://people.debian.org/~glaubitz/sparc64/
>
> Could someone test this kernel? It works for me in a SPARC T4 LDOM.
>
> FWIW, the kernel does*not*  yet include the fixes for accurate exception reporting [1],
> so expect that the kernels may not be stable on older UltraSPARC systems. The fixes for
> that will be included in 6.17.3 or newer or 6.18 or newer.
I found two versions. I tested:

https://people.debian.org/~glaubitz/sparc64/linux-image-6.16.12+3-sparc64-smp_6.16.12-2+sparc64.1_sparc64.deb

On T2000 with Niagara

[   12.126130] mptsas 0000:07:00.0: Unable to change power state from 
D3cold to
D0, device inaccessible
[   12.463473] NON-RESUMABLE ERROR: Reporting on cpu 31
[   12.463643] NON-RESUMABLE ERROR: TPC [0x0000000010184034] 
<MakeIocReady+0x10/
0x298 [mptbase]>
[   12.463810] NON-RESUMABLE ERROR: RAW 
[1f10000000000007:0000000e3179235c:00000
00202000004:000000ea00300000
[   12.463894] NON-RESUMABLE ERROR: 00000000001f0000:0000000000000000:00000
00000000000:0000000000000000]
[   12.463975] NON-RESUMABLE ERROR: handle [0x1f10000000000007] stick 
[0x0000000
e3179235c]
[   12.464050] NON-RESUMABLE ERROR: type [precise nonresumable]
[   12.464113] NON-RESUMABLE ERROR: attrs [0x02000004] < PIO sp-faulted 
priv >
[   12.464221] NON-RESUMABLE ERROR: raddr [0x000000ea00300000]
[   12.465352] Kernel panic - not syncing: Non-resumable error.
[   12.465422] CPU: 31 UID: 0 PID: 367 Comm: (udev-worker) Not tainted 
6.16.12+3
-sparc64-smp #1 NONE  Debian 6.16.12-2+sparc64.1
[   12.465532] Call Trace:
[   12.465574] [<00000000004373c4>] dump_stack+0x8/0x18
[   12.465656] [<0000000000429540>] panic+0xf4/0x398
[   12.465727] [<000000000043afcc>] sun4v_nonresum_error+0x16c/0x240
[   12.465817] [<0000000000406eb8>] sun4v_nonres_mondo+0xc8/0xd8
[   12.465910] [<0000000010184034>] MakeIocReady+0x10/0x298 [mptbase]
[   12.466007] [<00000000101844b4>] mpt_do_ioc_recovery+0x9c/0x1110 
[mptbase]
[   12.466103] [<00000000101836f8>] mpt_attach+0xb58/0xd20 [mptbase]
[   12.466209] [<0000000010287f30>] mptsas_probe+0x10/0x440 [mptsas]
[   12.466336] [<0000000000b3fab0>] local_pci_probe+0x30/0x80
[   12.466427] [<0000000000b405d4>] pci_device_probe+0xb4/0x240
[   12.466518] [<0000000000bfd348>] really_probe+0xc8/0x400
[   12.466612] [<0000000000bfd70c>] __driver_probe_device+0x8c/0x160
[   12.466709] [<0000000000bfd8c8>] driver_probe_device+0x28/0x100
[   12.466805] [<0000000000bfdb7c>] __driver_attach+0xbc/0x1e0
[   12.466900] [<0000000000bfacfc>] bus_for_each_dev+0x5c/0xc0
[   12.466992] [<0000000000bfcafc>] driver_attach+0x1c/0x40
[   13.088506] Press Stop-A (L1-A) from sun keyboard or send break
[   13.088506] twice on console to return to the boot prom
[   13.088811] ---[ end Kernel panic - not syncing: Non-resumable error. 
]---

still crash, but there is some "information"


Take in consideration that on this sytem my sweet spot for kernel is:
6.12.38+deb13-sparc64-smp

older stuff was crashy, IIRC all newer kernel (or most?) straigt from 
debian and most kernel you provided fail to boot.

Instead on single-CPU I tested:

https://people.debian.org/~glaubitz/sparc64/linux-image-6.16.12+3-sparc64_6.16.12-2+sparc64.1_sparc64.deb

On Netra T1 UltraSPARC IIe

- boots fine
- basic operations like apt-get work fine
- some compilation - survives fine

In dmesg I see no failures, errors... except this:

[    0.952369] pci_bus 0000:01: extended config space not accessible
[    0.957507] pci_bus 0000:02: extended config space not accessible
[   10.402607] This architecture does not have kernel memory protection.
[   21.640233] Warning! ehci_hcd should always be loaded before uhci_hcd 
and ohci_hcd, not after
[   33.087538] PM: Image not found (code -22)
[   35.720238] Not activating Mandatory Access Control as 
/sbin/tomoyo-init does not exist.


Then I tried the said kernel on Ultra1 with UltraSPARC I (literally 
transferring the same Hard Disk)
As "expected" there were no improvements over other kernels. same boot 
failure:
Invalid sbus slot number 31
Invalid sbus slot number 31
error: canonicalise devname failed.
Can't read disk label.
Can't open disk label package
error: unable to open /sbus@1f,0/SUNW,fdtwo@f,1400000.
Invalid SCSI target number fffe55d0
error: unable to open /sbus@1f,0/SUNW,fas@e,8800000/sd.

This is really the same I even got with 6.1 kernels. I was not able to 
boot this system into debian at all.


Riccardo


