From: Jason Wever <weeve@gentoo.org>
Date: Sun, 19 Feb 2006 17:17:01 +0000
Subject: possible spinlock/esp bug in 2.6.16-rc4
Message-Id: <20060219101701.6f2ce579@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_K0eaRp.qMKvZqwEuF9mhlS0"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

--Sig_K0eaRp.qMKvZqwEuF9mhlS0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi All,

Getting the below on an Ultra 1 when booting 2.6.16-rc4.  Any ideas?  This =
box works fine using 2.4 kernels, and has worked before in 2.6 (though it i=
s susceptible to what appear to be the same the I/O lockup issues on the Ul=
tra 2s).


Allocated 8 Megs of memory at 0x40000000 for kernel
Loaded kernel version 2.6.16

Remapping the kernel... done.
Registering callbacks... done.
Booting Linux...
PROMLIB: Sun IEEE Boot Prom 3.35.0 2004/04/19 12:15
Linux version 2.6.16-rc4 (root@saratoga) (gcc version 3.4.5 (Gentoo
Linux 3.4.5)) #1 Sat Feb 18 21:18:33 MST 2006 ARCH: SUN4U
Ethernet address: 08:00:20:80:5c:3e
Allocated 466944 bytes for kernel page tables.
CPU[0]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)]
E[sz(524288):line_sz(64)] Built 1 zonelists
Kernel command line: root=3D/dev/sda1
PID hash table entries: 2048 (order: 11, 65536 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 5, 262144 bytes)
Memory: 445768k available (1968k kernel code, 752k data, 104k init)
[fffff80000000000,000000003ff4a000] Mount-cache hash table entries: 512
NET: Registered protocol family 16
SCSI subsystem initialized
SYSIO: UPA portID 1f, at 000001fe00000000
sbus0: Clock 25.0 MHz
dma0: Revision 2
dma1: Revision 2
dma2: HME DVMA gate array
Total HugeTLB memory allocated, 0
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Console: switching to colour frame buffer device 144x56
cg6: CGsix [GX+ 68020] at 1ff:20000000
zs2 at 0x000001fff1000004 (irq =3D 12,7e8) is a SunZilog
zs3 at 0x000001fff1000000 (irq =3D 12,7e8) is a SunZilog
Console: ttyS0 (SunZilog zs0)
ttyS0 at MMIO 0x0 (irq =3D 7194944) is a SunZilog
ttyS1 at MMIO 0x0 (irq =3D 7194944) is a SunZilog
loop: loaded (max 8 devices)
sunhme.c:v2.02 8/24/03 David S. Miller (davem@redhat.com)
eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:80:5c:3e
esp0: IRQ 4,7e0 SCSI ID 7 Clk 40MHz CCYC=3D25000 CCF=3D8 TOut 167
NCR53C9XF(espfast) esp1: IRQ 7,7c3 SCSI ID 7 Clk 40MHz CCYC=3D25000 CCF=3D8
TOut 167 NCR53C9XF(espfast) ESP: Total of 2 ESP hosts found, 2 actually
in use. scsi0 : Sparc ESP100A-FAST
  Vendor: SEAGATE   Model: ST39102LCSUN9.0G  Rev: 0828
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: XM-5401TASUN4XCD  Rev: 1036
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi1 : Sparc ESP366-HME
esp0: target 1 [period 100ns offset 15 10.00MHz FAST SCSI-II]
SCSI device sda: 17689267 512-byte hdwr sectors (9057 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back w/ FUA
SCSI device sda: 17689267 512-byte hdwr sectors (9057 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back w/ FUA
 sda: sda1 sda2 sda3
sd 0:0:1:0: Attached scsi disk sda
esp0: target 6 asynchronous
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20
sd 0:0:1:0: Attached scsi generic sg0 type 0
sr 0:0:6:0: Attached scsi generic sg1 type 5
rtc_sun_init: Registered Mostek RTC driver.
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 32768 bytes)
TCP established hash table entries: 16384 (order: 5, 393216 bytes)
TCP bind hash table entries: 16384 (order: 6, 524288 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
input: Sun Mouse as /class/input/input0
INIT: version 2.86 booting
esp0: Aborting command
esp0: dumping state
esp0: dma -- cond_reg<a6400311> addr<c7ffc002>
esp0: SW [sreg<13> sstep<04> ireg<10>]
esp0: HW reread [sreg<97> sstep<cc> ireg<08>]
esp0: current command [tgt<01> lun<00> pphase<STATUS> cphase<STATUS>]
esp0: disconnected
esp0: Aborting command
esp0: dumping state
esp0: dma -- cond_reg<a6400310> addr<c7ffc002>
esp0: SW [sreg<13> sstep<04> ireg<10>]
esp0: HW reread [sreg<17> sstep<cc> ireg<00>]
esp0: current command [tgt<01> lun<00> pphase<UNISSUED>
cphase<UNISSUED>] esp0: disconnected
esp0: Resetting scsi bus
BUG: spinlock already unlocked on CPU#0, scsi_eh_0/633
 lock: fffff8003fc3d060, .magic: dead4ead, .owner:
<none>/-1, .owner_cpu: -1 Call Trace:
 [000000000051aef4] _raw_spin_unlock+0x50/0xb4
 [00000000005ecf00] _spin_unlock_irq+0x10/0x24
 [00000000005655dc] esp_reset+0x28/0xc8
 [0000000000559828] scsi_try_bus_reset+0x38/0xc8
 [000000000055a8f4] scsi_error_handler+0x5ec/0x9bc
 [000000000044631c] kthread+0xbc/0xf0
 [000000000040f7a8] kernel_thread+0x3c/0x54
 [000000000044636c] keventd_create_kthread+0x1c/0x6c


--=20
Jason Wever
Gentoo/Sparc Team Co-Lead

--Sig_K0eaRp.qMKvZqwEuF9mhlS0
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFD+KgQdKvgdVioq28RAukUAJ42+WZ+q4z4SiopwcQAXEsUmh0H5gCcCl1o
tzGWaFJx8Gr2OH7YCmAXkGg=
=pI+n
-----END PGP SIGNATURE-----

--Sig_K0eaRp.qMKvZqwEuF9mhlS0--
