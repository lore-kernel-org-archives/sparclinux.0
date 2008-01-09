From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Wed, 09 Jan 2008 16:31:15 +0000
Subject: Re: Linux 2.6.24-rc7: sparc64: WARNING: at kernel/lockdep_proc.c:267 lockdep_stats_show()
Message-Id: <200801091731.16043.m.kozlowski@tuxland.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LFD.1.00.0801061410290.3148@woody.linux-foundation.org> <200801082339.13198.m.kozlowski@tuxland.pl> <4783FD17.90806@oracle.com>
In-Reply-To: <4783FD17.90806@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

Hello,

> >>> 	Got this when doing usual looping over /proc entries on fresh test kernel:
> >> What is the usual looping, please?
> > 
> > #!/bin/bash
> > 
> > for i in `find /proc -type f`; do
> >         echo -n "cat $i > /dev/null ... ";
> >         ( cat $i > /dev/null & );
> >         echo "done";
> > done
> 
> OK, thanks.  Probably not related to the problem report, but
> the script should probably check each file for 'readable' (-r).
> /proc/sysrq-trigger is write-only...

Hm... true. Good hint.

Thanks,

	Mariusz


