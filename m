From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 18 Aug 2020 22:18:00 +0000
Subject: Re: [PATCH v3 10/17] memblock: reduce number of parameters in for_each_mem_range()
Message-Id: <CANiq72mnzTv7SphVxsYy++rAPdaKVVLGGHauxNLY5D4dzq3CPA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200818151634.14343-1-rppt@kernel.org> <20200818151634.14343-11-rppt@kernel.org>
In-Reply-To: <20200818151634.14343-11-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Baoquan He <bhe@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christoph Hellwig <hch@lst.de>, Daniel Axtens <dja@axtens.net>, Dave Hansen <dave.hansen@linux.intel.com>, Emil Renner Berthing <kernel@esmil.dk>, Ingo Molnar <mingo@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, clang-built-linux <clang-built-linux@googlegroups.com>, iommu@lists.linux-foundation.org, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-c6x-dev@linux-c6x.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>

On Tue, Aug 18, 2020 at 5:19 PM Mike Rapoport <rppt@kernel.org> wrote:
>
>  .clang-format                          |  2 ++

For the .clang-format bit:

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
