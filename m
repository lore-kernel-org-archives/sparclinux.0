From: "Frans van Berckel" <fberckel@xs4all.nl>
Date: Wed, 28 Mar 2012 00:29:44 +0000
Subject: Re: v440 & expert 3D
Message-Id: <62be3dbdaf781e34e6916eca19b79177.squirrel@webmail.xs4all.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <1332502667.1755.10.camel@deblnxsrv224.lan>
In-Reply-To: <1332502667.1755.10.camel@deblnxsrv224.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>> Today I hooked a serial kabel, take off the usb keyboard. And fount out
>> the system reboots spontaneously at the switch with a Expert 3D only
>> installed. How do I boot a little bit more verbose, getting debug info?
>
> Boot with the "-p" kernel command line option.

[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,ultra3,mul32,div32]
[    0.000000] CPU CAPS: [v8plus,vis,vis2]
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on. 
Total pages: 2415404
[    0.000000] Kernel command line: root=/dev/sda2 ro -p
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 4194304 (order: 12,
33554432 bytes)
[    0.000000] Inode-cache hash table entries: 2097152 (order: 11,
16777216 bytes)
[    0.000000] Memory: 20740952k available (3488k kernel code, 1504k data,
184k init) [fffff80000000000,000000323fe68000]
[    0.000000] NR_IRQS:255
[    0.000000] clocksource: mult[64000000] shift[24]
[    0.000000] clockevent: mult[28f5c29] shift[32]
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[  196.340297] Calibrating delay using timer specific routine.. 20.00
BogoMIPS (lpj@000)
[  196.436169] pid_max: default: 32768 minimum: 301
[  196.491500] Security Framework initialized
[  196.540489] AppArmor: AppArmor disabled by boot time parameter
[  196.610399] Mount-cache hash table entries: 512
[  196.664975] Initializing cgroup subsys cpuacct
[  196.718215] Initializing cgroup subsys memory
[  196.770435] Initializing cgroup subsys devices
[  196.823651] Initializing cgroup subsys freezer
[  196.876791] Initializing cgroup subsys net_cls
[  196.929931] Initializing cgroup subsys blkio
[  196.981011] Initializing cgroup subsys perf_event
[  197.037542] Performance events: Supported PMU type is 'ultra3i'
[  197.109249] devtmpfs: initialized
[  197.149561] print_constraints: dummy:
[  197.194558] NET: Registered protocol family 16
[  197.252710] /pci@1c,600000: TOMATILLO PCI Bus Module ver[4:0]
[  197.321480] /pci@1c,600000: PCI IO[7ce01000000] MEM[7cf00000000]
[  197.395740] PCI: Scanning PBM /pci@1c,600000
[  197.447201] /pci@1d,700000: TOMATILLO PCI Bus Module ver[4:0]
[  197.516052] /pci@1d,700000: PCI IO[7c601000000] MEM[7c700000000]
[  197.590317] PCI: Scanning PBM /pci@1d,700000
[  197.641614] /pci@1e,600000: TOMATILLO PCI Bus Module ver[4:0]
[  197.710416] /pci@1e,600000: PCI IO[7fe01000000] MEM[7ff00000000]
[  197.784698] PCI: Scanning PBM /pci@1e,600000
[  197.836148] pci 0002:00:06.0: quirk: [io  0x7fe01000800-0x7fe0100083f]
claimed by ali7101 ACPI
[  197.939308] pci 0002:00:06.0: quirk: [io  0x7fe01000600-0x7fe0100061f]
claimed by ali7101 SMB
[  198.042335] /pci@1f,700000: TOMATILLO PCI Bus Module ver[4:0]
[  198.111101] /pci@1f,700000: PCI IO[7f601000000] MEM[7f700000000]
[  198.185378] PCI: Scanning PBM /pci@1f,700000
[  198.239472] bio: create slab <bio-0> at 0
[  198.287826] vgaarb: device added:
PCI:0002:00:03.0,decodes=io+mem,owns=none,locks=none
[  198.382644] vgaarb: loaded
[  198.415065] vgaarb: bridge control possible 0002:00:03.0
[  198.479180] /pci@1e,600000/isa@7/rtc@0,70: RTC regs at 0x7fe01000070
[  198.555830] Switching to clocksource stick
[  198.613062] NET: Registered protocol family 2
[  198.665596] IP route cache hash table entries: 524288 (order: 9,
4194304 bytes)
[  198.761192] TCP established hash table entries: 524288 (order: 10,
8388608 bytes)
[  198.879885] TCP bind hash table entries: 65536 (order: 6, 524288 bytes)
[  198.960976] TCP: Hash tables configured (established 524288 bind 65536)
[  199.040182] TCP reno registered
[  199.077747] UDP hash table entries: 16384 (order: 6, 524288 bytes)
[  199.153672] UDP-Lite hash table entries: 16384 (order: 6, 524288 bytes)
[  199.235087] NET: Registered protocol family 1
[  199.287347] pci 0002:00:07.0: Activating ISA DMA hang workarounds
[  199.469065] Unpacking initramfs...
[  200.040965] Freeing initrd memory: 9571k freed
[  200.095132] power: Control reg at 7fe01000800
[  200.148161] chmc: UltraSPARC-IIIi memory controller at
/memory-controller@0,0
[  200.233638] chmc: UltraSPARC-IIIi memory controller at
/memory-controller@1,0
[  200.319109] chmc: UltraSPARC-IIIi memory controller at
/memory-controller@2,0
[  200.404593] chmc: UltraSPARC-IIIi memory controller at
/memory-controller@3,0
[  200.490436] audit: initializing netlink socket (disabled)
[  200.555082] type 00 audit(2.192:1): initialized
[  201.153792] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[  201.230515] VFS: Disk quotas dquot_6.5.2
[  201.277595] Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
[  201.355844] msgmni has been set to 32768
[  201.403269] alg: No test for stdrng (krng)
[  201.452394] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 253)
[  201.540920] io scheduler noop registered
[  201.587814] io scheduler deadline registered
[  201.638929] io scheduler cfq registered (default)
[  201.695856] e3d: Found device at 0002:00:03.0

SC Alert: Host System has Reset

SC Alert: Failed to send email alert for recent event.

Fatal Error Reset
CPU 0000.0000.0000.0000 AFSR 0080.0000.0000.0000 JEIC
AFAR 0000.0000.0000.0000

