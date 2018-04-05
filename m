From: Jan Engelhardt <jengelh@inai.de>
Date: Thu, 05 Apr 2018 00:32:43 +0000
Subject: Re: [sparc64] number of processors in a LDOM
Message-Id: <alpine.LSU.2.20.1804050146150.6762@n3.vanv.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqwQZJ-9T3=zS8pXkf0PUiKdw=wFjduRJg8v0mh6W4gzkw@mail.gmail.com>
In-Reply-To: <CADxRZqwQZJ-9T3=zS8pXkf0PUiKdw=wFjduRJg8v0mh6W4gzkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: kernelnewbies@lists.kernelnewbies.org


On Wednesday 2018-04-04 15:30, Anatoly Pugachev wrote:
>
>Can someone tell me or suggest why does getconf returns total available to a physical machine
>cpu count, and not LDOM allocated processor/vcpu count ?
>
>ttip$ getconf -a | grep PROCESSORS
>_NPROCESSORS_CONF                  256
>_NPROCESSORS_ONLN                  16

It's how the hypervisor populates the MDESC info passed to domains.
It even does that for control domains. Almost makes one want to believe
the 6-core T1s could be functional 8-core ones. (Who knows.)


jengelh@a1:~$ lscpu
Architecture:        sparc64 (T1000)
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Big Endian
CPU(s):              24
On-line CPU(s) list: 0-23

Anyhow, by declaring nr_cpus_present%6 but only nr_cpus_online, domains can
get more vCPUs assigned at a later time without rebooting the OS, if one
assumes that the MDESC is meant to be static during runtime and/or that the OS
cannot handle a change of nr_cpus_present (there are possibly some allocations
of exactly this size all over the place). Similar to NR_CPUS.



>I'm raising this issue, because some userspace tools use nproc to run parallel make for
>example. And starting from 4.15+ (but not on 4.14) kernel overcommited CPU usage (for example,
>using make -j256 on a LDOM with 16 vcpus allocated) gets me to the following (reproducible):

I consider defaulting to nr_cpus_present totally wrong for any software.
CPUs can be offlined by the administrator at will.

Second, I would also consider defaulting to on nr_cpus_online to be a subpar
default. Some institutions (or the load balancing system in use there) use
sched_setaffinity as a primitive measure to statically ensure that login shells
never run on the same core as a number cruncher task.
`make -j$(getconf _NPROCESSORS_ONLN)` would be dumb there because only e.g. 2 cores
are available for shells/gcc - the other 14 are assigned to HPC tasks.
