From: David Miller <davem@davemloft.net>
Date: Thu, 12 Oct 2006 21:52:18 +0000
Subject: Re: [PATCH] sparc32: remove '-s' boot argument
Message-Id: <20061012.145218.90121152.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061012152243.GA21924@palantir8>
In-Reply-To: <20061012152243.GA21924@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Thu, 12 Oct 2006 16:22:43 +0100

> The '-s' boot argument is not working and not needed. Users should use
> argument 's' or '1' to boot into single user mode.
> This patch removes the remains of the '-s' argument.
> 
> Martin
> 
> 	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

Applied, and I killed it from sparc64 too.
