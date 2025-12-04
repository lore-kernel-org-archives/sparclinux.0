Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512432DAFA8;
	Thu,  4 Dec 2025 11:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764849211; cv=none; b=UCIJCJvWKwL6o90GmoqjF3sbld6V1Y0Dqetp18bIVCvx085NEZi0HTukSjbd1py1Mk8xrGqKGpe2GaX6AJJRph4EUPq0zpFRhD/DhxDawsk4w8ztuarNOcqkIOGW/4Wu9qVlUrjbh9GSZAYwdlSyKtIbl9IV6ZWBIgFzzENSoec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764849211; c=relaxed/simple;
	bh=Zpl414Y6vefFz+0mGA9CipSOvbTehPYA0WM0ZAZ5yEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGVBPKzO4Y++Ef1QplfmuuN5+Y+UCt4bGqyma/88MW0wkcmWnuftuqQRTJHO56TzBH4gNKN2lvrZ3iio4LIwBMT+s6vF6EoqOaN2RzbgCHmInDrmH0Kg4TJTvz8x3KDDs7tB1COkgp2PIpSrVAixOoNWCxepVTZhtwLqu6SLSCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8F43iGu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8F43iGu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8423DC4CEFB;
	Thu,  4 Dec 2025 11:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764849210;
	bh=Zpl414Y6vefFz+0mGA9CipSOvbTehPYA0WM0ZAZ5yEc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l8F43iGu2V8NDUl3DIh/2+X2bfiJU3z4ZM3VULx8KpRVQtoH+xW7CH2tkww5ZTCxo
	 Z732odFWqfzHNQy5SzNM5XixZWclVhNfUhvGgJiGbPutM3AwRHmsLfNCAboCSPDTP/
	 mQ1qAy91zph5RvCXiIten7mneAop/GvZWqVrT+sRJH1n488UuXQMywvv0E8xZPYpO8
	 hem4mPeZ8WDhirZ3INCR8Hs8TJNiMUf1+2/EkXzuyFkWiHk2/yA/ki9bTau+qinvtl
	 uLvGed0JMtDUZ3H/ydu3YrDfOdvy/uR+aG5ySHHt6+QmCrIk7eopnc2uqCD/LCtR4b
	 NGvDZU/gQZlqA==
Message-ID: <0f08e893-6097-4ab1-8231-ac3304c51ee9@kernel.org>
Date: Thu, 4 Dec 2025 12:53:18 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] mm: enable lazy_mmu sections to nest
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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
References: <20251124132228.622678-1-kevin.brodsky@arm.com>
 <20251124132228.622678-9-kevin.brodsky@arm.com>
 <23dcf752-0b75-45a7-84f8-25bddf97af08-agordeev@linux.ibm.com>
 <703cbee6-a813-4970-9232-34ee91ed8961@arm.com>
 <2c2b3382-7bdb-41a9-b48e-4fa9a44312ba@arm.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <2c2b3382-7bdb-41a9-b48e-4fa9a44312ba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/25 06:25, Anshuman Khandual wrote:
> 
> 
> On 03/12/25 1:50 PM, Kevin Brodsky wrote:
>> On 28/11/2025 14:55, Alexander Gordeev wrote:
>>>> + * in_lazy_mmu_mode() can be used to check whether the lazy MMU mode is
>>>> + * currently enabled.
>>> The in_lazy_mmu_mode() name looks ambiguous to me. When the lazy MMU mode
>>> is paused are we still in lazy MMU mode? The __task_lazy_mmu_mode_active()
>>> implementation suggests we are not, while one could still assume we are,
>>> just paused.
>>>
>>> Should in_lazy_mmu_mode() be named e.g. as in_active_lazy_mmu_mode() such
>>> a confusion would not occur in the first place.
>>
>> I see your point, how about is_lazy_mmu_mode_active()?
> 
> Agreed - is_lazy_mmu_mode_active() seems better.

+1, I was scratching my head over this in previous revisions as well.

-- 
Cheers

David
