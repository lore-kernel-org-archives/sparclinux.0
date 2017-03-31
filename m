From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 31 Mar 2017 14:44:26 +0000
Subject: Re: [PATCH] serial: Do not treat the IIR register as a bitfield
Message-Id: <CAHp75VeomHb32NxgBbg1W51_FqyjjU-6DEM4KOFZY_pu0mrwbQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170329184431.6226-1-oliver@schinagl.nl> <1490867763.708.62.camel@linux.intel.com>
 <b962b00c-64d7-0b55-2fde-5a3ea04d8671@schinagl.nl>
In-Reply-To: <b962b00c-64d7-0b55-2fde-5a3ea04d8671@schinagl.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Laxman Dewangan <ldewangan@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "David S . Miller" <davem@davemloft.net>, dev@linux-sunxi.org, Ed Blake <ed.blake@imgtec.com>, Alexander Sverdlin <alexander.sverdlin@nokia.com>, Yegor Yefremov <yegorslists@googlemail.com>, Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiko Stuebner <heiko@sntech.de>, Jason Uy <jason.uy@broadcom.com>, Douglas Anderson <dianders@chromium.org>

On Fri, Mar 31, 2017 at 4:54 PM, Olliver Schinagl
<o.schinagl@ultimaker.com> wrote:
> On 30-03-17 11:56, Andy Shevchenko wrote:
>> On Wed, 2017-03-29 at 20:44 +0200, Olliver Schinagl wrote:

>> Looking to implementation I would rather go with some helper like
>>
>> int serial_in_IIR(port, [additional mask])
>> {
>>  return port->serial_in(port, UART_IIR) & (_IIR_MASK [| additional
>> mask]);
>> }

> As I just wrote a simply static inline helper function in serial_core.h, I
> just figured that the helper will only work for some of the calls. All
> interrupt checks in xxx_serial_in() obviously can't rely on this. So do you
> still want this helper function added for the other cases? Or have all
> implementations do the masking manually?

You have still few places (3+ IIRC) where it makes sense.

> And then, is iir = serial_port_in(up, UART_IIR) & UART_IIR_MASK; preferred
> over splitting it over two lines, like I did?

With given indentation it might be long enough to uglify the code.

So, I would still go with one / two helpers (do your own choice), but
if you insist that is not beneficial I would not object in-place
masking.

static inline int serial_in_IIR_mask(port, mask)
{
 return ... & mask;
}

static inline int serial_in_IIR(port)
{
return serial_in_IIR_mask(port, ..._IIR_MASK);
}

> Finally, why rename it to _IIR_MASK, I assume a typo here?

I usually do such to minimize characters to type (notice leading _
which means I referred to a suffix) and that's why the work "like" is
used above implying you need to modify to function correctly.

-- 
With Best Regards,
Andy Shevchenko
