From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Tue, 08 Jan 2008 22:39:10 +0000
Subject: Re: Linux 2.6.24-rc7: sparc64: WARNING: at kernel/lockdep_proc.c:267 lockdep_stats_show()
Message-Id: <200801082339.13198.m.kozlowski@tuxland.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LFD.1.00.0801061410290.3148@woody.linux-foundation.org> <200801081942.17139.m.kozlowski@tuxland.pl> <20080108130034.8ab82fb0.randy.dunlap@oracle.com>
In-Reply-To: <20080108130034.8ab82fb0.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

Hello, 

> > 	Got this when doing usual looping over /proc entries on fresh test kernel:
> 
> What is the usual looping, please?

#!/bin/bash

for i in `find /proc -type f`; do
        echo -n "cat $i > /dev/null ... ";
        ( cat $i > /dev/null & );
        echo "done";
done

Regards,

	Mariusz
