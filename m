From: David Miller <davem@davemloft.net>
Date: Fri, 10 Oct 2008 19:13:30 +0000
Subject: Re: [PATCH] leo.c disable cursor when leaving graphics mode
Message-Id: <20081010.121330.131261921.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <48EF3D92.2070102@earthlink.net>
In-Reply-To: <48EF3D92.2070102@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Fri, 10 Oct 2008 07:33:38 -0400

> On sparc32 debian etch, the cursor is not disabled
> when leaving X windows.  This patch disables the
> cursor when leaving graphics mode just like the
> ffb driver.
> 
> Signed-off-by: Robert Reif <reif@earthlink.net>

Also applied, thanks.
