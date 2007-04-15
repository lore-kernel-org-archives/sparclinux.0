From: "Adam Kropelin" <akropel1@rochester.rr.com>
Date: Sun, 15 Apr 2007 16:03:26 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <045101c77f77$9a3c3020$84163e05@kroptech.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller wrote:
> Thanks in advance for testing.

I've given the new driver a run on my U1. A bit of history before the=20
results: 2.6.13 (aurora 2.0) esp driver works well on this machine.=20
However, 2.6.20 stock does not: it dies with DMA errors after=20
(correctly) identifying the disks. (I can get the exact errors, if=20
they're useful.) So this was my motivation for trying the new esp.

I patched 2.6.20 with...
    - [SPARC64]: Fix SBUS IOMMU allocation code
    - [SCSI]: Fix scsi_send_eh_cmnd scatterlist handling
    - new esp driver
    - esp_enable_interrupts "I need my head examined" patch

I hit a small build glitch: Wwith the new driver, the combination...
    CONFIG_SCSI_SPI_ATTRS=3Dm
    CONFIG_SCSI_SUNESP=3Dy
...gives...
      LD      .tmp_vmlinux1
    drivers/built-in.o: In function `esp_slave_configure':
    esp.c:(.text+0x7aadc): undefined reference to `spi_dv_device'
    drivers/built-in.o: In function `esp_setsync':
    esp.c:(.text+0x7c2e4): undefined reference to=20
`spi_display_xfer_agreement'
    drivers/built-in.o: In function `esp_init':
    esp.c:(.init.text+0x5490): undefined reference to=20
`spi_attach_transport'
    esp.c:(.init.text+0x54c4): undefined reference to=20
`spi_release_transport'
    make: *** [.tmp_vmlinux1] Error 1

Switching to...
    CONFIG_SCSI_SPI_ATTRS=3Dy
 ...cures that.

Booting with the new driver I see very similar behavior to 2.6.20 stock:=20
Devices are correctly identified, then DMA errors kick in. I suppose=20
this is interesting because it implies the breakage between 2.6.13 and=20
2.6.20 may have been outside the esp driver itself. Full dmesg with=20
esp.esp_debug 47 is below. There is a single target on the bus at id=20
1. Although I haven't tried it with the new esp, previously moving the=20
target to different ids and adding/removing targets had no effect.

--Adam

Allocated 8 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 2.6.20
Loading initial ramdisk (3781384 bytes at 0x30800000 phys, 0x40C00000=20
virt)...
Remapping the kernel... done.
Booting Linux...
PROMLIB: Sun IEEE Boot Prom 'OBP 3.35.0 2004/04/19 12:15'
PROMLIB: Root node compatible:
Linux version 2.6.20 (adk0212@ultra60) (gcc version 4.1.1 20061011 (Red=20
Hat 4.1.1-30)) #4 Sun Apr 15 07:37:02 EDT 2007
ARCH: SUN4U
Ethernet address: 08:00:20:89:e7:a2
PROM: Built device tree with 32323 bytes of memory.
CPU[0]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)]=20
E[sz(524288):line_sz(64)]
Built 1 zonelists.  Total pages: 31007
Kernel command line: ro root=3D/dev/sda4 esp.esp_debug 47
PID hash table entries: 1024 (order: 10, 8192 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 4, 131072 bytes)
Memory: 251312k available (2360k kernel code, 864k data, 152k init)=20
[fffff80000000000,0000000033f4c000]
Calibrating delay using timer specific routine.. 286.29 BogoMIPS=20
(lpjW2583)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing for controllers.
SCSI subsystem initialized
SYSIO: UPA portID 1f, at 000001fe00000000
sbus0: Clock 25.0 MHz
dma0: Revision 2
dma1: Revision 2
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
AUXIO: Found device at /sbus@1f,0/auxio@f,1900000
/sbus@1f,0/eeprom@f,1200000: Clock regs at 000001fff1200000
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 16384 bytes)
TCP established hash table entries: 8192 (order: 3, 65536 bytes)
TCP bind hash table entries: 4096 (order: 2, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 3692k freed
audit: initializing netlink socket (disabled)
audit(1176648301.744:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Console: switching to colour frame buffer device 144x56
/sbus@1f,0/cgsix@2,0: CGsix [TGX+ sparc] at 0:1ff20000000
[drm] Initialized drm 1.1.0 20060810
f005a290: ttyS0 at MMIO 0x1fff1100000 (irq =3D 9) is a zs
Console: ttyS0 (SunZilog zs0)
f005a290: ttyS1 at MMIO 0x1fff1100004 (irq =3D 9) is a zs
f005b730: Keyboard at MMIO 1fff1000000 (irq =3D 9) is a zs
f005b730: Mouse at MMIO 1fff1000004 (irq =3D 9) is a zs
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes; override with=20
idebus=3Dxx
ide-floppy driver 0.99.newide
scsi0 : esp
esp: esp0 found at /sbus@1f,0/espdma@e,8400000/esp@e,8800000,=20
regs[1ffe8800000:1ffe8400000] irq[10]
esp: esp0 is a FAS100A, 40 MHz (ccf=3D0), SCSI ID 7
ESP: tgt[0] lun[0] scsi_cmd [ 12 00 00 00 24 00 ]
ESP: intr sreg[80] seqreg[00] sreg2[00] ireg[20]
ESP: tgt[1] lun[0] scsi_cmd [ 12 00 00 00 24 00 ]
ESP: intr sreg[91] seqreg[00] sreg2[00] ireg[18]
ESP: start data addr[c00051e0] len[36] write(1)
ESP: intr sreg[93] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[1] sent[36]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
ESP: tgt[1] lun[0] scsi_cmd [ 12 00 00 00 2e 00 ]
ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[18]
ESP: start data addr[c00071e0] len[46] write(1)
ESP: intr sreg[93] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[1] sent[46]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
scsi 0:0:1:0: Direct-Access     FUJITSU  MAJ3182M SUN18G  0804 PQ: 0=20
ANSI: 2
 target0:0:1: Beginning Domain Validation
ESP: tgt[1] lun[0] scsi_cmd [ 12 00 00 00 2e 00 ]
ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[18]
ESP: start data addr[c0008000] len[46] write(1)
ESP: intr sreg[93] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[1] sent[46]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
ESP: tgt[1] lun[0] scsi_cmd [ 12 00 00 00 2e 00 ]
ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[18]
ESP: start data addr[c000a02e] len[46] write(1)
ESP: intr sreg[93] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[1] sent[46]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
ESP: tgt[1] lun[0] scsi_cmd [ 12 00 00 00 2e 00 ]
ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[18]
ESP: start data addr[c000c02e] len[46] write(1)
ESP: intr sreg[93] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[1] sent[46]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
ESP: tgt[1] lun[0] scsi_cmd [ 12 00 00 00 2e 00 ]
ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[18]
ESP: start data addr[c000e02e] len[46] write(1)
ESP: intr sreg[93] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[1] sent[46]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
ESP: tgt[1] lun[0] scsi_cmd [ 12 00 00 00 2e 00 ]
ESP: intr sreg[96] seqreg[04] sreg2[00] ireg[18]
ESP: Sending message [ 01 03 01 19 0f ]
ESP: intr sreg[97] seqreg[01] sreg2[00] ireg[10]
ESP: intr sreg[97] seqreg[01] sreg2[00] ireg[08]
ESP: Got msgin byte 1
ESP: intr sreg[97] seqreg[01] sreg2[00] ireg[10]
ESP: intr sreg[97] seqreg[01] sreg2[00] ireg[08]
ESP: Got msgin byte 3
ESP: intr sreg[97] seqreg[01] sreg2[00] ireg[10]
ESP: intr sreg[97] seqreg[01] sreg2[00] ireg[08]
ESP: Got msgin byte 1
ESP: intr sreg[97] seqreg[01] sreg2[00] ireg[10]
ESP: intr sreg[97] seqreg[01] sreg2[00] ireg[08]
ESP: Got msgin byte 19
ESP: intr sreg[97] seqreg[01] sreg2[00] ireg[10]
ESP: intr sreg[97] seqreg[01] sreg2[00] ireg[08]
ESP: Got msgin byte f
 target0:0:1: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
ESP: intr sreg[92] seqreg[01] sreg2[00] ireg[10]
ESP: intr sreg[91] seqreg[01] sreg2[00] ireg[10]
ESP: start data addr[c001002e] len[46] write(1)
ESP: intr sreg[93] seqreg[01] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[1] sent[46]
ESP: intr sreg[97] seqreg[01] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[01] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
ESP: tgt[1] lun[0] scsi_cmd [ 12 00 00 00 2e 00 ]
ESP: intr sreg[91] seqreg[01] sreg2[00] ireg[18]
ESP: start data addr[c001202e] len[46] write(1)
ESP: intr sreg[93] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[1] sent[46]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
ESP: tgt[1] lun[0] scsi_cmd [ 12 00 00 00 2e 00 ]
ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[18]
ESP: start data addr[c001402e] len[46] write(1)
ESP: intr sreg[93] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[1] sent[46]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
 target0:0:1: Domain Validation skipping write tests
 target0:0:1: Ending Domain Validation
ESP: tgt[1] lun[1] scsi_cmd [ 12 20 00 00 24 00 ]
ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[18]
ESP: start data addr[c00171e0] len[36] write(1)
ESP: intr sreg[93] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[1] sent[36]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
ESP: tgt[1] lun[1] scsi_cmd [ 12 20 00 00 2e 00 ]
ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[18]
ESP: start data addr[c00191e0] len[46] write(1)
ESP: intr sreg[93] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[1] sent[46]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
ESP: tgt[2] lun[0] scsi_cmd [ 12 00 00 00 24 00 ]
ESP: intr sreg[80] seqreg[04] sreg2[00] ireg[20]
ESP: tgt[3] lun[0] scsi_cmd [ 12 00 00 00 24 00 ]
ESP: intr sreg[80] seqreg[00] sreg2[00] ireg[20]
ESP: tgt[4] lun[0] scsi_cmd [ 12 00 00 00 24 00 ]
ESP: intr sreg[80] seqreg[00] sreg2[00] ireg[20]
ESP: tgt[5] lun[0] scsi_cmd [ 12 00 00 00 24 00 ]
ESP: intr sreg[80] seqreg[00] sreg2[00] ireg[20]
ESP: tgt[6] lun[0] scsi_cmd [ 12 00 00 00 24 00 ]
ESP: intr sreg[80] seqreg[00] sreg2[00] ireg[20]
rtc_sun_init: Registered Mostek RTC driver.
usbmon: debugfs is not available
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
input: Sun Mouse as /class/input/input0
Red Hat nash version 6.0.8 starting
Mounting proc filesystem
Mounting sysfs filesystem
Creating /dev
Creating initial device nodes
Setting up hotplug.
Creating block device nodes.
Loading sd_mod.ko module
ESP: tgt[1] lun[0] scsi_cmd [ 00 00 00 00 00 00 ]
ESP: intr sreg[93] seqreg[00] sreg2[00] ireg[18]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[2] message[0]
ESP: tgt[1] lun[0] scsi_cmd [ 03 00 00 00 fc 00 ]
ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[18]
ESP: start data addr[c0024000] len[252] write(1)
ESP: intr sreg[83] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[1] sent[48]
ESP: intr sreg[87] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[80] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
ESP: tgt[1] lun[0] scsi_cmd [ 00 00 00 00 00 00 ]
ESP: intr sreg[93] seqreg[04] sreg2[00] ireg[18]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
ESP: tgt[1] lun[0] scsi_cmd [ 25 00 00 00 00 00 00 00 00 00 ]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[18]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: Got msgin byte 4
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Disconnecting tgt[1] tag[20:0]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[0c]
ESP: reconnect tag, IRQ(0:10:97), IRQ2(1:8:97) tag[20:0]
ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[10]
ESP: start data addr[c0027c80] len[8] write(1)
ESP: intr sreg[93] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[1] sent[8]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
SCSI device sda: 35378533 512-byte hdwr sectors (18114 MB)
ESP: tgt[1] lun[0] scsi_cmd [ 1a 00 3f 00 04 00 ]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[18]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: Got msgin byte 4
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Disconnecting tgt[1] tag[20:0]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[0c]
ESP: reconnect tag, IRQ(0:10:97), IRQ2(1:8:91) tag[20:0]
ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[10]
ESP: start data addr[c0029c80] len[4] write(1)
ESP: intr sreg[93] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[1] sent[4]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
sda: Write Protect is off
ESP: tgt[1] lun[0] scsi_cmd [ 1a 00 08 00 04 00 ]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[18]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: Got msgin byte 4
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Disconnecting tgt[1] tag[20:0]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[0c]
ESP: reconnect tag, IRQ(0:10:97), IRQ2(1:8:97) tag[20:0]
ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[10]
ESP: start data addr[c002bc80] len[4] write(1)
ESP: intr sreg[93] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[1] sent[4]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
ESP: tgt[1] lun[0] scsi_cmd [ 1a 00 08 00 20 00 ]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[18]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: Got msgin byte 4
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Disconnecting tgt[1] tag[20:0]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[0c]
ESP: reconnect tag, IRQ(0:10:97), IRQ2(1:8:97) tag[20:0]
ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[10]
ESP: start data addr[c002dc80] len[32] write(1)
ESP: intr sreg[93] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[1] sent[32]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
SCSI device sda: write cache: disabled, read cache: enabled, supports=20
DPO and FUA
ESP: tgt[1] lun[0] scsi_cmd [ 00 00 00 00 00 00 ]
ESP: intr sreg[93] seqreg[04] sreg2[00] ireg[18]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
ESP: tgt[1] lun[0] scsi_cmd [ 25 00 00 00 00 00 00 00 00 00 ]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[18]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: Got msgin byte 4
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Disconnecting tgt[1] tag[20:0]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[0c]
ESP: reconnect tag, IRQ(0:10:97), IRQ2(1:8:97) tag[20:0]
ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[10]
ESP: start data addr[c002fc80] len[8] write(1)
ESP: intr sreg[93] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[1] sent[8]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
SCSI device sda: 35378533 512-byte hdwr sectors (18114 MB)
ESP: tgt[1] lun[0] scsi_cmd [ 1a 00 3f 00 04 00 ]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[18]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: Got msgin byte 4
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Disconnecting tgt[1] tag[20:0]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[0c]
ESP: reconnect tag, IRQ(0:10:97), IRQ2(1:8:91) tag[20:0]
ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[10]
ESP: start data addr[c0031c80] len[4] write(1)
ESP: intr sreg[93] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[1] sent[4]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
sda: Write Protect is off
ESP: tgt[1] lun[0] scsi_cmd [ 1a 00 08 00 04 00 ]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[18]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: Got msgin byte 4
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Disconnecting tgt[1] tag[20:0]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[0c]
ESP: reconnect tag, IRQ(0:10:97), IRQ2(1:8:91) tag[20:0]
ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[10]
ESP: start data addr[c0033c80] len[4] write(1)
ESP: intr sreg[93] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[1] sent[4]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
ESP: tgt[1] lun[0] scsi_cmd [ 1a 00 08 00 20 00 ]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[18]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: Got msgin byte 4
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Disconnecting tgt[1] tag[20:0]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[0c]
ESP: reconnect tag, IRQ(0:10:97), IRQ2(1:8:97) tag[20:0]
ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[10]
ESP: start data addr[c0035c80] len[32] write(1)
ESP: intr sreg[93] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[1] sent[32]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
SCSI device sda: write cache: disabled, read cache: enabled, supports=20
DPO and FUA
 sda:ESP: tgt[1] lun[0] scsi_cmd [ 28 00 00 00 00 00 00 00 10 00 ]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[18]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: Got msgin byte 4
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Disconnecting tgt[1] tag[20:0]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[0c]
ESP: reconnect tag, IRQ(0:10:97), IRQ2(1:8:97) tag[20:0]
ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[10]
ESP: start data addr[c0036000] len[8192] write(1)
ESP: intr sreg[93] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[1] sent[8192]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
 sda1 sda2 sda3 sda4
sd 0:0:1:0: Attached scsi disk sda
Loading uhci-hcd.ko module
USB Universal Host Controller Interface driver v3.0
end_request: I/O error, dev fd0, sector 0
Loading jbd.ko module
Loading ext3.ko module
Loading sym53c8xx.ko module
CreatiESP: tgt[1] lun[0] scsi_cmd [ 28 00 02 1b cf 80 00 00 10 00 ]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[18]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: Got msgin byte 4
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Disconnecting tgt[1] tag[20:0]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[0c]
ESP: reconnect tag, IRQ(0:10:97), IRQ2(1:8:91) tag[20:0]
ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[10]
ESP: start data addr[c0038000] len[8192] write(1)
ESP: intr sreg[93] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[1] sent[8192]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Command done status[0] message[0]
nESP: tgt[1] lun[0] scsi_cmd [ 28 00 00 13 20 00 00 00 90 00 ]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[18]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
ESP: Got msgin byte 4
ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
ESP: Disconnecting tgt[1] tag[20:0]
ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[0c]
ESP: reconnect tag, IRQ(0:10:97), IRQ2(1:8:97) tag[20:0]
ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[10]
ESP: start data addr[c003a000] len[65536] write(1)
g root ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[10]
ESP: data done csr[a6400310] flgs[1] sent[73728]
ESP: start data addr[c004c000] len[0] write(1)
esp: esp0: DMA error, csr=A440031e
esp: esp0: DMA error, csr=A440031e
esp: esp0: DMA error, csr=A440031e
esp: esp0: DMA error, csr=A440031e
esp: esp0: DMA error, csr=A440031e
esp: esp0: DMA error, csr=A440031e
esp: esp0: DMA error, csr=A440031e
<...continues...>

