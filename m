From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 06 Apr 2020 10:52:27 +0000
Subject: Re: [PATCH v1] serial: sunhv: Initialize lock for non-registered console
Message-Id: <20200406105227.GP3676135@smile.fi.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200402172026.79478-1-andriy.shevchenko@linux.intel.com>
 <CADxRZqzgenruphXAKE8MJM2zayR7u7yvc=-5YwPHkCN4gW2eNQ@mail.gmail.com>
In-Reply-To: <CADxRZqzgenruphXAKE8MJM2zayR7u7yvc=-5YwPHkCN4gW2eNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anatoly Pugachev <matorola@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Sparc kernel list <sparclinux@vger.kernel.org>, David Miller <davem@davemloft.net>

On Sat, Apr 04, 2020 at 08:50:56PM +0300, Anatoly Pugachev wrote:
> On Thu, Apr 2, 2020 at 8:20 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > The commit a3cb39d258ef
> > ("serial: core: Allow detach and attach serial device for console")
> > changed a bit logic behind lock initialization since for most of the console
> > driver it's supposed to have lock already initialized even if console is not
> > enabled. However, it's not the case for Sparc HV console.
> >
> > Initialize lock explicitly in the ->probe().
> >
> > Note, there is still an open question should or shouldn't not this driver
> > register console properly.
> >
> > Fixes: a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
> > Reported-by: Anatoly Pugachev <matorola@gmail.com>
> > Cc: David Miller <davem@davemloft.net>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/tty/serial/sunhv.c | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> 
> fixes issue for me, sorry for the late testing

Thank you! Can you formally provide a Tested-by tag?

-- 
With Best Regards,
Andy Shevchenko
