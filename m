Received: from mail.oetec.com (mail.oetec.com [108.160.241.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE2E3B1EC6
	for <sparclinux@vger.kernel.org>; Thu,  1 Oct 2026 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.160.241.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790877036; cv=none; b=D3hYx8FJKJMpu5ktutEE9YrGy8X2liRTl13CHuEDjFgwPVCUelRcCAggvc9x6xBqccfiH9rI48c7/S3+C1Wy2H7kF4N8MCdJTHYDwNQO9v1Rm8pNxR0MUbXZMoHqO65SNEgcdC86F2cEOXiKSLrVaObmpyct70o55si5B88OP0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790877036; c=relaxed/simple;
	bh=ELPFYzWdImKb+ze54Mo9Lp3L6gJUzxXEMSjU3RXcGQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PSgklQ1QgKlLxPiS0ZYUI1Vlc3p4jFaHBs1ExqcyhxE+41iaVIyjecDTZ7e9OuNIYQ75v9j9F0l9zeIA+XiMTXxUsQslCuzxDr0i3CJwvp88vHhTWmXRRH5MMdgVfnco08XqUYgqcnwsbtwl9fMFyvMlJXIMhd9LYiiZtKzCZzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=blastwave.org; spf=pass smtp.mailfrom=blastwave.org; dkim=fail (2048-bit key) header.d=blastwave.org header.i=@blastwave.org header.b=dx0uU+jv reason="signature verification failed"; arc=none smtp.client-ip=108.160.241.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=blastwave.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blastwave.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=blastwave.org header.i=@blastwave.org header.b="dx0uU+jv"
Received: from [192.168.2.3] (bras-base-btfdon1711w-grc-49-65-95-211-81.dsl.bell.ca [65.95.211.81])
	(authenticated bits=0)
	by mail.oetec.com (8.17.1/8.17.1) with ESMTPSA id 691HbpPa024964
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Thu, 1 Oct 2026 13:37:51 -0400 (EDT)
	(envelope-from dclarke@blastwave.org)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=blastwave.org;
	s=default; t=1790876272;
	bh=ELPFYzWdImKb+ze54Mo9Lp3L6gJUzxXEMSjU3RXcGQk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dx0uU+jvjMah1ZVwOuozck7kmMlR+eglx0RZU7OyejYF7EpnU0kFjVq4T+MMzGtxV
	 oFp6aQGhRztu5d239aDq5G4bq0lEhnwYfsfbZQTc0+LLUrsKsD6Xnk8BxAneE4alXo
	 Ek1RV+2JPq51HXeoEX8jpYV7Rpc+pIH+FmSgM9dEqnVR9h+YfGHRdMh2I+7AyXy+rQ
	 xN8UMPFdLqcz0aP3DaymJB2IJMiFcYPojlmKHb8M239227Vpc0dTOHjpXfFpnEgj8M
	 gLdI9qL8D7U9f0YNI92y1LdO4ba/zJY6RWHY0D3j24co1oo0DZc2TvUklYLxxr4rDu
	 tQgNVeQ/5htNA==
Message-ID: <e2113dd8-6e87-469a-a635-df357a869320@blastwave.org>
Date: Thu, 1 Oct 2026 13:37:51 -0400
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux on Fujitsu M3000 - was: Re: [PATCH v3] crypto: aes - Fix
 undesired override of some optimized AES modes
Content-Language: en-CA
To: Magnus Lindholm <linmag7@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: sparclinux@vger.kernel.org,
        "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
References: <20260929222752.36427-1-ebiggers@kernel.org>
 <322e5255353e3a5f9e3840a496018edd980fb016.camel@itx.no>
 <1f85bdb9614365fedda81fb649147da48bf7be13.camel@physik.fu-berlin.de>
 <25c7a7c7bbe3c7f70fca559867e0883b9e4dc48d.camel@itx.no>
 <3ea57d640ac7409fa37b15ec9e3f49126347e432.camel@physik.fu-berlin.de>
 <8d3d3142d1ac323695a3ea2d5b3e2a10d2a129d6.camel@itx.no>
 <CA+=Fv5R0F5YNgORUx1c8YWzyFcS6wqVtmzQUXaS3vuLHYwBndw@mail.gmail.com>
 <071a1ebbd8dc9d99bfe9b4c98285f435bdb3a39f.camel@physik.fu-berlin.de>
 <CA+=Fv5SgDoLxN5-un=Q2=Q-SYCyZwHMNLEeBkjSqrc5KSS0=ww@mail.gmail.com>
From: Dennis Clarke <dclarke@blastwave.org>
Organization: GENUNIX
In-Reply-To: <CA+=Fv5SgDoLxN5-un=Q2=Q-SYCyZwHMNLEeBkjSqrc5KSS0=ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-oetec-MailScanner-Information: Please contact the ISP for more information
X-oetec-MailScanner-ID: 691HbpPa024964
X-oetec-MailScanner: Found to be clean
X-oetec-MailScanner-From: dclarke@blastwave.org

On 9/30/26 17:41, Magnus Lindholm wrote:
> Hi Adrian,
> 
> On Wed, Sep 30, 2026 at 10:23 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
>>
>> On Wed, 2026-09-30 at 18:03 +0200, Magnus Lindholm wrote:
>>> Hi,

.
.
. <snip>
.
.

> Thanks for picking this up, I would very much appreciate some help with testing.
> Getting in touch with people who have access to M3000 hardware
> and are willing to help out in testing would be great.
> 
> I'm gonna go over the patches and do some cleaning up, I hope I'll
> have something
> to send out by the weekend.
> 
> Magnus
> 


Sadly I tossed that machine into the trash a few months ago. Full of
memory and SAS disks and gone out the door to the recycle centre.

I still have a SPARC S7-2 server and a few Netra units.

-- 
--
Dennis Clarke
RISC-V/SPARC/PPC/ARM/CISC
UNIX and Linux spoken
