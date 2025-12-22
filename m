Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A131E86341;
	Mon, 22 Dec 2025 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766425212; cv=none; b=lyC4FtHf+2Wp+zf1J+E4xKdB+4vU299Xncr9O8xD3FRnWn0Pi98P6ynYR+cdGjetOMscbW31xjLqtVdmKp09mng4puebI1VfiGw8ZJ6GuXDO64IQQrAYJ5NNTq9n5KMK7nVIx+bWBlOjhlL28Q2l7GRRvRBBqRZ3ftNTQzJmq8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766425212; c=relaxed/simple;
	bh=mOX8KrdE3DiwTosdubhShm3kZdki14+tYLnPGWEHzRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VTpgRHGPQf7eKV9QMzl4chc25PQSNQ9PrjlsI39itxwTiJxAGKdPc8ZPmQqyQrdDSgGdIg5SWISn2jyrnQtlrGSjqIUbBatXaFA/57W9TAECrN7FiKps5fa6sxT6svmA2qdDxg3adYNvCei60U8ZA7/t4qV+xgekFBQUjetPKVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Nh/yI5BS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nh/yI5BS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=7L2bczFi2HEVJD/Oo1abyjEAAHhDH83PsW7WLqE7GI8=; b=Nh/yI5BSxrSVxcg1JrrYE1bOK2
	xDtWbfX98OEqRulCJQRmcxYWvaAjyDP5TNuRMeczWXMbQ1xWlC6luZMyVVmBVFp5WR5CsGAQDn3If
	mxlU0lXC8STHgR5hIDaRHc+hzIG0JSCowsDMtbgPzmm0CamycztPWRD7+PghBkqna3yYjcJ8o7wvN
	tLwQEP9i4wfPF1fqcC7kUn8DSmlJ13Kmwa8+gNElRe6WrDfPTYrIBcZYQFkFQMgm6QfuuhdB+dfUU
	jVlDkiypFHO/Sz7MqMv8GCEB/gQF1nw/mbGXpbSrH31tETki1ldj6k/58Wub7Y98IyqNV5E2K6Div
	7M8kBOMg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXjt0-0000000E1o6-3787;
	Mon, 22 Dec 2025 17:39:58 +0000
Message-ID: <e0514679-32df-4559-8f88-591cea25a541@infradead.org>
Date: Mon, 22 Dec 2025 09:39:57 -0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc/vdso: add missing prototypes
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org
References: <20251209050332.881348-1-rdunlap@infradead.org>
 <20251222083340-159edb10-2209-40af-9d7d-8959ac485a07@linutronix.de>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251222083340-159edb10-2209-40af-9d7d-8959ac485a07@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/21/25 11:36 PM, Thomas Weißschuh wrote:
> Hi Randy,
> 
> On Mon, Dec 08, 2025 at 09:03:32PM -0800, Randy Dunlap wrote:
>> On sparc64, when CONFIG_WERROR=y, there are a few missing-prototype
>> build errors. Fix them.
>>
>> Add the 4 missing prototypes to <asm/vdso.h> and include that header
>> file in vclock_gettime.c.
>>
>> Fixes these build errors:
>> In file included from ../arch/sparc/vdso/vdso32/vclock_gettime.c:22:
>> ../arch/sparc/vdso/vdso32/../vclock_gettime.c:274:1: error: no previous
>>  prototype for '__vdso_clock_gettime' [-Werror=missing-prototypes]
>> ../arch/sparc/vdso/vdso32/../vclock_gettime.c:302:1: error: no previous
>>  prototype for '__vdso_clock_gettime_stick' [-Werror=missing-prototypes]
>> ../arch/sparc/vdso/vdso32/../vclock_gettime.c:327:1: error: no previous
>>  prototype for '__vdso_gettimeofday' [-Werror=missing-prototypes]
>> ../arch/sparc/vdso/vdso32/../vclock_gettime.c:363:1: error: no previous
>>  prototype for '__vdso_gettimeofday_stick' [-Werror=missing-prototypes]
> 
> This issue would also be fixed by my patch series adopting the generic
> vDSO library on SPARC [0].
> Picking up your patch would introduce conflicts.
> 
> [0] https://lore.kernel.org/lkml/20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de/

OK, thanks for the info.
Patch dropped.

-- 
~Randy

