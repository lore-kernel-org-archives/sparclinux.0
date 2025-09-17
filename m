Received: from libero.it (smtp-31-wd.italiaonline.it [213.209.13.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F982D8383
	for <sparclinux@vger.kernel.org>; Wed, 17 Sep 2025 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.13.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117886; cv=none; b=ueWy1EwJiyfDO3G9josBQcYt20OxAWYSDwsNugGU1eq/1q9ErCCOYFS3Iu3j3++yfOTNkVUbGLMyatH2l8Xzcw2e3fmnmRL8uG9K22GC/t7UuJN1LvryZs6KdNEvpW+sqb5f0rbd+NO1wxDFr49Gp05jOFcn11jFaUEILFxMwLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117886; c=relaxed/simple;
	bh=+kuhSKsjPxQ8nOrSZdx0XxDy6WRC00FTF7AC4OCtulc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MC4J3QY1XgP4zFqDtcigEpQRpB/bQdquS+o6CF+Pt7/3pQx00QPSW2970uqEpRlgdWdVjI60CVeOj0QaCQRXcjnKXTtOWnnobfFJzAbtrlBuxumDKyzOjRyYO87IdW67JAnf6S7s0Ou4V+sqkMGn57pdE8clBwTn4qzfvNVsvA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=J220iQT7; arc=none smtp.client-ip=213.209.13.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="J220iQT7"
Received: from [192.168.1.36] ([151.65.2.228])
	by smtp-31.iol.local with ESMTPA
	id ysm1ua0TX90dBysm2udAKv; Wed, 17 Sep 2025 16:04:42 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1758117882; bh=H/egCDy360dY4Nlu1TnTBbuSMVnjJdqH+I3/V00HJIc=;
	h=From;
	b=J220iQT7rGgBmcLePcWU90Pap8zkc+uAzimNkoFHx2oltt9d/GKMLdHu6GyJrnuXw
	 vN7cVsC1iSAJ0Np/+IvGQZJ7eEfBqvaWKKidrTfGBa9qoB6Sx3WMBfXweuHhBgw0p8
	 aZAdUCJ1GLVuWtP8yzLA728IgwO5QYxh6hsspUnj15bs5/D1kkEv6D2FbCCxrVNkxZ
	 zeUI5fFxRlDKD+h6geDMwSRdOs7mOugqxZGwad7Wl8naI0oHOITA3vrj4OrDYamYlX
	 aV10zJT1gsa2XbR3mMgaMsWe7WkRJh1QV/Q0fwwLMzB5Ry/EC+ysWt+zSp+V+dizA5
	 gvayZr7yV0DwQ==
X-CNFS-Analysis: v=2.4 cv=bNoWIO+Z c=1 sm=1 tr=0 ts=68cabffa cx=a_exe
 a=fUUb/luldTa8vXwyIFcL2Q==:117 a=fUUb/luldTa8vXwyIFcL2Q==:17
 a=IkcTkHD0fZMA:10 a=PlO26epGgpw1fcW0wy0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
Subject: Re: New test kernel - second attempt
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
References: <9b8530550078b5e89b19e987981d25fee8e18500.camel@physik.fu-berlin.de>
 <7515a193-5ae2-69d6-9c6e-c3b6c7459f50@libero.it>
 <73e81a8280b345ee09df0dfa9f0e21148144722f.camel@physik.fu-berlin.de>
 <74380961-4a1b-95a7-96f5-448737356082@libero.it>
 <4207162c8254a2b8f423db485f974ca00ae355a3.camel@physik.fu-berlin.de>
 <a00eb0eb-5276-0f0b-f983-f14d20c62978@libero.it>
 <701179a7ec724e3d921bcc8e31315f2fea45b4b7.camel@physik.fu-berlin.de>
From: Riccardo Mottola <riccardo.mottola@libero.it>
Message-ID: <2f0fbc24-e73f-5b47-8b7e-ee48e720f899@libero.it>
Date: Wed, 17 Sep 2025 16:08:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.21
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <701179a7ec724e3d921bcc8e31315f2fea45b4b7.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJh8q7tetz7Qmp8h8dglTSEBLMgfV4G1OuYjXfdO5Ozrp7Wc7mdGnJHnoOUwkglDB5lVQK8aAdGBBWeYZtRB1XqGVAbHa99S9Jqm8L++SCeaxfu/HSmU
 wpW5NC/1h9uhfC8NoISpcp2rSi5k8/QLYrUzQSk0PD44hOIZswr/mqd50LczmL2MWIw0a8o0DPC8cewwT9lC1h6gnzKjfmuyaKsa76mNS4gDRcPZYxHL5WfN
 +cbmwNvvONFy8kgVbWZR1Y3kBHfVYxjpvgrPMR907/+iPfikj36MCHyg6y2QQH/z

John Paul Adrian Glaubitz wrote:
> Looks like your machine has problems with power management.

some feature previously not harnessed by older kernels?

>
> Could be issues with the hardware. I would give Solaris 11.3 a try to verify
> that the hardware is actually working properly.

That one is unfortunately long gone. It did work years ago before I 
"linuxized" it.

Thanks to ALOM, I can check for faults and see:
sc> showfaults
Last POST run: SAT JAN 01 02:15:39 2000
POST status: Passed all devices

   ID FRU               Fault
    0 SC/BAT            BATTERY at SC/BAT/V_BAT has exceeded low warning 
threshold.

that should be minor, just my NVRAM battery going low? IIRC it is 
user-replacemable on the T2000... put that on my TODO.

Riccardo
