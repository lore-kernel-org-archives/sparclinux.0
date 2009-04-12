From: Mark Farnell <mark.farnell@gmail.com>
Date: Sun, 12 Apr 2009 21:32:33 +0000
Subject: Re: getting the program counter from sparc64 under gcc/glibc linux
Message-Id: <aaf549e0904121432o68f0b5dfvbc216ba442072c50@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <aaf549e0904111624s386eb6dfm1401a5561dfdc2f1@mail.gmail.com>
In-Reply-To: <aaf549e0904111624s386eb6dfm1401a5561dfdc2f1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I am a bit confused here.

The signal handler will be:

void (*sa_sigaction)(int, siginfo_t *, void *);

in your last email, do you mean that I should cast the last argument
to sigcontext_t rather than ucontext_t?

Thanks!

Mark


On Sun, Apr 12, 2009 at 8:25 PM, David Miller <davem@davemloft.net> wrote:
> From: Mark Farnell <mark.farnell@gmail.com>
> Date: Sun, 12 Apr 2009 11:24:30 +1200
>
>> How can I get the program counter which points to the instruction that
>> causes the write-segmentation fault under GNU/Linux SPARC64?
>
> Look at the dwarf2 unwind support code in the GCC sources of
> the signal handler support in the MONO tree.
>
> We provide the register values differently than other platforms,
> there isn't a ucontext available but there is a sigcontext_t:
>
> From the sigcontext you can get at the program counter by
> accessing sc->sigc_regs.tpc on 64-bit sparc and
> sc->si_regs.pc on 32-bit sparc.
>
