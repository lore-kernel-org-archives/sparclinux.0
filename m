From: David Miller <davem@davemloft.net>
Date: Fri, 27 Apr 2012 18:36:20 +0000
Subject: Re: [PATCH] sparc64: Use node local allocations for IRQ stacks.
Message-Id: <20120427.143620.1553503087991526184.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120426.235507.1967848292117984225.davem@davemloft.net>
In-Reply-To: <20120426.235507.1967848292117984225.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 27 Apr 2012 20:29:35 +0200

> If I read the memblock code correct something like this should do it.
> Only as a principal idea - I may revist this another time.

The interface wrappers you come up with have to cope with all of the
generic bootmem calls we have in the tree.  And therefore you'll need
to provide limit, goal, and associated fallbacks.

Oh look, the alloc_bootmem wrappers already provide this and allow us
to not have to edit all the call sites at all.

So it seems quite useless if you ask me. :-)
