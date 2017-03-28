From: David Miller <davem@davemloft.net>
Date: Tue, 28 Mar 2017 04:38:28 +0000
Subject: Re: [PATCH] sparc64: kern_addr_valid regression
Message-Id: <20170327.213828.279684208188568647.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170310193119.18768-1-bob.picco@oracle.com>
In-Reply-To: <20170310193119.18768-1-bob.picco@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bob.picco@oracle.com>
Date: Fri, 10 Mar 2017 14:31:19 -0500

> From: bob picco <bob.picco@oracle.com>
> 
> I encountered this bug when using /proc/kcore to examine the kernel. Plus a
> coworker inquired about debugging tools. We computed pa but did
> not use it during the maximum physical address bits test. Instead we used
> the identity mapped virtual address which will always fail this test.
> 
> I believe the defect came in here:
> [bpicco@zareason linus.git]$ git describe --contains bb4e6e85daa52
> v3.18-rc1~87^2~4
> .
> 
> Signed-off-by: Bob Picco <bob.picco@oracle.com>

Applied and queued up for -stable, thanks Bob.
