From: James Morris <jmorris@namei.org>
Date: Tue, 05 Jun 2007 14:51:54 +0000
Subject: Re: [4/5] 2.6.22-rc4: known regressions
Message-Id: <Line.LNX.4.64.0706051049050.21439@d.namei>
List-Id: <sparclinux.vger.kernel.org>
References: <46657407.1000108@googlemail.com> <466576B1.5020105@googlemail.com>
In-Reply-To: <466576B1.5020105@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@redhat.com>, Gregor Jasny <gjasny@googlemail.com>, Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>, Ingo Molnar <mingo@elte.hu>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, Mikael Pettersson <mikpe@it.uu.se>, linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Simon <sg02r@ecs.soton.ac.uk>, linux-usb-devel@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@suse.de>

On Tue, 5 Jun 2007, Michal Piotrowski wrote:

> SELinux
> 
> Subject    : very high non-preempt latency in context_struct_compute_av()
> References : http://lkml.org/lkml/2007/6/4/78
> Submitter  : Ingo Molnar <mingo@elte.hu>
> Handled-By : Stephen Smalley <sds@tycho.nsa.gov>
>             James Morris <jmorris@namei.org>
> Status     : unknown

Not sure what the criteria are for being listed as a regression, but this 
problem was likely introduced many moons ago with changes which reduced 
the memory footprint of security policy.


-- 
James Morris
<jmorris@namei.org>
