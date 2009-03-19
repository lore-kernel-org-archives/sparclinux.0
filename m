From: David Miller <davem@davemloft.net>
Date: Thu, 19 Mar 2009 06:53:31 +0000
Subject: Re: [PATCH] crash with /proc/iomem on sparc64
Message-Id: <20090318.235331.65960278.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0903170758060.24107@hs20-bc2-1.build.redhat.com>
	<Pine.LNX.4.64.0903170807440.25109@hs20-bc2-1.build.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0903170807440.25109@hs20-bc2-1.build.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpatocka@redhat.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 17 Mar 2009 08:08:08 -0400 (EDT)

> 
> 
> On Tue, 17 Mar 2009, Mikulas Patocka wrote:
> 
> > Hi
> > 
> > When you compile kernel on Sparc64 with heap memory checking and type
> > "cat /proc/iomem", you get a crash, because pointers in struct resource 
> > are uninitialized.
> > 
> > Most code fills struct resource with zeros, so I assume that it is 
> > responsibility of the caller of request_resource to initialized it, not 
> > the responsibility of request_resource functuion.
> > 
> > After 2.6.29 is out, there could be a check for uninitialized fields added 
> > to request_resource to avoid crashes like this.
> > 
> > Mikulas
> 
> I forgot to add:
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Patch applied and queued up for -stable, thanks a lot.
