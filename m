From: David Miller <davem@davemloft.net>
Date: Thu, 04 Jun 2009 09:01:21 +0000
Subject: Re: [PATCH] move of_device common code to of_device_common
Message-Id: <20090604.020121.26513511.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49754324.2080201@earthlink.net>
In-Reply-To: <49754324.2080201@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Mon, 19 Jan 2009 22:21:08 -0500

> This patch moves code common to of_device_32.c and of_device_64.c into
> of_device_common.h and of_device_common.c.
> 
> The only functional difference is in sparc32 where of_bus_default_map
> is used in place of of_bus_sbus_map because they are equivelent.
> 
> There is still room for further code consolidation with some minor
> refactoring.
> 
> Boot tested on sparc32 and compile tested on sparc64.
> 
> Signed-off-by: Robert Reif <reif@earthlink.net>

Applied to sparc-next-2.6, thanks Robert!
