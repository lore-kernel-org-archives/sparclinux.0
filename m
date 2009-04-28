From: =?ISO-8859-15?Q?S=E9bastien_Bernard?= <seb@sfrdev.fr>
Date: Tue, 28 Apr 2009 12:52:54 +0000
Subject: Re: SunFire V240 hangs
Message-Id: <49F6FC26.40301@sfrdev.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <20090408200711.GA1142@frankengul.org>
In-Reply-To: <20090408200711.GA1142@frankengul.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller a =E9crit :
> From: seb@frankengul.org
> Date: Mon, 27 Apr 2009 16:40:42 +0200
>
>  =20
>> I'm willing to downgrade for testing to check. Which one should I
>> pick ? testing or stable ?
>>    =20
>
> I built a kernel using tools that work for me, using your
> provided config, and double checked that it boots on
> my ultra45.  Give it a spin:
>
> 	http://vger.kernel.org/~davem/v240.image
>
> it of course doesn't have the modules, and therfore won't
> be able to mount root.  But we will see if it passes the
> NMI test which is where you see problems.
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  =20
Unfortunately, this kernel hangs in the same way as the others.
Same place, same symptom.
I'm afraid the compiler has nothing to do with that problem.

    Seb

Here is the log :
Probing system devices
Probing memory
Probing I/O buses

Sun Fire V240, No Keyboard
Copyright 2007 Sun Microsystems, Inc.  All rights reserved.
OpenBoot 4.22.33, 4096 MB memory installed, Serial #58957285.
Ethernet address 0:3:ba:83:9d:e5, Host ID: 83839de5.



Rebooting with command: boot
Boot device: disk1  File and args:
SILO Version 1.4.14
boot:
Linux                    LinuxOLD                 Linux-rescue           =20
LinuxOLD-rescue          Linux2630                test                   =20
boot: test
Allocated 64 Megs of memory at 0x40000000 for kernel
Loaded kernel version 2.6.29
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.22.33 2007/06/18 12:45'
[    0.000000] PROMLIB: Root node compatible:
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.29.2 (davem@ultra45) (gcc version 4.3.2=20
(Debian 4.3.2-1.1) ) #1 SMP Tue Apr 28 03:39:16 PDT 2009
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] console [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:83:9d:e5
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@1e,600000/isa@7/serial@0,3f8
[    0.000000] PROM: Built device tree with 89996 bytes of memory.
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
[    0.000000] On node 0 totalpages: 393216
[    0.000000]   Normal zone: 13312 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 379904 pages, LIFO batch:15
[    0.000000] On node 1 totalpages: 130876
[    0.000000]   Normal zone: 1023 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 129853 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] Built 2 zonelists in Node order, mobility grouping on. =20
Total pages: 509757
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: ro single initcall_debug=3D1=20
ignore_loglevel
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] clocksource: mult[535555] shift[16]
[    0.000000] clockevent: mult[3126e97] shift[32]
[   36.103573] Console: colour dummy device 80x25
[   36.161984] console handover: boot [earlyprom0] -> real [tty0]
^[[H^[[J=20
^H                                                                         =
     =20
^H^[[@ ^[[1;80H^H^[[7m ^[[m^H^[[@ ^H ^H^[[@ ^[[2;1H

