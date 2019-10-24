From: Michal Simek <michal.simek@xilinx.com>
Date: Thu, 24 Oct 2019 10:13:10 +0000
Subject: [PATCH 0/2] Enabling MSI for Microblaze
Message-Id: <cover.1571911976.git.michal.simek@xilinx.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com, palmer@sifive.com, hch@infradead.org, longman@redhat.com, helgaas@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jackie Liu <liuyun01@kylinos.cn>, Wesley Terpstra <wesley@sifive.com>, Firoz Khan <firoz.khan@linaro.org>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, James Hogan <jhogan@kernel.org>, Vineet Gupta <vgupta@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Walmsley <paul.walmsley@sifive.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.>

Hi,

these two patches come from discussion with Christoph, Bjorn, Palmer and
Waiman. The first patch was suggestion by Christoph here
https://lore.kernel.org/linux-riscv/20191008154604.GA7903@infradead.org/
The second part was discussed
https://lore.kernel.org/linux-pci/mhng-5d9bcb53-225e-441f-86cc-b335624b3e7c@palmer-si-x1e/
and
https://lore.kernel.org/linux-pci/20191017181937.7004-1-palmer@sifive.com/

Thanks,
Michal


Michal Simek (1):
  asm-generic: Make msi.h a mandatory include/asm header

Palmer Dabbelt (1):
  pci: Default to PCI_MSI_IRQ_DOMAIN

 arch/arc/include/asm/Kbuild     | 1 -
 arch/arm/include/asm/Kbuild     | 1 -
 arch/arm64/include/asm/Kbuild   | 1 -
 arch/mips/include/asm/Kbuild    | 1 -
 arch/powerpc/include/asm/Kbuild | 1 -
 arch/riscv/include/asm/Kbuild   | 1 -
 arch/sparc/include/asm/Kbuild   | 1 -
 drivers/pci/Kconfig             | 2 +-
 include/asm-generic/Kbuild      | 1 +
 9 files changed, 2 insertions(+), 8 deletions(-)

-- 
2.17.1
