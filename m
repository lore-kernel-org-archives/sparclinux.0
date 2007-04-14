From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Sat, 14 Apr 2007 22:58:57 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <1176591537.3970.255.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-9fg3FP7Seywo8VhrVH5f"
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
To: sparclinux@vger.kernel.org


--=-9fg3FP7Seywo8VhrVH5f
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2007-04-13 at 22:01 -0700, David Miller wrote:
> From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
> Date: Fri, 13 Apr 2007 23:10:46 -0500
> 
> > Here you go. Doesn't seem to make much difference. The only difference I
> > see is this:
> > 
> > ESP: tgt[0] lun[0] scsi_cmd [ 12 00 00 00 24 c2 ]
> 
> I need to have my head examined :-)
> 
> Please try this patch:
> 
> diff --git a/drivers/scsi/esp.c b/drivers/scsi/esp.c
> index 989b022..b500961 100644
> --- a/drivers/scsi/esp.c
> +++ b/drivers/scsi/esp.c
> @@ -174,7 +174,7 @@ static void esp_enable_interrupts(struct esp *esp)
>  {
>  	u32 val = dma_read32(DMA_CSR);
>  
> -	dma_write32(val & ~DMA_INT_ENAB, DMA_CSR);
> +	dma_write32(val | DMA_INT_ENAB, DMA_CSR);
>  }
>  
>  static int esp_interrupt_pending(struct esp *esp)

OK, that patch fixes the obvious flaw, but its still not scanning the
bus. Attached is the output from a patched kernel (esp + scsi are
static) with esp.esp_debug=1023.

Thanks,

~spot

--=-9fg3FP7Seywo8VhrVH5f
Content-Disposition: attachment; filename=new-ss4-esp-debug.log
Content-Type: text/x-log; name=new-ss4-esp-debug.log; charset=utf-8
Content-Transfer-Encoding: quoted-printable


|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08Loaded kernel version 2.6.20
Loading initial ramdisk (3719180 bytes at 0x3000000 phys, 0x60000000 virt).=
..
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08PROMLIB: obio_ranges 1
Booting Linux...
PROMLIB: Sun Boot Prom Version 3 Revision 2
Linux version 2.6.20-1.3062.al3.4 (root@odyssey) (gcc version 4.1.1 2006062=
9 (Red Hat 4.1.1-6)) #1 Sat Apr 14 17:34:05 EDT 2007
ARCH: SUN4M
TYPE: SPARCstation 4
Ethernet address: 8:0:20:79:8d:63
Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz). Patching =
kernel for srmmu[Fujitsu Swift]/iommu
PROM: Built device tree with 20056 bytes of memory.
Power off control detected.
Built 1 zonelists.  Total pages: 38998
Kernel command line: ro root=3DLABEL=3D/ stop-a=3D1 esp.esp_debug=3D1023
PID hash table entries: 1024 (order: 10, 4096 bytes)
start_kernel(): bug: interrupts were enabled early
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 153400k/163508k available (1796k kernel code, 9956k reserved, 496k =
data, 148k init, 0k highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
SCSI subsystem initialized
IOMMU: impl 0 vers 4 table 0xf9f00000[262144 B] map [65536 b]
sbus0: Clock 22.0 MHz
dma0: Revision 2=20
dma1: Revision 2=20
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 3632k freed
ioremap: done with statics, switching to malloc
apc: power management initialized
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Console: switching to colour frame buffer device 144x56
/iommu@0,10000000/sbus@0,10001000/SUNW,tcx@2,800000: TCX at 0:50800000, 8-b=
it only
ffd35080: ttyS0 at MMIO 0x71100000 (irq =3D 44) is a zs
Console: ttyS0 (SunZilog zs0)
ffd35080: ttyS1 at MMIO 0x71100004 (irq =3D 44) is a zs
ffd35134: Keyboard at MMIO 71000000 (irq =3D 44) is a zs
ffd35134: Mouse at MMIO 71000004 (irq =3D 44) is a zs
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
scsi0 : esp
esp: esp0 found at /iommu@0,10000000/sbus@0,10001000/espdma@4,8400000/esp@4=
,8800000, regs[fd117000:fd00f000] irq[36]
esp: esp0 is a FAS100A, 40 MHz (ccf=3D0), SCSI ID 7
ESP: tgt[0] lun[0] scsi_cmd [ 12 00 00 00 24 c2 ]
ESP: intr sreg[80] seqreg[00] sreg2[00] ireg[20]
ESP: tgt[1] lun[0] scsi_cmd [ 12 00 00 00 24 c2 ]
ESP: intr sreg[80] seqreg[00] sreg2[00] ireg[20]
ESP: tgt[2] lun[0] scsi_cmd [ 12 00 00 00 24 c2 ]
ESP: intr sreg[80] seqreg[00] sreg2[00] ireg[20]
ESP: tgt[3] lun[0] scsi_cmd [ 12 00 00 00 24 c2 ]
ESP: intr sreg[93] seqreg[00] sreg2[00] ireg[18]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[2] message[0]
ESP: tgt[3] lun[0] scsi_cmd [ 03 00 00 00 fc 00 ]
ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[18]
ESP: start data addr[f0005000] len[252] write(1)
ESP: intr sreg[83] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[1] sent[18]
ESP: intr sreg[87] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[80] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
ESP: tgt[4] lun[0] scsi_cmd [ 12 00 00 00 24 c2 ]
ESP: intr sreg[80] seqreg[04] sreg2[00] ireg[20]
ESP: tgt[5] lun[0] scsi_cmd [ 12 00 00 00 24 c2 ]
ESP: intr sreg[80] seqreg[00] sreg2[00] ireg[20]
ESP: tgt[6] lun[0] scsi_cmd [ 12 00 00 00 24 c2 ]
ESP: intr sreg[80] seqreg[00] sreg2[00] ireg[20]
rtc_sun_init: Registered Mostek RTC driver.
mice: PS/2 mouse device common for all mice
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Freeing unused kernel memory: 148k freed
input: Sun Mouse as /class/input/input0
Red Hat nash version 6.0.6 starting
Mounting proc filesystem
Mounting sysfs filesystem
Creating /dev
Creating initial device nodes
Setting up hotplug.
Creating block device nodes.
Loading jbd.ko module
Loading ext3.ko module
Creating root device.
Mounting root filesystem.
mount: could not find filesystem '/dev/root'
Setting up other filesystems.
Setting up new roKernel panic - not syncing: Attempted to kill init!
Press Stop-A (L1-A) to return to the boot prom
ot fs
setuproot: moving /dev failed: No such file or directory
no fstab.sys, mounting internal defaults
setuproot: error mounting /proc: No such file or directory
setuproot: error mounting /sys: No such file or directory
Switching to new root and running init.
unmounting old /dev
unmounting old /proc
unmounting old /sys
switchroot: mount failed: No such file or directory

Type  'go' to resume
Type  help  for more information
ok=20
--=-9fg3FP7Seywo8VhrVH5f--

