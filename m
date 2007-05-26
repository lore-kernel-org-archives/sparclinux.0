From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sat, 26 May 2007 16:29:15 +0000
Subject: Re: Sun4c bug: Unable to handle kernel paging request at virtual
Message-Id: <Pine.LNX.4.61.0705261716420.15010@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0705261400320.14639@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0705261400320.14639@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all,

I have done some more investigating and it looks like this problem has 
been caused by a line of code I changed to get meaningfull bus_id's from 
the PROM. The type pointer in dev was getting overwritten by an unchecked 
write to bus_id.

On a different issue assosciated with the commit, if there is an error 
with class->dev_attrs in device_add_attrs, the error value can get lost.

Regards
 	Mark Fortescue.

On Sat, 26 May 2007, Mark Fortescue wrote:

> Hi Kay,
>
> commit: f9f852df2faf76a2667949ddb4947d4b8f99f02f (linux-2.6.20) breaks 
> Sparc32 (sun4c SS1 Clone). It causes a paging request fault - see below.
>
> I am going to investigate further later on today. I will let you know what I 
> find. If any one else can shead light on the problem then pleae let me know.
>
> Regards
> 	Mark Fortescue.
>
> The commit details are:
> ----------------------------------------------------------------------------
> Author: Kay Sievers <kay.sievers@novell.com>
> Date:   Sat Oct 7 21:54:55 2006 +0200
>
>    Driver core: add device_type to struct device
>
>    This allows us to add type specific attributes, uevent vars and
>    release funtions.
>
>    A subsystem can carry different types of devices like the "block"
>    subsys has disks and partitions. Both types create a different set
>    of attributes, but belong to the same subsystem.
>
>    This corresponds to the low level objects:
>      kobject   -> device       (object/device data)
>      kobj_type -> device_type  (type of object/device we are embedded in)
>      kset      -> class/bus    (list of objects/devices of a subsystem)
>
>    Signed-off-by: Kay Sievers <kay.sievers@novell.com>
>    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
>
> :040000 040000 ea0a0790d3b65ed36c87b07e343da36011b050d0 
> 1d1136a7326c774e0f8d22f01487b30d5e122449 M      drivers
> :040000 040000 cee410003607520618014fbc21a0c7eaf57388ab 
> 97e7bc5ae6238ba6d58a30b3b464a223ec90556b M      include
>
> The console log is as follows:
> -------------------------------------------------------------------------
> Booting Linux...
> PROMLIB: Sun Boot Prom Version 0 Revision 0
> Linux version 2.6.20 (mark@a64) (gcc version 4.1.2) #1 Sat May 26 14:11:09 
> BST 2007
> ARCH: SUN4C
> TYPE: Sun4c SparcStation 1 (Opus 4/60)
> Ethernet address: 0:80:f1:0:5:89
> Loading sun4c MMU routines
> Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz). Patching 
> kernel for sun4c
> SUN4C: 79 mmu entries for the kernel
> PROM: Built device tree with 12437 bytes of memory.
> Built 1 zonelists.  Total pages: 9472
> Kernel command line: root=/dev/nfs 
> nfsroot.1.1.4:/cross/sparc/sys-root,rsize 48,wsize 48 ip=dhcp 
> init=/sbin/bash.static rw console=prom
> PID hash table entries: 256 (order: 8, 1024 bytes)
> start_kernel(): bug: interrupts were enabled early
> Console: mono PROM 80x34
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 37796k/40908k available (1676k kernel code, 3144k reserved, 604k 
> data, 160k init, 0k highmem)
> Mount-cache hash table entries: 512
> NET: Registered protocol family 16
> Unable to handle kernel paging request at virtual address 66302000
> tsk->{mm,active_mm}->context = ffffffff
> tsk->{mm,active_mm}->pgd = f0005000
>              \|/ ____ \|/
>              "@'/ ,. \`@"
>              /_| \__/ |_\
>                 \__U_/
> swapper(1): Oops [#1]
> PSR: 000010c4 PC: f0112f30 NPC: f0112f34 Y: 00000000    Not tainted
> PC: <device_add+0x2a0/0x534>
> %G: f0fcf0b4 00000000  ffffffff 00000000  f028b180 00000005  ff000000 
> 00000001
> %O: 00000000 00000028  f0fcf0b4 f0fcf160  f0fc5c9c 00000018  ff001cb0 
> f0112da8
> RPC: <device_add+0x118/0x534>
> %L: 00000008 f0fcf0b4  00000000 f0fcf1a8  f0fcf1a8 00000000  66302900 
> f0fcf15c
> %I: 00000000 0f030e57  00000010 ff001dd4  f0fcf1c4 f0fe5480  ff001d18 
> f001ad20
> Caller[f001ad20]: of_device_register+0x30/0x64
> Caller[f0246ca4]: do_header+0x234/0x274
> Caller[f0246d10]: inflate_dynamic+0x2c/0x5c4
> Caller[f0246dac]: inflate_dynamic+0xc8/0x5c4
> Caller[f00100cc]: init+0xb0/0x2ac
> Caller[f00141d4]: kernel_thread+0x3c/0x50
> Caller[f00102e0]: rest_init+0x18/0x2c
> Caller[f0240f54]: __ret_efault+0x844/0xd40
> Caller[f0240790]: __ret_efault+0x80/0xd40
> Caller[0030509c]: 0x3050a4
> Instruction DUMP: 80a5a000  02800027  a4102000 <c2058000> 80a06000  1280000f 
> a0102000  10800022  80a62000
> Kernel panic - not syncing: Attempted to kill init!
>
> Press Stop-A (L1-A) to return to the boot prom
> ----------------------------------------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
