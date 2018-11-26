From: Andrew Murray <andrew.murray@arm.com>
Date: Mon, 26 Nov 2018 11:12:16 +0000
Subject: [PATCH v2 00/20] perf/core: Generalise event exclusion checking
Message-Id: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Many PMU drivers do not have the capability to exclude counting events
that occur in specific contexts such as idle, kernel, guest, etc. These
drivers indicate this by returning an error in their event_init upon
testing the events attribute flags.

However this approach requires that each time a new event modifier is
added to perf, all the perf drivers need to be modified to indicate that
they don't support the attribute. This results in additional boiler-plate
code common to many drivers that needs to be maintained. Furthermore the
drivers are not consistent with regards to the error value they return
when reporting unsupported attributes.

This patchset allow PMU drivers to advertise their ability to exclude
based on context via a new capability: PERF_PMU_CAP_EXCLUDE. This allows
the perf core to reject requests for exclusion events where there is no
support in the PMU.

This is a functional change, in particular:

 - Some drivers will now additionally (but correctly) report unsupported
   exclusion flags. It's typical for existing userspace tools such as
   perf to handle such errors by retrying the system call without the
   unsupported flags.

 - Drivers that do not support any exclusion that previously reported
   -EPERM or -EOPNOTSUPP will now report -EINVAL - this is consistent
   with the majority and results in userspace perf retrying without
   exclusion.

All drivers touched by this patchset have been compile tested.

Changes from v1:

 - Changed approach from explicitly rejecting events in unsupporting PMU
   drivers to explicitly advertising a capability in PMU drivers that
   do support exclusion events

 - Added additional information to tools/perf/design.txt

 - Rename event_has_exclude_flags to event_has_any_exclude_flag and
   update commit log to reflect it's a function

Andrew Murray (20):
  perf/doc: update design.txt for exclude_{host|guest} flags
  perf/core: add function to test for event exclusion flags
  perf/core: add PERF_PMU_CAP_EXCLUDE for exclusion capable PMUs
  perf/hw_breakpoint: perf/core: advertise PMU exclusion capability
  alpha: perf/core: remove unnecessary checks for exclusion
  arc: perf/core: advertise PMU exclusion capability
  arm: perf: conditionally advertise PMU exclusion capability
  arm: perf/core: remove unnecessary checks for exclusion
  drivers/perf: perf/core: remove unnecessary checks for exclusion
  drivers/perf: perf/core: remove unnecessary checks for exclusion
  drivers/perf: perf/core: advertise PMU exclusion capability
  mips: perf/core: advertise PMU exclusion capability
  powerpc: perf/core: advertise PMU exclusion capability
  powerpc: perf/core: remove unnecessary checks for exclusion
  s390: perf/events: advertise PMU exclusion capability
  sparc: perf/core: advertise PMU exclusion capability
  x86: perf/core: remove unnecessary checks for exclusion
  x86: perf/core remove unnecessary checks for exclusion
  x86: perf/core: advertise PMU exclusion capability
  perf/core: remove unused perf_flags

 arch/alpha/kernel/perf_event.c           |  6 ------
 arch/arc/kernel/perf_event.c             |  1 +
 arch/arm/mach-imx/mmdc.c                 |  8 +-------
 arch/arm/mm/cache-l2x0-pmu.c             |  8 --------
 arch/mips/kernel/perf_event_mipsxx.c     |  1 +
 arch/powerpc/perf/core-book3s.c          |  1 +
 arch/powerpc/perf/core-fsl-emb.c         |  1 +
 arch/powerpc/perf/hv-24x7.c              |  9 ---------
 arch/powerpc/perf/hv-gpci.c              |  9 ---------
 arch/powerpc/perf/imc-pmu.c              | 18 ------------------
 arch/s390/kernel/perf_cpum_cf.c          |  1 +
 arch/s390/kernel/perf_cpum_sf.c          |  2 ++
 arch/sparc/kernel/perf_event.c           |  1 +
 arch/x86/events/amd/ibs.c                | 12 ------------
 arch/x86/events/amd/iommu.c              |  5 -----
 arch/x86/events/amd/power.c              |  9 +--------
 arch/x86/events/amd/uncore.c             |  5 -----
 arch/x86/events/core.c                   |  2 ++
 arch/x86/events/intel/bts.c              |  2 +-
 arch/x86/events/intel/cstate.c           |  8 +-------
 arch/x86/events/intel/pt.c               |  4 +++-
 arch/x86/events/intel/rapl.c             |  8 +-------
 arch/x86/events/intel/uncore.c           |  8 --------
 arch/x86/events/intel/uncore_snb.c       |  8 +-------
 arch/x86/events/msr.c                    |  8 +-------
 drivers/perf/arm-cci.c                   |  9 ---------
 drivers/perf/arm-ccn.c                   |  5 +----
 drivers/perf/arm_dsu_pmu.c               |  8 +-------
 drivers/perf/arm_pmu.c                   | 15 +++++----------
 drivers/perf/arm_spe_pmu.c               |  3 ++-
 drivers/perf/hisilicon/hisi_uncore_pmu.c |  9 ---------
 drivers/perf/qcom_l2_pmu.c               |  8 --------
 drivers/perf/qcom_l3_pmu.c               |  7 -------
 drivers/perf/xgene_pmu.c                 |  5 -----
 include/linux/perf_event.h               | 10 ++++++++++
 include/uapi/linux/perf_event.h          |  2 --
 kernel/events/core.c                     |  9 +++++++++
 kernel/events/hw_breakpoint.c            |  2 ++
 tools/include/uapi/linux/perf_event.h    |  2 --
 tools/perf/design.txt                    |  4 ++++
 40 files changed, 54 insertions(+), 189 deletions(-)

-- 
2.7.4
