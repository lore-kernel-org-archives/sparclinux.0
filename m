From: David Miller <davem@davemloft.net>
Date: Sat, 07 Feb 2009 10:32:52 +0000
Subject: Re: SILO problems
Message-Id: <20090207.023252.118094387.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <498D413B.2060009@neb.rr.com>
In-Reply-To: <498D413B.2060009@neb.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Matt Cole <mikaey@neb.rr.com>
Date: Sat, 07 Feb 2009 02:07:23 -0600

> Anywho, I'm having the damnedest time getting SILO to work.  I think
> I've tried just about every trick that Google knows of.  Initially,
> when I turned the machine on, I would get "the file just loaded does
> not appear to be executable".  I since ran SILO with -t to install
> it on /dev/hda1, and now I get:
>
> Sun Ultra 5/10 UPA/PCI (UltraSPARC-IIi 440MHz), Keyboard Present
> OpenBoot 3.31, 256MB (50 ns) memory installed, Serial #16661092.
> Ethernet address 8:0:20:fe:3a:64, Host ID: 80fe3a64
> 
> Boot device: disk  File and args:
>
> ...and at this point the machine freezes.  It still responds to
> Stop+A, but any attempts to do "boot disk0", "boot disk:3", "boot
> disk:c", etc., etc., yield the same result.

If you're going to do that you have to boot from that specific
partition.  For example, if you put the master bootblock on
/dev/hda1 you probably need to boot from "disk:a" or similar.

> Disk /dev/hda (Sun disk label): 64 heads, 32 sectors, 38170 cylinders
> Units = cylinders of 2048 * 512 bytes
> 
>    Device Flag    Start       End    Blocks   Id  System
> /dev/hda1   r         1        11     10240   83  Linux native
> /dev/hda2  u         12     36241  37098496   83  Linux native
> /dev/hda3             0     38170  39086080    5  Whole disk
> /dev/hda4  u      36242     38170   1974272   82  Linux swap

Hmmm, looking at mine:

   Device Flag    Start       End    Blocks   Id  System
/dev/hda1             0        12     96390    1  Boot
/dev/hda2            12     14219 114117727+  83  Linux native
/dev/hda3             0     14593 117218272+   5  Whole disk
/dev/hda4         14219     14593   3004155   82  Linux swap

I notice that I have none of those funny flags set, and my
boot partition starts at zero and is of type "1" or Sun partition
type "Boot".

Perhaps one of those two things makes a difference.
