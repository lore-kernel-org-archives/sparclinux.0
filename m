From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 Oct 2010 04:04:43 +0000
Subject: Re: [PATCH 1/7] sparc: make drivers/of/pdt.c no longer sparc-only
Message-Id: <20101011040443.GA23588@angua.secretlab.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20101010014358.30cb74b5@debxo>
 <20101010020905.1e27c1b4@debxo>
In-Reply-To: <20101010020905.1e27c1b4@debxo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andres Salomon <dilinger@queued.net>
Cc: devicetree-discuss@lists.ozlabs.org, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Oct 10, 2010 at 02:09:05AM -0700, Andres Salomon wrote:
> Whoops, that should've been 1/5, not 1/7.  Two additional x86 patches
> snuck in there that are already in Grant's test-devicetree branch.

Note that of the two patches I'm carrying in test-devicetree, only one
of them is actually able to move into linux-next at this present time.

1) of/irq: remove references to NO_IRQ in drivers/of/platform.c

I'm putting this one into next-devicetree now

2) x86/of: define irq functions to allow drivers/of/* to build on x86

I've not yet received an ack from the x86 maintainers on this, so I
cannot put it into my next branch.  (Sorry I didn't notice this
earlier; it just dawned on me as I was looking over which patches I
needed to move over).  The same goes for the patch that actaully adds
OF support for x86 OLPC.  I'll need an ack from x86 folks before I
merge it.

g.


> 
> 
> On Sun, 10 Oct 2010 01:43:58
> -0700 Andres Salomon <dilinger@queued.net> wrote:
> 
> > 
> > Clean up pdt.c:
> >  - make build dependent upon config OF_PROMTREE
> >  - #ifdef out the sparc-specific stuff
> >  - create pdt-specific header
> > 
> > Signed-off-by: Andres Salomon <dilinger@queued.net>
