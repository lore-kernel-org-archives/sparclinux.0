From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Date: Mon, 29 Apr 2019 16:20:31 +0000
Subject: Re: [PATCH 22/41] drivers: tty: serial: cpm_uart: fix logging calls
Message-Id: <fc01df37-3e7e-0c71-745d-63fbd83c1079@metux.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1556369542-13247-1-git-send-email-info@metux.net>
 <1556369542-13247-23-git-send-email-info@metux.net>
 <a00ba23b-e73e-c964-a6d0-347cb605b8c8@c-s.fr>
In-Reply-To: <a00ba23b-e73e-c964-a6d0-347cb605b8c8@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe Leroy <christophe.leroy@c-s.fr>, "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org
Cc: lorenzo.pieralisi@arm.com, linux-ia64@vger.kernel.org, macro@linux-mips.org, andrew@aj.id.au, gregkh@linuxfoundation.org, slemieux.tyco@gmail.com, liviu.dudau@arm.com, linux-mips@vger.kernel.org, vz@mleia.com, linux@prisktech.co.nz, matthias.bgg@gmail.com, khilman@baylibre.com, linux-serial@vger.kernel.org, sudeep.holla@arm.com, sparclinux@vger.kernel.org, jacmet@sunsite.dk, linux-amlogic@lists.infradead.org, andriy.shevchenko@linux.intel.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On 29.04.19 17:59, Christophe Leroy wrote:

> If we want to do something useful, wouldn't it make more sense to
> introduce the use of dev_err() in order to identify the faulting device
> in the message ?

Well, I could get the struct device* pointer via pinfo.port->dev,
but I wasn't entirely sure that it's always defined before these
functions could be called.

Shall I change it to dev_*() ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
