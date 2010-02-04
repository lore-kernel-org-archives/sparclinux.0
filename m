From: Chris Torek <chris.torek@windriver.com>
Date: Thu, 04 Feb 2010 11:25:54 +0000
Subject: [PATCH 0/8] niu parameters and RX flow separation
Message-Id: <1265282762-13954-1-git-send-email-chris.torek@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This series of patches adds:

 - configurable items for tuning the NIU driver (patches 1 and 2)

 - RX flow separation (NAPI drivers only, and off by default --
   patches 3 through 6, with most of the real work in 5 and 6)

 - changes to the NIU driver to use RX flow separation
   (patches 7 and 8)

The RX flow separation code in patches 5 and 6 is based on Dave
Miller's code in <http://article.gmane.org/gmane.linux.network/124921>.
There are a couple of key differences from Dave's original version
though:

  - There are no size increases to "struct sk_buff".
  - Remote CPUs are chosen on a per-device basis, rather than a
    global basis (more on this in a bit).

Patch 5 adds the actual RX flow hashing and remote-CPU interrupt, and
patch 6 makes the rx flow software interrupt a new, separate interrupt
(rather than re-using NET_RX_SOFTIRQ).  It's not entirely clear to me
what value the new separate NET_RX_FLOW interrupt provides.  The obvious
difference is that it runs at slightly lower priority, so that we do
all the separated flows after we run all our NET_RX_SOFTIRQ work, but
on SMP systems the entire notion of "before" and "after" is suspect.
However, DaveM's original patch also adds a new softirq, and I assume
Dave knows what he is doing. :-)  See also Hong's comments towards the
bottom.

DaveM's original patch simply maps all available CPUs at the time
the network is configured, and delivers packet flows to the CPU that
corresponds to the hash index for that flow.  This version instead maps
some specific number of CPUs per-device, and delivers flows to the CPU
associated with that <device, hashed-flow> pair.

There are three main ideas here.  One (the biggest one) is outlined below.
Another is that we run into diminishing returns on systems with a large
number of CPUs.  The last is that, at least on SPARC hardware, we'd
like to make sure that the software processing happens on "as different
as possible" CPUs (due to the difference between physically-separate
CPUs, vs separate "strands" on a single physical CPU).  To this end,
we add a notion of "reserving" CPUs, in patch 3 (generic) and 4
(SPARC-specific override).  The reservation is just an accounting
gimmick, so that different devices can offload work to different CPUs.
The machine-specific reservation code handles the tricky optimization
(via the existing sparc CPU-mapping code, which makes it a one-liner).

Patch 7 has the NIU driver "pre-reserve" the hardware-interrupt
handling CPUs, so that they will be "un-preferred" for handling
separated packet flows.  Patch 8 enables RX flow separation on the
NIU driver.

Here are some more notes from Hong, regarding differences in design
between Dave Miller's original patch and the current set, with my
own comments in [brackets]:
--------------------------------------------------------------

Dave Miller posted [an] experimental patch to the Linux netdev
mailing list, which modified the networking stack on the receiving
side to distribute incoming packets to remote CPUs for processing
in order to improve throughput.

Throughput [with Dave's patch, applied to a 2.6.27-based kernel] was
improved with light to moderate work loads, but testing with heavy work
loads showed the following side effects with this patch:

 1. High CPU utilization due to overhead of inter-processor interrupts.

 2. Massive packet backlogs caused by remote CPUs not processing packets
    as fast as they were being dequeued from the network driver. This
    could eventually cause an out of memory condition (denial of service).

 3. Since all network devices send incoming packets to a common pool of
    CPUs (i.e. all online CPUs) for processing, a device under heavy
    load could starve out or cause huge latencies for other devices.

The network flow separation on receive patch was redesigned and
reimplemented with the following considerations:

 1. High CPU utilization:

    * Packets are queued and submitted in batches (up to 64 packets at a
      time, the default NAPI weight) to remote processors to minimize the
      overhead of processor to processor communication and synchronization.
      [I'm sure this adds some overhead to low-bit-rate traffic, but it
      seems to help a lot with massive flows.]

    * Minimize the use of inter-processor interrupts. IPIs are only used
      to signal a remote CPU to start processiing packets if it is not
      already handling packets for that device.  

 2. Massive packet backlogs causing high memory usage:

    * A per CPU and device limit on how many backlogged packets are
      allowed was implemented. By default, each device is allowed a
      maximum backlog of 1000 packets on each CPU. The backlog threshold
      is configurable by writing to /proc/sys/net/core/netdev_max_backlog.

      [netdev_max_backlog is/was already in net/core/dev.c in the -current
      tree to which I ported this.  These patches have the side effect
      of making it act per-cpu-thread, which effectively multiplies it
      by the number of rx cpus.  Perhaps something should be done to
      address that, although I am not sure what off-hand.]

 3. Starvation caused by other devices:

    * Each network device can create a configurable number of helper
      threads to process incoming packets. Using kernel threads
      partitioned the CPUs (as each thread is assigned to a different
      CPU), which improved fairness and throughput for multiple network
      devices.

      The per network device number of helper threads is configurable
      by writing to /sys/class/net/eth[0..n]/rx_threads. By default
      rx_threads is 0, which is to disable network flow separation on
      receive (drivers or init scripts can set a reasonable value). The
      NIU driver sets a default value of 16 rx_threads.

Iperf TCP and IP forwarding benchmarks showed that the redesigned
flow separation on receive patch improved throughput and reduced CPU
utilization compared to Dave Miller's patch. Massive packet reordering
did not occur. [I think this "packet reordering" problem was
exclusive to a first attempt that predated adapting Dave's code.]

Despite the improvements, there were several [observed] problems
with the redesigned patch:

 1. "Port starvation" under heavy load. After some time, a port on
    an IP forwarding test machine would show no packets being
    forwarded. The inactivity may be temporary (the port would recover
    and resume activity) or permanent.
 2. Highly variable bidirectional throughput. Unidirectional throughput
    was stable.
 3. Iperf TCP throughput was on par with Solaris, but IP forwarding was
    not.

[The redesigned patch was then tweaked and reworked for a while,
gaining various marginal-but-useful improvements that are included in
this final version.  The "port starvation" problem ultimately turned out
to be simple: ARP packets are dropped along with everything else when
the network load becomes too great.  This series of patches does not
address that; the workaround was to increase the ARP cache timeout on the
test machines.  The bidirectional variablity went away when the patches
were first brought forward to 2.6.29-based kernels.  I don't know if IP
forwarding caught up to or surpassed Solaris, but throughput -- both uni-
and bi-directional -- looks to beat Solaris pretty handily in 2.6.30-based
tests.  Hong's last tests were with 2.6.30-rc5, plus these patches of
course, where the packet rates and CPU usage were:

          Unidirectional      Bidirectional
	  Rate*  CPU Usage    Rate*  CPU Usage
  Linux:   1.80      28%      1.5       56%
  Solaris: 1.65               1.1

  * Rate = million packets per second.

(I don't have CPU usage figures for Solaris.)  I have brought the patches
forward to sparc-next and tested them on the NIU driver.  I also tested
them on x86, on a Dell box, using the v2.6.33-rc6 tree, but without
modifying any NAPI drivers to turn the code on, just to verify that it
does not break x86.

I will be on holiday in Australia soon, but joined the sparclinux mailing
list from my google email address, so I should be able to respond
to questions from there, whenever I have Internet access, which will
probably be somewhat spotty.]
