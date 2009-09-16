From: Tim Abbott <tabbott@ksplice.com>
Date: Wed, 16 Sep 2009 18:03:48 +0000
Subject: Re: [PATCH v2] sparc: Clean up linker script using new linker script
Message-Id: <alpine.DEB.1.10.0909161332190.2942@dr-wily.mit.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <1253119592-19598-2-git-send-email-tabbott@ksplice.com> <20090916.101924.186960949.davem@davemloft.net> <alpine.DEB.1.10.0909161322260.2942@dr-wily.mit.edu> <20090916.103019.253722423.davem@davemloft.net>
In-Reply-To: <20090916.103019.253722423.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, sam@ravnborg.org, geofft@ksplice.com

On Wed, 16 Sep 2009, David Miller wrote:

> From: Tim Abbott <tabbott@ksplice.com>
> Date: Wed, 16 Sep 2009 13:27:43 -0400 (EDT)
> 
> > On Wed, 16 Sep 2009, David Miller wrote:
> > 
> >> Can you do this cleanup without moving the relative locations of .data
> >> and .data1 sections?
> > 
> > Yes, if you just swap RW_DATA_SECTION and .data1 so it looks like
> > 
> > RW_DATA_SECTION(SMP_CACHE_BYTES, 0, THREAD_SIZE)
> > .data1 : {
> > 	*(.data1)
> > }
> > 
> > instead, that would preserve their relative locations.
> > 
> > Currently, switching to RW_DATA_SECTION would still result in a change in 
> > their relative position that .data.page_aligned and .data.nosave would be 
> > between .data and .data1 (not sure if that is relevant on sparc). (this 
> > will change when <http://lkml.org/lkml/2009/9/16/396> is merged).
> 
> I don't know which, if any, are relevant or could cause problems.

The kind of problem I've seen on other architectures is if there are 
short-range (e.g. 2-byte) relative relocations between two sections, and 
you insert a new section between them, they end up too far apart and the 
kernel fails to link.  I don't know whether the sparc architecture has 
that kind of short relocation issue, but that's what I'd be worried about 
with section order changes.

The other potential issue is sections moving past linker script defined 
symbols such as __init_end, so that the section might be allocated 
differently.  The only change of that form in this patch is that it moves 
.data.init_task before _edata, which on sparc is only used to print how 
memory is used by different data types.

The other thing I should mention is that I've not boot-tested this; I've 
only build-tested it with a sparc64 cross-compiler.  So that should be 
done before merging this.

> It's hard for me to ACK this because it's not a straight nop
> transformation, which we could at least presume would function
> properly if the macros were implemented correctly.

Would it help if I were to split the patch into first rearranging the code 
to look like the macros and then applying the macros, so that you can see 
more easily exactly what is changing?

	-Tim Abbott
