From: David Miller <davem@davemloft.net>
Date: Thu, 24 Dec 2009 04:52:41 +0000
Subject: Re: [RFC][PATCH 14/14] Convert sparc to
Message-Id: <20091223.205241.70185990.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1261541643.3508.74.camel@localhost.localdomain>
	<1261541703.3508.75.camel@localhost.localdomain>
	<1261541771.3508.76.camel@localhost.localdomain>
In-Reply-To: <1261541771.3508.76.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: johnstul@us.ibm.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: john stultz <johnstul@us.ibm.com>
Date: Tue, 22 Dec 2009 20:16:11 -0800

> This patch converts the sparc architecture to use the generic
> read_persistent_clock and update_persistent_clock interfaces, reducing
> the amount of arch specific code we have to maintain, and allowing for
> further cleanups in the future.
> 
> I have not built or tested this patch, so help from arch maintainers
> would be appreciated.
> 
> Signed-off-by: John Stultz <johnstul@us.ibm.com>

This looks fine to me:

Acked-by: David S. Miller <davem@davemloft.net>
