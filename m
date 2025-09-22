Received: from libero.it (smtp-31-wd.italiaonline.it [213.209.13.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C085C235BE2
	for <sparclinux@vger.kernel.org>; Mon, 22 Sep 2025 22:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.13.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758580657; cv=none; b=iuidqToIIVr1w+ZDcd+GlN0JVauYz0LvY7Mi7rtRNb1mcOKGW7GtSYBYxYs6U4XMLflYLSBkOKwy1V4J7QQP/1JrR+s0jYdnXyeVB3426Z55Cr6j6JmZciX64j0iW5rkZ27hNsFZoO8XDdQRY0whmGEwGFGtiEYSx+BBcNsu1RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758580657; c=relaxed/simple;
	bh=2BSb/XMT5T/iz0kFCSq1TdTdKyGHqYhRePk8d83ycyM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FsSuaKZ5mgD8HkYAYOIsEDsDmE24HbUOurM732Y7OTn3osReEmIuo3ApuzNo274TJpTM6TvbSWWqwmBHQZTMLhlrDdLMdyDY+ZWBjDiJS1n21nMCjSS/cT2oWuXAlr1Yhng6la8xRj/ilt8LFBhdAysCMs5NKwjiwzwqvJAsGkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=pPhErYEj; arc=none smtp.client-ip=213.209.13.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="pPhErYEj"
Received: from [192.168.1.36] ([151.65.2.228])
	by smtp-31.iol.local with ESMTPA
	id 0p9yvEtWb90dB0p9yvuPV4; Tue, 23 Sep 2025 00:37:27 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1758580647; bh=pxtcFaF2yAfCk0juuHbrrwUGFmfWb7WaZFzE+kNfTSY=;
	h=From;
	b=pPhErYEjrCf4Rh/BRyLtoq/r2yOfqShzk1I0z1zZyi2X4U200pTr8w1HpD673iW2D
	 skrQEM5hPv0bJqjFXGWlbfYCYw474f+w7/zkjXh7oNs5U5KXLOhNSH0ZYUuP7GHXcT
	 Gr/WI8aEiKd47UqfRmzC2RW2894vWiWQruAZCt6NN9GeLbheEdmxoPJcO8zBVQzkAi
	 IU/1k0DD704aKOzdXJN+VrZjMa4AkgKXZ+3rwgyXtlZYy/EV87aQyI1k/Yvk2neuP2
	 S8unxXKVAu/xv6n3hfJ+hy1Bq6ULASyQbBdA7BdV7UkT7Pf5DH8m8dbv1JgWm7BUju
	 QJtFLPpcv91Mg==
X-CNFS-Analysis: v=2.4 cv=bNoWIO+Z c=1 sm=1 tr=0 ts=68d1cfa7 cx=a_exe
 a=fUUb/luldTa8vXwyIFcL2Q==:117 a=fUUb/luldTa8vXwyIFcL2Q==:17
 a=IkcTkHD0fZMA:10 a=sGDgGPI5OTvwaNb7dgAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Subject: Re: New test kernel - second attempt
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
References: <9b8530550078b5e89b19e987981d25fee8e18500.camel@physik.fu-berlin.de>
 <7515a193-5ae2-69d6-9c6e-c3b6c7459f50@libero.it>
 <73e81a8280b345ee09df0dfa9f0e21148144722f.camel@physik.fu-berlin.de>
 <74380961-4a1b-95a7-96f5-448737356082@libero.it>
 <4207162c8254a2b8f423db485f974ca00ae355a3.camel@physik.fu-berlin.de>
 <784cff9b-d09b-8f02-0f77-d48bcda6c921@libero.it>
 <c3c82ca3-5e6f-fb7d-3e93-60ed9bd37098@libero.it>
 <aafc9d1ea293ac095137d224849447082206a1c4.camel@physik.fu-berlin.de>
From: Riccardo Mottola <riccardo.mottola@libero.it>
Message-ID: <f39d1936-f5fd-0352-6207-95318baeb257@libero.it>
Date: Tue, 23 Sep 2025 00:41:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.21
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aafc9d1ea293ac095137d224849447082206a1c4.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDUHKJVgbIgxW9FRM+TbVvOZLbH2FeqiIue8B9dKJGLk6vazfO+drUCrDL8Ufb0idasCyEPbDGaxP8X3U+ai5V/NQKLcR7UWszkhoryvip9GC0KqAEVN
 e+DtN11PFSCkjYOdzmk9KQG4z0fpOEF+qo1pqnE0kV5t6bXLfr6V/uHNymps5pSxxcNT78UNad03Yrl49lh7Y0E9uP8mVkQEZso9c8EYj4fY2+MLprMRSShP
 GTxahifsuvmlyaAD8hjnxLZUxOZyuy8g7T0WxQpW6zQkOm3vXNrUUSgvfaZZDLPb

Hi Adrian,


John Paul Adrian Glaubitz wrote:
> I can therefore only recommend to verify your hardware first and address
> any issues with empty NVRAM batteries which may lead to incorrect NVRAM
> contents. We have had one user reporting stability issues resolved after
> resetting the SP on his T5240, see [1].
>
> So, it's really not too far fetched to think your problems may indicate
> a problem with your hardware. That's why you have to make sure everything
> is working properly, including the NVRAM.

Actually, on heavy-stress NetBSD choked! it never did in the past years. 
so time to look at it.

Could be... one never knows. Today I spent time with the Netra T1 to get 
it back on track. I got two new RAM sticks. The Battery hack I did 
Friday seems to hold quite well, content remains stored, RTC worked over 
the weekend.

What I rembered is that I did not "set-defaults" before working on it... 
content seemed good to boot,  for safety, I redid it.
I discovered that Not all RAM DIMMS combinations were good and that a 
NVRAM reset even improved things, very strange, but that it is.
Things like two new DIMMS did not work as "upper" two slots, but left 
alone in the first two slots were fine. But old DIMMs put in upper 
resulted in a stable system with NetBSD. I stress tested it and for sure 
enough I used enough RAM as well as I let diag run at boot. Good thing, 
also, the reliable system I need as NFS server and lots of things is back.
I ordered some new NVRAM chips though, we shall see how new ney will be 
and if it is worth changing my hacked one. Also I want to improve my 
hack with a battery holder in the future.

> All variants of the UltraSPARC I and II CPUs use the same assembler
> optimizations in the Linux kernel. There is no code optimized specifically
> for UltraSPARC II or even variants of it.

Sure, there are no specific compiler optimizations, but I wonder if they 
are really the same and what could change in the machines.
In theory, just cache sizes, CPU speed.. and possibly other minor things 
(e.g. if one board accepts 1GB modules, the other only 512MB ones, sure 
some details differ).

Strong of an apparently goot Netra T1 with NetBSD 10.1, I tried the 
linux disk again.

I stressed the old kernel a bit:
  6.1.0-9-sparc64 #1 Debian 6.1.27-1 (2023-05-08) sparc64 GNU/Linux

And this time also on the Netra T1 it proves good: I recovered 
filesystem journal, I can run apt-get upgrade, install things. 
Regenerated ramdisk, etc Definitely "hold" this kernel version for 
future safety.
Minor new kernel to test plus your 6.17 kernel, which choked on fsck / 
journal replay (but now fixed with 6.1 kernel).

Newly installed mainline kernel:

Loading Linux 6.16.8+deb14-sparc64 ...

/dev/sda2: clean, 43801/1011840 files, 1131402/4047104 blocks
[FAILED] Failed to mount boot.mount - /bo
ot.
[DEPEND] Dependency failed for local-fs.target - Local File Systems.
You are in emergency mode. After logging in, type "journalctl -xb" to view
system logs, "systemctl reboot" to reboot, or "exit"
to continue bootup.
Enter root password for system maintenance
(or press Control-D to continue):


reboot 6.1 - comes up clean!

Loading Linux 6.17.0-rc5+ ...
Loading initial ramdisk ...

/dev/sda2: clean, 43801/1011840 files, 1131402/4047104 blocks
[FAILED] Failed to mount boot.mount - /bo
ot.
[DEPEND] Dependency failed for local-fs.target - Local File Systems.
You are in emergency mode. After logging in, type "journalctl -xb" to view
system logs, "systemctl reboot" to reboot, or "exit"
to continue boEnter root password for system maintenance
(or press Control-D to continue):


Another reboot into 6.1  - all fine!

Now, a bit more confident about my hardware, I would say stock 6.16 and 
your 6.17 do have issues on the T1 200 with IIe

Riccardo
