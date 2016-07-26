From: rodent@NetBSD.org
Date: Tue, 26 Jul 2016 00:00:32 +0000
Subject: Re: QLogic PTI firmware
Message-Id: <20160726000029.GC4153@nixsyspaus.org>
List-Id: <sparclinux.vger.kernel.org>
References: <fdca2bc4e057d30a2981a5237e2428ef@triadic.us>
In-Reply-To: <fdca2bc4e057d30a2981a5237e2428ef@triadic.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Jul 25, 2016 at 06:14:28PM -0400, alexmcwhirter@triadic.us wrote:
> [...]
> Does anyone have any input on this? Fixing this would help stabilize a 
> ton of early sparc64 machines, almost everything with a scsi controller 
> around the US2 days use and isp1000 card.

IIRC, the Alphas had a few of these isp chips in SCSI adapters which came with
the machines. You might get two-for-one by fixing this. Perhaps, some of this
might help:

http://netbsd.gw.com/cgi-bin/man-cgi?isp++NetBSD-current

http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/dev/pci/isp_pci.c?rev=1.119&content-type=text/x-cvsweb-markup&only_with_tag=MAIN
