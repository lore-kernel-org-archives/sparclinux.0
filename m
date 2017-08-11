From: Anthony Yznaga <anthony.yznaga@oracle.com>
Date: Fri, 11 Aug 2017 04:09:45 +0000
Subject: Re: [sparc-next:master 2/7] arch/sparc/kernel/head_64.S:892: Warning: .space or .fill with negative 
Message-Id: <A4B91FCB-7401-403B-A154-D548EA335D7B@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <201708101410.4RM0mRyE%fengguang.wu@intel.com>
In-Reply-To: <201708101410.4RM0mRyE%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


> On Aug 10, 2017, at 9:39 AM, David Miller <davem@davemloft.net> wrote:
> 
> From: kbuild test robot <fengguang.wu@intel.com>
> Date: Thu, 10 Aug 2017 14:16:16 +0800
> 
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next.git master
>> head:   5389e239eba5ef0e1cad596dba4860890a3e6965
>> commit: f10bb00790dd3cf550f7ae6991c4d1a128802c00 [2/7] sparc64: Add 16GB hugepage support
> 
> Nitin, there's too much code now in head.S and the size of the initial
> block of assembler trap handler overflows the allowed size before this
> .skip directive which aligns things.
> 
> Unfortunately, I'm going to revert your changes and you'll have to
> find a way to fix this.  I did complain how huge the TSB miss page
> table walk is getting, and I wasn't kidding ;-)

A big chunk of space can be freed up by moving the include of hvcall.S to after the trap table.

Anthony


> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

