From: Palmer Dabbelt <palmer@dabbelt.com>
Date: Sat, 03 Jun 2017 02:18:08 +0000
Subject: Re: [PATCH 4/7] mips: Use lib/{ashldi3,ashrdi3,cmpdi2,lshrdi3,ucmpdi2}.c
Message-Id: <mhng-fc1d65cf-1943-4c73-8fae-b13ee8349d2f@palmer-si-x1c4>
List-Id: <sparclinux.vger.kernel.org>
References: <a870bfb8-a1c8-220e-460c-baa03b3fd554@imgtec.com>
In-Reply-To: <a870bfb8-a1c8-220e-460c-baa03b3fd554@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: matt.redfearn@imgtec.com
Cc: monstr@monstr.eu, ralf@linux-mips.org, liqin.linux@gmail.com, lennox.wu@gmail.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, 24 May 2017 02:01:39 PDT (-0700), matt.redfearn@imgtec.com wrote:
> Hi Palmer,
> This patch doesn't quite match the subject, since it only removes the
> mips specific implementation of __ucmpdi2. The following patch removes
> all of the intrinsics that you added to lib/ from arch/mips/lib. I've
> built & boot tested this on a MIPS pistachio platform.
> Note that this patch will require rebasing on linux-next, since it will
> conflict with other changes in arch/mips/Kconfig
>
> Thanks,
> Matt
>
> [PATCH] MIPS: Use generic libgcc intrinsics
>
> These routines in arch/mips/lib/ are functionally identical to those
> recently added to lib/ so remove them and select the generic ones.
>
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> ---
>   arch/mips/Kconfig       |  5 +++++
>   arch/mips/lib/Makefile  |  2 +-
>   arch/mips/lib/ashldi3.c | 29 -----------------------------
>   arch/mips/lib/ashrdi3.c | 31 -------------------------------
>   arch/mips/lib/cmpdi2.c  | 27 ---------------------------
>   arch/mips/lib/libgcc.h  | 25 -------------------------
>   arch/mips/lib/lshrdi3.c | 29 -----------------------------
>   arch/mips/lib/ucmpdi2.c | 21 ---------------------
>   8 files changed, 6 insertions(+), 163 deletions(-)
>   delete mode 100644 arch/mips/lib/ashldi3.c
>   delete mode 100644 arch/mips/lib/ashrdi3.c
>   delete mode 100644 arch/mips/lib/cmpdi2.c
>   delete mode 100644 arch/mips/lib/libgcc.h
>   delete mode 100644 arch/mips/lib/lshrdi3.c
>   delete mode 100644 arch/mips/lib/ucmpdi2.c

Sorry about that, I'll take your version and submit a v2.
