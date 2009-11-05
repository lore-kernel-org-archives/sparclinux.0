From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 05 Nov 2009 07:45:09 +0000
Subject: [PATCH 00/11] More OF merge patches
Message-Id: <20091105073728.10460.6061.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, benh@kernel.crashing.org, sfr@canb.auug.org.au, davem@davemloft.net, sparclinux@vger.kernel.org, monstr@monstr.eu

Round 2.  Here is my 2nd set of merging OF code between PowerPC and
Microblaze (no SPARC changes this time).  Compile tested on ppc,
microblaze and sparc.  Boot tested on MPC5200 powerpc platform.

I've also pushed this series out to the test-devicetree branch on my
git server if anyone cares to pull and test:

git://git.secretlab.ca/git/linux-2.6 test-devicetree

This is based on the next-devicetree branch which contains the first
round of patches and is being pulled into linux-next.

Cheers,
g.

---

Grant Likely (11):
      of/flattree: Merge early_init_dt_check_for_initrd()
      of: remove special case definition of of_read_ulong()
      of: merge prom_{add,remove,modify}_property
      of/flattree: Merge unflatten_device_tree
      of/flattree: Merge unflatten_dt_node
      of/flattree: Merge of_flat_dt_is_compatible
      of/flattree: merge of_get_flat_dt_prop
      of/flattree: remove __init annotations from the header file
      of/flattree: merge of_get_flat_dt_root
      of/flattree: merge of_scan_flat_dt
      of/flattree: merge find_flat_dt_string and initial_boot_params


 arch/microblaze/Kconfig            |    1 
 arch/microblaze/include/asm/prom.h |    1 
 arch/microblaze/kernel/prom.c      |  531 ------------------------------------
 arch/powerpc/Kconfig               |    1 
 arch/powerpc/kernel/prom.c         |  534 ------------------------------------
 drivers/of/Kconfig                 |    4 
 drivers/of/Makefile                |    1 
 drivers/of/base.c                  |  116 ++++++++
 drivers/of/fdt.c                   |  458 +++++++++++++++++++++++++++++++
 include/linux/of.h                 |   10 -
 include/linux/of_fdt.h             |   21 +
 11 files changed, 598 insertions(+), 1080 deletions(-)
 create mode 100644 drivers/of/fdt.c

