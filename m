From: David Miller <davem@davemloft.net>
Date: Tue, 04 Jan 2011 19:17:00 +0000
Subject: Re: [PATCH 2/7] SPARC/LEON: added support for IRQAMP IRQ Controller
Message-Id: <20110104.111700.39187179.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1294141295-26584-2-git-send-email-daniel@gaisler.com>
In-Reply-To: <1294141295-26584-2-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue,  4 Jan 2011 12:41:30 +0100

> Needed for LEON AMP systems where different CPUs are routed to
> different IRQ controllers. This patch selects the IRQ Controller
> which has been routed to the boot CPU, it is up to the boot loader
> to configure the IRQ controller.
> 
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>

Applied.
