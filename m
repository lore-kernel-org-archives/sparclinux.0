From: Babu Moger <babu.moger@oracle.com>
Date: Mon, 12 Jun 2017 22:09:59 +0000
Subject: [PATCH v3 2/3] arch/microblaze: Add choice for endianness and update Makefile
Message-Id: <1497305400-147425-3-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1497305400-147425-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1497305400-147425-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, geert@linux-m68k.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, jejb@parisc-linux.org, deller@gmx.de, davem@davemloft.net, viro@zeniv.linux.org.uk, monstr@monstr.eu
Cc: mpe@ellerman.id.au, peterz@infradead.org, mingo@redhat.com, jcmvbkbc@gmail.com, linux-kernel@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org

microblaze architectures can be configured for either little or
big endian formats. Add a choice option for the user to select the
correct endian format(default to big endian).

Also update the Makefile so toolchain can compile for the format
it is configured for.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/microblaze/Kconfig  |   16 ++++++++++++++++
 arch/microblaze/Makefile |    2 ++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 85885a5..74aa5de 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -35,6 +35,22 @@ config MICROBLAZE
 	select VIRT_TO_BUS
 	select CPU_NO_EFFICIENT_FFS
 
+# Endianness selection
+choice
+	prompt "Endianness selection"
+	default CPU_BIG_ENDIAN
+	help
+	  microblaze architectures can be configured for either little or
+	  big endian formats. Be sure to select the appropriate mode.
+
+config CPU_BIG_ENDIAN
+	bool "Big endian"
+
+config CPU_LITTLE_ENDIAN
+	bool "Little endian"
+
+endchoice
+
 config SWAP
 	def_bool n
 
diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index 740f2b8..1f6c486 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -35,6 +35,8 @@ endif
 CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_DIV) += -mno-xl-soft-div
 CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_BARREL) += -mxl-barrel-shift
 CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_PCMP_INSTR) += -mxl-pattern-compare
+CPUFLAGS-$(CONFIG_BIG_ENDIAN) += -mbig-endian
+CPUFLAGS-$(CONFIG_LITTLE_ENDIAN) += -mlittle-endian
 
 CPUFLAGS-1 += $(call cc-option,-mcpu=v$(CPU_VER))
 
-- 
1.7.1

