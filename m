From: David Miller <davem@davemloft.net>
Date: Thu, 10 Aug 2017 16:39:17 +0000
Subject: Re: [sparc-next:master 2/7] arch/sparc/kernel/head_64.S:892: Warning: .space or .fill with negative 
Message-Id: <20170810.093917.944068835589724332.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201708101410.4RM0mRyE%fengguang.wu@intel.com>
In-Reply-To: <201708101410.4RM0mRyE%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 10 Aug 2017 14:16:16 +0800

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next.git master
> head:   5389e239eba5ef0e1cad596dba4860890a3e6965
> commit: f10bb00790dd3cf550f7ae6991c4d1a128802c00 [2/7] sparc64: Add 16GB hugepage support

Nitin, there's too much code now in head.S and the size of the initial
block of assembler trap handler overflows the allowed size before this
.skip directive which aligns things.

Unfortunately, I'm going to revert your changes and you'll have to
find a way to fix this.  I did complain how huge the TSB miss page
table walk is getting, and I wasn't kidding ;-)
