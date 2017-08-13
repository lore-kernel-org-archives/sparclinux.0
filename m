From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Sun, 13 Aug 2017 21:14:58 +0000
Subject: [PATCH] sparc: kernel/pcic: silence gcc 7.x warning in pcibios_fixup_bus()
Message-Id: <20170813211458.24511-1-thomas.petazzoni@free-electrons.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

When building the kernel for Sparc using gcc 7.x, the build fails
with:

arch/sparc/kernel/pcic.c: In function ‘pcibios_fixup_bus’:
arch/sparc/kernel/pcic.c:647:8: error: ‘cmd’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
    cmd |= PCI_COMMAND_IO;
        ^~

The simplified code looks like this:

unsigned int cmd;
[...]
pcic_read_config(dev->bus, dev->devfn, PCI_COMMAND, 2, &cmd);
[...]
cmd |= PCI_COMMAND_IO;

I.e, the code assumes that pcic_read_config() will always initialize
cmd. But it's not the case. Looking at pcic_read_config(), if
bus->number is != 0 or if the size is not one of 1, 2 or 4, *val will
not be initialized.

As a simple fix, we initialize cmd to zero at the beginning of
pcibios_fixup_bus.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/sparc/kernel/pcic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index a38787b..732af9a 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -602,7 +602,7 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 	int i, has_io, has_mem;
-	unsigned int cmd;
+	unsigned int cmd = 0;
 	struct linux_pcic *pcic;
 	/* struct linux_pbm_info* pbm = &pcic->pbm; */
 	int node;
-- 
2.9.4

