From: David Miller <davem@davemloft.net>
Date: Thu, 26 Mar 2009 20:54:51 +0000
Subject: Re: configs
Message-Id: <20090326.135451.262323297.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <c785bba30903250909y5c742607sc32a26ab06b87350@mail.gmail.com>
In-Reply-To: <c785bba30903250909y5c742607sc32a26ab06b87350@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Paul Thomas <pthomas8589@gmail.com>
Date: Thu, 26 Mar 2009 10:08:30 -0700

> Thanks for the response. That makes sense. It is a lot different from
> ARM. Does the hypervisor handle the XAUI interfaces also? I see there
> is a SUNVNET driver. Is that how the kernel accesses the network? It
> all seems like a very elegant solution. Is the hypervisor under GPL
> license?

The SUNVNET driver is for logical domain guest, not for for
Linux executing with access to PCI segments.  Linux running
on "real iron" uses the normal PCI drivers for whatever network
hardware is available.

The hypervisor only gets involved with the XAUI interfaces when you
want to export portions of the NIU network device to logical domain
guests from control comains.  Linux has a full hardware driver for the
NIU chip, drivers/net/niu.c

The hypervisor is GPL'd and available from www.opensparc.org, you want
the "Architecture and Performance Modeling" download that contains the
full openfirmware and hypervisor sources.
