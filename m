From: David Miller <davem@davemloft.net>
Date: Wed, 13 Feb 2008 22:24:32 +0000
Subject: Re: [GIT]: Make LMB code sharable with sparc64.
Message-Id: <20080213.142432.206908646.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080213.004120.22092044.davem@davemloft.net>
	<D846801F-AA6B-4238-9FA4-A712EABFE800@kernel.crashing.org>
In-Reply-To: <D846801F-AA6B-4238-9FA4-A712EABFE800@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: galak@kernel.crashing.org
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org

From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 13 Feb 2008 07:12:26 -0600

> Does sparc have the concept of a phys_addr_t?  We are in the process  
> of expanding the lmb support to deal with 36-bit physical addresses on  
> 32-bit machines.

On sparc64, where I intend to use this, unsigned long's are 64-bit.
If you use some phys_addr_t type instead to help ppc32 along, that
would be perfectly fine with me.
