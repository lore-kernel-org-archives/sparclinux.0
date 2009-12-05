From: Jan Engelhardt <jengelh@medozas.de>
Date: Sat, 05 Dec 2009 18:41:59 +0000
Subject: Re: No MC sched domains
Message-Id: <alpine.LSU.2.01.0912051931280.16160@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912021934420.18813@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912021934420.18813@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Thursday 2009-12-03 23:02, David Miller wrote:
>> On Wednesday 2009-12-02 23:57, David Miller wrote:
>>>The T1 cores are repesented as SMT units.
>> 
>> It seems so.
>> 
>> /sys/devices/system/cpu/
>> cpu0/topology/physical_package_id:0
>> cpu1/topology/physical_package_id:0
>> cpu10/topology/physical_package_id:2
>> cpu11/topology/physical_package_id:2
>> cpu12/topology/physical_package_id:3
>> cpu13/topology/physical_package_id:3
>> cpu14/topology/physical_package_id:3
>> cpu15/topology/physical_package_id:3
>> cpu16/topology/physical_package_id:4
>> ...
>> 
>> Why is this done, when they are, in fact, not multiple physical 
>> packages?
>
>Because I need two levels of grouping to represent chips like T2.
>
>I use SMT to represent the cores.
>
>And I use MC to represent the 2 integer units within a core on T2.

Since 2.6.32 was recently released, I thought I give that a try (the
2.6.31 state carrying my Netfilter changes was throwing a recursive
fault on sparc), and the scheduling toplogy has changed slightly:

CPU0 attaching sched-domain:
 domain 0: span 0-3 level SIBLING
  groups: 0 (cpu_power = 294) 1 (cpu_power = 294) 2 (cpu_power = 294) 3 (cpu_pow
  domain 1: span 0-3 level MC
   groups: 0-3 (cpu_power = 1176)
   domain 2: span 0-23 level CPU
    groups: 0-3 (cpu_power = 1176) 4-7 (cpu_power = 1176) 8-11 (cpu_power = 1176

This is what I would have really expected before, though Fedora "only" 
shipped 2.6.31 so I may have looked at something outdated.

Where did the NODE domain actually go, or are sched-domains limited to a 
depth of 3?


thanks
Jan
