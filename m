From: Jan Engelhardt <jengelh@medozas.de>
Date: Fri, 21 Jan 2011 01:17:52 +0000
Subject: Re: physical_package_id on sun4v
Message-Id: <alpine.LNX.2.01.1101210158320.9501@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LNX.2.01.1101210131480.6015@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LNX.2.01.1101210131480.6015@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

On Friday 2011-01-21 01:43, David Miller wrote:

>From: Jan Engelhardt <jengelh@medozas.de>
>Date: Fri, 21 Jan 2011 01:40:03 +0100 (CET)
>
>> Did I get something wrong? Is perhaps the Machine Description not 
>> expressive enough to figure out how many packages (CPU sockets) there 
>> are?
>
>This is simply how we number physical packages and "cores" on Niagara.
>
>CPU sockets are represented by NUMA nodes.
>
>We need three layers of scheduler grouping, and those are the three
>layers provided by the kernel's generic hierarchy:
>
>	NUMA node --> physical_package --> core
>
>Inside the CPU socket we need two layers of scheduler grouping, so
>that's how I decided to implement things.
>
>So it's intentional and on purpose.

Linux 2.6.32 used to output the scheduler grouping on bootup (these 
messages are gone in Linux 2.6.37):

CPU0 attaching sched-domain:
 domain 0: span 0-3 level SIBLING
  groups: 0 (cpu_power = 294) 1 (cpu_power = 294) 2 (cpu_power = 294) 3
 (cpu_power = 294)
  domain 1: span 0-3 level MC
   groups: 0-3 (cpu_power = 1176)
   domain 2: span 0-23 level CPU
    groups: 0-3 (cpu_power = 1176) 4-7 (cpu_power = 1176) 8-11 (cpu_power = 1176) 12-15 (cpu_power = 1176) 16-19 (cpu_power = 1176) 20-23 (cpu_power = 1176)

SIBLING, MC, CPU. That looks pretty much like the three-level
grouping you described. Though if 0-23 makes up a CPU and 0-3
makes up a core (that's what one could infer), 0-3 is not
one thread.

I am still a bit puzzled since the T1 is configured quite like the
Intel i7 920:

T1: 4 threads × 6 cores × 1 CPU
	core_sibling_list=0-3, thread_sibling_list=0-3

i7: 2 threads × 4 cores × 1 CPU
	core_sibling_list=0-7, thread_sibling_list=0,4

And in comparison:
Altix4700: 2 threads × 2 cores × 128 CPUs
	cpu0/core_sibling=0x03 (inferring>) core_sibling_list=0-3
	cpu0/thread_sibling=0x01 (inferring>) thread_sibling_list=0-1


So it seems as if, because the toplogy is different between sparc
and {ia64, x86}, at least one has worse scheduling.
