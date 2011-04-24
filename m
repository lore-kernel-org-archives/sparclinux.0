From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 24 Apr 2011 08:22:32 +0000
Subject: Re: memblock versus bootmem (relevant for sparc32?)
Message-Id: <20110424082232.GA25725@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110423174200.GA25324@merkur.ravnborg.org>
In-Reply-To: <20110423174200.GA25324@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Ben.

On Sun, Apr 24, 2011 at 09:20:46AM +1000, Benjamin Herrenschmidt wrote:
> On Sat, 2011-04-23 at 19:42 +0200, Sam Ravnborg wrote:
> > Hi Ben, Yinghai, Ingo.
> > 
> > While doing some sparc related tasks I noticed that sparc64
> > uses memblock - whereas sparc32 does not.
> > 
> > I am aware that memblock was called lmb in the older days and
> > that sparc64 had lmb support which was converted to memblock support.
> > 
> > But so far I have failed to find any information on what the benefit
> > of memblock is and how it compared to for example bootmem.
> > I can see that x86 no longer uses bootmem - as the only arch.
> 
> Mostly memblock works earlier and handles both the actual physical
> memory layout and allocation within that memory. Archs like powerpc
> still use memblock, then bootmem, then page alloc.
> 
> x86 eventually removed the bootmem step in the middle, which is a good
> thing, unfortunately...
> 
> > But I also noticed that mm/nobootmem.c contains several functions
> > named bla_x86_bla(). So I continued to be a bit confused.
> 
>  ... as you noticed, this is all quite horrible with x86 junk in generic
> places etc... and so I haven't yet looked at doing that on powerpc as
> well (though I'd like to at some stage).
>  
> > Do there exist any writeup of what memblock is?
> 
> Other than the code ? :-) It's a very simple region list management
> which works on two lists, one represents the physical memory in the
> system and the other represents reserved areas and can be used as an
> allocator (or to reserve "FW" regions etc...).
> 
> It initially worked entirely on static arrays (it used to be that way so
> it can be used very early during boot), but it now grew the ability to
> re-allocate its own arrays so that it can be used more generically as an
> allocator instead of bootmem.
> 
> It's probably slower than bootmem tho, but on the other hand it
> shouldn't be on any critical path.

Seems that my initial impression is OK. But I was confused by the x86
specific parts.

> 
> > Also does it make sense to consider introducing memblock for sparc32.
> > And if yes - what is the benefit and what does it replace?

I have digged a bit deeper in the code now. sparc32 has a local implementation
that handle the availabe memory which it then handed over to bootmem.
It would be a nice cleanup to get this local implementation migrated
over to memblock. Both in terms of using generic code but also
to be more aligned with sparc64.

Replacing bootmem seems like a bigger task - that will wait.

	Sam
