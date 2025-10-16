Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2578727E066;
	Thu, 16 Oct 2025 07:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760599952; cv=none; b=pzRKBMT3SK+CqL4jbXPO+AzdCU3/ec5zYw8Eef0ya8CM9UCSzX+xLof4Nftf8z6qbIjy9I25p1egG3zuqNY8WltVu6KQ3EJpWNcQ4x6fAJpdDdZP8FX616pxTNlibPOm/BVZmQ1NXXlJjgRtC/Fno1xLHPnzXo1HFem34wapWzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760599952; c=relaxed/simple;
	bh=MEzUQpgjiFwNN3xQOvmqg23wAzgVCnaWuW1tomJiGNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Up3t+8+kEAGOuzrsj6ydi2XB83dn5fceZKQjQQGBTX8b7MDwoBaO/6Yz/KOwLdZeNpXcW/VDu8ch/G4ctyF+dDEzzoypsxmQLxFUs3zX3FvIxOn4t9I+tEhuA7S0CG2DXUUKvLKfHoD9ywfdfixexYl7TcHwaRCNh309cGUeOKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B64F21688;
	Thu, 16 Oct 2025 00:32:20 -0700 (PDT)
Received: from [10.57.65.134] (unknown [10.57.65.134])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F1683F6A8;
	Thu, 16 Oct 2025 00:32:20 -0700 (PDT)
Message-ID: <54f183bb-33ce-4b9c-91a9-827a6ed198d6@arm.com>
Date: Thu, 16 Oct 2025 09:32:13 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/13] x86/xen: simplify flush_lazy_mmu()
To: Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
 Juergen Gross <jgross@suse.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251015082727.2395128-1-kevin.brodsky@arm.com>
 <20251015082727.2395128-3-kevin.brodsky@arm.com>
 <35d9cf4f-135e-4786-a4e3-fd3a4a18b800@intel.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <35d9cf4f-135e-4786-a4e3-fd3a4a18b800@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/10/2025 18:52, Dave Hansen wrote:
> On 10/15/25 01:27, Kevin Brodsky wrote:
>> While at it, we can also avoid preempt_disable() if we are not
>> in lazy MMU mode - xen_get_lazy_mode() should tolerate preemption.
> ...
>>  static void xen_flush_lazy_mmu(void)
>>  {
>> -	preempt_disable();
>> -
>>  	if (xen_get_lazy_mode() == XEN_LAZY_MMU) {
>> -		arch_leave_lazy_mmu_mode();
>> -		arch_enter_lazy_mmu_mode();
>> +		preempt_disable();
>> +		xen_mc_flush();
>> +		preempt_enable();
>>  	}
> But xen_get_lazy_mode() does:
>
> 	this_cpu_read(xen_lazy_mode);
>
> Couldn't preemption end up doing the 'xen_lazy_mode' read and the
> xen_mc_flush() on different CPUs?
>
> That seems like a problem. Is there a reason it's safe?

You're right, I was thinking in terms of task, but xen_mc_flush() does
operate on the current CPU (and it's called when context-switching).
Will restore the original order in v4.

- Kevin

