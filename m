From: David Miller <davem@davemloft.net>
Date: Sat, 03 Apr 2010 06:47:35 +0000
Subject: Re: Kernel panic - not syncing: Irrecoverable deferred error trap
Message-Id: <20100402.234735.213347924.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1270240845.1783.52.camel@deblnxsrv254.localdomain>
In-Reply-To: <1270240845.1783.52.camel@deblnxsrv254.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Frans, please retry your test case, but please add
"of_debug=1 ofpci_debug=1" to the kernel command line
options.

Send the kernel log you get as a result, thanks!
