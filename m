From: David Miller <davem@davemloft.net>
Date: Tue, 22 Aug 2006 20:39:01 +0000
Subject: Re: sym53c8xx PCI card broken in 2.6.18
Message-Id: <20060822.133901.110902970.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200608221546.11532.dj@david-web.co.uk>
In-Reply-To: <200608221546.11532.dj@david-web.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, dj@david-web.co.uk


Sounds like the interrupts are being misconfigured for the
PCI card.  Please post 2 pieces of information:

1) Boot logs with "ofdebug=2" given on the kernel command line
2) Output of "/usr/sbin/prtconf -pv"

Thanks.
