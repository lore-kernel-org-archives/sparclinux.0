From: David Miller <davem@davemloft.net>
Date: Sun, 12 Jan 2020 08:05:04 +0000
Subject: Re: [PATCH] tty: n_hdlc: fix build on SPARC
Message-Id: <20200112.000504.1994757840298424991.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <675e7bd9-955b-3ff3-1101-a973b58b5b75@infradead.org>
In-Reply-To: <675e7bd9-955b-3ff3-1101-a973b58b5b75@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rdunlap@infradead.org
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, akpm@linux-foundation.org, gregkh@linuxfoundation.org, keescook@chromium.org, lkp@intel.com

From: Randy Dunlap <rdunlap@infradead.org>
Date: Mon, 30 Sep 2019 19:15:12 -0700

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix tty driver build on SPARC by not using __exitdata.
> It appears that SPARC does not support section .exit.data.
> 
> Fixes these build errors:
> 
> `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
> `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
> `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
> `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: 063246641d4a ("format-security: move static strings to const")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

I'll add an .exit.data to arch/sparc/kernel/vmlinux.lds.S to fix this.
