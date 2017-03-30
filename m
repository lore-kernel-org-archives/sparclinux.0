From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 30 Mar 2017 10:32:51 +0000
Subject: Re: [PATCH] serial: Do not treat the IIR register as a bitfield
Message-Id: <1490869971.708.66.camel@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <201703301843.OZzxWtxO%fengguang.wu@intel.com>
In-Reply-To: <201703301843.OZzxWtxO%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "David S . Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org, Ed Blake <ed.blake-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Jason Uy <jason.uy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Tony

On Thu, 2017-03-30 at 18:22 +0800, kbuild test robot wrote:

>    drivers/net//irda/smsc-ircc2.c:

> > > drivers/net//irda/smsc-ircc2.c:

Just out of my curiosity, why do we have // in some reports?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
