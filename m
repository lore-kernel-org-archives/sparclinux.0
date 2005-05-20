From: Bob Breuer <breuerr@mc.net>
Date: Fri, 20 May 2005 03:45:15 +0000
Subject: Re: 2.6.11.10 failure on Hypersparc sparc32 [was: Re: sparc32 2.6
Message-Id: <428D5D4B.2090205@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0505190111530.13987@bobcat>
In-Reply-To: <Pine.LNX.4.61.0505190111530.13987@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Jurij Smakov wrote:
> 
> strip -R .comment -R .note -K sun4u_init -K _end -K _start image

Yes, that worked.  I'll have to remember that next time.

> Interesting. I guess that it actually uses initramfs capability to load 
> cpio archives into ramdisk. We are planning this transition at some 
> point, but at the moment cramfs/ext2 initrds is what is used.

I just noticed the initramfs messages earlier in the boot:

Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs... it is
Freeing initrd memory: 741k freed

Does a cramfs/ext2 initrd get freed at that point also?

Even though my build loads the initrd, it still has 2 problems.
1) it complains about udiv:
scsi_mod: no version for "udiv" found: kernel tainted.

2) blows up when probing the scsi bus:
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
esp0: Aborting command
esp0: dumping state
esp0: dma -- cond_reg<a6400310> addr<f0083e41>
esp0: SW [sreg<11> sstep<04> ireg<18>]
esp0: HW reread [sreg<01> sstep<c4> ireg<00>]
esp0: current command [tgt<01> lun<01> pphase<CLUELESS> cphase<DATAIN>]
esp0: disconnected
...
   and more scsi errors, eventually leading to a kernel panic.

I've seen this scsi problem before and worked around it by un-selecting 
SCSI_MULTI_LUN when scsi was a module.

Bob
