From: Jurij Smakov <jurij@wooyd.org>
Date: Mon, 09 Oct 2006 03:05:49 +0000
Subject: Re: cassini driver failure in 2.6.17
Message-Id: <20061009030549.GA4728@droopy.oc.cox.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 24, 2006 at 11:14:11PM -0700, Jurij Smakov wrote:
> Hi,
> 
> We have a report from a user (CC'd) who tried to install Debian testing 
> with 2.6.17 (including all patches up to 2.6.17.8) kernel onto a B100 
> blade with two cassini ethernet adapters [0]. The installer was 
> successfully netbooted, but an attempt to load the cassini driver later 
> failed with the messages:
> 
>  cassini.c:v1.4 (1 July 2004)
>  cassini: Cannot find proper PCI device base address, aborting.
>  cassini: Cannot find proper PCI device base address, aborting.
> 
> Any help in resolving this issue would be appreciated.

Together with the bug submitter we tried to debug this issue further. 
I've build a modified netboot image, which contained a 2.6.17 kernel 
with some extra debugging output in the PCI probing code. The relevant 
part of the function pci_read_bases() in drivers/pci/probe.c which 
actually gets the memory regions from the card looked like that:

static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, 
int rom)
{
        unsigned int pos, reg, next;
        u32 l, sz;
        struct resource *res;

        for(pos=0; pos<howmany; pos = next) {
                next = pos+1;
                res = &dev->resource[pos];
                res->name = pci_name(dev);
                reg = PCI_BASE_ADDRESS_0 + (pos << 2);
                pci_read_config_dword(dev, reg, &l);
                pr_debug("pci_read_bases: device %s, pos=%u, got l=%lx\n",
                        pci_name(dev), pos, (unsigned long) l);
                pci_write_config_dword(dev, reg, ~0);
                pci_read_config_dword(dev, reg, &sz);
                pr_debug("pci_read_bases: device %s, pos=%u, got sz=%lx\n",
                        pci_name(dev), pos, (unsigned long) sz);
                pci_write_config_dword(dev, reg, l);
                if (!sz || sz == 0xffffffff)
                        continue;
                if (l == 0xffffffff)
                        l = 0;
                if ((l & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_MEMORY) {
                        sz = pci_size(l, sz, (u32)PCI_BASE_ADDRESS_MEM_MASK);
                        pr_debug("  memory: device %s, pos=%u, sz=%lx\n",
                                pci_name(dev), pos, (unsigned long) sz);
                        if (!sz)
                                continue;
                        res->start = l & PCI_BASE_ADDRESS_MEM_MASK;
                        res->flags |= l & ~PCI_BASE_ADDRESS_MEM_MASK;
                        pr_debug("  memory: device %s, pos=%u, start=%lx, flags=%lx\n", pc
i_name(dev), pos, (unsigned long) res->start, (unsigned long) res->flags);

For the cassini cards the dmesg output looked like that:

PCI: Found 0000:00:0a.0 [108e/abba] 000200 00
pci_read_bases: device 0000:00:0a.0, pos=0, got l=0
pci_read_bases: device 0000:00:0a.0, pos=0, got sz=0
pci_read_bases: device 0000:00:0a.0, pos=1, got l=0
pci_read_bases: device 0000:00:0a.0, pos=1, got sz=0
pci_read_bases: device 0000:00:0a.0, pos=2, got l=0
pci_read_bases: device 0000:00:0a.0, pos=2, got sz=0
pci_read_bases: device 0000:00:0a.0, pos=3, got l=0
pci_read_bases: device 0000:00:0a.0, pos=3, got sz=0
pci_read_bases: device 0000:00:0a.0, pos=4, got l=0
pci_read_bases: device 0000:00:0a.0, pos=4, got sz=0
pci_read_bases: device 0000:00:0a.0, pos=5, got l=0
pci_read_bases: device 0000:00:0a.0, pos=5, got sz=0
PCI: Found 0000:00:0b.0 [108e/abba] 000200 00
pci_read_bases: device 0000:00:0b.0, pos=0, got l=400000
pci_read_bases: device 0000:00:0b.0, pos=0, got sz=400000
  memory: device 0000:00:0b.0, pos=0, sz=0
pci_read_bases: device 0000:00:0b.0, pos=1, got l=0
pci_read_bases: device 0000:00:0b.0, pos=1, got sz=0
pci_read_bases: device 0000:00:0b.0, pos=2, got l=0
pci_read_bases: device 0000:00:0b.0, pos=2, got sz=0
pci_read_bases: device 0000:00:0b.0, pos=3, got l=0
pci_read_bases: device 0000:00:0b.0, pos=3, got sz=0
pci_read_bases: device 0000:00:0b.0, pos=4, got l=0
pci_read_bases: device 0000:00:0b.0, pos=4, got sz=0
pci_read_bases: device 0000:00:0b.0, pos=5, got l=0
pci_read_bases: device 0000:00:0b.0, pos=5, got sz=0

So the first card returned nothing but zeroes, and the second one 
produces the values, which cause pci_size() to return zero, and again 
we get nothing useful. Do this cards require some special treatment 
before they can be properly initialized by the PCI subsystem?

I am also attaching the complete dmesg output to this message.

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

~ # dmesg
 Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU[0]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)]
E[sz(524288):line_sz(64)]
Using max_cache_size of 512KB
Brought up 1 CPUs
Total of 1 processors activated (11.12 BogoMIPS).
migration_cost=0
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Freeing initrd memory: 2911k freed
NET: Registered protocol family 16
PCI: Probing for controllers.
PCI: Found SABRE, main regs at 000001fe00000000
SABRE: Shared PCI config space at 000001fe01000000
SABRE: DVMA at c0000000 [20000000]
PCI: Scanning bus 0000:00
PCI: Found 0000:00:00.0 [108e/a001] 000600 00
pci_read_bases: device 0000:00:00.0, pos=0, got l=0
pci_read_bases: device 0000:00:00.0, pos=0, got sz=0
pci_read_bases: device 0000:00:00.0, pos=1, got l=0
pci_read_bases: device 0000:00:00.0, pos=1, got sz=0
pci_read_bases: device 0000:00:00.0, pos=2, got l=0
pci_read_bases: device 0000:00:00.0, pos=2, got sz=0
pci_read_bases: device 0000:00:00.0, pos=3, got l=0
pci_read_bases: device 0000:00:00.0, pos=3, got sz=0
pci_read_bases: device 0000:00:00.0, pos=4, got l=0
pci_read_bases: device 0000:00:00.0, pos=4, got sz=0
pci_read_bases: device 0000:00:00.0, pos=5, got l=0
pci_read_bases: device 0000:00:00.0, pos=5, got sz=0
PCI: Found 0000:00:03.0 [10b9/7101] 000000 00
pci_read_bases: device 0000:00:03.0, pos=0, got l=0
pci_read_bases: device 0000:00:03.0, pos=0, got sz=0
pci_read_bases: device 0000:00:03.0, pos=1, got l=0
pci_read_bases: device 0000:00:03.0, pos=1, got sz=0
pci_read_bases: device 0000:00:03.0, pos=2, got l=0
pci_read_bases: device 0000:00:03.0, pos=2, got sz=0
pci_read_bases: device 0000:00:03.0, pos=3, got l=0
pci_read_bases: device 0000:00:03.0, pos=3, got sz=0
pci_read_bases: device 0000:00:03.0, pos=4, got l=0
pci_read_bases: device 0000:00:03.0, pos=4, got sz=0
pci_read_bases: device 0000:00:03.0, pos=5, got l=0
pci_read_bases: device 0000:00:03.0, pos=5, got sz=0
PCI quirk: region 0800-083f claimed by ali7101 ACPI
PCI quirk: region 0600-061f claimed by ali7101 SMB
PCI: Found 0000:00:07.0 [10b9/1533] 000601 00
pci_read_bases: device 0000:00:07.0, pos=0, got l=0
pci_read_bases: device 0000:00:07.0, pos=0, got sz=0
pci_read_bases: device 0000:00:07.0, pos=1, got l=0
pci_read_bases: device 0000:00:07.0, pos=1, got sz=0
pci_read_bases: device 0000:00:07.0, pos=2, got l=0
pci_read_bases: device 0000:00:07.0, pos=2, got sz=0
pci_read_bases: device 0000:00:07.0, pos=3, got l=0
pci_read_bases: device 0000:00:07.0, pos=3, got sz=0
pci_read_bases: device 0000:00:07.0, pos=4, got l=0
pci_read_bases: device 0000:00:07.0, pos=4, got sz=0
pci_read_bases: device 0000:00:07.0, pos=5, got l=0
pci_read_bases: device 0000:00:07.0, pos=5, got sz=0
PCI: Found 0000:00:0a.0 [108e/abba] 000200 00
pci_read_bases: device 0000:00:0a.0, pos=0, got l=0
pci_read_bases: device 0000:00:0a.0, pos=0, got sz=0
pci_read_bases: device 0000:00:0a.0, pos=1, got l=0
pci_read_bases: device 0000:00:0a.0, pos=1, got sz=0
pci_read_bases: device 0000:00:0a.0, pos=2, got l=0
pci_read_bases: device 0000:00:0a.0, pos=2, got sz=0
pci_read_bases: device 0000:00:0a.0, pos=3, got l=0
pci_read_bases: device 0000:00:0a.0, pos=3, got sz=0
pci_read_bases: device 0000:00:0a.0, pos=4, got l=0
pci_read_bases: device 0000:00:0a.0, pos=4, got sz=0
pci_read_bases: device 0000:00:0a.0, pos=5, got l=0
pci_read_bases: device 0000:00:0a.0, pos=5, got sz=0
PCI: Found 0000:00:0b.0 [108e/abba] 000200 00
pci_read_bases: device 0000:00:0b.0, pos=0, got l=400000
pci_read_bases: device 0000:00:0b.0, pos=0, got sz=400000
  memory: device 0000:00:0b.0, pos=0, sz=0
pci_read_bases: device 0000:00:0b.0, pos=1, got l=0
pci_read_bases: device 0000:00:0b.0, pos=1, got sz=0
pci_read_bases: device 0000:00:0b.0, pos=2, got l=0
pci_read_bases: device 0000:00:0b.0, pos=2, got sz=0
pci_read_bases: device 0000:00:0b.0, pos=3, got l=0
pci_read_bases: device 0000:00:0b.0, pos=3, got sz=0
pci_read_bases: device 0000:00:0b.0, pos=4, got l=0
pci_read_bases: device 0000:00:0b.0, pos=4, got sz=0
pci_read_bases: device 0000:00:0b.0, pos=5, got l=0
pci_read_bases: device 0000:00:0b.0, pos=5, got sz=0
PCI: Found 0000:00:0d.0 [10b9/5229] 000101 00
pci_read_bases: device 0000:00:0d.0, pos=0, got l=901
pci_read_bases: device 0000:00:0d.0, pos=0, got sz=fffffff9
  io: device 0000:00:0d.0, pos=0, sz=7
  io: device 0000:00:0d.0, pos=0, start=900, flags=1
  final: device 0000:00:0d.0, pos=0, end=907, flags=101
pci_read_bases: device 0000:00:0d.0, pos=1, got l=919
pci_read_bases: device 0000:00:0d.0, pos=1, got sz=fffffffd
  io: device 0000:00:0d.0, pos=1, sz=3
  io: device 0000:00:0d.0, pos=1, start=918, flags=1
  final: device 0000:00:0d.0, pos=1, end=91b, flags=101
pci_read_bases: device 0000:00:0d.0, pos=2, got l=911
pci_read_bases: device 0000:00:0d.0, pos=2, got sz=fffffff9
  io: device 0000:00:0d.0, pos=2, sz=7
  io: device 0000:00:0d.0, pos=2, start=910, flags=1
  final: device 0000:00:0d.0, pos=2, end=917, flags=101
pci_read_bases: device 0000:00:0d.0, pos=3, got l=909
pci_read_bases: device 0000:00:0d.0, pos=3, got sz=fffffffd
  io: device 0000:00:0d.0, pos=3, sz=3
  io: device 0000:00:0d.0, pos=3, start=908, flags=1
  final: device 0000:00:0d.0, pos=3, end=90b, flags=101
pci_read_bases: device 0000:00:0d.0, pos=4, got l=921
pci_read_bases: device 0000:00:0d.0, pos=4, got sz=fffffff1
  io: device 0000:00:0d.0, pos=4, sz=f
  io: device 0000:00:0d.0, pos=4, start=920, flags=1
  final: device 0000:00:0d.0, pos=4, end=92f, flags=101
pci_read_bases: device 0000:00:0d.0, pos=5, got l=0
pci_read_bases: device 0000:00:0d.0, pos=5, got sz=0
PCI: Fixups for bus 0000:00
PCI: Bus scan for 0000:00 returning with max=00
PCI-IRQ: Routing bus[ 0] slot[ a] to INO[22]
PCI-IRQ: Routing bus[ 0] slot[ b] to INO[23]
PCI-IRQ: Routing bus[ 0] slot[ d] to INO[20]
PCI0(PBMA): Bus running at 33MHz
isa0: [serial] [bscbus -> (bscv) (i2c)] [rtc] [power] [flashprom]
ebus: No EBus's found.
power: Control reg at 000001fe02000800 ... powerd running.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 65536 bytes)
TCP established hash table entries: 32768 (order: 6, 524288 bytes)
TCP bind hash table entries: 16384 (order: 5, 262144 bytes)
TCP: Hash tables configured (established 32768 bind 16384)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1160070139.232:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Activating ISA DMA hang workarounds.
Console: switching to mono PROM 80x34
Real Time Clock Driver v1.12ac
[drm] Initialized drm 1.0.1 20051102
ttyS0 at MMIO 0x1fe020003f8 (irq = 7590784) is a 16550A
Console: ttyS0 (SU)
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
usbmon: debugfs is not available
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
cassini.c:v1.4 (1 July 2004)
cassini: Cannot find proper PCI device base address, aborting.
cassini: Cannot find proper PCI device base address, aborting.

--PNTmBPCT7hxwcZjr--
