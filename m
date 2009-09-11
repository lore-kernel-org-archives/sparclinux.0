From: David Miller <davem@davemloft.net>
Date: Fri, 11 Sep 2009 20:04:33 +0000
Subject: Re: Sparc release requalification
Message-Id: <20090911.130433.09850535.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Fri, 11 Sep 2009 21:09:10 +0200

> calling  pcr_arch_init+0x0/0x130 @ 1
> Test

Make pcr_arch_init() in arch/sparc/kernel/pcr.c simply return 0
instead of doing anything, see if that helps it get further along.

> I'll test Dave's image later, and if that fails, I guess it's best to start
> bisecting?

Yes, but if the above fixes things the bisect would almost
certainly land on commit:

commit e5553a6d04421eec326a629571d696e8e745a0e4
Author: David S. Miller <davem@davemloft.net>
Date:   Thu Jan 29 21:22:47 2009 -0800

    sparc64: Implement NMI watchdog on capable cpus.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>


