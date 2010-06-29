From: Andres Salomon <dilinger@queued.net>
Date: Tue, 29 Jun 2010 15:03:24 +0000
Subject: Re: [PATCH 2/4] sparc: break out some prom device-tree building
Message-Id: <20100629110324.2756cc02@debian>
List-Id: <sparclinux.vger.kernel.org>
References: <20100628215407.2017bf2f@debian>
	<20100628220037.5744c207@debian>
	<AANLkTilN3_ntG7AWKi-8LM9X_dZJPPlWM6xRM_V_00xU@mail.gmail.com>
In-Reply-To: <AANLkTilN3_ntG7AWKi-8LM9X_dZJPPlWM6xRM_V_00xU@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, cjb@laptop.org, Mitch Bradley <wmb@laptop.org>, pgf@laptop.org, linux-kernel@vger.kernel.org, davem@davemloft.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Tue, 29 Jun 2010 00:50:08 -0700
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Mon, Jun 28, 2010 at 7:00 PM, Andres Salomon <dilinger@queued.net> wrote:
> >
> > Stick code into drivers/of/pdt.c (Prom Device Tree) that other
> > architectures with OpenFirmware resident in memory can make use of.
> >
> > Signed-off-by: Andres Salomon <dilinger@queued.net>
> 
> Hi Andres,
> 
> The patch itself looks fine, but there are currently two methods for
> extracting the device tree from open firmware; one in arch/powerpc
> using the flattened format, and one in arch/sparc.  I don't want to
> end up maintaining both methods in drivers/of, and there has also some
> discussions on moving the powerpc version into common code.  I've been
> thinking about using the powerpc approach to support ARM platforms
> using both the flat tree and real OFW.
> 
> Ben, what say you?  Before I do anything I'd like to have your opinion.
> 

So you're saying that you want ARM (and sparc, and OLPC) to generate a
flat tree by calling into OFW?  Sparc and OLPC have very similar
mechanisms for getting device tree info from OFW, so it makes sense to
share code between them.


