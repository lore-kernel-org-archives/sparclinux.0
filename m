Received: from libero.it (smtp-31-wd.italiaonline.it [213.209.13.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7373230BE9
	for <sparclinux@vger.kernel.org>; Fri, 19 Sep 2025 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.13.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758280053; cv=none; b=UuexQh9Lf2y9Zs4Qb8F09ZnLl5W3nBUk7Tdxd7F1bSOXUMNTGCNrAmS9H7SWmSr3TkWaYlTBGgEqgJPA8SRMvABpMvoMGn23qZSm3XhGy68kKnwfJjsy40a4tA8NgZrx05XtDjQ/o+AQKPN4zP0N1i61bZtvQxiRvDPBHoCX5Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758280053; c=relaxed/simple;
	bh=JHGPX7j2mw5VQCUssdh4NxVd5hdae8zXe/txmJfs4Pc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uS7HYiDTfKS8aprJXE3nZZ4uK3uVtjDBg3raZ9W5KnGMEfqMVKCKX5SpcAttXFZ7zc5hQUMrDYooJGS9fs2gfwcyULKcVTMistQnT/jMvnz7HHSRMW+oSs3Q/m4nBvdoVlWNvqYA6a3bunRPOueuyEaoksqYyIWOE7sUvExWa7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=LyIvqtv/; arc=none smtp.client-ip=213.209.13.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="LyIvqtv/"
Received: from [192.168.1.36] ([151.65.2.228])
	by smtp-31.iol.local with ESMTPA
	id zYxWuoMzx90dBzYxWukHsz; Fri, 19 Sep 2025 13:07:23 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1758280043; bh=P9F4uHs7U6nOrMQLrMaEzsjs9vgxAYy8Snv8BplXiaE=;
	h=From;
	b=LyIvqtv/0mAsqYT/F1tNrQbwCDmhFJsQN+RP+sNpuNHh/aG0XLlgygZncpRjJOxC/
	 c+NvQKarc7VyrBSLynXFGfyRnVzzuiWHeWgMx6NU2tWRDvRYjWdwm+9r7C5MtkeO6A
	 8TMQBsCZFll8crQ4VEHa1DDV3D0ghp7rOLJeWJ2/oQvJLuCjk3zT9VGQuxrO3W3/tf
	 o6ouX+zchFBPymH1Y42klb/rV1/EKXyHJbTpuIReI57iAu+uBWGIX24FTGb7jF8A3O
	 cCnncuXCIiA8psfNGlf9r54xnk7CECpvRqXH9VXXJBbK7NKX5AkktZurMYeqlkvDfs
	 qJlIcB9itUjFw==
X-CNFS-Analysis: v=2.4 cv=bNoWIO+Z c=1 sm=1 tr=0 ts=68cd396b cx=a_exe
 a=fUUb/luldTa8vXwyIFcL2Q==:117 a=fUUb/luldTa8vXwyIFcL2Q==:17
 a=IkcTkHD0fZMA:10 a=xNf9USuDAAAA:8 a=yDcJJOAaMUu-wWFFKroA:9 a=3ZKOabzyN94A:10
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
Message-ID: <784cff9b-d09b-8f02-0f77-d48bcda6c921@libero.it>
Date: Fri, 19 Sep 2025 13:10:57 +0200
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
X-CMAE-Envelope: MS4xfAECLnme5pctp8/PYpqhE2QgpiztmrjhblKWZ+ARZ0XfRbhubv0BtIpslK88VLTyreCDhceuKZK2Sty3LWvqyD/3/6OUwHt0Nvk2Syuk3Gmb7O+C5WQt
 wSyfrnwaKt6qtRYbkgrjaoIJUPMvFKa0q7C6bIkfHzK3oDFzSsCxOTOWzpSfTjMDaUMLykkHQQA58jpD3kwY4czpjukAbt8PaJOlnXMsjv/d/sYWHh2GXAA/
 DSZTQrdAqwsdAtAo81OVKIG8+PvWaBL2AX3hWqfeQudKGtPr2EEvFPDLnU/O/P8L

Hi Adrian.

"strong" of my new setup I went bold testing and also exploited one more 
time the Sun Fire which was "install donor" for this installation before 
putting back its solaris disks and back in original state.

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

I see this on the V120
[    2.200440] rtc-m48t59 rtc-m48t59.0: hctosys: unable to read the 
hardware clock

then the serial console looks a bit garbage, seems terminal types don't 
work well after apt updates! yet it is standard vt102 or ANSI through 
minicom as I always used :(
I am able to luckily login via ssh. So machine is "alive". Just for 
double-check I rebooted the 6.16 kernel and it still spits out crap. I 
think it is color codes that corrupt something.



To Sum Up:

Sun Fire V120 (1x UltraSparc IIe )
---------------------------------------------------------------

debian-sparc64 6.16.7+deb14-sparc64 #1 Debian 6.16.7-1 (2025-09-11) 
sparc64 GNU/Linux : boots fine
debian-sparc64 6.17.0-rc5+ #1 SMP Fri Sep 12 20:37:32 UTC 2025 sparc64 
GNU/Linux : boots fine

After several boots and restarts, eventually I got a crash on a "warm 
restart"...


on Ultra 2:
GRUB Loading kernel.... and hangs there.
I tried a set-defaults since the nvram chip is flakey until i fix it or 
a replacement comes, but nothing.
Coherent with CDROM boot?

hangs here....


on Ultra 1:
GRUB Loading kernel.... and hangs there.
This one has a good nvram chip. So it appears that the old Ultras don't 
like GRUB? nor from CD nor from the installed system

Could the GRUB version be "tailored" to the Fire 120 and not work on 
previous systems?


As a 100% re-check I put in the solaris hard disk and it boots.. until 
it fails to fsck extra partition... I lost a disk. Still enough to prove 
the system is functional!

So... not a shiny future right now for Linux on the old Ultras

Riccardo
