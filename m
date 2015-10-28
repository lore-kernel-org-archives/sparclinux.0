From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 28 Oct 2015 00:29:52 +0000
Subject: Re: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
Message-Id: <1445992192.1856.23.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
 <20151026.182746.1323901353520152838.davem@davemloft.net>
 <20151027222010.GD7716@linux.vnet.ibm.com>
 <CAGRGNgXV+RJvjOBe351HyguYkonQ8F=CM3uZTijcqoQg6ArAcw@mail.gmail.com>
 <20151027234018.GA48779@linux.vnet.ibm.com>
 <CAGRGNgVvvcjHFjU4H1wnj6bGy69X19d-xR9O+Xc-p-TmtPxNgQ@mail.gmail.com>
In-Reply-To: <CAGRGNgVvvcjHFjU4H1wnj6bGy69X19d-xR9O+Xc-p-TmtPxNgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 2015-10-28 at 10:43 +1100, Julian Calaby wrote:
> Hi Nishanth,
> You'll be CCing the maintainers of each architecture on the patches
> to
> add the functions, so if they do have specific requirements, I'm sure
> they'll let you know or provide patches.

That sort of accross-all-arch change tend to take forever. I'd rather
get the existing series in to fix the problem, we can look into
improving things later but I tend to think that the default of using
PAGE_SHIFT in asm-generic will be fine for most archs.

Ben.

