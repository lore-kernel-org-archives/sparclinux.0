Received: from libero.it (smtp-31-wd.italiaonline.it [213.209.13.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBBF30FF25
	for <sparclinux@vger.kernel.org>; Fri, 19 Sep 2025 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.13.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758289515; cv=none; b=marW/x3AEd9P+PAkOD0lJ1DuDGZr6XGjeExd3Tc4jw+Y5soe9QqAgzT3c49fLO4FTwcG8rbi2bAfJqhFEBSHr04KG+KbM+CxwQ7oVKp6dNDAwu/UpcxvlxJepuC0bu67JMKrb88QCopa2gIkk9q+7T+TkUlHcAy9yi03J2jHqkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758289515; c=relaxed/simple;
	bh=mICMv23kIho3N59fEOZzsVBvFeE2YPXk2kKNVofm824=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=g18lT24DIOsx4rnqkRfmBg3K1IQIuRe4py+1pETyWIAU5bzKBTQ/nw6DUk06aSvEOl4/gq7b4elvfFjxiO44Zl+u8PrjVUJPdq9KPwGSEAUhmGT+n0iI4IEr2Hhx0YYRY/J/515UDLkj4RTrJjTa+Axl7LM6VlLKh22mEGklUQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=apo6urzA; arc=none smtp.client-ip=213.209.13.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="apo6urzA"
Received: from [192.168.1.36] ([151.65.2.228])
	by smtp-31.iol.local with ESMTPA
	id zbQEupKiX90dBzbQEukn7M; Fri, 19 Sep 2025 15:45:10 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1758289510; bh=8q309Kt4mcU1msC+++fu+mf0P1GV1BZZ0GeNV3E4nsU=;
	h=From;
	b=apo6urzA2c7FQhPEJrbp0LQgNpNkoR2f5K2nsIE1mpdsTRG84ozMFiDoEmMJsmvpv
	 Gxx3nXcOmiYhw0vjJG9MUnR+1GlFTwXB65M1FCdi0TIZ1ywAd4ETxI3BCvDkYzP3zm
	 kfGAuEdzgRjg5rDznieAWUqj2LM2KbJA5QqvzTpwNjrJ4txeNUuDnVLSDvg4DRU2+c
	 jLIcsVRTKn6UfxdoEeHT8pdS58rXoSmQWh4up9hncLKg8sXbqh1KF51TQIBk5ZEvFg
	 sCjDXXq31y5IslOSyR+AqE32E0JHV3UJ5nEHxD6ESVaftFhOgtEGoId2eCw1+SBpVH
	 C5GL76DQGI8Dg==
X-CNFS-Analysis: v=2.4 cv=bNoWIO+Z c=1 sm=1 tr=0 ts=68cd5e66 cx=a_exe
 a=fUUb/luldTa8vXwyIFcL2Q==:117 a=fUUb/luldTa8vXwyIFcL2Q==:17
 a=IkcTkHD0fZMA:10 a=Nz9hZ4mRXWPXzyWNrqsA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
Subject: Re: New test kernel - second attempt
To: Robin Cremer <robin.cremer@medicem.de>
Cc: "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>,
 sparclinux <sparclinux@vger.kernel.org>
References: <9b8530550078b5e89b19e987981d25fee8e18500.camel@physik.fu-berlin.de>
 <7515a193-5ae2-69d6-9c6e-c3b6c7459f50@libero.it>
 <73e81a8280b345ee09df0dfa9f0e21148144722f.camel@physik.fu-berlin.de>
 <74380961-4a1b-95a7-96f5-448737356082@libero.it>
 <4207162c8254a2b8f423db485f974ca00ae355a3.camel@physik.fu-berlin.de>
 <784cff9b-d09b-8f02-0f77-d48bcda6c921@libero.it>
 <f12d40b7-9dd8-49c1-b65d-b725c154d7c8@medicem.de>
From: Riccardo Mottola <riccardo.mottola@libero.it>
Message-ID: <58525cc2-7be7-fe12-5bf7-48648ead1569@libero.it>
Date: Fri, 19 Sep 2025 15:48:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.21
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f12d40b7-9dd8-49c1-b65d-b725c154d7c8@medicem.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGtEV3vR1htzzO2UXbK3RV3Xh4zF26jt1UMrobifqwBJ3COP2FrY66NlhscKG7rPLdnGPOy8odEQFUYP81YzHWpXhWQsFuvVuuJVFhq52QgYQXRP00Ce
 W64ORKUYk8dPNe7KQVvXwzEnIPi0SHKnNiCRdbEyXiM0QuK9ZqJECuaebLt0wsBCfZqiSnzPOxFLP9yFFrmMTP6Vln8PA9IjLfIsj84rrwjPNF0SGWRWTbDz
 zk6SAigsQarn7k61po7/tVilHaCDh0zH3JmMT5G0XPl5LUtQhRL4nJei/KBIWGm9

Hi Robin,

Robin Cremer wrote:
> Are you sure it hangs? Or maybe console is going to a different output? Do these systems have a framebuffer installed? Linux might favor output there. What cmdline are you using for the kernels in grub?

No I am not sure. I did wait for a while, so if the kernel would start 
up at one point up to the login on serial, that one did not come.

Systems are without keyboard and monitor and Solaris & NetBSD just 
worked out. I did not remove framebuffers, will check.
I could also attach Keyboard & Monitor - even if the LCD I now have 
doesn't display Sun resolution correctly, it is readable (at least with 
the SparcStations). It it could be a GRUB sensing and ignoring OBP settings.

Will write back when I can test.

Riccardo
