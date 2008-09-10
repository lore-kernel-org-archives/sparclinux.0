From: David Miller <davem@davemloft.net>
Date: Wed, 10 Sep 2008 02:43:48 +0000
Subject: Re: [PATCH] sparc: remove unused includes
Message-Id: <20080909.194348.86305262.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080904031137.GA24664@swan5.cs.unc.edu>
In-Reply-To: <20080904031137.GA24664@swan5.cs.unc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Bjoern B. Brandenburg" <bbb@cs.unc.edu>
Date: Wed, 3 Sep 2008 23:11:37 -0400

> The spinlock code does not use NR_CPUS.
> Compile tested using allyesconfig and allnoconfig.
> 
> Signed-off-by: Bjoern B. Brandenburg <bbb@cs.unc.edu>

Applied to sparc-next-2.6, thanks Bjoern.
