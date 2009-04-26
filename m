From: =?ISO-8859-1?Q?S=E9bastien_Bernard?= <seb@frankengul.org>
Date: Sun, 26 Apr 2009 21:59:26 +0000
Subject: Re: SunFire V240 hangs
Message-Id: <49F4D93E.6000705@frankengul.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090408200711.GA1142@frankengul.org>
In-Reply-To: <20090408200711.GA1142@frankengul.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller a =E9crit :
> From: S=E9bastien Bernard <seb@frankengul.org>
> Date: Sun, 26 Apr 2009 01:30:35 +0200
>
>  =20
>> sparc port is unofficial but available on the ports.ubuntu.com for all
>> version up to 9.04.
>> PPC has been retrogaded in ports recently since apple dropped that
>> arch in favor of x86.
>> The compiler is not custom. It came from the ubuntu archive.
>> I don't think the compiler is the culprit in this case because all of
>> the kernels built before 2.6.29 are working OK
>> (I could be wrong, but it's unlikely).
>>    =20
>
> I'm worryed with this particular bug because the NMI code added
> in 2.6.29 where this bootup is hanging has a loop over a variable
> changing, with a memory barrier in there.  It's exactly the kind
> of thing a compiler error can and has caused in the past
>  =20
>> I have a sid debian sparc available. I'll try to build a kernel with
>> that compiler and try if it changes anything
Well, it still hangs at the same place.
The strange thing is that the debug_initcall parameter does not work. No=20
initcall output is done. Really weird.
Below is the transcription from the logs :
--------------------------------------
boot: LinuxOLD-rescue initcall_debug=3D1 ignore_loglevel
Allocated 64 Megs of memory at 0x40000000 for kernel^
Uncompressing image...
Loaded kernel version 2.6.29
Loading initial ramdisk (8545117 bytes at 0x103F000000 phys, 0x40C00000=20
virt)...
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.22.33 2007/06/18 12:45'
[    0.000000] PROMLIB: Root node compatible:
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.29.1 (seb@calypso) (gcc version 4.3.3=20
(Debian 4.3.3-8) ) #1 SMP Sun Apr 26 04:00:36 CEST 2009
[    0.000000] console [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:83:9d:e5
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@1e,600000/isa@7/serial@0,3f8
[    0.000000] PROM: Built device tree with 90020 bytes of memory.
[    0.000000] [0000000200000000-fffff80000400000] page_structs=131072=20
node=3D0 entry=3D0/0
[    0.000000] [0000000200000000-fffff80000800000] page_structs=131072=20
node=3D0 entry=3D1/0
[    0.000000] [0000000204000000-fffff80000c00000] page_structs=131072=20
node=3D0 entry=16/0
[    0.000000] [0000000204000000-fffff80001000000] page_structs=131072=20
node=3D0 entry=17/0
[    0.000000] [0000000206000000-fffff80001400000] page_structs=131072=20
node=3D0 entry$/0
[    0.000000] [0000000206000000-fffff80001800000] page_structs=131072=20
node=3D0 entry%/0
[    0.000000] [0000000220000000-fffff81000800000] page_structs=131072=20
node=3D1 entry=128/0
[    0.000000] [0000000220000000-fffff81000c00000] page_structs=131072=20
node=3D1 entry=129/0
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x00000000 -> 0x0081ff74
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[8] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00020000
[    0.000000]     0: 0x00100000 -> 0x00120000
[    0.000000]     0: 0x00180000 -> 0x001a0000
[    0.000000]     1: 0x00800000 -> 0x0081f7ff
[    0.000000]     1: 0x0081f800 -> 0x0081ff30
[    0.000000]     1: 0x0081ff38 -> 0x0081ff40
[    0.000000]     1: 0x0081ff48 -> 0x0081ff49
[    0.000000]     1: 0x0081ff70 -> 0x0081ff74
[    0.000000] Booting Linux...
[    0.000000] Built 2 zonelists in Node order, mobility grouping on. =20
Total pages: 509757
[    0.000000] Policy zone: Normal
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] clocksource: mult[535555] shift[16]
[    0.000000] clockevent: mult[3126e97] shift[32]
[   69.011963] Console: colour dummy device 80x25
[   69.070377] console handover: boot [earlyprom0] -> real [tty0]
--------------------------------------
And that's all. Screen clears and cursor goes a few lines down and hangs.
So, should I try with another gcc ? 4.2 maybe ?

Seb
