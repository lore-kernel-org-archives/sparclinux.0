Received: from libero.it (smtp-36.italiaonline.it [213.209.10.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD82330B27
	for <sparclinux@vger.kernel.org>; Wed, 22 Oct 2025 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141512; cv=none; b=pnqx/evZ2VaDjLrsU8ABJo/SYU7bxYOStdlY56h2S81Jmw9lfIZIR1jJrJwy/nG58VuwNKrEmi3xLQhdcPoBLKLG5v2g980eyHB+ijzBLQNpCr2S9KMN4h2NFwfz6Uq7UYS6GY+b1VMUqZRR2pfyhxQFR56mAGprDk8fLf2SSFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141512; c=relaxed/simple;
	bh=abmMcPMA3WiKWH2WP9x+5MaKIquTJnKfLtjW74p/2hg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VGASHVJbDRTJEWgf+6UIWYj6zqjQs10WSfkSsx4inVTfX/g2Obt/022GKXrI5jsTI2iCt/POpdUo3d2R2/3cdv91DcxhpdIx2gaDNHfoWR3K6ymsW3adN0rdMWW6gkGF/jE1WEC3mxiQBRUdgdR6EuSOHV4Ln09MOfk1OvefNGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=UHKcfV77; arc=none smtp.client-ip=213.209.10.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="UHKcfV77"
Received: from [192.168.1.36] ([151.65.17.26])
	by smtp-36.iol.local with ESMTPA
	id BZMBvrZAho6RnBZMCvYJsG; Wed, 22 Oct 2025 15:58:28 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1761141508; bh=ZzMMPPAEv0b0RQpPKpHyMbrEGrqW1ywB4v8/5K8RfOk=;
	h=From;
	b=UHKcfV77a0Z41vmrYYRWnzDeTh+3m/loRASYOhljP/JJJfF6yjQYQXUN5MZQcJoOX
	 epVAbu2RVepGFWfB2LfvSvZUFGN55p7/limwmDn2bECsVKVRGGZb7owB4rkXtxlYJr
	 Dbjm1aVw9mwbGePWNTSHE1/oaNEDIBtnqRVKhy+ZAPn3zBcey6+AmHUpV9kW5iNciU
	 0LPYK/ZZ0twnVKOgHABrmu2PKYYPl+XjHxq70K7bfzgFNsu6DFcKiPjgF58Heca8ie
	 Xj7fMcLLOq3eAh02QwxQHRrecoH9amNBDMi3F4jZMul7wPWefNiP+AxaB9gBb9G7gI
	 qLMoQe9minUJQ==
X-CNFS-Analysis: v=2.4 cv=I6dlRMgg c=1 sm=1 tr=0 ts=68f8e304 cx=a_exe
 a=ST5ZiqFa3+sjRnzYuqUWMA==:117 a=ST5ZiqFa3+sjRnzYuqUWMA==:17
 a=IkcTkHD0fZMA:10 a=xNf9USuDAAAA:8 a=1syAZFpIVNY0p8oxoT4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
Subject: Re: New Debian sparc64 test kernel for stack corruption issue
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
References: <e61027c249c88484a77d2e1dd2a42d2bc1e2ac06.camel@physik.fu-berlin.de>
 <ed13b363-71b7-0467-00eb-c8dedea39eb8@libero.it>
 <82e4d4e7e4439ebf9b4ead403d5f94e482b416fd.camel@physik.fu-berlin.de>
From: Riccardo Mottola <riccardo.mottola@libero.it>
Message-ID: <63585287-3243-b961-209a-426a00651d48@libero.it>
Date: Wed, 22 Oct 2025 16:03:12 +0200
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
X-CMAE-Envelope: MS4xfCTwB3qsMylKiwkUEGi0cF0zVIa5SJuE8+m3W+ObXhlg24qKeSqhn+S4zzH5ignr+B3zSXJ+c3O0oBRa+CJXr9Gg6Ikv/mY7b1GLyNJMX6XX5GDd1TSb
 IQrkgVhMSVh7TU7GfT9mS/BQl4di1ZQAr8oB5ezU3TcDMUWB5ZUjJgqEM5UEFds0pPTycKvY2jncXtV9dJ/wDTQYUa7vzly8h2Jtf8wDgusuG+y2dwYDFBXn
 FFhixldzNorD2TI2e5YK+4HlvVV8lZbZwBa+lWzDezAvA6nE0C0cT3V1HX8Xk2+a

Hi,

regarding T2000 Niagara T1 I did some tests using kernels from debian 
snapshots. E.g.

https://snapshot.debian.org/archive/debian-ports/20250511T134440Z/pool-sparc64/main/l/linux/

I found that 6.13, 6.14, 6.15 were available and I tried most of them.
I was prearing a report file with various boots attempt.
Unfortunately doing lots of reboots, I ended up rebooting my running 
workstation and not the SPARC server loosing everything. Ah! I was not 
"connected" and xterms are look alike.


John Paul Adrian Glaubitz wrote:
>> Take in consideration that on this sytem my sweet spot for kernel is:
>> 6.12.38+deb13-sparc64-smp
> Would you be able to bisect this?
>

The boot breakage appears to be with 6.15. I am unsure of the various 
versions.
6.14 kernels do boot, although during usage I got VM issues (e.g. using 
aptitude while running it)

Luckily I have the downloaded files so I coiuld reconstruct.

-rw-r--r--  1 multix users 42142648 Aug 28 16:34 
linux-image-6.12.3-sparc64-smp_6.12.3-1+sparc64_sparc64.deb
-rw-r--r--  1 multix users 48755288 Sep  8 23:53 
linux-image-6.12+unreleased-sparc64-smp_6.12.43-1+nothp1_sparc64.deb
-rw-r--r--  1 multix users 49575964 Jan 26  2025 
linux-image-6.13-rc7-sparc64-smp_6.13~rc7-1~exp1_sparc64.deb
-rw-r--r--  1 multix users 51283484 Feb 22  2025 
linux-image-6.13-sparc64-smp_6.13.4-1~exp1_sparc64.deb

-> up to here all boot fine!

-rw-r--r--  1 multix users 50302692 Apr 25 22:00 
linux-image-6.14-sparc64-smp_6.14.3-1~exp1_sparc64.deb
-rw-r--r--  1 multix users 50316636 May 10 09:50 
linux-image-6.14-sparc64-smp_6.14.6-1~exp1_sparc64.deb

-> these do boot, but running aptitude issued vm issues, although the 
machine did not lock up and could reboot



-rw-r--r--  1 multix users 50688376 May 23 09:53 
linux-image-6.15-rc7-sparc64-smp_6.15~rc7-1~exp1_sparc64.deb
-rw-r--r--  1 multix users 50664668 May 30 09:54 
linux-image-6.15-sparc64-smp_6.15-1~exp1_sparc64.deb
-rw-r--r--  1 multix users 50935216 Jul 11 16:14 
linux-image-6.15-sparc64-smp_6.15.6-1~exp1_sparc64.deb
-rw-r--r--  1 multix users 50422504 Oct 19 21:58 
linux-image-6.16.12+3-sparc64-smp_6.16.12-2+sparc64.1_sparc64.deb
-rw-r--r--  1 multix users 50432892 Sep 28 03:52 
linux-image-6.16.9+deb14-sparc64-smp_6.16.9-1_sparc64.deb

-> all of these fail to boot, even the rc7

I don't know if there are later 6.14 kernels I can try or earlier 6.15, 
but I would say that the issue is there.
Could be kernel code, change in configuration...

Riccardo

