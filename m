From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 14 Jun 2007 02:00:55 +0000
Subject: Re: [2/2] 2.6.22-rc4: known regressions v3
Message-Id: <20070614020055.GL15426@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <46704923.1010009@googlemail.com> <46704C44.8020602@googlemail.com> <Pine.LNX.4.61.0706132320200.26751@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0706132320200.26751@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, Dan Aloni <da-x@monatomic.org>, Chad Tindel <ctindel@users.sourceforge.net>, Jay Vosburgh <fubar@us.ibm.com>, Stephen Hemminger <shemminger@linux-foundation.org>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, Mikael Pettersson <mikpe@it.uu.se>, linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, linux-usb-devel@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@suse.de>, Alex Riesen <raa.lkml@gmail.com>, Andi Kleen <ak@suse.de>, discuss@x86-64.org, Ioan Ionita <opslynx@gmail.com>

On Wed, Jun 13, 2007 at 11:25:20PM +0100, Mark Fortescue wrote:
> The random seg faults on x86_64 is interesting as I have been getting 
> random illegal instruction faults on sparc (sun4c) with 2.6.22-rc3. I have 
> not yet tried to track it down. All I know at present is that it is not a 
> problem on 2.6.20.9.

Very interesting. Any hints as to how to test or how long to wait
before the illegal instructions happen?


-- wli
