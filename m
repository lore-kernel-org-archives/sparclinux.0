From: Frans van Berckel <fberckel@xs4all.nl>
Date: Thu, 06 Jan 2011 13:41:13 +0000
Subject: Re: [PATCH] cassini: Use local-mac-address prom property for
Message-Id: <1294321273.1612.12.camel@deblnxsrv222>
List-Id: <sparclinux.vger.kernel.org>
References: <1294273030.6193.31.camel@duncow>
In-Reply-To: <1294273030.6193.31.camel@duncow>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 2011-01-06 at 00:17 +0000, Richard Mortimer wrote:
> Fallback on the local-mac-address prom property if the Cassini device
> does not have an address programmed in the VPD ROM. This uses the same
> technique as implemented by the sungem driver.
> 
> The problem was reported by Frans van Berckel using Debian kernel 2.6.34-7
> on Sun Fire V440. udev was assigning a new eth<n> device name on each reboot
> because the cassini driver was using a random MAC address.
> 
> Fix tested on 2.6.34-7/Sun Fire V440. Compile tested only against 2.6.36
> davem/sparc-2.6.git because Sun Fire V440 does not currently boot recent
> kernels so runtime test is not possible at present.
> 
> Reported-by: Frans van Berckel <fberckel@xs4all.nl>
> Tested-by: Frans van Berckel <fberckel@xs4all.nl>
> Signed-off-by: Richard Mortimer <richm@oldelvet.org.uk>

Good news. I did a 2.6.37 release build today with this patch. It's boot
tested now and goes the same as it did in 2.6.34-7. Being happy.

