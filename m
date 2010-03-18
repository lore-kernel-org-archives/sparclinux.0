From: Jochen Friedrich <jochen@scram.de>
Date: Thu, 18 Mar 2010 15:58:32 +0000
Subject: Re: [V2 PATCH 06/10] of/drivers: Always use struct device.of_node
Message-Id: <4BA24DA8.9030309@scram.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20100318144836.21082.93040.stgit@angua>
	<20100318152238.21082.10985.stgit@angua>
In-Reply-To: <20100318152238.21082.10985.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-kernel@vger.kernel.org, michal.simek@petalogix.com, microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

Hi Grant,

> The following structure elements duplicate the information in
> 'struct device.of_node' and so are being eliminated.  This patches
> makes all readers of the following elements use device.of_node instead.
> 
> struct dev_archdata.prom_node (sparc)
> struct dev_archdata.of_node (powerpc)
> struct of_device.node
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
>  drivers/i2c/busses/i2c-ibm_iic.c              |    4 ++--
>  drivers/i2c/busses/i2c-mpc.c                  |   17 ++++++++-------

drivers/i2c/busses/i2c-cpm.c is missing in this patch.

Thanks,
Jochen
