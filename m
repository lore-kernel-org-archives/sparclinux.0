From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 17 Jul 2014 07:52:04 +0000
Subject: Re: Sparc: Fix Mes in highmem.c
Message-Id: <20140717075204.GA15569@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <CAPDOMVjTxTNTfgPJMz6eNfabXuvtJ43YMpEeDEQ236EtF168Cg@mail.gmail.com>
In-Reply-To: <CAPDOMVjTxTNTfgPJMz6eNfabXuvtJ43YMpEeDEQ236EtF168Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nick Krause <xerofoify@gmail.com>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Jul 16, 2014 at 10:25:30PM -0400, Nick Krause wrote:
> I am hitting three Fix mes in this file and am wondering as the
> maintainer how you would like
> to clean them up.

They may be addressed if we one day decide to give the sparc32 highmem
support a big overhaul. Until then they are left as is.

	Sam
