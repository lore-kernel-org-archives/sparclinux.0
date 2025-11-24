Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747082AD0C;
	Mon, 24 Nov 2025 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763993895; cv=none; b=n4XxLhfFe6JomoTCBxN6ys/qrGLk18hQkVZyBIN0X+B6B1vrhMb3YdgyrQDdhigMWuF9iZBLasDYHwSZ5HeZ9ipp5dRy6+CKIL7fFetM3+Y/dHq0TF43OO50viEumrLdyyyIwwsbIUC+9DxKEyX1AnycGvbutFTS/vS6y19tNvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763993895; c=relaxed/simple;
	bh=a/6C0mF2h1YMNLw+DoImoO4DgoQDEX8r5mtUDpbvJqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+X65q6a23/WohtC6cUpmitYflvcVR+5AKAaz1zG5uVdiE3p7Em+u3u355t1MQDmaROqU/8HbvcOM+dqzQwifz7961F6ZocsMQqkqzTrjUSCJLKwcKDnBBO0Iyq6npmigKAgrDWqH0kvFTTBunA7sP/rE09Rk+Xue8jU2C2Sqcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwY/4Czd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwY/4Czd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C2BC4CEF1;
	Mon, 24 Nov 2025 14:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763993894;
	bh=a/6C0mF2h1YMNLw+DoImoO4DgoQDEX8r5mtUDpbvJqc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jwY/4CzdWYY3yql3el0w+panwPS8eTjG7NM5YCf3L3YhAsy5JwYjh7Es6LPXbY89K
	 UzT72wJIiWxPTXvC40ejjtyyoevI1urf2RHf3q2IQUAdx3ePP+T4aUCoLSuGBW+5t9
	 AyiGGmZu06pHbDaUwcXprsC2/AOzkRIQV4P+9nx22kKeJxYI/6ZX91Ahx+H6MJ6otw
	 r5N1JbHHbfGXrrxqIl8Vle4agRInm92WILAzWl7GR78JqldJ+4Ahy0TaoQXDl+8qyU
	 P/r56C1XkT4MDr3u/nrxsHIOTWIbg9bUxLNNU6+mmG6IXjp3Uu9lJEaRSB+6XeQQRZ
	 piKMF1RKiWZwg==
Message-ID: <53a032d0-a394-4040-ba9b-79610ec4b791@kernel.org>
Date: Mon, 24 Nov 2025 15:18:02 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] x86/xen: use lazy_mmu_state when
 context-switching
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
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
 <20251124132228.622678-13-kevin.brodsky@arm.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251124132228.622678-13-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/25 14:22, Kevin Brodsky wrote:
> We currently set a TIF flag when scheduling out a task that is in
> lazy MMU mode, in order to restore it when the task is scheduled
> again.
> 
> The generic lazy_mmu layer now tracks whether a task is in lazy MMU
> mode in task_struct::lazy_mmu_state. We can therefore check that
> state when switching to the new task, instead of using a separate
> TIF flag.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---

Nothing jumped at me, hoping for another pair of eyes from the XEN folks

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David
