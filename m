From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 25 Jun 2019 22:45:41 +0000
Subject: Re: [PATCH 3/5] x86: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
Message-Id: <alpine.DEB.2.21.1906260032250.32342@nanos.tec.linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1561501810-25163-1-git-send-email-Hoan@os.amperecomputing.com>
 <1561501810-25163-4-git-send-email-Hoan@os.amperecomputing.com>
In-Reply-To: <1561501810-25163-4-git-send-email-Hoan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hoan Tran OS <hoan@os.amperecomputing.com>
Cc: Michal Hocko <mhocko@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Open Source Submission <patches@amperecomputing.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will.deacon@arm.com>, Borislav Petkov <bp@alien8.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Oscar Salvador <osalvador@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "David S . Miller" <davem@davemloft.net>

Hoan,

On Tue, 25 Jun 2019, Hoan Tran OS wrote:

Please use 'x86/Kconfig: ' as prefix.

> This patch removes CONFIG_NODES_SPAN_OTHER_NODES as it's
> enabled by default with NUMA.

Please do not use 'This patch' in changelogs. It's pointless because we
already know that this is a patch.

See also Documentation/process/submitting-patches.rst and search for 'This
patch'

Simply say:

  Remove CONFIG_NODES_SPAN_OTHER_NODES as it's enabled by default with
  NUMA.

But .....

> @@ -1567,15 +1567,6 @@ config X86_64_ACPI_NUMA
>  	---help---
>  	  Enable ACPI SRAT based node topology detection.
>  
> -# Some NUMA nodes have memory ranges that span
> -# other nodes.  Even though a pfn is valid and
> -# between a node's start and end pfns, it may not
> -# reside on that node.  See memmap_init_zone()
> -# for details.
> -config NODES_SPAN_OTHER_NODES
> -	def_bool y
> -	depends on X86_64_ACPI_NUMA

the changelog does not mention that this lifts the dependency on
X86_64_ACPI_NUMA and therefore enables that functionality for anything
which has NUMA enabled including 32bit.

The core mm change gives no helpful information either. You just copied the
above comment text from some random Kconfig.

This needs a bit more data in the changelogs and the cover letter:

     - Why is it useful to enable it unconditionally

     - Why is it safe to do so, even if the architecture had constraints on
       it

     - What's the potential impact

Thanks,

	tglx
