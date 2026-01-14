Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3217C35EDD6;
	Wed, 14 Jan 2026 07:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768375542; cv=none; b=VJP0fS2kKPt36DF5qKRx//AIy1hKYHQ+kVF0A0HaLmvSTUw0vs05E36PXlGsZ53+DSwjiY+T/p+n16+kZtzeaBAoy30ATGYDK8zy9t8JAsDkwDERt7fA/xujltHP2EbDSlupvVF0iqCx7/tRG0SpkTjkOwetL6KsMJsrtmDjvjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768375542; c=relaxed/simple;
	bh=EsNZ4+myFPEIbATHRFEfBhLXHEiwiHOa1NsWO8uWN3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaLo6lqQdqHOci+zHGJ4B/nGTchD8/6jrdzo8cPnLT04ekNkBJ8ZhIvEZndyT9QfLCj8stAXn3L5Kv8QUgV0zjwT8vT8/Q9HOO1nOJUuqqjAkxTdCjv9XMyrHiDX4jVDu0LycwI+33ul6wzS3vsyFql+2bLILySYprrZ/nRF6Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=c4SqqxTq reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="c4SqqxTq"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4drd1q6zYpz1DR2l;
	Wed, 14 Jan 2026 08:25:35 +0100 (CET)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4drd1q44hrz1DDhH;
	Wed, 14 Jan 2026 08:25:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1768375535;
	bh=+QBpOtA3H6xidkI1ONmiWsTt0NU6CuZMGASd99AdC9o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=c4SqqxTqRyZW6GiGzW3EQ1/DX4NuN/R50gplUIWWXpHha2xT5UeWo3RelFqYi4296
	 +ucx8iDatl9tLt3ksR8EobqWQdAYKQ22dazm00PAy64ss6jWX0t6JQvNkQ0YaWSIfX
	 CUzdxBfwXhXDWbnl2wMFhtmw56Z2DgjpMnB7b4bba7xub+MbaDtgC3bHF5msY+uAQn
	 jV6pIDD1CJbBRoK1fft1/qVF0dKmB4HmPuxq3D6qrc+n+Gs8DF7pEG/rYAOcfo2SKD
	 1XC+VMRJVzDLkXxQmWv0uazA5JOU7GSVhGV0H77PHt0pLkkuS5Y0iPxOzeHuhj6jno
	 5k1tmtch/dBag==
Message-ID: <8cddb02c-6bc0-4c1b-85c5-a00e3e75b63a@gaisler.com>
Date: Wed, 14 Jan 2026 08:25:35 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc/mm: export symbols for lazy_mmu_mode KUnit tests
To: Kevin Brodsky <kevin.brodsky@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 "David Hildenbrand (Red Hat)" <david@kernel.org>, sparclinux@vger.kernel.org
References: <20251216201403.4647a4f9861d3122ee9e90d7@linux-foundation.org>
 <20251218100541.2667405-1-kevin.brodsky@arm.com>
 <3ae6e07c-c99e-476e-b9d8-49b999e87197@arm.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <3ae6e07c-c99e-476e-b9d8-49b999e87197@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-01-12 11:09, Kevin Brodsky wrote:
> On 18/12/2025 11:05, Kevin Brodsky wrote:
>> Upcoming KUnit tests will call lazy_mmu_mode_{enable,disable}.
>> These tests may be built as a module, and because of inlining this
>> means that arch_{enter,flush,leave}_lazy_mmu_mode need to be
>> exported.
>>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> ---
>>
>> The CI reports that sparc needs pretty much the same time treatment as
>> powerpc... Here's another patch to take care of that.
>>
>> Andrew, could you please add it after the powerpc one? At this point it's
>> probably best to remove the comment above MODULE_IMPORT_NS() in
>> mm/tests/lazy_mmu_mode_kunit.c. Thank you and sorry for the noise!
> 
> Gentle ping - I think we need this patch in mm-unstable, the CI has been
> complaining as well. Thanks!

I get this problem as well, which is solved by this patch.

>> ---
>>  arch/sparc/mm/tlb.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
>> index 3a852071d260..6d9dd5eb1328 100644
>> --- a/arch/sparc/mm/tlb.c
>> +++ b/arch/sparc/mm/tlb.c
>> @@ -11,6 +11,8 @@
>>  #include <linux/preempt.h>
>>  #include <linux/pagemap.h>
>>  
>> +#include <kunit/visibility.h>
>> +
>>  #include <asm/tlbflush.h>
>>  #include <asm/cacheflush.h>
>>  #include <asm/mmu_context.h>
>> @@ -54,6 +56,8 @@ void arch_enter_lazy_mmu_mode(void)
>>  {
>>  	preempt_disable();
>>  }
>> +/* For lazy_mmu_mode KUnit tests */
>> +EXPORT_SYMBOL_IF_KUNIT(arch_enter_lazy_mmu_mode);
>>  
>>  void arch_flush_lazy_mmu_mode(void)
>>  {
>> @@ -62,12 +66,14 @@ void arch_flush_lazy_mmu_mode(void)
>>  	if (tb->tlb_nr)
>>  		flush_tlb_pending();
>>  }
>> +EXPORT_SYMBOL_IF_KUNIT(arch_flush_lazy_mmu_mode);
>>  
>>  void arch_leave_lazy_mmu_mode(void)
>>  {
>>  	arch_flush_lazy_mmu_mode();
>>  	preempt_enable();
>>  }
>> +EXPORT_SYMBOL_IF_KUNIT(arch_leave_lazy_mmu_mode);
>>  
>>  static void tlb_batch_add_one(struct mm_struct *mm, unsigned long vaddr,
>>  			      bool exec, unsigned int hugepage_shift)
>>
>> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
Regardless of if it becomes a patch of its own in the end, or is
folded into another:

Acked-by: Andreas Larsson <andreas@gaisler.com>

Cheers,
Andreas

