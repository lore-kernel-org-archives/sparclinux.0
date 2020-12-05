From: Anatoly Pugachev <matorola@gmail.com>
Date: Sat, 05 Dec 2020 10:16:33 +0000
Subject: "No support for PMU type" or early "NMI appears to be stuck (0->0)"
Message-Id: <CADxRZqwUfOq_GoPjcHHkZhcy5k_WOz0NMGO3tjsBJRJNeYu5uQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello!

Just to share my current experience with updated solaris being used as
a hypervisor for linux LDOMs.

Using sparc T5-2 server as a hypervisor (solaris 11.4 for primary
domain) for various LDOMs, with ones being used under linux OS (debian
sid unstable).

Recently, updated solaris on primary domain to latest version and some
of my linux domains started to report the following logs on kernel
boot (full log at [1]):

$ dmesg
...
[    0.401140] smp: Brought up 1 node, 8 CPUs
[    0.403154] devtmpfs: initialized
[    0.403758] Performance events:
[    0.403771] Testing NMI watchdog ...
[    0.483850] WARNING: CPU#0: NMI appears to be stuck (0->0)!
[    0.483861] Please report this to bugzilla.kernel.org,
[    0.483872] and attach the output of the 'dmesg' command.
[    0.483885] WARNING: CPU#1: NMI appears to be stuck (0->0)!
[    0.483896] Please report this to bugzilla.kernel.org,
[    0.483907] and attach the output of the 'dmesg' command.
[    0.483925] WARNING: CPU#2: NMI appears to be stuck (0->0)!
[    0.483940] Please report this to bugzilla.kernel.org,
[    0.483954] and attach the output of the 'dmesg' command.
[    0.483972] WARNING: CPU#3: NMI appears to be stuck (0->0)!
[    0.483986] Please report this to bugzilla.kernel.org,
[    0.484001] and attach the output of the 'dmesg' command.
[    0.484018] WARNING: CPU#4: NMI appears to be stuck (0->0)!
[    0.484032] Please report this to bugzilla.kernel.org,
[    0.484047] and attach the output of the 'dmesg' command.
[    0.484064] WARNING: CPU#5: NMI appears to be stuck (0->0)!
[    0.484078] Please report this to bugzilla.kernel.org,
[    0.484093] and attach the output of the 'dmesg' command.
[    0.484110] WARNING: CPU#6: NMI appears to be stuck (0->0)!
[    0.484124] Please report this to bugzilla.kernel.org,
[    0.484138] and attach the output of the 'dmesg' command.
[    0.484154] WARNING: CPU#7: NMI appears to be stuck (0->0)!
[    0.484169] Please report this to bugzilla.kernel.org,
[    0.484183] and attach the output of the 'dmesg' command.
[    0.484207] No support for PMU type 'niagara5'
[    0.484409] ldc.c:v1.1 (July 22, 2008)
[    0.484766] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns

versus old behavior on the same domain :
$ journalctl -k -b -2 -o short-monotonic --no-hostname
...
[    0.427406] kernel: smp: Brought up 1 node, 24 CPUs
[    0.429746] kernel: devtmpfs: initialized
[    0.430558] kernel: Performance events:
[    0.430577] kernel: Testing NMI watchdog ...
[    0.510652] kernel: OK.
[    0.510669] kernel: Supported PMU type is 'niagara5'
[    0.511025] kernel: ldc.c:v1.1 (July 22, 2008)
[    0.511485] kernel: clocksource: jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns


while checking what has changed , found that domains which report "NMI
appears to be stuck" being a bit different in a LDOM configuration for
the domain, they have empty perf-counters [2]:

$ ldm list -l ldg0 | grep perf
    perf-counters
setting "perf-counters" to any value [ "strand" or "htstrand" ] ,
removes this error messages and gets back to the older behaviour.

Not sure if this info will be useful to anyone, but posting anyway....

Thanks.

1. https://gist.github.com/mator/19769bf36625bdd1d27cecf38591ea75
2. https://docs.oracle.com/cd/E93612_01/html/E93617/useperfcounterprops.html

PS: I didn't found perf-counter being used (declared) in a ldom
configuration on older machines, like T3-2 or T5240
