Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72A32D9EFB;
	Fri, 31 Jul 2026 09:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785489422; cv=none; b=HE2MjIfpIrZQaU8MMe2OZmuxaTh/JA/vETFCAwLcFMhLAS37w/SCp8JnkONCk5TcHquIxsg5TfHjkOqI0t3FwhDziCfopWo7lzWbSQb9zYEKx++zrDihTW+06J7ZA4SKIc23/S0ue6uLYM8xDi/GBXqIqfQWmqSa0gWUXukbOrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785489422; c=relaxed/simple;
	bh=STdaIP3BkiVmPg2LzJMfTZnSTYZgh/uiXsJvPKHCoG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sc8fXku1w2KdbydUCRBk10fIsBLMhgMTX2hM/zIb5QScGVK34oMQig8BtR44khI3Kf8yTWWM0kcFv9xa5ol/RZ/7XMOgjPsNsOalRRsNNO/asuesNHZcox0qUb357ZvXYCvCg3oCoN24ljPRAXBKGyPp0Yi9vgKK5tfJp6Rc9z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVqZv+eN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVqZv+eN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A682E1F000E9;
	Fri, 31 Jul 2026 09:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785489420;
	bh=lUJhtLi6sjw4TDrdtAdIGO4QqwN3Ldi1q7BaQU8Zx0g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hVqZv+eNQ0zmamVWG/pRAGaYY20PIzxTUffAL7k+7erCUTDQ3iIWfWrFI+Oc9rF6S
	 5WGp/o28iCUUc5xqTUHdmi4Wu/G7YuvjFbYzn1/y9IAdFsv+fdkl38lrwI5dsIzZfX
	 O3aDueXRG0pkUQ33hAmi/+n7v//J67j6pbrbIOI2hdwmMfzWCfTPa1yQxVcQ7vQ7Cp
	 vEI7DoV0xD1td3+Hhhp0EZopRrqN0Hx8iNzGT+pbgXY1YFtQrYBoc3laNWv5JO87Bi
	 HY9N/yQ/Qos2JjrIJyPT1nPDMW5wnrfyHB1qeF3OtB7t+S6vyx/cQWy3Qp78GkR8AJ
	 vauF1M+uhhwDA==
Message-ID: <3bf1002b-4e3e-4670-a3d9-2f5b7f67beb7@kernel.org>
Date: Fri, 31 Jul 2026 11:16:57 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tty: vcc: zero-initialize control packet in
 vcc_send_ctl()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Joshua Rogers <linux@joshua.hu>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, stable <stable@kernel.org>,
 Kees Cook <keescook@chromium.org>
References: <20260731-aisle-tty-vcc-v1-0-962e18beb8a8@linuxfoundation.org>
 <20260731-aisle-tty-vcc-v1-1-962e18beb8a8@linuxfoundation.org>
 <42534bff-4aed-497d-bb9c-e413b92493cb@kernel.org>
 <2026073155-leverage-rentable-fbbd@gregkh>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <2026073155-leverage-rentable-fbbd@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31. 07. 26, 10:32, Greg Kroah-Hartman wrote:
> On Fri, Jul 31, 2026 at 10:29:14AM +0200, Jiri Slaby wrote:
>> On 31. 07. 26, 10:15, Greg Kroah-Hartman wrote:
>>> From: Joshua Rogers <linux@joshua.hu>
>>>
>>> The stack-allocated struct vio_vcc pkt was partially initialized,
>>> leaving the tag.stype_env field uninitialized before being sent via
>>> ldc_write(), potentially leaking kernel stack data to the LDC peer.
>>>
>>> Assisted-by: AISLE:Snapshot
>>> Cc: stable <stable@kernel.org>
>>> Signed-off-by: Joshua Rogers <linux@joshua.hu>
>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> ---
>>>    drivers/tty/vcc.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
>>> index 27a55465bf5e..3947bd2b75ac 100644
>>> --- a/drivers/tty/vcc.c
>>> +++ b/drivers/tty/vcc.c
>>> @@ -492,7 +492,7 @@ static ssize_t domain_show(struct device *dev,
>>>    static int vcc_send_ctl(struct vcc_port *port, int ctl)
>>>    {
>>> -	struct vio_vcc pkt;
>>> +	struct vio_vcc pkt = {};
>>
>> Note this needs not initialize holes.
> 
> Does it?  I keep forgetting this if it's really true or not.  I think
> we've been through this in the past but I can't find the archives.
> 
>> I believe there are none here, but memset() is usually
>> preferred/safer.
> 
> Last I remember, a long time ago, the compiler would just use memset()
> for this, and hit the holes.  Or is that a compiler-specific issue?
> 
> Yes, it's more obvious, and I'll be glad to change it, but figuring this
> out for real would be great :)

OK, so the standard (C17) does not guarantee zeroing.

What I found though:

* both clang and gcc zero the full struct for "{}". There was a bug in 
gcc < 8 where it did not.

* this is not true for designated initializer, cf. ce50039be49e ("net: 
sched: act_ife: initialize struct tc_ife to fix KMSAN kernel-infoleak")).


Adding Kees who is the author of:
====
Memory initialization
---------------------

Memory copied to userspace must always be fully initialized. If not
explicitly memset(), this will require changes to the compiler to make
sure structure holes are cleared.
====

He might aware of more bugs.



FWIW, {} here should be safe for two reasons:
* not a designated initializer
* no holes (IMO)

thanks,
-- 
js
suse labs
