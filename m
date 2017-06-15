From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 15 Jun 2017 17:57:30 +0000
Subject: Re: [v1 0/2] Early boot timestamp fixes
Message-Id: <89eab1ad-f886-94fa-1424-36e42bd8712d@ilande.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1497537659-419752-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1497537659-419752-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 15/06/17 16:43, Pasha Tatashin wrote:

> I have not used qemu for SPARC, so I am not fully aware of its
> capability. The changes in this work touched three types of CPUs:

The default CPU in QEMU for sun4u is the TI UltraSparc IIi, and the
device tree is roughly similar to that of an Ultra 5, or it least it
will be soon when I've finished working on my latest round of patches.

Currently I'm booting one of John Paul Adrian Glaubitz's Debian 9 images
and the timestamps stay at 0 until the clock is initialised so I'd hope
that these patches would fix that. Do they require any PROM support at all?

> 1. UltraSPARC IIe (Hummingbird)
>     - %stick is in I/O space, need at least to loads to get upper
>       and lower part of stick value.
> 2. Spitfire
>     - Use %tick and cpu frequency to determine that clock. This is
>      what you tested with TI UltraSparc IIi

So this is the path I'd expect to be exercised under QEMU.

> 3. All other
>     - use %stick register and stick-frequency values. This is what
>     you tested with Fujitsu Sparc64 IV (which by the way is still
>     sun4u, I do not think qemu supports sun4v emulation)

Sure it does. As of the latest 2.9 release, QEMU includes niagara
support out of the box - see http://wiki.qemu.org/SPARC for the latest
updates and
http://tyom.blogspot.co.uk/2016/10/qemu-sun4vniagara-target-went-public.html
for more sun4v detail.

Disclaimer: I'm one of the QEMU SPARC maintainers.


ATB,

Mark.

