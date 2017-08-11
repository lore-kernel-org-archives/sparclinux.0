From: David Miller <davem@davemloft.net>
Date: Fri, 11 Aug 2017 04:35:57 +0000
Subject: Re: [sparc-next:master 2/7] arch/sparc/kernel/head_64.S:892: Warning: .space or .fill with negative 
Message-Id: <20170810.213557.626750722922749436.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201708101410.4RM0mRyE%fengguang.wu@intel.com>
In-Reply-To: <201708101410.4RM0mRyE%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Anthony Yznaga <anthony.yznaga@oracle.com>
Date: Thu, 10 Aug 2017 21:09:45 -0700

> A big chunk of space can be freed up by moving the include of
> hvcall.S to after the trap table.

That might be a good way of handling this.
