From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Wed, 08 Apr 2015 23:07:40 +0000
Subject: Re: [PATCH] of: return NUMA_NO_NODE from fallback of_node_to_nid()
Message-Id: <20150408230740.GB53918@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150408165920.25007.6869.stgit@buzz>
 <55255F84.6060608@yandex-team.ru>
In-Reply-To: <55255F84.6060608@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org

On 08.04.2015 [20:04:04 +0300], Konstantin Khlebnikov wrote:
> On 08.04.2015 19:59, Konstantin Khlebnikov wrote:
> >Node 0 might be offline as well as any other numa node,
> >in this case kernel cannot handle memory allocation and crashes.

Isn't the bug that numa_node_id() returned an offline node? That
shouldn't happen.

#ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
...
#ifndef numa_node_id
/* Returns the number of the current Node. */
static inline int numa_node_id(void)
{
        return raw_cpu_read(numa_node);
}
#endif
...
#else   /* !CONFIG_USE_PERCPU_NUMA_NODE_ID */

/* Returns the number of the current Node. */
#ifndef numa_node_id
static inline int numa_node_id(void)
{
        return cpu_to_node(raw_smp_processor_id());
}
#endif
...

So that's either the per-cpu numa_node value, right? Or the result of
cpu_to_node on the current processor.

> Example:
> 
> [    0.027133] ------------[ cut here ]------------
> [    0.027938] kernel BUG at include/linux/gfp.h:322!

This is 

VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES || !node_online(nid));

in

alloc_pages_exact_node().

And based on the trace below, that's

__slab_alloc -> alloc

alloc_pages_exact_node
	<- alloc_slab_page
		<- allocate_slab
			<- new_slab
				<- new_slab_objects
					< __slab_alloc?

which is just passing the node value down, right? Which I think was
from:

        domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
                              GFP_KERNEL, of_node_to_nid(of_node));

?


What platform is this on, looks to be x86? qemu emulation of a
pathological topology? What was the topology?

Note that there is a ton of code that seems to assume node 0 is online.
I started working on removing this assumption myself and it just led
down a rathole (on power, we always have node 0 online, even if it is
memoryless and cpuless, as a result).

I am guessing this is just happening early in boot before the per-cpu
areas are setup? That's why (I think) x86 has the early_cpu_to_node()
function...

Or do you not have CONFIG_OF set? So isn't the only change necessary to
the include file, and it should just return first_online_node rather
than 0?

Ah and there's more of those node 0 assumptions :)

#define first_online_node       0
#define first_memory_node       0

if MAX_NUMODES = 1...

-Nish

