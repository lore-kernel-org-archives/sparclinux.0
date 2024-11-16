Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F7219306F;
	Sat, 16 Nov 2024 08:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731745599; cv=none; b=nJII1K9E9l5nY+DK018RKuogXLdmuXtSIsL3N6Byd/DD0wioiLTXh4cqNUsC6BNd1B6BoWpvQ+1fqzZB/zOxGD4eTw6tAuBu1LJWtASWw8G1BtWQ8RHbDbsV8Kox9umXs6nMurqUevwYQHaJEKn2ebKhIKD4EYTomZRtr/FwzHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731745599; c=relaxed/simple;
	bh=OgH69nnHXhTLMLZ6FaS67kWb4+27ArjfgSN6GfqNt/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AM0ovWTM2HY+KA+3cnSCH6O5FlCVcU8ESooIFZBMZDOSTQeIrJwnObkaMu4YNCrnPVvuEZmYNduHWA0J0OxMIjVRgIQHlOklcs9Cbf+3kH5/dFi6aiEmkpe6ykkCvxCpXN97dVoSBJKybY73WLSZSTmlz3huWjmKYJMyL6D2Cik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=clAj8f6t; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="clAj8f6t"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Xr6Rq1VnLz1DHVl;
	Sat, 16 Nov 2024 09:26:31 +0100 (CET)
Received: from [10.10.15.6] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Xr6Rp5nq9z1DHnc;
	Sat, 16 Nov 2024 09:26:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1731745591;
	bh=qlTPlWsDxw1bU6MSU5l/l3K4o7iUpqUvtFAPMZ/EGS4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=clAj8f6tJiEjWxZRCaZGxjsCYpOKpSN75MHGxoOMzJUtLRBgsIBIbVM80YDToUYZ5
	 kYZLmCBrhDXlSvRsFw5cfMFxaLNl+aAsBRKKGeha0qd5AFiyiCjkpuw2H6ZMuWHapT
	 jetN2ShAnVcLhZpO0XA3ydca2NKY+RUVdtF2Ebdo=
Message-ID: <c2e1273d-00b0-4cf5-b315-46413153110b@gaisler.com>
Date: Sat, 16 Nov 2024 09:26:29 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sparc: Replace one-element array with flexible array
 member
To: Thorsten Blum <thorsten.blum@linux.dev>,
 "David S. Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>,
 Sam Ravnborg <sam@ravnborg.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-hardening@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241111204724.165263-2-thorsten.blum@linux.dev>
 <8EAE9B99-EB4F-4361-9C7C-4DBC4998F439@linux.dev>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <8EAE9B99-EB4F-4361-9C7C-4DBC4998F439@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-11-12 12:03, Thorsten Blum wrote:
> On 11. Nov 2024, at 21:47, Thorsten Blum wrote:
>> Replace the deprecated one-element array with a modern flexible array
>> member in the struct hvtramp_descr.
>>
>> Additionally, 15 unnecessary bytes were allocated for hdesc, but instead
>> of fixing the parentheses in the open-coded version, use struct_size()
>> to calculate the correct number of bytes.
>>
>> Link: https://github.com/KSPP/linux/issues/79
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
> 
> If this justifies a Fixes: tag, it should probably be:
> 
> Fixes: 64658743fdd4 ("[SPARC64]: Remove most limitations to kernel image size.")

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

