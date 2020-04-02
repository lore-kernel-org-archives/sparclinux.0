From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 02 Apr 2020 14:03:02 +0000
Subject: Re: [sparc64] OOPS after 'serial: core: Allow detach and attach serial device for console'
Message-Id: <20200402140302.GB1922688@smile.fi.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqwHdRd=3fzr=-9hdR7_cW2VXXHwoySzbSpWx+aZ1S=ysA@mail.gmail.com>
In-Reply-To: <CADxRZqwHdRd=3fzr=-9hdR7_cW2VXXHwoySzbSpWx+aZ1S=ysA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Apr 02, 2020 at 02:24:59PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 02, 2020 at 02:00:51PM +0300, Anatoly Pugachev wrote:
> > Hello!
> > 
> > Bisected the following call trace on kernel boot with linux sparc64
> > debian sid LDOM:
> > 
> 
> Thank you, I'm on it.
> 
> Briefly looking it among these lines
> 
> static inline void uart_port_spin_lock_init(struct uart_port *port)
> {
> 	- if (uart_console_enabled(port))
> 	+ if (uart_console(port))
> 
> which reveals an issue in the sparc code.
> 
> I'm going to look further into it...

Meanwhile, can you replace above and test if it fixes your case?

-- 
With Best Regards,
Andy Shevchenko
