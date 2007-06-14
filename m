From: Stephen Hemminger <shemminger@linux-foundation.org>
Date: Thu, 14 Jun 2007 21:39:29 +0000
Subject: Re: [2/2] 2.6.22-rc4: known regressions v3
Message-Id: <20070614143929.23cc1553@localhost>
List-Id: <sparclinux.vger.kernel.org>
References: <46704923.1010009@googlemail.com> <46704C44.8020602@googlemail.com>
In-Reply-To: <46704C44.8020602@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: discuss@x86-64.org, Mikael@smtp2.linux-foundation.org, Alex Riesen <raa.lkml@gmail.com>, Dan Aloni <da-x@monatomic.org>, Greg Kroah-Hartman <gregkh@suse.de>, Netdev <netdev@vger.kernel.org>, linux-usb-devel@lists.sourceforge.net, Jay Vosburgh <fubar@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Pettersson <mikpe@it.uu.se>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, Ioan Ionita <opslynx@gmail.com>, Chad Tindel <ctindel@users.sourceforge.net>

On Wed, 13 Jun 2007 21:57:56 +0200
Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:

> Hi all,
> 
> Here is a list of some known regressions in 2.6.22-rc4.
> 
> Feel free to add new regressions/remove fixed etc.
> http://kernelnewbies.org/known_regressions
> 
> 
> 
> Networking
> 
> Subject    : commit 9093bbb2d96d0184f037cea9b4e952a44ebe7c32 broke the bonding driver
> References : http://lkml.org/lkml/2007/6/13/65
> Submitter  : Dan Aloni <da-x@monatomic.org>
> Handled-By : Stephen Hemminger <shemminger@linux-foundation.org>
> Status     : Unknown
> 
> 

Patch available (to bonding).
