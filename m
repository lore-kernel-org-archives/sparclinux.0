From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 06 Dec 2008 08:37:27 +0000
Subject: Re: [PATCH 0/14]: Commonization of OF device tree code.
Message-Id: <20081206083727.GA16234@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20081205.190455.152563946.davem@davemloft.net>
In-Reply-To: <20081205.190455.152563946.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Dec 05, 2008 at 07:04:55PM -0800, David Miller wrote:
> 
> This tries to split out as much common code from
> arch/sparc/kernel/prom_{32,64}.c as possible.
> 
> There is an ugly ifdef or two left in the new
> prom_common.c but that once I can fix at some
> point by rejigging the 32-bit prom_firstprop() et al.
> oplib interfaces.


The diffstat looks good:

 arch/sparc/include/asm/openprom_32.h |    6
 arch/sparc/include/asm/oplib_32.h    |    6
 arch/sparc/kernel/Makefile           |    2
 arch/sparc/kernel/prom.h             |   48 +
 arch/sparc/kernel/prom_32.c          |  341 ----------
 arch/sparc/kernel/prom_64.c          | 1153 -----------------------------------
 arch/sparc/kernel/prom_common.c      |  356 ++++++++++
 arch/sparc/kernel/prom_irqtrans.c    |  844 +++++++++++++++++++++++++
 arch/sparc/prom/tree_32.c            |    8
 9 files changed, 1275 insertions(+), 1489 deletions(-)

As for the individual patches I have only browsed them and
nothing suspicious showed up.

	Sam
