From: David Dillow <dave@thedillows.org>
Date: Sat, 10 Jul 2004 00:42:19 +0000
Subject: Re: [RFC PATCH] Allow larger than 1MB mappings on sparc64 sbus
Message-Id: <1089420138.3096.71.camel@ori.thedillows.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1089341045.3100.38.camel@ori.thedillows.org>
In-Reply-To: <1089341045.3100.38.camel@ori.thedillows.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 2004-07-09 at 19:57, David S. Miller wrote:
> On 08 Jul 2004 22:44:05 -0400
> David Dillow <dave@thedillows.org> wrote:
> 
> > Unfortunately, we only support streaming mappings of up to 1MB in size,
> > while printing on letter paper requires up to 1.75MB, and B4 paper
> > requires 2.75MB. Worse, if someone asks for more than 1MB, we could
> > potentially corrupt memory above the IOMMU page tables.
> 
> Does the device require being queued the entire page all at
> once or can you send it in pieces some other way?

Unfortunately, all at once AFAICT. I don't have real docs -- this has
been built from the documentation provided by the NetBSD driver and some
investigation by myself. It takes a DMA address and a length, then I
tell it to go. It's also quite picky about other things, like ending DMA
on a page boundry... :/

> Your patch looks fine.

Cool, at least I won't kill my machine. :)
I'd like to see it go into mainline if possible, or at least a patch
that catches attempts to map more than 1MB to avoid trashing memory.

Dave
