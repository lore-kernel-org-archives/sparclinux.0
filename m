Received: from libero.it (smtp-31-wd.italiaonline.it [213.209.13.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F48313E30
	for <sparclinux@vger.kernel.org>; Fri, 19 Sep 2025 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.13.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294187; cv=none; b=F1yNyaqf2C4apKWc5zx0YdO6nPUgXwYajmo+gRcNs7ytD9Q3cwu7EFRXXDt7XZnqWbnBuX6hyuDFeZrytk7wP/dLkRhepMDRMcN59lzfWfp2RmQSc4qdZUDljbpR6lYs77IOfM/DQmtMHFeqlMm1jSgAG+cec1sRbgCHnr1vXK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294187; c=relaxed/simple;
	bh=leZiR1zqk8T7piZTQPj/GD99PDLBxPgt45mfsozRJhU=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DwTj09Oa/QmST/aez0BVLxdDh5RcsKLwrW3J7RVPqGl/79pMe9c+W91Op5DzeTJWvAQcPqzGh6I37cWRKARdirynTJeVk3LSSAP/mRlJXL93k82C7HSg0Msd7+YLHMt0GpCTCWs7FEZFk9spvYz1oL7i2ZFqfi1I8ZRtNXDDiT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=Y2hRVONr; arc=none smtp.client-ip=213.209.13.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="Y2hRVONr"
Received: from [192.168.1.36] ([151.65.2.228])
	by smtp-31.iol.local with ESMTPA
	id zcdaupr8N90dBzcdaul4Ek; Fri, 19 Sep 2025 17:03:02 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1758294182; bh=JSzH22Yk7u81ZRmAS4cOFmGa4VRP4HK1qhnfQefJkNw=;
	h=From;
	b=Y2hRVONrQl6MOKh75HYeYD+nSBpLDJ4oLuOYWZR10PF8b+wasR2BHy+mC/FRNqjh8
	 u+dZKpdMnAqY/ABJrfeUph+X2eTMOOv88rm1346zu1bxtyNvYM/evUEEYbbdNSEnfM
	 E7y9u1O/+CMmFEB08fSF8/aKpNzHMbq/neBP90yslc/wdXoug1HLTUoXltQLxP/e2v
	 B55a8s7ZrOhjiSpf9YFPGJLm4WU0OSTK0mH6JblEippfPCYnOTR8qb2tS5GAImJyiY
	 hw+Bl2YWGO2qNOPAsb/FF3yXiwlWdaJ6U2ZCO5a+/hagFTvTCrEhv1/APladIUqEOc
	 J/bhebtU6v9yw==
X-CNFS-Analysis: v=2.4 cv=bNoWIO+Z c=1 sm=1 tr=0 ts=68cd70a6 cx=a_exe
 a=fUUb/luldTa8vXwyIFcL2Q==:117 a=fUUb/luldTa8vXwyIFcL2Q==:17
 a=IkcTkHD0fZMA:10 a=qbuC6shXmeKGCeCeVG8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Subject: Re: New test kernel - second attempt
From: Riccardo Mottola <riccardo.mottola@libero.it>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
References: <9b8530550078b5e89b19e987981d25fee8e18500.camel@physik.fu-berlin.de>
 <7515a193-5ae2-69d6-9c6e-c3b6c7459f50@libero.it>
 <73e81a8280b345ee09df0dfa9f0e21148144722f.camel@physik.fu-berlin.de>
 <74380961-4a1b-95a7-96f5-448737356082@libero.it>
 <4207162c8254a2b8f423db485f974ca00ae355a3.camel@physik.fu-berlin.de>
 <784cff9b-d09b-8f02-0f77-d48bcda6c921@libero.it>
Message-ID: <c3c82ca3-5e6f-fb7d-3e93-60ed9bd37098@libero.it>
Date: Fri, 19 Sep 2025 17:06:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.21
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <784cff9b-d09b-8f02-0f77-d48bcda6c921@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOk/2WvTNIcrOIqi4HzSfMRPU12AyhtJ2A15MZCKtZ1Ia1SS84PxCR2BMtFQfiGVgxKXrvIF0WrIcHfCSlwi7xIavVeRsTD2Y1YLMqtmPAnNqzpmU1DG
 cbNosU5kujRWkPzIJcjWxUTjfG/21Z9SxvfzWcSCNXnRFyP1kNaFB8PCHlqUTy10XPqrDr9uMv1GhlMyeF082Ov1mv1ApkhGAhdwFA1282pI2vNb/LYZSdwy
 b1P32L6NkNRjpDMzYOIkuHZTLxQnsH+SGXFBrnfNtLCTRTAJfx7GN6oO/FOZ88Ud

Hi,

further follow-up, last tests for today. The Netra T1 was still open for 
the tests, the one which booted

Loading Linux 6.17.0-rc5+ ...
Loading initial ramdisk ...

/dev/sda2: clean, 33785/1011840 files, 724818/4047104 blocks
3008;start=0e6a730b368e44c897ac90aa211eb72a;user=root;hostname=debian-sparc64;machineid=8b9a152319f14cd59
23fb8a80457b56a;bootid=63ef412630eb42fca7ad2d38d1539e29;pid=1;pidfdid=2;comm=systemd;type=boot[ 
45.6843
88] Fixing recursive fault but reboot is needed!
[   45.929220] systemd[1]: segfault at 32 ip fffff80100a224ac (rpc 
fffff80100458d3c) sp 000007fefff41cd1
error 1 in libsystemd-shared-258.so[2224ac,fffff80100800000+3fa000]
[   46.462211] systemd[1]: segfault at 28 ip fffff801011b08e8 (rpc 
fffff801011881f0) sp 000007fefff2d591
error 1 in libc.so.6[b08e8,fffff80101100000+194000]
[   46.654294] systemd[1]: segfault at 1008034bdd0 ip fffff801011a53ec 
(rpc fffff801011a5348) sp 000007fe
fff2b931 error 1 in libc.so.6[a53ec,fffff80101100000+194000]
000000000000001500000000004200000000000000000000ffffffff80300000000000000005ce18000000000000000e000000000
01f20b3000000000058003b0000000000000877000500340000000000405ec80000000000405ecc000400340000000000405ec800
00000000405ecc000300340000000000405ec80000000000405ecc000200340000000000404868000000000040486c0001004e000
000000085845c0000000000858460
Watchdog Reset
Externally Initiated Reset


the output is dirty since some color codes come out.

I did reboot as proposed... but it fails for I/O errors:
/dev/sda2: recovering journal
/dev/sda2: clean, 33795/1011840 files, 725650/4047104 blocks
3008;start=49e9dcbbe6e8415ea64c096f811f6f61;user=root;hostname=debian-sparc64;machineid=8b9a152319f14cd59
23fb8a80457b56a;bootid=ba10d5eaddab44f5bc7a3d6afd4f21b6;pid=1;pidfdid=2;comm=systemd;type=boot[ 
228.4900
60] sd 0:0:0:0: [sda] tag#297 timing out command, waited 180s
[  228.574948] I/O error, dev sda, sector 13901518 op 0x1:(WRITE) flags 
0x9800 phys_seg 8 prio class 2
[  228.702627] Aborting journal on device sda2-8.
[  253.583514] sd 0:0:0:0: [sda] tag#297 timing out command, waited 180s
[  253.668339] I/O error, dev sda, sector 13992638 op 0x1:(WRITE) flags 
0x103000 phys_seg 1 prio class 2
[  253.789648] Buffer I/O error on dev sda2, logical block 1624066, lost 
async page write
[  253.894046] sd 0:0:0:0: [sda] tag#300 timing out command, waited 180s
[  253.978800] I/O error, dev sda, sector 13583030 op 0x1:(WRITE) flags 
0x103000 phys_seg 1 prio class 2
[  254.100123] Buffer I/O error on dev sda2, logical block 1572865, lost 
async page write
[  254.207606] EXT4-fs error (device sda2): ext4_journal_check_start:87: 
comm kworker/u4:4: Detected abor
ted journal
[  256.841511] EXT4-fs error (device sda2): ext4_journal_check_start:87: 
comm kworker/u4:1: Detected abor
ted journal
[  256.994388] EXT4-fs (sda2): Remounting filesystem read-only
[  257.067800] EXT4-fs (sda2): ext4_do_writepages: jbd2_start: 3067 
pages, ino 393758; err -30


it is, by definition, the same disk that worked & booted on the Fire 120.

I then attempted to boot the older 6.16:

Loading Linux 6.16.7+deb14-sparc64 ...
Loading initial ramdisk ...

/dev/sda2: recovering journal
/dev/sda2 contains a file system with errors, check forced.
/dev/sda2: 33796/1011840 files (0.2% non-contiguous), 727699/4047104 blocks
fsck exited with status code 1
3008;start=ff9f4e8bd6514200ab7c4d915e3c4a75;user=root;hostname=debian-sparc64;machineid=8b9a152319f14cd59
3008;start=9057abc423f1498d9018f5cd9643795e;user=root;hostname=debian-sparc64;machineid=8b9a152319f14cd59
23fb8a80457b56a;bootid=1af80057945f45d6a4cea5ccffed75b5;pid=515;pidfdid=516;comm=(agetty);servicename=ser
ial-getty@ttyS0.service;invocationid=0ee7aa1c7d74494fbc15f021438ab905;type=service
Debian GNU/Linux forky/sid debian-sparc64 ttyS0

debian-sparc64 login: root
Password:

Login incorrect
p104 583.036741] systemd[1]: segfault at 67effd43fd9 ip fffff80101146618 
(rpc fffff8010114663c) sp 000007
feffd422c1 error 1 in libc.so.6[46618,fffff80101100000+194000]
[1G



so this one completes fsck / file recovery (no scsi read errors)
I mistyped my password and got a segfault..... yay!

If I reboot and do not get my password wrong....
debian-sparc64 login: root
Password:
[  211.600247] systemd[1]: Caught <BUS>.

L

and now the lock is so bad I am unable to return to LOM with a break! argh!

At this point I try the historic 6.1.0-9 kernel that came from the CD. 
Boots, fsck/journal recover, login... and hangs! no errors displayed. No 
break...

At this point I am worried, but the NetBSD 10.1 Hard disk back in the 
tray, perform a cold start... and get a login prompt: Console is smooth 
and no funny chars.


Interesting is that the Netra T1 and Fire 120 are quite similar in 
hardware... the latter is a bit higher spec'd (e.g. accepts double 
memory) but essentially differs  with the lower-spec'd embedded 
UltraSparc IIe vs high-performance IIi.
(the advantage is that the IIe just needs a simple CPU cooler with fan, 
no air ducts and is so much quieter... almost like a workstaiton).

Riccardo

