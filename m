From: David Miller <davem@davemloft.net>
Date: Wed, 23 Aug 2006 04:01:36 +0000
Subject: Re: sym53c8xx PCI card broken in 2.6.18
Message-Id: <20060822.210136.59470258.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060822.133901.110902970.davem@davemloft.net>
	<200608222339.43511.dj@david-web.co.uk>
	<ec7cefb0608222059g48c36384keefedf8e19771cb7@mail.gmail.com>
In-Reply-To: <ec7cefb0608222059g48c36384keefedf8e19771cb7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ebrower@gmail.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: "Eric Brower" <ebrower@gmail.com>
Date: Tue, 22 Aug 2006 20:59:14 -0700

> The envctrl OOPS is definately my fault in the blind conversion of the
> driver to the OF interface-- of_find_propery() return values should be
> checked for NULL rather than relying upon a -1 value stored into lenp.
>  We can discuss this separately, since you are using an out-of-kernel
> driver.

Ok.

BTW, it is better to use "of_get_property()" if you are actually
interested in the value since it will return a void pointer to the
property value instead of a "struct property".  of_find_property() is
useful if you just want to check for existence or if you want to
modify the property value.
