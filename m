From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sat, 27 Apr 2019 13:03:35 +0000
Subject: Re: [PATCH 37/41] drivers: tty: serial: 8250: simplify io resource size computation
Message-Id: <ba6dd5fa-36f1-902d-1ab4-c99e6a5ea3c2@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1556369542-13247-1-git-send-email-info@metux.net>
 <1556369542-13247-38-git-send-email-info@metux.net>
In-Reply-To: <1556369542-13247-38-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org
Cc: lorenzo.pieralisi@arm.com, linux-ia64@vger.kernel.org, linux-serial@vger.kernel.org, andrew@aj.id.au, gregkh@linuxfoundation.org, sudeep.holla@arm.com, liviu.dudau@arm.com, linux-mips@vger.kernel.org, vz@mleia.com, linux@prisktech.co.nz, sparclinux@vger.kernel.org, khilman@baylibre.com, macro@linux-mips.org, slemieux.tyco@gmail.com, matthias.bgg@gmail.com, jacmet@sunsite.dk, linux-amlogic@lists.infradead.org, andriy.shevchenko@linux.intel.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On 4/27/19 2:52 PM, Enrico Weigelt, metux IT consult wrote:
> Simpily io resource size computation by setting mapsize field.
    ^^^^
Here's a typo

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
