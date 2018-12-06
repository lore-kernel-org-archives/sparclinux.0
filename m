From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 06 Dec 2018 18:08:26 +0000
Subject: Re: [PATCH v2 5/6] arch: simplify several early memory allocations
Message-Id: <20181206180826.GB19166@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-6-git-send-email-rppt@linux.ibm.com>
 <20181203162908.GB4244@ravnborg.org>
 <20181203164920.GB26700@rapoport-lnx>
In-Reply-To: <20181203164920.GB26700@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Michal Hocko <mhocko@suse.com>, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org, Rich Felker <dalias@libc.org>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>, Jonas Bonn <jonas@southpole.se>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, Russell King <linux@armlinux.org.uk>, Mark Salter <msalter@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>, Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Mon, Dec 03, 2018 at 06:49:21PM +0200, Mike Rapoport wrote:
> On Mon, Dec 03, 2018 at 05:29:08PM +0100, Sam Ravnborg wrote:
> > Hi Mike.
> > 
> > > index c37955d..2a17665 100644
> > > --- a/arch/sparc/kernel/prom_64.c
> > > +++ b/arch/sparc/kernel/prom_64.c
> > > @@ -34,16 +34,13 @@
> > >  
> > >  void * __init prom_early_alloc(unsigned long size)
> > >  {
> > > -	unsigned long paddr = memblock_phys_alloc(size, SMP_CACHE_BYTES);
> > > -	void *ret;
> > > +	void *ret = memblock_alloc(size, SMP_CACHE_BYTES);
> > >  
> > > -	if (!paddr) {
> > > +	if (!ret) {
> > >  		prom_printf("prom_early_alloc(%lu) failed\n", size);
> > >  		prom_halt();
> > >  	}
> > >  
> > > -	ret = __va(paddr);
> > > -	memset(ret, 0, size);
> > >  	prom_early_allocated += size;
> > >  
> > >  	return ret;
> > 
> > memblock_alloc() calls memblock_alloc_try_nid().
> > And if allocation fails then memblock_alloc_try_nid() calls panic().
> > So will we ever hit the prom_halt() code?
> 
> memblock_phys_alloc_try_nid() also calls panic if an allocation fails. So
> in either case we never reach prom_halt() code.

So we have code here we never reach - not nice.
If the idea is to avoid relying on the panic inside memblock_alloc() then
maybe replace it with a variant that do not call panic?
To make it clear what happens.

	Sam
