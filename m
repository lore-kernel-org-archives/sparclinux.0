From: David Miller <davem@davemloft.net>
Date: Thu, 11 Mar 2010 16:16:01 +0000
Subject: Re: XVR-500 additional pci ids
Message-Id: <20100311.081601.35313210.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201002251955.23519.dennis@ausil.us>
In-Reply-To: <201002251955.23519.dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frans van Berckel <fberckel@xs4all.nl>
Date: Thu, 11 Mar 2010 09:30:31 +0100

> Thanks for asking. Attaching XVR 1000 (SUNW,gfb) prtconf -pv.

We were talking about XVR-1200, and this isn't an XVR-1200, it's not
even a PCI card.

It does occupy a PCI slot because it is so huge, but it actually
operates out of the UPA slot.
