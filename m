From: Meelis Roos <mroos@linux.ee>
Date: Mon, 31 Jul 2006 12:43:22 +0000
Subject: serial console broken on Ultra 5
Message-Id: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Just tried 2.6.18-rc3 on my Ultra 5 using serial console. It hangs after 
telling ttyS0 is the console. No response to break either, and booting 
with -p does not give anythig more.

PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:36'
PROMLIB: Root node compatible:
Linux version 2.6.18-rc3 (mroos@mandariin) (gcc version 4.1.2 20060715 (prerelease) (Debian 4.1.1-9)) #137 Mon Jul 31 15:09:20o6
ARCH: SUN4U
Ethernet address: 08:00:20:f8:c7:72
PROM: Built device tree with 41786 bytes of memory.
CPU[0]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)] E[sz(262144):line_sz(64)]
Built 1 zonelists.  Total pages: 40377
Kernel command line: root=/dev/hda1 ro
PID hash table entries: 2048 (order: 11, 16384 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 5, 262144 bytes)
Memory: 319584k available (2288k kernel code, 1072k data, 128k init) [fffff80000000000,0000000013f42000]
Calibrating delay using timer specific routine.. 720.46 BogoMIPS (lpj40924)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing for controllers.
/pci@1f,0/pci@1,1: SABRE PCI Bus Module
/pci@1f,0/pci@1: SABRE PCI Bus Module
PCI0(PBMA): Bus running at 33MHz
PCI0(PBMB): Bus running at 33MHz
ebus0: [auxio] [power] [SUNW,pll] [se] [su] [su] [ecpp] [fdthree] 
[eeprom] [flashprom] [SUNW,CS4231]
power: Control reg at 1fff1724000 ... powerd running.
AUXIO: Found device at /pci@1f,0/pci@1,1/ebus@1/auxio@14,726000
/pci@1f,0/pci@1,1/ebus@1/eeprom@14,0: Clock regs at 000001fff1000000
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 32768 bytes)
TCP established hash table entries: 16384 (order: 5, 393216 bytes)
TCP bind hash table entries: 8192 (order: 5, 262144 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
rtc_init: no PC rtc found
/pci@1f,0/pci@1,1/ebus@1/su@14,3083f8: Keyboard port at 1fff13083f8, irq 6
/pci@1f,0/pci@1,1/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8, irq 7
se@14,400000: ttyS0 at MMIO 0x1fff1400000 (irq = 5) is a SAB82532 V3.2
Console: ttyS0 (SAB82532)


-- 
Meelis Roos (mroos@linux.ee)
