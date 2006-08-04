From: Daniel Smolik <marvin@mydatex.cz>
Date: Fri, 04 Aug 2006 20:08:48 +0000
Subject: Re: serial console broken on Ultra 5
Message-Id: <44D3A950.9070800@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Marc Zyngier napsal(a):
>>>>>>"Daniel" = Daniel Smolik <marvin@mydatex.cz> writes:
> 
> 
> Daniel> Console: switching to mono PROM 80x34
> Daniel> /pci@1f,4000/ebus@1/su@14,3083f8: Keyboard port at 1fff13083f8, irq 9
> Daniel> /pci@1f,4000/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8, irq 10
> Daniel> se@14,400000: ttyS0 at MMIO 0x1fff1400000 (irq = 7) is a SAB82532 V3.2
> Daniel> Console: ttyS2 (SAB82532)
> Daniel> SUNSAB baud:115200 quot:0
> Daniel> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^this is added by me  as you want.
> 
> Ok, that's indeed what I suspected... Looks like the RSC setting have
> some adverse effect on the uart_get_divisor() logic.
> 
> I'll try to give it a look.
> 
> Thanks for the report,
> 
> 	M.
There is kernel compiled with gcc-4.0.
Dan



Loaded kernel version 2.6.18

PROMLIB: Sun IEEE Boot Prom 'OBP 3.30.0 2003/11/11 10:37'
PROMLIB: Root node compatible: sun4u
Linux version 2.6.18-rc3 (root@sunik) (gcc version 4.0.4 20060730 (prerelease) ( 
              Debian 4.0.3-6)) #3 Fri Aug 4 21:46:49 CEST 2006
ARCH: SUN4U
Ethernet address: 08:00:20:c4:0d:36
Remapping the kernel... done.
PROM: Built device tree with 71570 bytes of memory.
Booting Linux...
CPU[0]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)] E[sz(2097152):l 
              ine_sz(64)]
Built 1 zonelists.  Total pages: 64967
Kernel command line: root=/dev/sdb1 ro video=pm2fb:mode:800x600-60,font:SUN12x22 
              ,ypan devfs=nomount elevator=anticipatory -p
PID hash table entries: 2048 (order: 11, 16384 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 5, 262144 bytes)
Memory: 514528k available (2032k kernel code, 672k data, 128k init) [fffff800000 
              00000,000000001feb0000]
Calibrating delay using timer specific routine.. 800.26 BogoMIPS (lpj@01343)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing for controllers.
Console: switching to mono PROM 80x34
/pci@1f,4000/ebus@1/su@14,3083f8: Keyboard port at 1fff13083f8, irq 9
/pci@1f,4000/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8, irq 10
se@14,400000: ttyS0 at MMIO 0x1fff1400000 (irq = 7) is a SAB82532 V3.2
Console: ttyS2 (SAB82532)                                      \|/ ____ \|/ 

               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
swapper(1): TL0: Kernel divide by zero. [#1]
TSTATE: 0000000080f01606 TPC: 0000000000557864 TNPC: 0000000000557868 Y: 0000000 
              0    Not tainted 

TPC: <sunsab_convert_to_sab+0x18c/0x240>
g0: 0000000000000000 g1: 0000000000000000 g2: 0000000000000056 g3: 0000000000000 
              000 

g4: fffff8001fe819e0 g5: 0000000000000000 g6: fffff8001fd80000 g7: 0000000000000 
              000 

o0: fffff8001fe6c5b0 o1: 0000000000001cb2 o2: 0000000000000000 o3: 0000000000660 
              c00 

o4: 0000000000000001 o5: 0000000000660eb8 sp: fffff8001fd82dc1 ret_pc: 000000000 
              05576f0 

RPC: <sunsab_convert_to_sab+0x18/0x240>
l0: fffff8001fe6c660 l1: ffffffffffffffff l2: 0000000000431c00 l3: 0000000000000 
              000
l4: 0000000000000000 l5: fffff8001fa6fe60 l6: 0000000000000000 l7: 0000000000000 
              008
i0: fffff8001fe6c5b0 i1: 0000000000001cb2 i2: 0000000000000000 i3: 000000000001c 
              200
i4: 0000000000000000 i5: fffff8001fa71748 i6: fffff8001fd82e81 i7: 0000000000558 
              cc4
I7: <sunsab_console_setup+0x10c/0x1c0>
Caller[0000000000558cc4]: sunsab_console_setup+0x10c/0x1c0
Caller[000000000044dce4]: register_console+0x20c/0x280
Caller[00000000005532a8]: uart_add_one_port+0x290/0x2e0
Caller[0000000000557cec]: sab_probe+0xb4/0xe0
Caller[00000000004292a8]: of_device_probe+0x50/0x80
Caller[000000000055b4e0]: driver_probe_device+0x48/0xe0
Caller[000000000055b5e0]: __driver_attach+0x68/0x80
Caller[000000000055a7dc]: bus_for_each_dev+0x44/0x80
Caller[000000000055ad08]: bus_add_driver+0x70/0x140
Caller[0000000000416f64]: init+0x8c/0x2e0
Caller[0000000000417f50]: kernel_thread+0x38/0x60
Caller[0000000000416e50]: rest_init+0x18/0x40
Instruction DUMP: 90100018  93366000  81802000 <9470400a> 7fffe99e  9532a000  c2 
              0e20d0  90102004  920620b0
Kernel panic - not syncing: Attempted to kill init!
  <0>Press Stop-A (L1-A) to return to the boot prom


SUNSAB baud:115200 quot:0
