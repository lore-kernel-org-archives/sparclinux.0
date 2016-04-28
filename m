From: Rich Felker <dalias@libc.org>
Date: Thu, 28 Apr 2016 17:58:44 +0000
Subject: Re: [patch V3] lib: GCD: add binary GCD algorithm
Message-Id: <20160428175843.GZ21636@brightrain.aerifal.cx>
List-Id: <sparclinux.vger.kernel.org>
References: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
 <20160428164856.10120.qmail@ns.horizon.com>
 <CAMuHMdU2e2PdwKYVaEsJ73X8Di1XHNPqnxuunr8R8bN8udazxw@mail.gmail.com>
In-Reply-To: <CAMuHMdU2e2PdwKYVaEsJ73X8Di1XHNPqnxuunr8R8bN8udazxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Apr 28, 2016 at 07:51:06PM +0200, Geert Uytterhoeven wrote:
> On Thu, Apr 28, 2016 at 6:48 PM, George Spelvin <linux@horizon.com> wrote:
> > Another few comments:
> >
> > 1. Would ARCH_HAS_FAST_FFS involve fewer changes than CPU_NO_EFFICIENT_FFS?
> 
> No, as you want to _disable_ ARCH_HAS_FAST_FFS / _enable_
> CPU_NO_EFFICIENT_FFS as soon as you're enabling support for a
> CPU that doesn't support it.
> 
> Logical OR is easier in both the Kconfig and C preprocessor languages
> than logical NAND.
> 
> E.g. in Kconfig, a CPU core not supporting it can just select
> CPU_NO_EFFICIENT_FFS.

How does a CPU lack an efficient ffs/ctz anyway? There are all sorts
of ways to implement it without a native insn, some of which are
almost or just as fast as the native insn on cpus that have the
latter. On anything with a fast multiply, the de Bruijn sequence
approach is near-optimal, and otherwise one of the binary-search type
approaches (possibly branchless) can be used. If the compiler doesn't
generate an appropriate one for __builtin_ctz, that's arguably a
compiler bug.

Rich
