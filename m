From: Ralf Baechle <ralf@linux-mips.org>
Date: Fri, 09 Jun 2017 19:53:22 +0000
Subject: Re: [PATCH 7/7] MIPS: Use generic libgcc intrinsics
Message-Id: <20170609195322.GA18307@linux-mips.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20170523220546.16758-1-palmer@dabbelt.com>
 <20170606191023.24581-1-palmer@dabbelt.com>
 <20170606191023.24581-8-palmer@dabbelt.com>
In-Reply-To: <20170606191023.24581-8-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: monstr@monstr.eu, liqin.linux@gmail.com, lennox.wu@gmail.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Matt Redfearn <matt.redfearn@imgtec.com>

On Tue, Jun 06, 2017 at 12:10:23PM -0700, Palmer Dabbelt wrote:

> These routines in arch/mips/lib/ are functionally identical to those
> recently added to lib/ so remove them and select the generic ones.
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>

Thanks, nice cleanup!

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
