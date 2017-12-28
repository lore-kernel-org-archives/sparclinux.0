From: David Miller <davem@davemloft.net>
Date: Thu, 28 Dec 2017 01:30:26 +0000
Subject: Re: [PATCH] sparc64: repair calling incorrect hweight function from stubs
Message-Id: <20171227.203026.1435850641149437919.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20171225024353.24458-1-jengelh@inai.de>
In-Reply-To: <20171225024353.24458-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@inai.de>
Date: Mon, 25 Dec 2017 03:43:53 +0100

> Commit v4.12-rc4-1-g9289ea7f952b introduced a mistake that made the
> 64-bit hweight stub call the 16-bit hweight function.
> 
> Fixes: 9289ea7f952b ("sparc64: Use indirect calls in hamming weight stubs")
> Signed-off-by: Jan Engelhardt <jengelh@inai.de>

Applied and queued up for -stable, thanks Jan.
