From: "Randy.Dunlap" <rddunlap@osdl.org>
Date: Thu, 03 Mar 2005 02:49:05 +0000
Subject: Re: [PATCH] procfs: fix printk format warning
Message-Id: <42267B21.2020405@osdl.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20050301211005.6a23f2b4.rddunlap@osdl.org>
In-Reply-To: <20050301211005.6a23f2b4.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

William Lee Irwin III wrote:
> On Tue, Mar 01, 2005 at 09:10:05PM -0800, Randy.Dunlap wrote:
> 
>>sparc: fix printk format warning:
>>fs/proc/proc_misc.c:195: warning: long unsigned int format, unsigned int arg (arg 23)
>>Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
>>diffstat:>> include/asm-sparc/vaddrs.h |    4 ++--
>> 1 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> The UL qualifier can't be used directly as VMALLOC_START is used in
> assembly (check arch/sparc/kernel/entry.S).

Darn, that gives me some lack of confidence in my cross-build
tools.  Cross-build results are at:
https://www.osdl.org/plm-cgi/plm?module=patch_info&patch_idB38
and sparc build with this patch passed....

But I do trust that you know what you are talking about and
that I probably have a toolchain problem.

-- 
~Randy
