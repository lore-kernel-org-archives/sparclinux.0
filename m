From: Bernd Zeimetz <bernd@bzed.de>
Date: Thu, 06 Dec 2007 12:09:18 +0000
Subject: Re: Fix for sparc64 cpu hangs.
Message-Id: <4757E66E.10101@bzed.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20071106.203433.144763156.davem@davemloft.net>
In-Reply-To: <20071106.203433.144763156.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: Bernd Zeimetz <bernd@bzed.de>
> Date: Thu, 06 Dec 2007 11:43:45 +0100
> 
>> David Miller wrote:
>>> From: Bernd Zeimetz <bernd@bzed.de>
>>> Date: Fri, 16 Nov 2007 22:17:07 +0100
>>>
>>>> The sysrq-g output is attached, I hope you can make sense out of it.
>>>> We'll also add some extra workload to the other machines here to try to
>>>> trigger the bug on other CPUs, too.
>>> I just got back from my vacation and started looking at these
>>> dumps.  I think there might be some bug in cheetah_xcall_deliver(),
>>> I'll try to diagnose this some more.
>> I'm not sure if it is related, but non-SMP Kernels don't boot at all on
>> the machine.
> 
> I doubt it's related as non-SMP kernels won't even have that
> code compiled in :-)
> What does a failed non-SMP boot say?  If it doesn't even bring up the
> console, give it "-p" on the kernel command line.


That's from a 2.6.21-2-sparc64, had the output lying around here. I can
build and install a 2.6.23 and try it again if you want. It would be
good to know if non-SMP kernels work at all on the v880 and larger
machines, same for more recent CPU models - at the moment the Sparc
installer is non-SMP only, which resulted in some extra fun to install
the v880.


Rebooting with command: boot net:dhcp -p
Boot device: /pci@9,700000/network@1,1:dhcp  File and args: -p
Timed out waiting for BOOTP/DHCP reply
\
PROMLIB: Sun IEEE Boot Prom 'OBP 4.22.34 2007/07/23 13:01'
PROMLIB: Root node compatible:
Linux version 2.6.21-2-sparc64 (Debian 2.6.21-6) (waldi@debian.org) (gcc
version 4.1.3 20070629 (prerelease) (Debian 4.1.2
-13)) #1 Thu Jul 12 12:33:00 UTC 2007
ARCH: SUN4U
Ethernet address: 00:03:ba:0b:07:89
Remapping the kernel... done.
PROM: Built device tree with 125090 bytes of memory.
Booting Linux...
CPU[0]: Caches D[sz(65536):line_sz(32)] I[sz(32768):line_sz(32)]
E[sz(8388608):line_sz(512)]
Built 1 zonelists.  Total pages: 412546
Kernel command line: -p
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 524288 (order: 9, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 8, 2097152 bytes)
Memory: 8311800k available (2360k kernel code, 824k data, 144k init)
[fffff80000000000,000000b0ffb16000]
Calibrating delay using timer specific routine.. 20.00 BogoMIPS
(lpj@009)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing for controllers.
/pci@8,700000: SCHIZO PCI Bus Module ver[4:0]
/pci@8,700000: PCI CFG[7ffee000000] IO[7ffef000000] MEM[7fe00000000]
/pci@8,600000: SCHIZO PCI Bus Module ver[4:0]
/pci@8,600000: PCI CFG[7ffec000000] IO[7ffed000000] MEM[7fd00000000]
/pci@9,700000: SCHIZO PCI Bus Module ver[4:0]
/pci@9,700000: PCI CFG[7ffea000000] IO[7ffeb000000] MEM[7fc00000000]
/pci@9,600000: SCHIZO PCI Bus Module ver[4:0]
/pci@9,600000: PCI CFG[7ffe8000000] IO[7ffe9000000] MEM[7fb00000000]
PCI1(PBMB): Bus running at 33MHz
PCI1(PBMA): Bus running at 66MHz
PCI0(PBMB): Bus running at 33MHz
PCI0(PBMA): Bus running at 66MHz
ebus0: [flashprom] [bbc] [power] [i2c -> (fru) (fru) (fru) (fru) (fru)
(fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru)
(fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru)
(fru) (fru) (fru) (fru) (fru) (fru) (fru) (temperature) (temperature)
(temperature) (temperature) (temperature) (temperature) (temperature)]
[i2c -> (controller) (smbus-ara) (controller) (temperature)
(temperature) (temperature) (ioexp) (temperature) (controller) (adio)
(adio) (ioexp) (ioexp) (ioexp) (ioexp) (ioexp) (ioexp) (ioexp) (adio)
(adio) (adio) (adio) (temperature-sensor) (fru) (fru) (fru) (fru) (fru)
(fru) (rscrtc) (hotplug-controller) (hotplug-controller)
(hotplug-controller) (hotplug-controller)] [bbc] [i2c -> (temperature)
(temperature) (temperature)] [i2c -> (nvram) (idprom)] [rtc] [gpio]
[pmc] [rsc-control] [rsc-console] [serial]
power: Control reg at 7fc7e30002e ... not using powerd.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
/pci@9,700000/ebus@1/rtc@1,300070: Clock regs at 000007fc7e300070
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 7, 1048576 bytes)
TCP established hash table entries: 524288 (order: 10, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 6, 524288 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 3238k freed
/memory-controller@0,400000: US3 memory controller at 0000040000400000
[ACTIVE]
/memory-controller@1,400000: US3 memory controller at 0000040000c00000
[ACTIVE]
/memory-controller@2,400000: US3 memory controller at 0000040001400000
[ACTIVE]
ERROR(0): Cheetah error trap taken afsr[0000100000000000]
afar[0000040001c00000] TL1(0)
ERROR(0): TPC[4351dc] TNPC[4351e0] O7[4353b4] TSTATE[80001606]
ERROR(0): TPC<interpret_one_decode_reg+0x0/0xfc>
ERROR(0): M_SYND(0),  E_SYND(0)
ERROR(0): Highest priority error (0000100000000000) "Unmapped error from
system bus"
ERROR(0): D-cache idx[0] tag[0000000000000000] utag[0000000000000000]
stag[0000000000000000]
ERROR(0): D-cache data0[0000000000000000] data1[0000000000000000]
data2[0000000000000000] data3[0000000000000000]
ERROR(0): I-cache idx[0] tag[0000000000000000] utag[0000000000000000]
stag[0000000000000000] u[0000000000000000] l[0000000000000000]
ERROR(0): I-cache INSN0[0000000000000000] INSN1[0000000000000000]
INSN2[0000000000000000] INSN3[0000000000000000]
ERROR(0): I-cache INSN4[0000000000000000] INSN5[0000000000000000]
INSN6[0000000000000000] INSN7[0000000000000000]
ERROR(0): E-cache idx[0] tag[0000000000000000]
ERROR(0): E-cache data0[0000000000000000] data1[0000000000000000]
data2[0000000000000000] data3[0000000000000000]
Kernel panic - not syncing: Irrecoverable deferred error trap.


-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>
