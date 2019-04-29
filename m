From: Peter Korsgaard <peter@korsgaard.com>
Date: Mon, 29 Apr 2019 15:26:00 +0000
Subject: Re: [PATCH 12/41] drivers: tty: serial: uartlite: use dev_dbg() instead of pr_debug()
Message-Id: <875zqwrfxz.fsf@dell.be.48ers.dk>
List-Id: <sparclinux.vger.kernel.org>
References: <1556369542-13247-1-git-send-email-info@metux.net>
 <1556369542-13247-13-git-send-email-info@metux.net>
In-Reply-To: <1556369542-13247-13-git-send-email-info@metux.net> (Enrico
 Weigelt's message of "Sat, 27 Apr 2019 14:51:53 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: lorenzo.pieralisi@arm.com, linux-ia64@vger.kernel.org, macro@linux-mips.org, andrew@aj.id.au, gregkh@linuxfoundation.org, slemieux.tyco@gmail.com, liviu.dudau@arm.com, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com, linux-mips@vger.kernel.org, linux@prisktech.co.nz, matthias.bgg@gmail.com, khilman@baylibre.com, linux-serial@vger.kernel.org, sudeep.holla@arm.com, sparclinux@vger.kernel.org, jacmet@sunsite.dk, linux-amlogic@lists.infradead.org, vz@mleia.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

>>>>> "Enrico" = Enrico Weigelt, metux IT consult <info@metux.net> writes:

 > Using dev_dbg() instead of pr_debg() for more consistent output.
 > (prints device name, etc).

 > Signed-off-by: Enrico Weigelt <info@metux.net>

Acked-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard
