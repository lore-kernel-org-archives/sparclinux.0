Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82E23FB1C
	for <sparclinux@vger.kernel.org>; Mon, 12 Feb 2024 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707761695; cv=none; b=HarBexRk0xvoSrku2VDXG24Y2lOY0ytL14QsJ5X7sv8GM5ym/17oW2xh7bYKRCQ1/nSF3R5WaL/VCVpTT3tr0PERJLqSkaPr9oxhn+dAcPPmlQekqTNhc2Ysi1/4+uu4h+IMxcFthRJCG5Qvf0Ciy22p8CT/tyy8T8pnrNsnag8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707761695; c=relaxed/simple;
	bh=hMlSs7/STAUc3R4i7h2Skp03HeKEinchAJV4rZebeXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4IkiEMyer4JJ4J5JhmhaKyILvbV/7H2g/cxM3U5IHmZliU8fuXhvKP2EuXlvXhTTK8EJsg2b++SjcfDqHrwVR/ASaIoGPG787YKNH5knxm8GyWINYeGifGOVD1g1AYF7HSlvWL0f5omHQvbm1DCjy5FeJ1X4KbcHiGAcu4winA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1rZapL-000000035ct-4Aa4; Mon, 12 Feb 2024 19:14:48 +0100
Received: from pd9f63554.dip0.t-ipconnect.de ([217.246.53.84] helo=[192.168.144.87])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <kernel@mkarcher.dialup.fu-berlin.de>)
          id 1rZapL-00000000tTQ-3Ewb; Mon, 12 Feb 2024 19:14:47 +0100
Message-ID: <62f9be9d-a086-4134-9a9f-5df8822708af@mkarcher.dialup.fu-berlin.de>
Date: Mon, 12 Feb 2024 19:14:46 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Reproducer for the posix_spawn() bug on sparc64
To: Adhemerval Zanella Netto <zatrazz@gmail.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 sparclinux <sparclinux@vger.kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "David S. Miller" <davem@davemloft.net>, Sam James <sam@gentoo.org>,
 jrtc27 <jrtc27@debian.org>
References: <fe5cc47167430007560501aabb28ba154985b661.camel@physik.fu-berlin.de>
 <3ae4130c-c5aa-428e-b819-44cf2daf2af1@mkarcher.dialup.fu-berlin.de>
 <ec6254ce82d8ea5d9d3e73680c98b42f06d0930a.camel@physik.fu-berlin.de>
 <e44d6030-b7dd-4caa-99b6-87409988a76a@gmail.com>
 <48af8a12516ff0db379addb07daea58722c8ea1a.camel@physik.fu-berlin.de>
 <9d466551-dc73-47ae-a73a-d2bd4a5f19af@gmail.com>
From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
In-Reply-To: <9d466551-dc73-47ae-a73a-d2bd4a5f19af@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Original-Sender: kernel@mkarcher.dialup.fu-berlin.de
X-ZEDAT-Hint: PO

Am 12.02.2024 um 18:31 schrieb Adhemerval Zanella Netto:
> On 12/02/24 13:32, John Paul Adrian Glaubitz wrote:
>> Hi Adhemerval,
>>
>> On Mon, 2024-02-12 at 11:01 -0300, Adhemerval Zanella Netto wrote:
>>> It fails on the two different sparc64 machines I usually use for glibc testing as well:
>>>
>>> azanella@catbus ~ $ /lib64/libc.so.6 | head -n 1
>>> GNU C Library (Gentoo 2.38-r9 (patchset 9)) stable release version 2.38.
>>> azanella@catbus ~ $ uname -a
>>> Linux catbus.sparc.dev.gentoo.org 6.1.72 #1 SMP Fri Jan 12 15:00:51 PST 2024 sparc64 sun4v UltraSparc T5 (Niagara5) GNU/Linux
>>> azanella@catbus ~ $ ./more_clone_attack
>>> effective FP in clone() with waste 0 = 7feffee09f0
>>> this is 318 64-bit words above the next page boundary
>>> clone: Bad address
>>> Problem detected at 1 pages distance
>>>
>>>
>>> azanella@ravirin:~$ /lib/sparc64-linux-gnu/libc.so.6 | head -n 1
>>> GNU C Library (Debian GLIBC 2.37-15) stable release version 2.37.
>>> azanella@ravirin:~$ uname -a
>>> Linux ravirin 4.19.0-5-sparc64 #1 Debian 4.19.37-6 (2019-07-18) sparc64 GNU/Linux
>>> azanella@ravirin:~$ ./more_clone_attack
>>> effective FP in clone() with waste 0 = 7feffa3ae50
>>> this is 458 64-bit words above the next page boundary
>>> clone: Bad address
>>> Problem detected at 1 pages distance
>>>
>>>
>>> And I see similar failures on qemu as well.
>> Thanks for the confirmation. I was also able to reproduce it even on Debian Wheezy
>> with kernel 3.2.0 and glibc 2.13, so it seems the bug is very old.
>>
>> Do you think it's a kernel or glibc bug?
>>
>> Adrian
>>
> I am not sure, I was leaning to some clone change in recent changes; but since you did
> see on version as old as 2.13 I don't think it is related to glibc clone implementation.
>
> It really make me to believe it is something related to kernel because running the regression
> program under strace I could not trigger the issue; nor by trying adding a printf just before
> clone call.

I did some root cause analysis. I *know* that the issue happens when %sp points into
uncommitted memory on the stack when the system call is invoked. If you add a printf
after the variable-length array has been reserved on the stack, you cause the target
stack page to be faulted in, so %sp is no longer hovering over uncommitted memory.
That's what the +/-22 comes from: I target to get %sp in call_clone (that is %fp in
clone) aligned to a page boundary. clone then reserves 24 64-bit-words on the stack
(without touching them). If the page boundary that %fp hovers over is
the lowest-address committed stack page, %sp will get into (yet) uncommitted memory.
wasting 24 words less make %sp get to the bottom of the last committed page, so the
issue does not appear. wasting at least 24 extra words cause the 7th argument to
clone to appear on the yet uncommitted page, and generates a page fault that commits
this page before clone is invoked.

Now that's the point where the guesswork starts: the kernel entry for clone, vfork and
fork issues "flushw" to flush the register windows to the stack. In the problematic
situation, this will hit address space without a committed page behind it. If I understand
the save trap handler in the kernel correctly, it detects that it is called from
kernel-space, and that the saving happens to user-space memory. In that case, the kernel
*disables* MMU fault traps, tries the saving, and the checks whether some writes got
dropped due to a fault by checking a MMU status flag. In that case, the kernels saves
the register into some backup location, because the kernel requires that saving the
user-space register to stack works, even if the user-mode stack is "bolixed".

Now, clone clones (pun intended) the frame of the caller into the stack of the new
"thread" (let's not argue whether the thing clone creates is a "lightweight procss",
a "thread", an "execution flow of some indetermined kind" or whatever), which is the
area between %sp of the caller frame and %fp of the caller frame. I guess the call
goes haywire at the point when %sp points to the backup location, but %fp points to
the user-mode stack (or possibly some different backup location), and "the area
between %sp and %fp" is no longer a well-defined memory range.

Let me know if you want file names / line numbers into the kernel source to back up
the facts and guesswork I wrote.

Kind regards,
   Michael Karcher

