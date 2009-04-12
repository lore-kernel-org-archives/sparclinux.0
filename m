From: David Miller <davem@davemloft.net>
Date: Sun, 12 Apr 2009 08:25:46 +0000
Subject: Re: getting the program counter from sparc64 under gcc/glibc linux
Message-Id: <20090412.012546.255530881.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <aaf549e0904111624s386eb6dfm1401a5561dfdc2f1@mail.gmail.com>
In-Reply-To: <aaf549e0904111624s386eb6dfm1401a5561dfdc2f1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Farnell <mark.farnell@gmail.com>
Date: Sun, 12 Apr 2009 11:24:30 +1200

> How can I get the program counter which points to the instruction that
> causes the write-segmentation fault under GNU/Linux SPARC64?

Look at the dwarf2 unwind support code in the GCC sources of
the signal handler support in the MONO tree.

We provide the register values differently than other platforms,
there isn't a ucontext available but there is a sigcontext_t:

From the sigcontext you can get at the program counter by
accessing sc->sigc_regs.tpc on 64-bit sparc and
sc->si_regs.pc on 32-bit sparc.
