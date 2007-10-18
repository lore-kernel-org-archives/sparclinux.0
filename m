From: linas@austin.ibm.com (Linas Vepstas)
Date: Thu, 18 Oct 2007 19:09:39 +0000
Subject: Re: [PATCH 2/2] Use of_get_pci_dev_node() in axon_msi.c
Message-Id: <20071018190939.GE29903@austin.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <8f76815cbbaf5fbab82c843d87bc0dafab038c80.1192605144.git.michael@ellerman.id.au>
	<dadd2b9540369b9e2c6773b2a60021dadafa58e2.1192605144.git.michael@ellerman.id.au>
	<20071017230449.GZ4891@austin.ibm.com>
	<1192670843.6681.10.camel@concordia>
In-Reply-To: <1192670843.6681.10.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Ellerman <michael@ellerman.id.au>
Cc: sparclinux@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>, linuxppc-dev@ozlabs.org

On Thu, Oct 18, 2007 at 11:27:23AM +1000, Michael Ellerman wrote:
> 
> It does what pci_device_to_OF_node() does, but in the right way. 
> 
> The plan is to remove pci_device_to_OF_node() once all the callers have
> been converted to properly handle the refcounting. 

Oh. Yes. well, of course, then. Excellent reason. I didn't get 
that from the patch commit comments. So, FWIW:

Ack'ed-by: Linas Vepstas <linas@austin.ibm.com>

--linas

