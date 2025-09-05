Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7438E2FD1D8;
	Fri,  5 Sep 2025 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757059467; cv=none; b=RbJu0a3dk3HtVZTQNLxJBCu3O0iOC2Hd3eJ1NF0lvmDcwUdvLya3SK/TNZYPkmsTZZxUVHMgNjG+/VTCIEE5183I/62Fttgeun0YeVWg7uYwdtjEJu07etHVC/aAY+77iKXwGcaLnTTFnaC10BZERomnLMfsA2q23zpKXsr4IyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757059467; c=relaxed/simple;
	bh=EjZA/lxVekrftyLm282p76tOjzm55CelzVQS4tiJ2Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0jdOHiHgcl/cUbBuWcS1k9mg1JFe0N8taSzCNt1NxJri91G6awJxsnKAFKOKlWM/1WIAgVFQgjcpWYQXRJ7k2kZ1ZYJeP8FvrQYyjwsYO5B56EKdEufzNvyH2JK2IuYclUxCLztbtzX8NDCSwqln618dLV6JjfoWEBUOOhs+Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=F2V+zx6I reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="F2V+zx6I"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cJ85015bYz1DDXC;
	Fri,  5 Sep 2025 10:04:20 +0200 (CEST)
Received: from [10.10.15.10] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cJ84z4RCTz1DDB7;
	Fri,  5 Sep 2025 10:04:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1757059459;
	bh=bfX4WwP6l4L7nuUkvsKK2kWfqcceycSxYP97lcTylMo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=F2V+zx6IxMZbR0mgxua/MDZVeAh9V1ANyfwP4c3s7CjFcQOik150ncyVgQLWZUoqj
	 VrEQ9ux9MEC/2o1y12d9VPjMtvxFEaS3p3XaN5C2wk2G3+tLgzK3i+NLB/79YToufA
	 9hlHGybISDsCDW1RjB+BDqI0ssjNCUjageS9ZBjemiBGpi9+WYdAOKzmHZUbl8mzzC
	 xwtcLi2dhMFdN7MS67xjutfKqIrxJ7eseLTBaynXDzxo3J9UD6cBqSlwG639zcN6wD
	 6iUKWcv8vGA1xwKntWw9xwJIZCZz7Da9E/F0ACHZi9BRW1fYJ0DRJM60x3qe+aV1hx
	 CqdGOrKXliEgQ==
Message-ID: <8deb9ed8-6c12-4fef-a78c-028de7928803@gaisler.com>
Date: Fri, 5 Sep 2025 10:04:19 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for Niagara
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Rene Rebe <rene@exactcode.com>, kernel@mkarcher.dialup.fu-berlin.de
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 anthony.yznaga@oracle.com
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
 <20250826160312.2070-4-kernel@mkarcher.dialup.fu-berlin.de>
 <20250902.184011.440504961051160142.rene@exactcode.com>
 <cf4e16f7846a3324521828e71c0676b9c524ebbf.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <cf4e16f7846a3324521828e71c0676b9c524ebbf.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-09-02 18:47, John Paul Adrian Glaubitz wrote:
> On Tue, 2025-09-02 at 18:40 +0200, Rene Rebe wrote:
>> From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
>>
>>> Fixes: 7ae3aaf53f16 ("sparc64: Convert NGcopy_{from,to}_user to accurate exception reporting.")
>>> Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
>>
>> Tested-by: René Rebe <rene@exactcode.com> # UltraSparc T4 SPARC T4-1 Server
> 
> Thanks for the testing! However, this actually needs to be tested on a SPARC T1
> as both T2 and T4 have their own implementation that is being used. Testing on a
> T4 will therefore not invoke this particular code unless you modify the kernel in
> head_64.S to employ the Niagara 1 code on Niagara 4.

Hi Rene,

Did you have the fourth patch, that is for Niagara 4, applied as well
when you did this testing? If so, we could add your Tested-by to that
patch instead.

Cheers,
Andreas

