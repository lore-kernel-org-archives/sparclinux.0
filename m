From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 28 May 2019 08:01:49 +0000
Subject: Re: [PATCH v5 0/2] Fix issues with vmalloc flush flag
Message-Id: <20190528080149.GJ2623@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190527211058.2729-1-rick.p.edgecombe@intel.com>
In-Reply-To: <20190527211058.2729-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, luto@kernel.org, dave.hansen@intel.com, namit@vmware.com

On Mon, May 27, 2019 at 02:10:56PM -0700, Rick Edgecombe wrote:
> These two patches address issues with the recently added
> VM_FLUSH_RESET_PERMS vmalloc flag.
> 
> Patch 1 addresses an issue that could cause a crash after other
> architectures besides x86 rely on this path.
> 
> Patch 2 addresses an issue where in a rare case strange arguments
> could be provided to flush_tlb_kernel_range(). 

Thanks!
