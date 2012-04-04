From: David Miller <davem@davemloft.net>
Date: Wed, 04 Apr 2012 07:38:18 +0000
Subject: Re: [PATCH v2] serial/sunzilog: fix keyboard on SUN SPARCstation
Message-Id: <20120404.033818.1909793141543472462.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120404073506.GA10592@merkur.ravnborg.org>
In-Reply-To: <20120404073506.GA10592@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 4 Apr 2012 09:35:06 +0200

> The keyboard on my SUN SPARCstation 5 no longer worked.
> 
>     The culprint was: d4e33fac2408d37f7b52e80ca2a89f9fb482914f
>     ("serial: Kill off NO_IRQ")
> 
> Fix up logic for no irq / irq so the keyboard works again.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied.
