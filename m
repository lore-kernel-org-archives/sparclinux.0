Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48FB2D3744;
	Thu, 21 Aug 2025 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780730; cv=none; b=HJYLiEavDMaxFY1fucc772urkyueOdWBYxZEOuLOqay/n57jiSV3pwlatRQ7ovGBV5b8j4JddDuTzqQCEOSoKs3nzAwg0zZ79pXlUinAdUHd3zs92BESHNof1h/M5RkwxZRrIvidwTJ0bf6R13MC+Bt6hDC3FSXOJ+W7YJAcb00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780730; c=relaxed/simple;
	bh=TLg/ZZiMzKJ/DgKTo8a95pDLDufqtbfH+VNy9cAFRfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ga5zsLBBh5k7x3zvOytPGBkTNQJE0fXxAKRBwNGBtse0Mxfvw+kPqrohxRYbRHKM7I09SkzNGF/FMxHJCXppPh/T3GjXumT0j1eqTL8KlvrcJ8wjlypojYV3QP3haRQw8TrPvTpL6xFQUxetnCWWAs/QfrtUYR5mzJbzTZ5MDG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1BBC4CEEB;
	Thu, 21 Aug 2025 12:52:07 +0000 (UTC)
Message-ID: <cd3c4a6a-abc5-4f4f-b829-72f86cfb5bde@redhat.com>
Date: Thu, 21 Aug 2025 14:52:06 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Found it - was: Re: [PATCH] sparc64: fix hugetlb for sun4u
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Anthony Yznaga <anthony.yznaga@oracle.com>, sparclinux@vger.kernel.org,
 davem@davemloft.net, andreas@gaisler.com
Cc: linux-kernel@vger.kernel.org, agordeev@linux.ibm.com, will@kernel.org,
 ryan.roberts@arm.com, osalvador@suse.de, Meelis Roos <mroos@linux.ee>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20250716012446.10357-1-anthony.yznaga@oracle.com>
 <35f5ec4eda8a7dbeeb7df9ec0be5c0b062c509f7.camel@physik.fu-berlin.de>
 <7e1e9aa5-0529-4fb5-84fb-557b5cc1cd50@oracle.com>
 <38f4469f48e6d36fa92b445c8ecef7a440be43e6.camel@physik.fu-berlin.de>
 <b14f55642207e63e907965e209f6323a0df6dcee.camel@physik.fu-berlin.de>
 <fc1555550f7a9b3c9aa5fb651769cf41ed859c77.camel@physik.fu-berlin.de>
 <ff3d87634aedec28e7103f16a35031bfe86ca501.camel@physik.fu-berlin.de>
 <b5b75976c94b7b46f86a5af4675a1a570aaf20cc.camel@physik.fu-berlin.de>
 <2bcb018c8b237f7ab2356f4459e14ae81a6fec8b.camel@physik.fu-berlin.de>
 <2daaa0648e9bcca42bf7a76d90580725f44fb4bc.camel@physik.fu-berlin.de>
 <c50091bdbb0556ee74ec501381f1efc14a4e5929.camel@physik.fu-berlin.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <c50091bdbb0556ee74ec501381f1efc14a4e5929.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> @Anthony: Can you see any suspicious in the disassembled code that Meelis (CC'ed) posted?
> 
> OK, bisecting has lead me to the following commit:

CCing Rick.

Hm, but that's bpf-only code. Are you sure that it's this exact commit 
or rather ....

> 
> d53d2f78ceadba081fc7785570798c3c8d50a718 is the first bad commit
> commit d53d2f78ceadba081fc7785570798c3c8d50a718 (HEAD)
> Author: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Date:   Thu Apr 25 17:11:38 2019 -0700
> 
>      bpf: Use vmalloc special flag
>      
>      Use new flag VM_FLUSH_RESET_PERMS for handling freeing of special
>      permissioned memory in vmalloc and remove places where memory was set RW
>      before freeing which is no longer needed. Don't track if the memory is RO
>      anymore because it is now tracked in vmalloc.
>      
>      Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>      Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>      Cc: <akpm@linux-foundation.org>
>      Cc: <ard.biesheuvel@linaro.org>
>      Cc: <deneen.t.dock@intel.com>
>      Cc: <kernel-hardening@lists.openwall.com>
>      Cc: <kristen@linux.intel.com>
>      Cc: <linux_dti@icloud.com>
>      Cc: <will.deacon@arm.com>
>      Cc: Alexei Starovoitov <ast@kernel.org>
>      Cc: Andy Lutomirski <luto@kernel.org>
>      Cc: Borislav Petkov <bp@alien8.de>
>      Cc: Daniel Borkmann <daniel@iogearbox.net>
>      Cc: Dave Hansen <dave.hansen@linux.intel.com>
>      Cc: H. Peter Anvin <hpa@zytor.com>
>      Cc: Linus Torvalds <torvalds@linux-foundation.org>
>      Cc: Nadav Amit <nadav.amit@gmail.com>
>      Cc: Rik van Riel <riel@surriel.com>
>      Cc: Thomas Gleixner <tglx@linutronix.de>
>      Link: https://lkml.kernel.org/r/20190426001143.4983-19-namit@vmware.com
>      Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
>   include/linux/filter.h | 17 +++--------------
>   kernel/bpf/core.c      |  1 -
>   2 files changed, 3 insertions(+), 15 deletions(-)
> 
> I assume it's also related to this change:

... this one?

> 
> commit 868b104d7379e28013e9d48bdd2db25e0bdcf751
> Author: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Date:   Thu Apr 25 17:11:36 2019 -0700
> 
>      mm/vmalloc: Add flag for freeing of special permsissions
>      
>      Add a new flag VM_FLUSH_RESET_PERMS, for enabling vfree operations to
>      immediately clear executable TLB entries before freeing pages, and handle
>      resetting permissions on the directmap. This flag is useful for any kind
>      of memory with elevated permissions, or where there can be related
>      permissions changes on the directmap. Today this is RO+X and RO memory.
>      
>      Although this enables directly vfreeing non-writeable memory now,
>      non-writable memory cannot be freed in an interrupt because the allocation
>      itself is used as a node on deferred free list. So when RO memory needs to
>      be freed in an interrupt the code doing the vfree needs to have its own
>      work queue, as was the case before the deferred vfree list was added to
>      vmalloc.
>      
>      For architectures with set_direct_map_ implementations this whole operation
>      can be done with one TLB flush when centralized like this. For others with
>      directmap permissions, currently only arm64, a backup method using
>      set_memory functions is used to reset the directmap. When arm64 adds
>      set_direct_map_ functions, this backup can be removed.
>      
>      When the TLB is flushed to both remove TLB entries for the vmalloc range
>      mapping and the direct map permissions, the lazy purge operation could be
>      done to try to save a TLB flush later. However today vm_unmap_aliases
>      could flush a TLB range that does not include the directmap. So a helper
>      is added with extra parameters that can allow both the vmalloc address and
>      the direct mapping to be flushed during this operation. The behavior of the
>      normal vm_unmap_aliases function is unchanged.
>      
>      Suggested-by: Dave Hansen <dave.hansen@intel.com>
>      Suggested-by: Andy Lutomirski <luto@kernel.org>
>      Suggested-by: Will Deacon <will.deacon@arm.com>
>      Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>      Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>      Cc: <akpm@linux-foundation.org>
>      Cc: <ard.biesheuvel@linaro.org>
>      Cc: <deneen.t.dock@intel.com>
>      Cc: <kernel-hardening@lists.openwall.com>
>      Cc: <kristen@linux.intel.com>
>      Cc: <linux_dti@icloud.com>
>      Cc: Borislav Petkov <bp@alien8.de>
>      Cc: H. Peter Anvin <hpa@zytor.com>
>      Cc: Linus Torvalds <torvalds@linux-foundation.org>
>      Cc: Nadav Amit <nadav.amit@gmail.com>
>      Cc: Rik van Riel <riel@surriel.com>
>      Cc: Thomas Gleixner <tglx@linutronix.de>
>      Link: https://lkml.kernel.org/r/20190426001143.4983-17-namit@vmware.com
>      Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
> Adrian
> 


-- 
Cheers

David / dhildenb
