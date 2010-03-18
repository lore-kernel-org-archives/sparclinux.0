From: Sean MacLennan <smaclennan@pikatech.com>
Date: Thu, 18 Mar 2010 17:12:12 +0000
Subject: Re: [V2 PATCH 06/10] of/drivers: Always use struct device.of_node
Message-Id: <20100318131212.55bd7689@lappy.seanm.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20100318144836.21082.93040.stgit@angua>
	<20100318152238.21082.10985.stgit@angua>
In-Reply-To: <20100318152238.21082.10985.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-kernel@vger.kernel.org, michal.simek@petalogix.com, microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On Thu, 18 Mar 2010 09:22:39 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> The following structure elements duplicate the information in
> 'struct device.of_node' and so are being eliminated.  This patches
> makes all readers of the following elements use device.of_node
> instead.

Acked-by: Sean MacLennan <smaclennan@pikatech.com>
