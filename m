From: "Eric Brower" <ebrower@gmail.com>
Date: Wed, 23 Aug 2006 03:59:14 +0000
Subject: Re: sym53c8xx PCI card broken in 2.6.18
Message-Id: <ec7cefb0608222059g48c36384keefedf8e19771cb7@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200608221546.11532.dj@david-web.co.uk>
	 <20060822.133901.110902970.davem@davemloft.net>
	 <200608222339.43511.dj@david-web.co.uk>
In-Reply-To: <200608222339.43511.dj@david-web.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Cc: David Miller <davem@davemloft.net>

On 8/22/06, David Johnson <dj@david-web.co.uk> wrote:
> On Tuesday 22 August 2006 21:39, you wrote:
> > Sounds like the interrupts are being misconfigured for the
> > PCI card.  Please post 2 pieces of information:
> >
> > 1) Boot logs with "ofdebug=2" given on the kernel command line

The envctrl OOPS is definately my fault in the blind conversion of the
driver to the OF interface-- of_find_propery() return values should be
checked for NULL rather than relying upon a -1 value stored into lenp.
 We can discuss this separately, since you are using an out-of-kernel
driver.

Thanks,
E


> > 2) Output of "/usr/sbin/prtconf -pv"
> >
>
> Both attached.
>
> Now that I've let the system finish booting, there are also a few oopses that
> seem related to the new openprom interface.
>
> Regards,
> David.
>
> --
> David Johnson
> www.david-web.co.uk - My Personal Website
> www.penguincomputing.co.uk - Need a Web Developer?
>
>
>


-- 
E
