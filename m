From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 03 Mar 2005 02:03:21 +0000
Subject: Re: [PATCH] procfs: fix printk format warning
Message-Id: <20050303020321.GV15648@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20050301211005.6a23f2b4.rddunlap@osdl.org>
In-Reply-To: <20050301211005.6a23f2b4.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Mar 01, 2005 at 09:10:05PM -0800, Randy.Dunlap wrote:
> sparc: fix printk format warning:
> fs/proc/proc_misc.c:195: warning: long unsigned int format, unsigned int arg (arg 23)
> Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
> diffstat:>  include/asm-sparc/vaddrs.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

The UL qualifier can't be used directly as VMALLOC_START is used in
assembly (check arch/sparc/kernel/entry.S).


-- wli
