From: Bob Picco <bpicco@meloft.net>
Date: Thu, 27 Feb 2014 11:03:15 +0000
Subject: Re: [PATCH 1/2] sparc64 - strict devmem
Message-Id: <20140227110315.GY29427@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1392750679-6966-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1392750679-6966-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
David Miller wrote:	[Wed Feb 19 2014, 07:44:01PM EST]
> From: Bob Picco <bpicco@meloft.net>
> Date: Tue, 18 Feb 2014 14:11:18 -0500
> 
> > +#ifdef CONFIG_STRICT_DEVMEM
> > +/* devmem_is_allowed for sparc.
> > + */
> > +int devmem_is_allowed(unsigned long pagenr)
> > +{
> > +	int  rc = page_is_ram(pagenr);
> > +
> > +	return rc;
> > +}
> > +#endif
> 
> We already go through all of the effort to build
> sparc64_valid_addr_bitmap, please use it via kern_addr_valid().
Sure we certainly can accomplish it this way and probably should.
> 
> Using resources is over-engineering.  We never provided that stuff
> in /proc/iomem on sparc so no need to add it unnecessarily.
Well over-engineering might be a strong word for a path that isn't hot.
/proc/iomem would be nice with it similar to x86_64.

It seems required with kexec-tools/kexec which is functional for T4/T5 but
not ready. Though I suppose you could have only "Crash kernel".

Also I can't think of a way to make "crash" operational without
CONFIG_DEVKMEM. Though I've had little time to ponder.

For example on T5-8 the head of /proc/iomem is:
30400000-3fdde47fff : System RAM
3fdde4e000-3fdde4ffff : System RAM
80000000000-83fffffffff : System RAM
100000000000-103fffffffff : System RAM
180000000000-183fffffffff : System RAM
200000000000-203fffffffff : System RAM
280000000000-283fffffffff : System RAM
300000000000-303fffffffff : System RAM
380000000000-383fffccbfff : System RAM
  380000004000-38000051661f : Kernel code
  380000516620-380000864e3f : Kernel data
  380000900000-380001180838 : Kernel bss
  383f5f400000-383f7f3fffff : Crash kernel
383fffcec000-383fffcfbfff : System RAM
383fffd0e000-383fffd0ffff : System RAM
800000000000-80007effffff : /pci@300
...

How about a combination of your suggestion and /proc/iomem?
> 
> Furthermore, the /dev/kmem device probably needs similar restrictions,
> it just blindly copies things as long as the address is lower than
> high memory.
Ah, the holes. I'll attempt and find time to engage.

thanx,

bob
> 
> All of this stuff can potentially trigger bus errors, and really the
> right thing to do is:
> 
> 1) Add the necessary address validations as being discussed here
> 
> 2) Put the accessed behind something like the PCI config space poking
>    framework, it is able to recover from BUS errors cleanly.  Take
>    a look at the code mentioning 'pci_poke_in_progress'.
> 
