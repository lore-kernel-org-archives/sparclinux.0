From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 21 May 2019 16:17:32 +0000
Subject: Re: [PATCH v2 2/2] vmalloc: Remove work as from vfree path
Message-Id: <CALCETrUdfBrTV3kMjdVHv2JDtEOGSkVvoV++96x4zjvue0GpZA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190520233841.17194-1-rick.p.edgecombe@intel.com> <20190520233841.17194-3-rick.p.edgecombe@intel.com>
In-Reply-To: <20190520233841.17194-3-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, sparclinux <sparclinux@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Network Development <netdev@vger.kernel.org>, Dave Hansen <dave.hansen@intel.com>, Nadav Amit <namit@vmware.com>, "David S. Miller" <davem@davemloft.net>, Rick Edgecombe <redgecombe.lkml@gmail.com>, Meelis Roos <mroos@linux.ee>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>

On Mon, May 20, 2019 at 4:39 PM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> From: Rick Edgecombe <redgecombe.lkml@gmail.com>
>
> Calling vm_unmap_alias() in vm_remove_mappings() could potentially be a
> lot of work to do on a free operation. Simply flushing the TLB instead of
> the whole vm_unmap_alias() operation makes the frees faster and pushes
> the heavy work to happen on allocation where it would be more expected.
> In addition to the extra work, vm_unmap_alias() takes some locks including
> a long hold of vmap_purge_lock, which will make all other
> VM_FLUSH_RESET_PERMS vfrees wait while the purge operation happens.
>
> Lastly, page_address() can involve locking and lookups on some
> configurations, so skip calling this by exiting out early when
> !CONFIG_ARCH_HAS_SET_DIRECT_MAP.

Hmm.  I would have expected that the major cost of vm_unmap_aliases()
would be the flush, and at least informing the code that the flush
happened seems valuable.  So would guess that this patch is actually a
loss in throughput.

--Andy
