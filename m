From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 24 Nov 2009 08:17:41 +0000
Subject: [PATCH 00/11] Yet another series of OF merge patches.
Message-Id: <20091124081316.6216.66310.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, benh@kernel.crashing.org, sfr@canb.auug.org.au, dave

Nothing much to say here other than mostly mechanical merging of OF
support code.  Some of it remains a little ugly, but I'm taking the
approach of merging the code first, and refactoring it second.

I've pushed this series out to my test-devicetree branch on my git
server if anyone wants to test.  That branch also includes the
previous 2 patch series that I've sent out.

git://git.secretlab.ca/git/linux-2.6 test-devicetree

Compile tested on: ppc64, ppc32, microblaze, sparc64, sparc32.
Boot tested on mpc5200 (ppc32) platform.

---

Grant Likely (11):
      of: unify phandle name in struct device_node
      microblaze: gut implementation of early_init_dt_scan_cpus()
      of: merge of_attach_node() & of_detach_node()
      of: Merge of_node_get() and of_node_put()
      of: merge machine_is_compatible()
      of/flattree: merge early_init_devtree() and early_init_move_devtree()
      of/flattree: merge early_init_dt_scan_chosen()
      of/flattree: eliminate cell_t typedef
      of/flattree: merge dt_mem_next_cell
      of/flattree: Merge earlyinit_dt_scan_root()
      of/flattree: Merge early_init_dt_check_for_initrd()


 arch/microblaze/include/asm/prom.h           |    4 
 arch/microblaze/kernel/prom.c                |  375 +-------------------------
 arch/powerpc/include/asm/prom.h              |    4 
 arch/powerpc/kernel/prom.c                   |  366 ++-----------------------
 arch/powerpc/platforms/powermac/pfunc_core.c |    2 
 arch/sparc/kernel/devices.c                  |    2 
 arch/sparc/kernel/of_device_32.c             |    2 
 arch/sparc/kernel/of_device_64.c             |    2 
 arch/sparc/kernel/prom_common.c              |    8 -
 arch/sparc/kernel/smp_64.c                   |    2 
 drivers/of/base.c                            |  153 +++++++++++
 drivers/of/fdt.c                             |  204 ++++++++++++++
 drivers/sbus/char/openprom.c                 |   10 -
 drivers/video/aty/atyfb_base.c               |    2 
 include/linux/of.h                           |    7 
 include/linux/of_fdt.h                       |   18 +
 16 files changed, 430 insertions(+), 731 deletions(-)

-- 
Signature
