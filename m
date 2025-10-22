Received: from libero.it (smtp-36.italiaonline.it [213.209.10.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD81DF59
	for <sparclinux@vger.kernel.org>; Wed, 22 Oct 2025 00:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761091659; cv=none; b=SqQqZmPwhvrOUJp6Hu/xJQG79KGd8OSUUsT9y+aodO77b2Z/QmoOKje44tajH87cDl1AtQl9KYPSfu6hOiew3QFxUvvPrcRY6g52HlrDCnS9lX+6IaWTizP1uqiMGfgPfcvCojuLPZnVPwuGfRAobjK9JG0VE0S9MBR4XJW1p+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761091659; c=relaxed/simple;
	bh=+867XKpuiVlOxzfz9VsALiD1Vv0m8rWW5o/uCxpOD3g=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pcwsdjM+Q1gkdrBS669E6WovVNhjGrqq/4rU6qS55411SfNyCDwQOoN2wRdnMDDApB3l8jGMk8XmLdCHJLltjv9KBfvOgWyopWCAcN9nXOWpCvtuNbEeRmOYkxiT6NPXDnzLJt9V37n5vkU3FiV90sWELnDM+WjfJwig6EKfW90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=YaADrB0m; arc=none smtp.client-ip=213.209.10.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="YaADrB0m"
Received: from [192.168.1.36] ([151.65.17.26])
	by smtp-36.iol.local with ESMTPA
	id BMLYviw8Mo6RnBMLYvRR42; Wed, 22 Oct 2025 02:04:56 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1761091496; bh=HYffuVO3EFVXAVljhB11+qKxPiyeuyclkLwziOUcyFU=;
	h=From;
	b=YaADrB0mrcyeU0txPzudRd+cWkmrskt7ADOdgfP//BJTsrpnODcuS9+ma3Wf5Ca12
	 Gu8FZkxkIwbER0LsxmNIotbAxyi0xNXnkvujwdFHD9zg1e1JG9dE/Lar8sziakgjHH
	 Uf/9NoOF/EglCHlfkJNpqlKUFIHhLHzZVAcZe6x6Bdo2Bx+cZNyfKgcwiVDkWO7M/R
	 hgMVcXmvOw+QXnELKh+bI1woimxFp9FyTvCGN+JErpwAUQJ+dbQQp0AjADlq7O7r4e
	 7d/9aRMaYTvHSTV2Fnm7m964USu7sKa6KhU8Itu2/bFOI2jkzeYXBDrgTHU2CzMqFu
	 rW7adMH6nMocQ==
X-CNFS-Analysis: v=2.4 cv=I6dlRMgg c=1 sm=1 tr=0 ts=68f81fa8 cx=a_exe
 a=ST5ZiqFa3+sjRnzYuqUWMA==:117 a=ST5ZiqFa3+sjRnzYuqUWMA==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=tED4pVO_wj5pCjcIifoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
Subject: Re: New Debian sparc64 test kernel for stack corruption issue
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
References: <e61027c249c88484a77d2e1dd2a42d2bc1e2ac06.camel@physik.fu-berlin.de>
 <ed13b363-71b7-0467-00eb-c8dedea39eb8@libero.it>
 <82e4d4e7e4439ebf9b4ead403d5f94e482b416fd.camel@physik.fu-berlin.de>
From: Riccardo Mottola <riccardo.mottola@libero.it>
Message-ID: <07e35a9a-0036-d6d3-649f-18c5ab2a0694@libero.it>
Date: Wed, 22 Oct 2025 02:09:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.21
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <82e4d4e7e4439ebf9b4ead403d5f94e482b416fd.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLCO1GtsdwryRL58F12Z1F6lrFo6zUshHtfHWkTl2DJ1Y9zxSFsa3KYRGl6JD9Zf4bcimlZmhkUCTjVrcokUXxnIvBEHRBl37f9UEIuC/rrTlTFIPbg3
 R/BGFZyoyyqJeDxd0ia2FR55nU2F2d0muce2DtUaNcEpaFI4ThG6T1yNvHdGNHlh3sXgbRMJkP6s3n1zRhjFo16WNS5jJVH70366+FeVlC0eS8iCZcPNNQQT
 HAYYyTvSU9r62d1GjzqfoZWKTk7I2ZuCgWNZG8TIh59XkRBsUYSf1QDyG4eZCzoB

Hi Adrian!

sorry for the delay, but $DAYJOB and actual coding in GNUSstep  do take 
over on system hacking...

John Paul Adrian Glaubitz wrote:

> I have not seen that crash on any of my machines, so I'm really 
> wondering where it comes from. 

I remember we had some testing about the issue on Niagara T1... I should 
dig in bast conversations.

>> Take in consideration that on this sytem my sweet spot for kernel is:
>> 6.12.38+deb13-sparc64-smp
> Would you be able to bisect this?

Not immediatly. Do you mean by cloing out git of kernel.org?
Or can I test various ready deb files already archived?
Issue could be in code as well as some configuration changes.

I can test some of the available kernels.. I think some are yours some 
debians.
Can I distinguish them with the "deb" ? There is also the issue that my 
boot partition can hold a finite number of kernels, so I need to 
uninstall some. I had more, but I removed some to make place for your 
lates tones.

Of course, it is easy if there are just .deb files to be 
uninstalled/reinstalled.

For a ballpark of the issue, I have:

6.8.12-sparc64-smp - > works
6.12.38+deb13-sparc64-smp -> works
6.12+unreleased-sparc64-smp -> doesn't work (where does this kernel come 
from??)
6.16.12+deb14-sparc64-smp -> doesn't work

and of course, your kernel doesn't work either.

> Out of curiosity, can you try reinstalling the openssh-server package?
>
> # apt install --reinstall openssh-server
>
> This causes crashes for me with certain kernels on UltraSPARC III.

On the Ultra IIe I just tried:

Preconfiguring packages ...
(Reading database ... 56583 files and directories currently installed.)
Preparing to unpack .../openssh-server_1%3a10.2p1-2_sparc64.deb ...
Unpacking openssh-server (1:10.2p1-2) over (1:10.2p1-2) ...
Setting up openssh-server (1:10.2p1-2) ...
ssh.socket is a disabled or a static unit not running, not starting it.
multix@debian-sparc64:~$

no kernel crash. I previously, diligently, installed also a telnetd 
server so i can access the system beyond serial console in case of ssh 
issues!
(It is safe, not NAT'd out of my LAN anyway)

> We can look into this later, this is not a kernel but a bootloader problem.

Do you think it is GRUB? IIRC it affects also the Ultra2. I did not test 
this kernel, because old Ultra (and SparcStation) cases are becoming 
brittle due to PC+ABS cristallization... and to my sadness also the 
Netra T1 Panel during this deep test process (I tested also OpenBSD and 
NetBSD which now I have fully functional instead of older Solaris, a 
quite nice comparison). I also exchanged most of NVRAM chips, I got a 
couple of NOS of more recent manufacture. Unfortunately one did not work 
or anyway somehow cooked.... need to check that. It made things quite 
more convenient.

Would be nice to look at it, but if it is so "separate thread" from the 
kernel stuff then. I am unsure how the mapping of SCSI targets is going 
on there.

Riccardo
