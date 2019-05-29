From: David Miller <davem@davemloft.net>
Date: Wed, 29 May 2019 00:23:27 +0000
Subject: Re: [PATCH v5 0/2] Fix issues with vmalloc flush flag
Message-Id: <20190528.172327.2113097810388476996.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190527211058.2729-1-rick.p.edgecombe@intel.com>
In-Reply-To: <20190527211058.2729-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rick.p.edgecombe@intel.com
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, luto@kernel.org, dave.hansen@intel.com, namit@vmware.com

From: Rick Edgecombe <rick.p.edgecombe@intel.com>
Date: Mon, 27 May 2019 14:10:56 -0700

> These two patches address issues with the recently added
> VM_FLUSH_RESET_PERMS vmalloc flag.
> 
> Patch 1 addresses an issue that could cause a crash after other
> architectures besides x86 rely on this path.
> 
> Patch 2 addresses an issue where in a rare case strange arguments
> could be provided to flush_tlb_kernel_range(). 

It just occurred to me another situation that would cause trouble on
sparc64, and that's if someone the address range of the main kernel
image ended up being passed to flush_tlb_kernel_range().

That would flush the locked kernel mapping and crash the kernel
instantly in a completely non-recoverable way.
