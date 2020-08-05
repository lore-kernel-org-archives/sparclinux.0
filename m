From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 05 Aug 2020 17:11:30 +0000
Subject: Re: [PATCH v2 16/17] memblock: implement for_each_reserved_mem_region() using __next_mem_region()
Message-Id: <CANiq72k-hZwbnttADQhi3+NrHkLDVe95jxLAPvLbvSOW41+HaQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200802163601.8189-1-rppt@kernel.org>
 <20200802163601.8189-17-rppt@kernel.org>
In-Reply-To: <20200802163601.8189-17-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Emil Renner Berthing <kernel@esmil.dk>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>, clang-built-linux <clang-built-linux@googlegroups.com>, Ingo

On Sun, Aug 2, 2020 at 6:40 PM Mike Rapoport <rppt@kernel.org> wrote:
>
>  .clang-format                    |  2 +-

The .clang-format bit:

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
