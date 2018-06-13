From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 13 Jun 2018 00:57:20 +0000
Subject: [RFC PATCH 00/23] Implement an HPET-based hardlockup detector
Message-Id: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Hi,

This patchset demonstrates the implementation of a hardlockup detector
driven by the High-Precision Event Timer.

= Introduction =

In CPU architectures that do not have an NMI watchdog, one can be
constructed using a counter of the Performance Monitoring Unit (PMU).
Counters in the PMU have high granularity and high visibility of the CPU.
These capabilities and their limited number make these counters precious
resources. Unfortunately, the perf-based hardlockup detector permanently
consumes one of these counters per CPU.

These counters could be freed for profiling purposes if the hardlockup
detector were driven by another timer.

The hardlockup detector runs relatively infrequently and does not require
visibility of the CPU activity (in addition to detect locked-up CPUs). A
timer that is external to the CPU (e.g., in the chipset) can be used to
drive the detector.

A key requirement is that the timer needs to be capable of issuing a
non-maskable interrupt to the CPU. In most cases, this can be achieved
by tweaking the delivery mode of the interrupt in the interrupt controller
chip (the exception is the IO APIC).

= Parts of this series =

Several parts of Linux need to be updated to operate the aforementioned
detector.

   1) Update the interrupt subsystem to accept requests of interrupts as
      non-maskable. Likewise, handle irqchips that have this capability.
      Patches 1-5
   
   2) Rework the x86 HPET platform code to reserve, configure a timer
      and its interrupt, and expose the needed interfaces and definitions.
      Patches 6-11

   3) Rework the hardlockup detector to decouple its generic part from
      perf. This adds definitions to be implemented using other sources
      of non-maskable interrupts. Patches 12-14

   4) Add an HPET-based hardlockup detector. This includes probing the
      hardware resources, configure the interrupt and rotate the
      destination of the interrupts among all monitored CPUs.

= Details on the HPET-based hardlockup detector

Unlike the the perf-based hardlockup detector, this implementation is
driven by a single timer. The timer targets one CPU at a time in a round-
robin manner. This means that if a CPU must be monitored every watch_thresh
seconds, in a system with N monitored CPUs the timer must expire every
watch_thresh/N. A timer expiration per CPU attribute is maintained.

The timer expiration time per CPU is updated every time CPUs are put
online or offline (a CPU hotplug thread enables and disables the watchdog
in these events).

Also, given that a single timer drives the detector, a cpumask is needed
to keep track of which online CPUs are allowed to be monitored. This mask
is updated every time a CPU is put online or offline as well as when the
user modifies the mask in /proc/sys/kernel/watchdog_cpumask. This mask
is needed to keep the current behavior of the lockup detector.


Thanks and BR,
Ricardo

Ricardo Neri (23):
  x86/apic: Add a parameter for the APIC delivery mode
  genirq: Introduce IRQD_DELIVER_AS_NMI
  genirq: Introduce IRQF_DELIVER_AS_NMI
  iommu/vt-d/irq_remapping: Add support for IRQCHIP_CAN_DELIVER_AS_NMI
  x86/msi: Add support for IRQCHIP_CAN_DELIVER_AS_NMI
  x86/ioapic: Add support for IRQCHIP_CAN_DELIVER_AS_NMI with interrupt
    remapping
  x86/hpet: Expose more functions to read and write registers
  x86/hpet: Calculate ticks-per-second in a separate function
  x86/hpet: Reserve timer for the HPET hardlockup detector
  x86/hpet: Relocate flag definitions to a header file
  x86/hpet: Configure the timer used by the hardlockup detector
  kernel/watchdog: Introduce a struct for NMI watchdog operations
  watchdog/hardlockup: Define a generic function to detect hardlockups
  watchdog/hardlockup: Decouple the hardlockup detector from perf
  kernel/watchdog: Add a function to obtain the watchdog_allowed_mask
  watchdog/hardlockup: Add an HPET-based hardlockup detector
  watchdog/hardlockup/hpet: Convert the timer's interrupt to NMI
  watchdog/hardlockup/hpet: Add the NMI watchdog operations
  watchdog/hardlockup: Make arch_touch_nmi_watchdog() to hpet-based
    implementation
  watchdog/hardlockup/hpet: Rotate interrupt among all monitored CPUs
  watchdog/hardlockup/hpet: Adjust timer expiration on the number of
    monitored CPUs
  watchdog/hardlockup/hpet: Only enable the HPET watchdog via a boot
    parameter
  watchdog/hardlockup: Activate the HPET-based lockup detector

 Documentation/admin-guide/kernel-parameters.txt |   5 +-
 arch/x86/include/asm/hpet.h                     |  38 ++
 arch/x86/include/asm/hw_irq.h                   |   5 +-
 arch/x86/include/asm/msidef.h                   |   3 +
 arch/x86/kernel/apic/io_apic.c                  |   5 +-
 arch/x86/kernel/apic/msi.c                      |   7 +-
 arch/x86/kernel/apic/vector.c                   |   8 +
 arch/x86/kernel/hpet.c                          | 149 ++++++-
 arch/x86/platform/uv/uv_irq.c                   |   2 +-
 drivers/char/hpet.c                             |  31 +-
 drivers/iommu/intel_irq_remapping.c             |  18 +-
 include/linux/hpet.h                            |   1 +
 include/linux/interrupt.h                       |   3 +
 include/linux/irq.h                             |  15 +
 include/linux/nmi.h                             |  56 ++-
 kernel/Makefile                                 |   3 +-
 kernel/irq/manage.c                             |  22 +-
 kernel/watchdog.c                               |  78 +++-
 kernel/watchdog_hld.c                           | 152 +------
 kernel/watchdog_hld_hpet.c                      | 557 ++++++++++++++++++++++++
 kernel/watchdog_hld_perf.c                      | 182 ++++++++
 lib/Kconfig.debug                               |  10 +
 22 files changed, 1145 insertions(+), 205 deletions(-)
 create mode 100644 kernel/watchdog_hld_hpet.c
 create mode 100644 kernel/watchdog_hld_perf.c

-- 
2.7.4

