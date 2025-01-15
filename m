Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3CB1D63DF
	for <sparclinux@vger.kernel.org>; Wed, 15 Jan 2025 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736957485; cv=none; b=rmXf7jA1nZW7ARANzKgAdnSILaplM/RbCgknfNKnoXZIDi6D9ACmbXv+ALMlBgFhBuAJYQkJwGXXSFpgaG+q+OaqSg6Z2LlyP20JpfhOcbtmbBcW1V7iLPeH6KaPvtfDUtCIzmA48slcziOAeQpkzwsHN2xyV83FWC+rmCJhOm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736957485; c=relaxed/simple;
	bh=PvA7OTMECEHWjOVyFMSYKm3vXqZf/4yVfZLnh6Mas0c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VVlwsJ2DKOyCgbvlJM7tqhCjsuRtcx+RacfZ8TlnaEAMQzdtwDhCP5I4VUHKg76rFhkcO1KT/Fhe94ls4CwXSe8roKoH22ki4rRRCcE5cHhSqCm4w8w/qrU5U+5krfKsSrFWje4Yal7yzE5qxclTCyHRkuEpO+35De688mAznI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c8qo6gAO; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c8qo6gAO"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736957478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+Z2mtbj7h+hR78gmDkOwHXa/8k3phQommNBk2WUCh0=;
	b=c8qo6gAOfFCnpVw0hGaCS7AMGWpHMhiRxlV48WReEBlOqcRXZy0Ws5ZAjWzaXcWKsywKPl
	B0RB6f1wjWJ1IWQubWebGIOqVwolCDlUloWTK/QY/3gd2ftygRY+nvq3fiNQT8j3os0ToV
	cEHUnWriI9wGsa851TEn7OITSgGT64A=
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] sparc/irq: Remove unneeded if check in
 sun4v_cookie_only_virqs()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <2b249bb11b3c08b21929b46f14bee808c9bbefe6.camel@physik.fu-berlin.de>
Date: Wed, 15 Jan 2025 17:11:05 +0100
Cc: "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Sam Ravnborg <sam@ravnborg.org>,
 Dawei Li <dawei.li@shingroup.cn>,
 sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <D58E47DF-ADED-4FD0-9710-62FBA284093E@linux.dev>
References: <20250114202502.912690-1-thorsten.blum@linux.dev>
 <2b249bb11b3c08b21929b46f14bee808c9bbefe6.camel@physik.fu-berlin.de>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
X-Migadu-Flow: FLOW_OUT

Hi Adrian,

On 14. Jan 2025, at 21:29, John Paul Adrian Glaubitz wrote:
> On Tue, 2025-01-14 at 21:25 +0100, Thorsten Blum wrote:
>> Remove the unnecessary if check and return the result directly.
>> 
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>> arch/sparc/kernel/irq_64.c | 4 +---
>> 1 file changed, 1 insertion(+), 3 deletions(-)
>> 
>> diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
>> index aff0d24f8c6f..81fb49b089a8 100644
>> --- a/arch/sparc/kernel/irq_64.c
>> +++ b/arch/sparc/kernel/irq_64.c
>> @@ -146,9 +146,7 @@ static int hv_irq_version;
>>  */
>> static bool sun4v_cookie_only_virqs(void)
>> {
>> - if (hv_irq_version >= 3)
>> - return true;
>> - return false;
>> + return hv_irq_version >= 3;
>> }
>> 
>> static void __init irq_init_hv(void)
> 
> I'm not sure whether this change is really necessary nor will it improve
> the readability of the code. I think the compiler will optimize the code
> the same way, for both variants.

It's not strictly necessary, but it's shorter, less verbose, and imo
improves the code's readability. Personally, I'd even consider the
current version a code smell, but feel free to ignore the patch.

Thanks,
Thorsten
