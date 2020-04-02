From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 02 Apr 2020 17:38:00 +0000
Subject: Re: [PATCH v1] serial: sunhv: Initialize lock for non-registered console
Message-Id: <20200402173800.GA3220509@kroah.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200402172026.79478-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200402172026.79478-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org, sparclinux@vger.kernel.org, Anatoly Pugachev <matorola@gmail.com>, David Miller <davem@davemloft.net>

On Thu, Apr 02, 2020 at 08:20:26PM +0300, Andy Shevchenko wrote:
> The commit a3cb39d258ef
> ("serial: core: Allow detach and attach serial device for console")
> changed a bit logic behind lock initialization since for most of the console
> driver it's supposed to have lock already initialized even if console is not
> enabled. However, it's not the case for Sparc HV console.
> 
> Initialize lock explicitly in the ->probe().
> 
> Note, there is still an open question should or shouldn't not this driver
> register console properly.
> 
> Fixes: a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> Cc: David Miller <davem@davemloft.net>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/sunhv.c | 3 +++
>  1 file changed, 3 insertions(+)

Thanks, will pick this up after -rc1 is out.

greg k-h
