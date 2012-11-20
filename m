From: Tobias Klauser <tklauser@distanz.ch>
Date: Tue, 20 Nov 2012 09:44:12 +0000
Subject: Re: [PATCH 145/493] tty: serial: remove use of __devexit_p
Message-Id: <20121120094412.GF25445@distanz.ch>
List-Id: <sparclinux.vger.kernel.org>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-145-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-145-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 2012-11-19 at 19:21:34 +0100, Bill Pemberton <wfp5p@virginia.edu> wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Alan Cox <alan@linux.intel.com> 
> Cc: Tobias Klauser <tklauser@distanz.ch> 
> Cc: Lucas Tavares <lucaskt@linux.vnet.ibm.com> 
> Cc: "David S. Miller" <davem@davemloft.net> 
> Cc: Peter Korsgaard <jacmet@sunsite.dk> 
> Cc: Tony Prisk <linux@prisktech.co.nz> 
> Cc: linux-serial@vger.kernel.org 
> Cc: nios2-dev@sopc.et.ntust.edu.tw 
> Cc: uclinux-dist-devel@blackfin.uclinux.org 
> Cc: sparclinux@vger.kernel.org 
> Cc: linux-arm-kernel@lists.infradead.org 
> ---
[...]
>  drivers/tty/serial/altera_jtaguart.c |  2 +-
>  drivers/tty/serial/altera_uart.c     |  2 +-

Acked-by: Tobias Klauser <tklauser@distanz.ch>
