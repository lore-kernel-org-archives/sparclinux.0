From: Ben Collins <ben.collins@ubuntu.com>
Date: Sat, 19 May 2007 12:23:36 +0000
Subject: Re: How to load 2.6.22 kernel (image too large to fit ...)
Message-Id: <1179577416.6510.374.camel@cunning>
List-Id: <sparclinux.vger.kernel.org>
References: <464d3ea78cfe8@wp.pl>
In-Reply-To: <464d3ea78cfe8@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 2007-05-20 at 06:54 +0200, Krzysztof Helt wrote:
> Ben Collins wrote:
> > On Sat, 2007-05-19 at 23:44 +0200, Krzysztof Helt wrote:
> >> Hi again,
> >>
> >> I overcame the problem with too big kernel with the attached patch, but 
> >> I run into another problem. Now, the silo says:
> >>
> >> "Your kernel cannot fit into the memory destination. This
> >> can be resolved by recompiling the kernel with more devices
> >> built as modules, or upgrading your kernel to one that
> >> supports being loaded to higher memory areas (currently
> >> 2.6.3+ or 2.4.26+)."
> >>
> >> Does it mean, that 2.6.22-rc1 for sparc32 cannot be relocated?
> > 
> > The patch isn't complete. SILO checks to make sure that the kernel can
> > be relocated. You probably also need to patch up sparc kernel to allow
> > itself to be loaded at an alternate location. Whole lot of work.
> > 
> 
> The silo patch seems complete. It is now kernel hHdrS version, which 
> says it is not relocatable.
> If the kernel fits 2.5MB size, the patch does not hurts (just allocate 
> memory and copy kernel back to 2.5MB area).

Sure, SILO side is complete, but the kernel side is a little more
difficult. It's not just HdrS that needs fixing, the kernel needs to
actually support being loaded to arbitrary locations in memory.

I'd be happy for someone to do this work, though.

-- 
Ubuntu   : http://www.ubuntu.com/
Linux1394: http://wiki.linux1394.org/

