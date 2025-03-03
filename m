Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA9421018F;
	Mon,  3 Mar 2025 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741006673; cv=none; b=bgupt6FKDDwKGBx65iwR6fVPS9jX3im7D3TZ2s0/2lOpdZdXafsL2hDM52NJh8ZNnYTYYO1Z0yWTa7XsQ8ufOKnusfyrP3e6iHhC0XGM3O6KXVnSNlDAcRbHbYNl1FepDclD1xIRnty2ubXx/f4JWOk4ONtjQ2CrJolSo6heGv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741006673; c=relaxed/simple;
	bh=JbI6XhJ61siUdVWSy8Ns1WhjpjszqzNkeDrfZmtl4e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2+QXaluNFS+Gkf6DHUNIP3Xts8j29XLIx8D1bK2WC4Z4I/lAvkj6w70LKF0ad0JDh+AgAuQVVPaGygWViSaQcpPtA87+LiBbOgW7cjROpJByLjFPdqT2lUvpgqr5oc7cQ4N4+JIXpR+eJ/XdOjgrD9EgYYLZvmJyToVWHvV1rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=nP9dd9JW; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="nP9dd9JW"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Z5zCn0L6Nz1FbbL;
	Mon,  3 Mar 2025 13:49:25 +0100 (CET)
Received: from [10.10.15.10] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Z5zCm2wxFz1FbZs;
	Mon,  3 Mar 2025 13:49:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1741006164;
	bh=uVrbTI227oB4DG3Xp0tOkuWBdxLi0PVMRa8nC6AqCqk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nP9dd9JW/wd7xfGVmIclsUAW7Lk6Vl6kAIG/wni38v7deAa6waS1Ayjqwmql3o84n
	 DZdS63CtpqFoNU3dj2tHF2SuUw3KIn/WTjJVIXHYffz8D4NJUG2Hd1Uk8YLjjoYulN
	 RX9/cvuf0Gb2o/aPBXh4plpcFNu8CtVnLb9vpzg4=
Message-ID: <8367749d-8dd7-40f5-881e-8f45e432a91d@gaisler.com>
Date: Mon, 3 Mar 2025 13:49:23 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] mm: Fix lazy mmu docs and usage
To: David Hildenbrand <david@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Juergen Gross <jgross@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20250302145555.3236789-1-ryan.roberts@arm.com>
 <20250302145555.3236789-2-ryan.roberts@arm.com>
 <5418a661-dbd0-46e9-8ef7-b1c5a34acce3@redhat.com>
 <a9e21c14-d390-4119-ad93-b23e6ccbac15@redhat.com>
 <1ff509c7-187b-4e43-b266-db8ada33b9a2@arm.com>
 <34388e5d-f9d1-4d29-a0e0-202a9fad345f@redhat.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <34388e5d-f9d1-4d29-a0e0-202a9fad345f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-03-03 11:30, David Hildenbrand wrote:
> On 03.03.25 11:22, Ryan Roberts wrote:[snip]
>>
>> I didn't actually cc stable on these, I'm wondering if I should do that? Perhaps
>> for all patches except the pagemap change?
> 
> That would make sense to me. CC stable likely doesn't hurt here. (although I wonder if anybody cares about stable on sparc :))

Yes, stable is important for sparc just as well as for other architectures.

Cheers,
Andreas
