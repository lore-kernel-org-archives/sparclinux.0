From: Matt Cole <mikaey@neb.rr.com>
Date: Sat, 07 Feb 2009 08:07:23 +0000
Subject: SILO problems
Message-Id: <498D413B.2060009@neb.rr.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Ok, I'm ready to cry uncle on this one.

I have a Sun Ultra 10.  The machine was given to me without a hard 
drive, so I slapped an old 40GB Maxtor in there that I had sitting 
around and compiled an entire Linux setup from source.  The machine 
initially came with a password set in the NVRAM, so everything that I've 
done to it so far has been accomplished by allowing it to netboot off of 
my other computer.  Since then, I've pulled the old "pull the NVRAM chip 
out, put it back in backwards, turn the power on for 2 seconds, then put 
the NVRAM chip back in the right way" trick to get rid of the password.

Anywho, I'm having the damnedest time getting SILO to work.  I think 
I've tried just about every trick that Google knows of.  Initially, when 
I turned the machine on, I would get "the file just loaded does not 
appear to be executable".  I since ran SILO with -t to install it on 
/dev/hda1, and now I get:

Sun Ultra 5/10 UPA/PCI (UltraSPARC-IIi 440MHz), Keyboard Present
OpenBoot 3.31, 256MB (50 ns) memory installed, Serial #16661092.
Ethernet address 8:0:20:fe:3a:64, Host ID: 80fe3a64

Boot device: disk  File and args:

...and at this point the machine freezes.  It still responds to Stop+A, 
but any attempts to do "boot disk0", "boot disk:3", "boot disk:c", etc., 
etc., yield the same result.

Here's the dump of my partition table from fdisk:

Disk /dev/hda (Sun disk label): 64 heads, 32 sectors, 38170 cylinders
Units = cylinders of 2048 * 512 bytes

   Device Flag    Start       End    Blocks   Id  System
/dev/hda1   r         1        11     10240   83  Linux native
/dev/hda2  u         12     36241  37098496   83  Linux native
/dev/hda3             0     38170  39086080    5  Whole disk
/dev/hda4  u      36242     38170   1974272   82  Linux swap

/dev/hda1 is a small ext2 partition that has the SILO boot loaders, my 
kernel, and silo.conf.  Hopefully, the others should be obvious.  Any 
suggestions anyone has would be appreciated!

Thanks,
Matt Cole
