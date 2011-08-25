From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 25 Aug 2011 09:58:22 +0000
Subject: Re: bug report: Sun Blade 100 kernel panics during boot under 3.0.3
Message-Id: <20110825095822.GA29290@entuzijast.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
In-Reply-To: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Aug 24, 2011 at 03:50:53PM -0400, Jim Faulkner wrote:
> On Mon, Aug 22, 2011 at 05:36:02PM -0700, David Miller wrote:
> 
> > Unfortunately we need the very first crash message that happens, but
> > even your first snapshot is after other crashes have occurred.
> > 
> > You'll need to build a kernel with CONFIG_BOOT_PRINTK_DELAYED enabled
> > and then you can boot with boot_delay=xxx (where "xxx" is something
> > like 100, it's in milliseconds) to slow down the message printing so
> > that you can capture the first message cleanly.
> 
> OK, I've attached several images of the kernel panic w/ boot_delay to
> the bug:
> 
> https://bugzilla.kernel.org/show_bug.cgi?idA522

https://bugzilla.kernel.org/attachment.cgi?idp042 (the third image) looks
like it first finds two address space collisions with ali7101... but they're
both listed at 0000:00:03.0 (i.e. not a collision of two different PCI
devices but one and the same), and that quirk code in drivers/pci/quirks.c
is ancient (2005, 2007).

The next problem is a WARN about 0000:00:07.0 being added twice, but latest
change in that sabre_* function seems to be a generic OF matching code
change, so that's not immediately suspicious either.

It looks as if something is generally screwing with the PCI detection logic
from the get-go.

Do you happen to have a working kernel to fall back to, and then do a
git bisect?

-- 
     2. That which causes joy or happiness.
