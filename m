From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 21 May 2019 17:00:34 +0000
Subject: Re: [PATCH v2 2/2] vmalloc: Remove work as from vfree path
Message-Id: <CALCETrXfnkLKv-jJzquj+547QWiwEBSxKtM3du3UqK80FNSSGg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190520233841.17194-1-rick.p.edgecombe@intel.com>
 <20190520233841.17194-3-rick.p.edgecombe@intel.com> <CALCETrUdfBrTV3kMjdVHv2JDtEOGSkVvoV++96x4zjvue0GpZA@mail.gmail.com>
 <4e353614f017c7c13a21d168992852dae1762aba.camel@intel.com>
In-Reply-To: <4e353614f017c7c13a21d168992852dae1762aba.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "luto@kernel.org" <luto@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mroos@linux.ee" <mroos@linux.ee>, "redgecombe.lkml@gmail.com" <redgecombe.lkml@gmail.com>, "mingo@redhat.com" <mingo@redhat.com>, "namit@vmware.com" <namit@vmware.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Hansen, Dave" <dave.hansen@intel.com>, "bp@alien8.de" <bp@alien8.de>, "davem@davemloft.net" <davem@davemloft.net>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>

On Tue, May 21, 2019 at 9:51 AM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Tue, 2019-05-21 at 09:17 -0700, Andy Lutomirski wrote:
> > On Mon, May 20, 2019 at 4:39 PM Rick Edgecombe
> > <rick.p.edgecombe@intel.com> wrote:
> > > From: Rick Edgecombe <redgecombe.lkml@gmail.com>
> > >
> > > Calling vm_unmap_alias() in vm_remove_mappings() could potentially
> > > be a
> > > lot of work to do on a free operation. Simply flushing the TLB
> > > instead of
> > > the whole vm_unmap_alias() operation makes the frees faster and
> > > pushes
> > > the heavy work to happen on allocation where it would be more
> > > expected.
> > > In addition to the extra work, vm_unmap_alias() takes some locks
> > > including
> > > a long hold of vmap_purge_lock, which will make all other
> > > VM_FLUSH_RESET_PERMS vfrees wait while the purge operation happens.
> > >
> > > Lastly, page_address() can involve locking and lookups on some
> > > configurations, so skip calling this by exiting out early when
> > > !CONFIG_ARCH_HAS_SET_DIRECT_MAP.
> >
> > Hmm.  I would have expected that the major cost of vm_unmap_aliases()
> > would be the flush, and at least informing the code that the flush
> > happened seems valuable.  So would guess that this patch is actually
> > a
> > loss in throughput.
> >
> You are probably right about the flush taking the longest. The original
> idea of using it was exactly to improve throughput by saving a flush.
> However with vm_unmap_aliases() the flush will be over a larger range
> than before for most arch's since it will likley span from the module
> space to vmalloc. From poking around the sparc tlb flush history, I
> guess the lazy purges used to be (still are?) a problem for them
> because it would try to flush each page individually for some CPUs. Not
> sure about all of the other architectures, but for any implementation
> like that, using vm_unmap_alias() would turn an occasional long
> operation into a more frequent one.
>
> On x86, it shouldn't be a problem to use it. We already used to call
> this function several times around a exec permission vfree.
>
> I guess its a tradeoff that depends on how fast large range TLB flushes
> usually are compared to small ones. I am ok dropping it, if it doesn't
> seem worth it.

On x86, a full flush is probably not much slower than just flushing a
page or two -- the main cost is in the TLB refill.  I don't know about
other architectures.  I would drop this patch unless you have numbers
suggesting that it's a win.
