From: David Miller <davem@davemloft.net>
Date: Fri, 10 Oct 2008 19:12:51 +0000
Subject: Re: [PATCH] cg6.c disable cursor when leaving graphics mode
Message-Id: <20081010.121251.113589666.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <48EF3D2A.9040505@earthlink.net>
In-Reply-To: <48EF3D2A.9040505@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Fri, 10 Oct 2008 07:31:54 -0400

> On sparc32 debian etch, the cursor is not disabled
> when leaving X windows.  This patch disables the
> cursor when leaving graphics mode just like the
> ffb driver.
> 
> Signed-off-by: Robert Reif <reif@earthlink.net>

Applied to sparc-next-2.6.
