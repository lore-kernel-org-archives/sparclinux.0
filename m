From: "C.Newport" <crn@netunix.com>
Date: Thu, 18 Mar 2004 10:51:27 +0000
Subject: Re: Ultrasparc 2 SMP 2.4.26-pre4 fails
Message-Id: <200403181051.27124.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200403180100.54517.crn@netunix.com>
In-Reply-To: <200403180100.54517.crn@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Thursday 18 March 2004 2:30 am, David S. Miller wrote:
> On Thu, 18 Mar 2004 01:00:54 +0000
>
> "C.Newport" <crn@netunix.com> wrote:
> > Am I wasting my time trying to get 2.4.x SMP working ?, checking
> > back in the list, others seem to have had similar problems but the
> > fixes seem to refer to 2.6 only.
>
> Nope, it should work like a charm.  Boot with "-p" and see if
> anymore diags get spit out.

PROMLIB: Sun IEEE Boot Prom 3.11.2 1997/12/05 10:25
<4>Linux version 2.4.26-pre4 (root@ultra2) (gcc version egcs-2.92.11 199809=
21=20
(gcc2 ss-980609 experimental)) #2 SMP Wed Mar 17 22:46:47 GMT 2004
<ARCH>: SUN4U
ARCH: SUN4U
Ethernet address: 08:00:20:9b:f1:8d
Remapping the kernel... done.
On node 0 totalpages: 48539
zone(0) 163745 pages.
zone(1) 0 pages.
zone(2) 0 pages.
Booting Linux...
Found CPU 0 (node=F00661ac,mid=3D0)
Found CPU 1 (node=F0066518,mid=3D1)
Found 2 CPU prom device tree node(s).
Kernel command line: root=3D/dev/sda1 ro -p
Console: colour dummy device 80x25
Calibrating delay loop... 591.46 BogoMIPS
Memory: 372872k available (2280k kernel code, 576k data,168k init)=20
[fffff80000000000,0000000004ff42000]
Dentry cache hash table entries: 65536 (order: 7, 1048576 bytes)
Inode cache hash table entries: 32768 (order: 6, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 8192 bytes)
Buffer cache hash table entries: 16384 (order: 4, 131072 bytes)
Page-cache hash table entries: 65536 (order: 6, 524288 bytes)
Posix conformance testing by UNIFIX=20
Entering UltraSMPenguin mode...
Starting CPU 1...=20

Should I try upgrading to the same compiler, libs, and toolset as you
or rip some stuff out of the config so that I do not need to strip the
kernel ?.

