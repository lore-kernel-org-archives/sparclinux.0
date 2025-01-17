Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1F31422A8;
	Fri, 17 Jan 2025 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737127282; cv=none; b=sA25u/cK9A+//USUdXH1Wn2EKSpLqZ2rw8JbjIuOsOyoAygFgkyS3zCRxFpmmhrOY+AqZUcj979dXiDgP7SRF1GIgc8LGAUY3oBdRVZ/1JDDq/OzVqBiuNTF7j3D5jFsgDiSZBwjC0gVRaqDvxfd3j9JxSKt6FILe2BpKxh2rpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737127282; c=relaxed/simple;
	bh=yGa6hUzr8DyJEUBZ3tI919w/9gXsLA0qRuSoWKb8zCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O9hM0cjoAB/yIdfFXW8hC2FqOpVf0syfqMfVbA3eIlQQ5kVxOBt/NQRWY51uc/F7r8ya41RzBNhuUssnL99fUCIJZy59KWqscGXgxk4cSn0+Yd8n3RZxUiy/zUVsG/oD74e7EZI51gKETRBEt2KWryckx0qMiHLoA7FNEBEPIjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=qcDkNu7Q; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="qcDkNu7Q"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4YZNjn60W5z1DHcQ;
	Fri, 17 Jan 2025 16:21:17 +0100 (CET)
Received: from [10.10.15.35] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4YZNjn2z5Hz1DHbt;
	Fri, 17 Jan 2025 16:21:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1737127277;
	bh=ptHOXP1wUmzgIYRIhu7sO95fxnt/T49njRfcoSsxbfo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=qcDkNu7Q+pGRtmwF7kX23QL1k+dKNXxTEw0eMLervZw2xWN8WMYWSOZrr6iGB2KPh
	 k594mM03l3FRzm9eal5Ot91CVaMGYi0e9wmmfvtOd4ZgAjX358Cr+fXVR+S4oQpYGf
	 3LaINmbOwwadHHytD1BM2ipbIPlxOBBHL4wK5y8k=
Message-ID: <b100da95-ff1c-43fe-8b63-c9830d2db5e9@gaisler.com>
Date: Fri, 17 Jan 2025 16:21:17 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc/irq: Remove unneeded if check in
 sun4v_cookie_only_virqs()
To: Thorsten Blum <thorsten.blum@linux.dev>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Sam Ravnborg <sam@ravnborg.org>, Dawei Li <dawei.li@shingroup.cn>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250114202502.912690-1-thorsten.blum@linux.dev>
 <2b249bb11b3c08b21929b46f14bee808c9bbefe6.camel@physik.fu-berlin.de>
 <D58E47DF-ADED-4FD0-9710-62FBA284093E@linux.dev>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <D58E47DF-ADED-4FD0-9710-62FBA284093E@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-01-15 17:11, Thorsten Blum wrote:
> Hi Adrian,
> 
> On 14. Jan 2025, at 21:29, John Paul Adrian Glaubitz wrote:
>> On Tue, 2025-01-14 at 21:25 +0100, Thorsten Blum wrote:
>>> Remove the unnecessary if check and return the result directly.
>>>
>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>>> ---
>>> arch/sparc/kernel/irq_64.c | 4 +---
>>> 1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
>>> index aff0d24f8c6f..81fb49b089a8 100644
>>> --- a/arch/sparc/kernel/irq_64.c
>>> +++ b/arch/sparc/kernel/irq_64.c
>>> @@ -146,9 +146,7 @@ static int hv_irq_version;
>>>  */
>>> static bool sun4v_cookie_only_virqs(void)
>>> {
>>> - if (hv_irq_version >= 3)
>>> - return true;
>>> - return false;
>>> + return hv_irq_version >= 3;
>>> }
>>>
>>> static void __init irq_init_hv(void)
>>
>> I'm not sure whether this change is really necessary nor will it improve
>> the readability of the code. I think the compiler will optimize the code
>> the same way, for both variants.
> 
> It's not strictly necessary, but it's shorter, less verbose, and imo
> improves the code's readability. Personally, I'd even consider the
> current version a code smell, but feel free to ignore the patch.

I could see it both ways, but personally agree about it being slightly
more readable. As I'll pick up the other sun4v_cookie_only_virqs()
related patch I might as well take this one as well.

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas
