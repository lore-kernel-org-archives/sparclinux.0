Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30B026A0DB;
	Mon, 12 Jan 2026 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768211145; cv=none; b=s8JdMZNNXFbLYtm1GhXB0QegHXm1mt9IFvT/7Rls4hL+RtL7awgmyJEKbXE0/t68vbRQHVnm4CT4UDYKNbb0SAeo9y8oyg/j1bmk2gxF91EHW2adPMHWkFCjs3yNrZxBw229884hZvMMTX7aNNncfumq8q5EIyQAmPfyGdnUtiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768211145; c=relaxed/simple;
	bh=fdMLvjeapQ/bfLWsnXGxaJQDtJcQspJseu6jDbRyKHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFtO6sIxBMYkWx0zU8fOF7g9W/8bEHnmxHBNBnBCk0EtspMjfuIg6mZgscWU2tTN3KPO/ptU5lCFYp9NJwHyaMLI42XcbHXjgSs0IVh+Rf3b4+DZsm+or6gAOW9ospzJ0OCrQ7CkBzxWQEOR8Th4J3JjhJqIqyob8kACpeZb098=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A486339;
	Mon, 12 Jan 2026 01:45:37 -0800 (PST)
Received: from [10.57.48.185] (unknown [10.57.48.185])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5C6F3F694;
	Mon, 12 Jan 2026 01:45:36 -0800 (PST)
Message-ID: <f287a467-e707-459e-96b2-ae0bb0fdce37@arm.com>
Date: Mon, 12 Jan 2026 10:45:34 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/14] mm: Add basic tests for lazy_mmu
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
 Juergen Gross <jgross@suse.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Suren Baghdasaryan <surenb@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251215150323.2218608-1-kevin.brodsky@arm.com>
 <20251215150323.2218608-15-kevin.brodsky@arm.com>
 <1e123306-0efe-457f-953b-d4a27ce6bc60@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <1e123306-0efe-457f-953b-d4a27ce6bc60@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/01/2026 16:07, David Hildenbrand (Red Hat) wrote:
>
> Very nice test 🙂

Thanks!

>
> I think I prefer the EXPORT_SYMBOL_IF_KUNIT over disabling the test
> for PPC and over making lazy_mmu_mode_enable() non-inlined functions
> with an exported symbol

The EXPORT_SYMBOL_IF_KUNIT approach is what's currently in mm-unstable
(with the fixes from Ritesh and me).

- Kevin
