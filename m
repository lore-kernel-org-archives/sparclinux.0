From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 03 Mar 2005 11:02:57 +0000
Subject: Re: [PATCH] procfs: fix printk format warning
Message-Id: <20050303110257.GW15648@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20050301211005.6a23f2b4.rddunlap@osdl.org>
In-Reply-To: <20050301211005.6a23f2b4.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

William Lee Irwin III wrote:
>> The UL qualifier can't be used directly as VMALLOC_START is used in
>> assembly (check arch/sparc/kernel/entry.S).

On Wed, Mar 02, 2005 at 06:49:05PM -0800, Randy.Dunlap wrote:
> Darn, that gives me some lack of confidence in my cross-build
> tools.  Cross-build results are at:
> https://www.osdl.org/plm-cgi/plm?module=patch_info&patch_idB38
> and sparc build with this patch passed....
> But I do trust that you know what you are talking about and
> that I probably have a toolchain problem.

Okay, in that case, I wonder why it worked.


-- wli
