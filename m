From: David Miller <davem@davemloft.net>
Date: Mon, 17 Jul 2006 08:31:44 +0000
Subject: Re: 2.6.18-rc1 fails to boot on E250
Message-Id: <20060717.013144.36663090.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060714.165308.83620688.davem@davemloft.net>
In-Reply-To: <20060714.165308.83620688.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Marc Zyngier <maz@misterjones.org>
Date: Mon, 17 Jul 2006 09:26:01 +0200

> While it obviously looks better (no more NULL translators), the
> machine hangs before probing the SCSI controllers. And the serial
> console is painfully slow as soon as the console is switched from PROM
> to SAB.
> 
> Looks like this E250 is an odd beast...

Please turn off CONFIG_PROM_CONSOLE if you have that thing
enabled, just as a test.

Thanks.
