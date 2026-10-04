Received: from mail.oetec.com (mail.oetec.com [108.160.241.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DD81922FD
	for <sparclinux@vger.kernel.org>; Sun,  4 Oct 2026 00:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.160.241.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791075497; cv=none; b=Tg4i6g3F1Fz0dc08uoPMWKJCrZpKdmvGms/EaSKW0vprl3vcO0GS8o+WYeHQAFq369QyB801bhsTU8oLpkS/mxWY9rMJOUzdI0qqVyq3CeZD/TSTJg4whxUMJ/eWTWrRySi6M0eoL6/Tr5kd2+fN+xEgw+op1Va3lTw3r3LvyUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791075497; c=relaxed/simple;
	bh=bws1og46n9cROSagv55nAOp9IMvlcx53YBnuOgIrd5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I8Y6qFNDSygt0aaN8Lu6TL6uo8OEataYUVwM2ghFC3wtgPgdxWb8+1VlA7H6Po9bHwkDnBZEtURBG+CqFxva2jTz95ZdfaDjjfO+3fjRKvxIx+KtVbNnya0MW/3Yx2RpA9RwsHv/xwdXEGXvpYps8mVcz4gvloYwcUMqX0hKIJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=blastwave.org; spf=pass smtp.mailfrom=blastwave.org; dkim=fail (2048-bit key) header.d=blastwave.org header.i=@blastwave.org header.b=V3oaXhfQ reason="signature verification failed"; arc=none smtp.client-ip=108.160.241.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=blastwave.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blastwave.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=blastwave.org header.i=@blastwave.org header.b="V3oaXhfQ"
Received: from [192.168.2.3] (bras-base-btfdon1711w-grc-49-65-95-211-81.dsl.bell.ca [65.95.211.81])
	(authenticated bits=0)
	by mail.oetec.com (8.17.1/8.17.1) with ESMTPSA id 6940vkpH005841
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Sat, 3 Oct 2026 20:57:54 -0400 (EDT)
	(envelope-from dclarke@blastwave.org)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=blastwave.org;
	s=default; t=1791075475;
	bh=bws1og46n9cROSagv55nAOp9IMvlcx53YBnuOgIrd5k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=V3oaXhfQmyj6tkPTH+jnWnUXosENDiz3ZUdPziRwi/8N0CRm8vUV8vC/OoGas7XGr
	 37v4jV3AvXsQ5zpbUrrY+ii0uiMh/upGjD0YsSp9GlvV9mgWnQlOFW52ntbcSXpxQE
	 CxEILJrIIIQ69kjRQpXPz6FEDxOmMRzYdozkhYwYqxPZnUGKAtjyXS8qUnsLD/NtcS
	 Q48nDkLJvRIuZqq3rYEaHa7yBiMOKeyMkKBCte/xtducslJiDF2PqsZgZqW1B2mtJG
	 2DAGEKLuNYuOhHhiw6QiWxsX9xGrOlmGryA/pZ8DHofs2xjLekkozSK+ygRVpeskHN
	 tYUHpNAveg0Dg==
Message-ID: <9d34ee51-f5ca-46f6-89b0-4e8b7e59876e@blastwave.org>
Date: Sat, 3 Oct 2026 20:57:46 -0400
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux on Fujitsu M3000 - was: Re: [PATCH v3] crypto: aes - Fix
 undesired override of some optimized AES modes
To: Magnus Lindholm <linmag7@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        sparclinux@vger.kernel.org,
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
 <e2113dd8-6e87-469a-a635-df357a869320@blastwave.org>
 <CA+=Fv5RqCug-f7R40k2MJGL=frXaxv9OzNwQWSB_o7XP5FryHA@mail.gmail.com>
Content-Language: en-CA
From: Dennis Clarke <dclarke@blastwave.org>
Organization: GENUNIX
In-Reply-To: <CA+=Fv5RqCug-f7R40k2MJGL=frXaxv9OzNwQWSB_o7XP5FryHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-oetec-MailScanner-Information: Please contact the ISP for more information
X-oetec-MailScanner-ID: 6940vkpH005841
X-oetec-MailScanner: Found to be clean
X-oetec-MailScanner-From: dclarke@blastwave.org

On 10/2/26 03:09, Magnus Lindholm wrote:
> Hi Dennis,
> 
> On Thu, Oct 1, 2026 at 7:37 PM Dennis Clarke <dclarke@blastwave.org> wrote:
>>
>>
>> Sadly I tossed that machine into the trash a few months ago. Full of
>> memory and SAS disks and gone out the door to the recycle centre.
>>
> Oooh no! Missed that by only a few months then?  But I understand,
> My M3000 came close to meeting the same faith a few times, but for
> some reason I've kept it in the hopes of resurrecting it again some
> day.
> 

Trust me, you would not even want to pay for the shipping. However it
was a fine unit that could *only* run Solaris 10. I do regret that I
do not have a decent Fujitsu SPARC64 handy. That can be easily fixed
if I also install a proper 220 volt battery backup unit for an M4000.

>>
>> I still have a SPARC S7-2 server and a few Netra units.
>>
> The S7-2 is a really nice machine.
> 

It is very loud. Really a screamer. Fantastic cooling.

Has anyone given a try with these snapshots? :

     https://cdimage.debian.org/cdimage/ports/snapshots/2026-06-12/

I can spin up a logical hardware domain ( LDOM ) with reasonable stuff
and a dedicated 10G network port. See what works or does not. I have not
had good success on the S7 with Linux.


-- 
--
Dennis Clarke
RISC-V/SPARC/PPC/ARM/CISC
UNIX and Linux spoken
