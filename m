From: Matt Cole <mikaey@neb.rr.com>
Date: Sun, 08 Feb 2009 02:29:14 +0000
Subject: Re: SILO problems
Message-Id: <498E437A.1080508@neb.rr.com>
List-Id: <sparclinux.vger.kernel.org>
References: <498D413B.2060009@neb.rr.com>
In-Reply-To: <498D413B.2060009@neb.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Tom "spot" Callaway wrote:
> On 2009-02-07 at 5:32:52 -0500, David Miller <davem@davemloft.net> wrote:
>   
>> I notice that I have none of those funny flags set, and my
>> boot partition starts at zero and is of type "1" or Sun partition
>> type "Boot".
>>
>> Perhaps one of those two things makes a difference.
>>     
>
> Your boot partition needs to start on 0, or silo can't be loaded by the
> OBP. Hit this the hard way debugging the Fedora installer. :)
>
> ~spot
>
>   
Thanks for the great responses everyone.

Meelie, I've reinstalled silo.  Several times.  Haven't tried zeroing 
out the beginning of the disk yet, but that will be in the list of 
things to try.

David, the flags I had set on my partitions were the mountable (r) flag, 
and the read-only (u) flag.  fdisk set these for me automatically.  I 
initially didn't bother to change it.  I went back and unset all the 
flags, no effect.

David and Tom, one of the problems I've noticed is that, with having the 
boot partition start on cylinder 0, that creating anything on that 
partition results in overwriting the disklabel.  David, I noticed your 
fdisk readout has your boot partition starting on cylinder 0, is this 
just a dummy partition?  Or how did you get around this problem?

Well, at any rate, I repartitioned the drive with the following:

Disk /dev/sdb (Sun disk label): 64 heads, 32 sectors, 38170 cylinders
Units = cylinders of 2048 * 512 bytes

   Device Flag    Start       End    Blocks   Id  System
/dev/sdb1             0         1      1024    1  Boot
/dev/sdb2             1        11     10240   83  Linux native
/dev/sdb3             0     38170  39086080    5  Whole disk
/dev/sdb4            11     34343  35155968   83  Linux native
/dev/sdb5         34343     38170   3918848   82  Linux swap

I'm in the process of copying everything back over to the drive.  I'll 
let you know how it goes.

Thanks,
Matt Cole
