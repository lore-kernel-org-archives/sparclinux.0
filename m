From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 25 Nov 2010 20:52:04 +0000
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
Message-Id: <1290718324.32570.127.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <1290607413.12457.44.camel@concordia>
	 <1290692075.689.20.camel@concordia>
	 <AANLkTim9fPPWO-240dmavng+j=70G8Y4P-+j3Y+OZTL0@mail.gmail.com>
In-Reply-To: <AANLkTim9fPPWO-240dmavng+j=70G8Y4P-+j3Y+OZTL0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: michael@ellerman.id.au, linux-arch <linux-arch@vger.kernel.org>, linux-mips <linux-mips@linux-mips.org>, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org

On Thu, 2010-11-25 at 15:01 +0100, Geert Uytterhoeven wrote:
> 
> I always read it as "for each child-OF-node", so I would rename it to
> "dt_for_each_child_node".

Well, it was meant to be for_child_of_node not _OF_node :-)

Cheers,
Ben.


