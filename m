From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 06 Jul 2010 08:17:59 +0000
Subject: Re: [PATCH 2/4] sparc: break out some prom device-tree building code
Message-Id: <AANLkTinK40AAe-sZKAbkvELo737yfrSlX4HNLoWvHnqN@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100628215407.2017bf2f@debian> <20100628220037.5744c207@debian>
	<AANLkTilN3_ntG7AWKi-8LM9X_dZJPPlWM6xRM_V_00xU@mail.gmail.com>
	<20100629110324.2756cc02@debian> <AANLkTinPsrqxj5oQirEDRvVOuOeWgWSdljsMRbw8wn8V@mail.gmail.com>
	<20100629193618.5a840b8e@dev.queued.net> <AANLkTilme2uAoXjorUEzam9j_xosR8kl70W8PS71d-Th@mail.gmail.com>
	<20100707040734.05d625af@debxo>
In-Reply-To: <20100707040734.05d625af@debxo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andres Salomon <dilinger@queued.net>
Cc: devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, cjb@laptop.org, Mitch Bradley <wmb@laptop.org>, pgf@laptop.org, linux-kernel@vger.kernel.org, davem@davemloft.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Tue, Jul 6, 2010 at 10:07 PM, Andres Salomon <dilinger@queued.net> wrote:
> On Wed, 30 Jun 2010 15:52:51 -0600
> Grant Likely <grant.likely@secretlab.ca> wrote:
> =A0- For the pdt, calling into the prom twice for each property/node,
> =A0 getting the size of everything during the first tree traversal,
> =A0 allocating memory, and then creating the tree during the second
> =A0 traversal. This is slow and I don't see much point to it.
>
> =A0- For the pdt, calling into the prom once for each property/node to
> =A0 create a fdt, and then unflattening it. =A0This is better than the
> =A0 previous option, but I don't think the prom->fdt code will be very
> =A0 nice.

No, don't do this.  It will be ugly.

> =A0- Changing the fdt code to allocate memory more dynamically; rather
> =A0 than a first run through the fdt to determine the unflattened tree
> =A0 size, simply allocate memory chunks as we run through the tree.
> =A0 Memory might still be backed the same way (calling
> =A0 early_init_dt_alloc_memory_arch to grab a chunk of memory, and then
> =A0 allocating chunks of it via unflatten_dt_alloc), but the difference
> =A0 would be that it wouldn't necessarily be contiguous, and in how it's
> =A0 done. =A0For example, early_init_dt_alloc_memory_arch might be called
> =A0 initially to allocate a 16k chunk, and once unflatten_dt_alloc runs
> =A0 out of memory in that chunk, another 16k chunk might be allocated.
> =A0 This would also translate to sparc's prom_early_alloc being used to
> =A0 allocate the chunk, and then node/property structs being
> =A0 allocated from those chunks. =A0(The 16k choice
> =A0 is completely arbitrary; people more familiar w/ the early memory
> =A0 setup of ppc/sparc might have a better suggestion)

I'm fine with option 3, but it is more complicated and the code for
option 1 already exists.  In fact, option 1 is almost of a
pre-requisite for doing option 3.  It makes sense to get the
double-pass method factored out of powerpc and working before
attempting the performance enhancement of option 3.

Note however, the fdt data format parser expects a single contiguous
region.  You'll want to copy it into a single region before parsing
it.

That Being Said....

I just finished talking with Ben about the parser code.  There is no
immediate imperative to generalizing the powerpc OF->fdt->unflatten
code (unless David decides it makes sense for sparc too), and the
possibility of an ARM machine using it is theoretical enough that I'm
just not going to waste cycles thinking about it.  If the situation
changes in a couple of year or two, then it can be refactored.

That clears the way for your original pdt patch.  It will need to be
respun for Stephen's CONFIG_OF changes, and I have some other
comments, but I'll reply to the patches directly for those.

Cheers,
g.
