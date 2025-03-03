Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F4A5661;
	Mon,  3 Mar 2025 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005212; cv=none; b=uvYAQlUtNdHjEz+h1xWNMkxjMjT6LskuiKBKjXkYQpFRIYgy7E/H2z19F+YiIXnYLuikxBVck1UTgsv3dibgfgd+DhTLTR92FtexbHn4QViMt+GQfdWF9ifAJxAABCXAGbqdG0xA2C6AYtyVLbi3p+m78x2dbHKlhQ84bobOT0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005212; c=relaxed/simple;
	bh=TFqvs3w3FSeuRo+f0d0WiU1fTK+fTyPEqzBF5damugE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMM7iE7m3slKrhe/V7pKCEaKIoqAubcA0n+HW8fMEzLB17x6AizVSJCJv+rv+2wCil22XDn2UAcb8cBWt4MofbDBheNFpgjV11GV0pZRH1ZmRqWE1gdw8RE64U829V64qw/CgyW84Do8PpOoZolJg9Z8xspbwkcVMat8bYpD23Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58026106F;
	Mon,  3 Mar 2025 04:33:44 -0800 (PST)
Received: from [10.1.26.155] (XHFQ2J9959.cambridge.arm.com [10.1.26.155])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4DD33F673;
	Mon,  3 Mar 2025 04:33:27 -0800 (PST)
Message-ID: <8b218b95-f0e3-424c-815f-5131e3e54031@arm.com>
Date: Mon, 3 Mar 2025 12:33:26 +0000
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] Revert "x86/xen: allow nesting of same lazy mode"
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Juergen Gross <jgross@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20250302145555.3236789-1-ryan.roberts@arm.com>
 <20250302145555.3236789-5-ryan.roberts@arm.com>
 <75031fe1-50d7-48d0-87bb-9c5c88f3b41c@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <75031fe1-50d7-48d0-87bb-9c5c88f3b41c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/03/2025 11:52, David Hildenbrand wrote:
> On 02.03.25 15:55, Ryan Roberts wrote:
>> Commit 49147beb0ccb ("x86/xen: allow nesting of same lazy mode") was
>> added as a solution for a core-mm code change where
>> arch_[enter|leave]_lazy_mmu_mode() started to be called in a nested
>> manner; see commit bcc6cc832573 ("mm: add default definition of
>> set_ptes()").
>>
>> However, now that we have fixed the API to avoid nesting, we no longer
>> need this capability in the x86 implementation.
>>
>> Additionally, from code review, I don't believe the fix was ever robust
>> in the case of preemption occurring while in the nested lazy mode. The
>> implementation usually deals with preemption by calling
>> arch_leave_lazy_mmu_mode() from xen_start_context_switch() for the
>> outgoing task if we are in the lazy mmu mode. Then in
>> xen_end_context_switch(), it restarts the lazy mode by calling
>> arch_enter_lazy_mmu_mode() for an incoming task that was in the lazy
>> mode when it was switched out. But arch_leave_lazy_mmu_mode() will only
>> unwind a single level of nesting. If we are in the double nest, then
>> it's not fully unwound and per-cpu variables are left in a bad state.
>>
>> So the correct solution is to remove the possibility of nesting from the
>> higher level (which has now been done) and remove this x86-specific
>> solution.
>>
>> Fixes: 49147beb0ccb ("x86/xen: allow nesting of same lazy mode")
> 
> Does this patch here deserve this tag? IIUC, it's rather a cleanup now that it
> was properly fixed elsewhere.

Now that nesting is not possible, yes it is just a cleanup. But when nesting was
possible, as far as I can tell it was buggy, as per my description. So it's a
bug bug that won't ever trigger once the other fixes are applied. Happy to
remove the Fixes and then not include it for stable for v2. That's probably
simplest.

> 
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

