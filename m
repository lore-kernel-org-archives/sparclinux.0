Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B59D126BE6;
	Fri, 13 Sep 2024 18:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726250964; cv=none; b=pofDGi+D23y4PRtG3vRVkCoqJrMdqJFhkSPGeIt04ofo1QONx8C8lF0/n+4u/N/4B3EiILNH7aBUcF6LUrS5JJssa632OfuufggQ9fGzwlttPlLwn6YKVSgOtcJxduNJMMq/EbbJhATs/YhL54Z21AEqlJwi1Rc3A8/JISRgoRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726250964; c=relaxed/simple;
	bh=CYsnOF3mg7HRqKjs8+zohjNJM8L3/gkDXeAgSnJOS/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JHVRuZhqoSaC4pjo3Ow2BYo57hGCN2lskFBXU8bceFpEtjVz8MHScBFIU0apR7Xa2onhYTW9fYP9t8Ca6praBttu412Y0zXH2CQ5Z5s3QfY0Tm4fkinW02CSUwb0gX6AnUO2XJHruSnP3etWbUnYh9Zm5/tfBZLuTmhkSmZfsZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=gGMBvjRN; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="gGMBvjRN"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4X52C92QGHz1FXSC;
	Fri, 13 Sep 2024 20:00:05 +0200 (CEST)
Received: from [10.10.15.13] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4X52C90KsQz1DPl0;
	Fri, 13 Sep 2024 20:00:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1726250405;
	bh=SWvXRVsmJjaa9ejRemRSz9PHWcu0seHqqpEBo4CbFBs=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=gGMBvjRNvr61acm1rTtvWLXKfCX18UDdEju1gTxvBk7OYtXkmLWmhm/bMNAbheuyR
	 bKzb/VFlaZBuWaJgM/6m+8h02Qu603llsCKr/Xy54epP+F30LjbsFZDhE+LrfXTTiK
	 w+j9RdsLXmyqut7g2fNULu8dDjPfiQyy7e3KB1JM=
Message-ID: <59d604b6-8672-4c90-ab10-b3b74e79f9b1@gaisler.com>
Date: Fri, 13 Sep 2024 20:00:03 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch/sparc: remove unused varible paddrbase in function
 leon_swprobe()
To: alexs@kernel.org, "David S . Miller" <davem@davemloft.net>,
 Christian Brauner <brauner@kernel.org>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240729064926.3126528-1-alexs@kernel.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20240729064926.3126528-1-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-07-29 08:49, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> commit f22ed71cd602 ("sparc32,leon: SRMMU MMU Table probe fix") change
> return value from paddrbase to 'pte', but left the varible here.
> That causes a build warning for this varible, so we may remove it.
> 
> make --keep-going CROSS_COMPILE=/home/alexs/0day/gcc-14.1.0-nolibc/sparc-linux/bin/sparc-linux- --jobs=16 KCFLAGS= -Wtautological-compare -Wno-error=return-type -Wreturn-type -Wcast-function-type -funsigned-char -Wundef -fstrict-flex-arrays=3 -Wformat-overflow -Wformat-truncation -Wrestrict -Wenum-conversion W=1 O=sparc ARCH=sparc defconfig SHELL=/bin/bash arch/sparc/mm/ mm/ -s
> <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> ../arch/sparc/mm/leon_mm.c: In function 'leon_swprobe':
> ../arch/sparc/mm/leon_mm.c:42:32: warning: variable 'paddrbase' set but not used [-Wunused-but-set-variable]
>    42 |         unsigned int lvl, pte, paddrbase;
>       |                                ^~~~~~~~~
> 
> Signed-off-by: Alex Shi <alexs@kernel.org>
> To: linux-kernel@vger.kernel.org
> To: sparclinux@vger.kernel.org
> To: Christian Brauner <brauner@kernel.org>
> To: Andreas Larsson <andreas@gaisler.com>
> To: David S. Miller <davem@davemloft.net>
> ---
>  arch/sparc/mm/leon_mm.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Tested-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas
