From: matthieu castet <castet.matthieu@free.fr>
Date: Wed, 20 Oct 2004 20:34:05 +0000
Subject: 2.6 broken on sparc64 ?
Message-Id: <4176CBBD.8080909@free.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
we have tried to run 2.6.x series on 2 sparc64 machines.

The first one is a 4 CPU sun enterprise [1] .
With the 2.6.x the maximum uptime was 11 day, after that the machine 
freezed with no error message (we even tried with netconsole).
With this machine we have tried vanilla kernel 2.6.3->2.6.8 with no 
result since mars 2004.

The 2.4 series seems to work well.


On the second machine [2], we only try Debian kernel-image-2.6.8-1-sparc64 .
The machine hangs randomly.
The machine hangs when loading snd-ioctl32.
Also there is a minor problem with mouse working only after unplugging 
repluggin.


Also we notice on recent 2.6 kernel (2.6.8 for example) that if the 
machine is cut from the nfs server, the machine freezes. It isn't happen 
on 2.4 kernels.

If someone is interested in making work 2.6 kernel on these old 
machines, we could provide other informations.


Thanks

Matthieu



[1]
cat /proc/cpuinfo
cpu             : TI UltraSparc I   (SpitFire)
fpu             : UltraSparc I integrated FPU
promlib         : Version 3 Revision 2
prom            : 3.2.4
type            : sun4u
ncpus probed    : 4
ncpus active    : 4
Cpu0Bogo        : 333.41
Cpu0ClkTck      : 0000000009f437c0
Cpu1Bogo        : 333.41
Cpu1ClkTck      : 0000000009f437c0
Cpu4Bogo        : 333.41
Cpu4ClkTck      : 0000000009f437c0
Cpu5Bogo        : 333.41
Cpu5ClkTck      : 0000000009f437c0
MMU Type        : Spitfire
State:
CPU0:           online
CPU1:           online
CPU4:           online
CPU5:           online

[2]
cat /proc/cpuinfo
cpu             : TI UltraSparc IIi (Sabre)
fpu             : UltraSparc IIi integrated FPU
promlib         : Version 3 Revision 25
prom            : 3.25.2
type            : sun4u
ncpus probed    : 1
ncpus active    : 1
Cpu0Bogo        : 878.18
Cpu0ClkTck      : 000000001a39de00
MMU Type        : Spitfire
