From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 29 Apr 2019 13:19:30 +0000
Subject: Re: [PATCH 37/41] drivers: tty: serial: 8250: simplify io resource size computation
Message-Id: <20190429131930.GE9224@smile.fi.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1556369542-13247-1-git-send-email-info@metux.net>
 <1556369542-13247-38-git-send-email-info@metux.net>
 <20190428152103.GP9224@smile.fi.intel.com>
 <431b36fe-3071-fcfd-b04e-b4b293e79a80@metux.net>
In-Reply-To: <431b36fe-3071-fcfd-b04e-b4b293e79a80@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: sparclinux@vger.kernel.org, lorenzo.pieralisi@arm.com, linux-ia64@vger.kernel.org, linux-serial@vger.kernel.org, andrew@aj.id.au, gregkh@linuxfoundation.org, sudeep.holla@arm.com, liviu.dudau@arm.com, linux-kernel@vger.kernel.org, vz@mleia.com, linux@prisktech.co.nz, linuxppc-dev@lists.ozlabs.org, khilman@baylibre.com, macro@linux-mips.org, slemieux.tyco@gmail.com, matthias.bgg@gmail.com, jacmet@sunsite.dk, linux-amlogic@lists.infradead.org, linux-mips@vger.kernel.org, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, davem@davemloft.net

On Mon, Apr 29, 2019 at 08:48:53AM +0200, Enrico Weigelt, metux IT consult wrote:
> On 28.04.19 17:21, Andy Shevchenko wrote:

> >> +#define SERIAL_RT2880_IOSIZE	0x100
> > 
> > And why this is in the header file and not in corresponding C one?
> 
> hmm, no particular reason, maybe just an old habit to put definitions
> into .h files ;-)
> 
> I can move it to 8250_of.c if you like me to.

Please, do.

-- 
With Best Regards,
Andy Shevchenko
