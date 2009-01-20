From: David Miller <davem@davemloft.net>
Date: Tue, 20 Jan 2009 06:35:17 +0000
Subject: Re: opps building sparc64 packages
Message-Id: <20090119.223517.190558209.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200901021435.23972.dgilmore@redhat.com>
In-Reply-To: <200901021435.23972.dgilmore@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dennis Gilmore <dgilmore@redhat.com>
Date: Fri, 2 Jan 2009 14:35:19 -0600

> trying to build openbabel sparc64 
> https://sparc.koji.fedoraproject.org/koji/taskinfo?taskID2540  I got an 
> opps 
> 
> sun4v_data_access_exception: ADDR[ffffb83000000008] CTX[16ba] TYPE[0009], going.                                                                              
 ...
> lt-atom(22311): Dax [#1]                                                                                                                                      
> TSTATE: 0000009911001600 TPC: 00000000004821d8 TNPC: 00000000004821dc Y: 
> 00000000    Not tainted                                                              
> TPC: <exit_robust_list+0x78/0x10c>                                                                                                                            
 ...
> Ive seen something similar building OOo also 
> 22311 ?        D      0:00 /builddir/build/BUILD/openbabel-2.2.0b3-20080215-
> r2249/test/.libs/lt-atom
> 
> the process that should be running ends up in a D state  so it is sleeping and 
> unkillable.  the processes hang around until a reboot.  any ideas where I 
> should start looking?  this happens on a T1000 and T2000 i've not yet tried on 
> non-niagara hardware.  

Thanks for this report.  I think I know why this happens.

exit_robust_list() just walks the userland linked list of
robust FUTEX objects to release.  Since it's userland,
anything can be there, so this can generate all kinds of
exceptions depending upon the address used.  Such exceptions
should just silently be handled and cause an abort of the
FUTEX list traversal.

The address in question is in register %g2 as the faulting
instruction is:

	ldxa  [ %g2 ] %asi, %g3

And register %g2 holds 0xfff8b83000000008 which is inside of
the address space hole on Niagara.  Any acccess there is
illegal and will generate a data access exception as we see
here.

The code in sun4v_data_access_exception() needs some logic to properly
handle the case of the kernel doing a userspace access.  Currently it
does an OOPS unconditionally when triggered from kernel space, which
is wrong.

I'll fix this up and post a patch.

Thanks again.
