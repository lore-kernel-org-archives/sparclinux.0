Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023962C027C;
	Wed,  3 Dec 2025 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764750070; cv=none; b=RoU+HTPYRx8WBHWK5gTE4PGUqYkkFASjJR1/00KTP/0svcvPsqgMtjZtESmkrtU4yVE8TdH1FSbeO8uKMxupXccIFhNMg0c41uplHHASJvfYPDdd3o8Pmwxs4LoPKV0QhWa9FY90AKAJsa99pH3YzNe3iZXcwJBIV+SlKWj7JXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764750070; c=relaxed/simple;
	bh=e8MuL9dN4W4aZAtBVVyLVjE13/XsnSiE2gy07VCOnSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPfO5Ukyp4e297NQdL5epdmjnxIxpyYqKUe442wP1v9a4kUC7xDeZox9aFHZ4jocY92b2PriE84aBsi7AqLkQku5Bpwg9Wu1kR/kfNUSe6wKI7JGUcxjkr2x/M/u6dLI3aOD10OucLGTBJVoVl74OOkYrD67ZigTo6J0BxiEIYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDA3E1477;
	Wed,  3 Dec 2025 00:21:00 -0800 (PST)
Received: from [10.57.45.92] (unknown [10.57.45.92])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23FCA3F73B;
	Wed,  3 Dec 2025 00:20:59 -0800 (PST)
Message-ID: <703cbee6-a813-4970-9232-34ee91ed8961@arm.com>
Date: Wed, 3 Dec 2025 09:20:57 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] mm: enable lazy_mmu sections to nest
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Jann Horn <jannh@google.com>, Juergen Gross <jgross@suse.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
References: <20251124132228.622678-1-kevin.brodsky@arm.com>
 <20251124132228.622678-9-kevin.brodsky@arm.com>
 <23dcf752-0b75-45a7-84f8-25bddf97af08-agordeev@linux.ibm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <23dcf752-0b75-45a7-84f8-25bddf97af08-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/11/2025 14:55, Alexander Gordeev wrote:
>> + * in_lazy_mmu_mode() can be used to check whether the lazy MMU mode is
>> + * currently enabled.
> The in_lazy_mmu_mode() name looks ambiguous to me. When the lazy MMU mode
> is paused are we still in lazy MMU mode? The __task_lazy_mmu_mode_active()
> implementation suggests we are not, while one could still assume we are,
> just paused.
>
> Should in_lazy_mmu_mode() be named e.g. as in_active_lazy_mmu_mode() such
> a confusion would not occur in the first place.

I see your point, how about is_lazy_mmu_mode_active()?

- Kevin
