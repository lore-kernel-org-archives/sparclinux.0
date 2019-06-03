From: David Miller <davem@davemloft.net>
Date: Mon, 03 Jun 2019 05:15:50 +0000
Subject: Re: [PATCH] mdesc: fix a missing-check bug in get_vdev_port_node_info()
Message-Id: <20190602.221550.1371676212285136500.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190531012418.GA4473@zhanggen-UX430UQ>
In-Reply-To: <20190531012418.GA4473@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: blackgod016574@gmail.com
Cc: rppt@linux.vnet.ibm.com, mhocko@suse.com, akpm@linux-foundation.org, sfr@canb.auug.org.au, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Gen Zhang <blackgod016574@gmail.com>
Date: Fri, 31 May 2019 09:24:18 +0800

> In get_vdev_port_node_info(), 'node_info->vdev_port.name' is allcoated
> by kstrdup_const(), and it returns NULL when fails. So 
> 'node_info->vdev_port.name' should be checked.
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

Applied, thanks.
