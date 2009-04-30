From: Chris Torek <chris.torek@windriver.com>
Date: Thu, 30 Apr 2009 00:06:57 +0000
Subject: Re: interrupt problem with multiple vnet devices
Message-Id: <200904300006.n3U06vn17471@elf.torek.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200904292141.n3TLfmn16267@elf.torek.net>
In-Reply-To: <200904292141.n3TLfmn16267@elf.torek.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>This is the commit that test comes from.  I assume you guys
>would check the commit logs for something like this, but just
>in case...
[snippage - will just retain commit ID]
>commit 5a606b72a4309a656cd1a19ad137dc5557c4b8ea

Yes, this one is in.  I did (and still do) suspect a hypervisor
bug.  I think in this case the problem is that this test is not
sufficent for the "two vnets on one vswitch" case, though,
because this results in the desc->status not having
IRQ_INPROGRESS set on the "other" vnet that gets a double
interrupt.

I'm also wondering now if it has something to do with the code we
added that attempts to redistribute interrupts, so that in the case
of a double interrupt, the second one goes to a different CPU
than the CPU already handling the first one.  Although we
should still see IRQ_INPROGRESS then...

Chris
