From: Meelis Roos <mroos@linux.ee>
Date: Wed, 13 Jun 2007 08:59:23 +0000
Subject: Re: parport_pc BUG in dma-mapping.h
Message-Id: <Pine.SOC.4.64.0706131137370.12888@math>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0705121525460.4493@math>
In-Reply-To: <Pine.SOC.4.64.0705121525460.4493@math>
To: sparclinux@vger.kernel.org

> All along the compiler was telling us the problem:
> 
> In file included from drivers/parport/parport_pc.c:67:
> include/asm/parport.h: In function $,1rx(Bparport_isa_probe$,1ry(B:
> include/asm/parport.h:148: error: request for member $,1rx(Bdev$,1ry(B in something not a structure or union
> include/asm/parport.h: In function $,1rx(Bparport_pc_find_nonpci_ports$,1ry(B:
> include/asm/parport.h:203: error: request for member $,1rx(Bdev$,1ry(B in something not a structure or union
> 
> The following patch should fix things for good:
> 
> commit f75823072cd2bfa6e7aacafa15c9e5af7ce8d879
> Author: David S. Miller <davem@sunset.davemloft.net>
> Date:   Tue Jun 12 23:53:03 2007 -0700

Yes, this works, thank you!

I tried a similar way - the compiler warnings. The following warnings 
looked suspicious to me but I could not see into them in 10 minutes so I 
did not investigate it further.

  CC [M]  drivers/parport/parport_pc.o
In file included from drivers/parport/parport_pc.c:67:
include/asm/parport.h: In function 'parport_isa_probe':
include/asm/parport.h:148: warning: passing argument 5 of 'parport_pc_probe_port' from incompatible pointer type
include/asm/parport.h: In function 'parport_pc_find_nonpci_ports':
include/asm/parport.h:202: warning: passing argument 5 of 'parport_pc_probe_port' from incompatible pointer type

-- 
Meelis Roos (mroos@linux.ee)
