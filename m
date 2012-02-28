From: David Miller <davem@davemloft.net>
Date: Tue, 28 Feb 2012 21:08:18 +0000
Subject: Re: [PATCH trivial next 1/9] sparc: Use vsprintf extention %pf with builtin_return_address
Message-Id: <20120228.160818.1053082393913813758.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1330454853.git.joe@perches.com>
	<5788cc9f8e5e9b3d8d2d7b78b2d1fb71325df773.1330454853.git.joe@perches.com>
In-Reply-To: <5788cc9f8e5e9b3d8d2d7b78b2d1fb71325df773.1330454853.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: joe@perches.com
Cc: trivial@kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Tue, 28 Feb 2012 10:49:30 -0800

> Emit the function name not the address when possible.
> 
> builtin_return_address() gives an address.  When building
> a kernel with CONFIG_KALLSYMS, emit the actual function
> name not the address.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied to sparc-next, thanks Joe.
