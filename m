From: linas@austin.ibm.com (Linas Vepstas)
Date: Wed, 17 Oct 2007 23:04:49 +0000
Subject: Re: [PATCH 2/2] Use of_get_pci_dev_node() in axon_msi.c
Message-Id: <20071017230449.GZ4891@austin.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <8f76815cbbaf5fbab82c843d87bc0dafab038c80.1192605144.git.michael@ellerman.id.au>
	<dadd2b9540369b9e2c6773b2a60021dadafa58e2.1192605144.git.michael@ellerman.id.au>
In-Reply-To: <dadd2b9540369b9e2c6773b2a60021dadafa58e2.1192605144.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Ellerman <michael@ellerman.id.au>
Cc: sparclinux@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>, linuxppc-dev@ozlabs.org

On Wed, Oct 17, 2007 at 05:12:27PM +1000, Michael Ellerman wrote:

> +struct device_node *of_get_pci_dev_node(struct pci_dev *pdev)
> +{
> +       return of_node_get(pci_device_to_OF_node(pdev));
> +}

[...]

> -	dn = of_node_get(pci_device_to_OF_node(dev));
> +	dn = of_get_pci_dev_node(dev);

Is this really useful or wise?

As a matter of personal taste, I find stuff like this clutters
and confuses my mind. I go to read new code, and I run across some
routine I haven't heard of before ... e.g. of_get_pci_dev_node(),
so now I have to look it up to see what it does.  A few minutes later, 
I realize that its just a pair of old freinds (of_node_get and 
pci_device_to_OF_node) and so now I have to make mental room for it.  

Tommorrow, or 3 days later, I'm again looking at of_get_pci_dev_node()
and I'm thinking "gee what did that thing do again??"

I don't much like this style, and I've been known to submit
patches that remove stuff like this ... 

--linas
