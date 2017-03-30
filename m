From: Fengguang Wu <lkp@intel.com>
Date: Thu, 30 Mar 2017 11:27:17 +0000
Subject: Re: [kbuild-all] [PATCH] serial: Do not treat the IIR register as a bitfield
Message-Id: <20170330112717.pfaz7c5yicbdvhzs@wfg-t540p.sh.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <201703301843.OZzxWtxO%fengguang.wu@intel.com>
 <1490869971.708.66.camel@linux.intel.com>
In-Reply-To: <1490869971.708.66.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jason Uy <jason.uy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ed Blake <ed.blake-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org, Alexander

On Thu, Mar 30, 2017 at 01:32:51PM +0300, Andy Shevchenko wrote:
>On Thu, 2017-03-30 at 18:22 +0800, kbuild test robot wrote:
>
>>    drivers/net//irda/smsc-ircc2.c:
>
>> > > drivers/net//irda/smsc-ircc2.c:
>
>Just out of my curiosity, why do we have // in some reports?

Log shows the bisect runs

        make M=drivers/net/

That should explain the // in error messages.

Thanks,
Fengguang
