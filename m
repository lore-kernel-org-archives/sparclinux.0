From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 08 Oct 2010 18:27:45 +0000
Subject: Re: [PATCH 1/2 v2] of: move phandle/ihandle into types.h and
Message-Id: <20101008182745.GI3863@angua.secretlab.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20101008171210.GE3863@angua.secretlab.ca>
 <20101008.101759.193728130.davem@davemloft.net>
 <20101008173650.GH3863@angua.secretlab.ca>
 <20101008.104557.59696706.davem@davemloft.net>
In-Reply-To: <20101008.104557.59696706.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: dilinger@queued.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, sam@ravnborg.org, devicetree-discuss@lists.ozlabs.org

On Fri, Oct 08, 2010 at 10:45:57AM -0700, David Miller wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> Date: Fri, 8 Oct 2010 11:36:50 -0600
> 
> > Weird.  Yeah, no other platforms expect to get a phandle type
> > definition from the kernel headers.  The only thing driving this
> > conversation is from arch/sparc/include/asm/Kbuild:
> > 
> > header-y += openprom.h
> 
> It was probably at one point for the sake of asm/openpromio.h but
> that header has no dependencies on openprom.h
> 
> The only hit I can find in google code search, for non-kernel code, is
> the SILO bootloader.
> 
> But that tree includes it's own copy of include/asm/openprom.h so
> the actual kernel copy isn't even used.
> 
> I'd say we can stop exporting that header and also therefore not
> worry about making phandle_t visible to userspace.

Yay!  That simplifies everything, and I believe it also means that the
phandle/ihandle definitions can remain where they currently are in
linux/of.h

Andres, can you post an updated series that includes removing
openprom.h from the header export list?

Thanks,
g.
