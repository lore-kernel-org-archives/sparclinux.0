From: David Miller <davem@davemloft.net>
Date: Wed, 10 Jul 2013 20:42:36 +0000
Subject: Re: [PATCH] sunvnet: vnet_port_remove must call unregister_netdev
Message-Id: <20130710.134236.1858860840226789075.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <51D1F962.1020409@oracle.com>
In-Reply-To: <51D1F962.1020409@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Mon, 01 Jul 2013 16:49:22 -0500

> The missing call to unregister_netdev() leaves the interface active
> after the driver is unloaded by rmmod.
> 
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>

Applied.
