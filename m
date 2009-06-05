From: David Miller <davem@davemloft.net>
Date: Fri, 05 Jun 2009 07:46:18 +0000
Subject: Re: SILO & Ext4
Message-Id: <20090605.004618.70433870.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670906010333x16cbae69g667a7441be2f140a@mail.gmail.com>
In-Reply-To: <a4423d670906010333x16cbae69g667a7441be2f140a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Thu, 04 Jun 2009 22:49:25 -0400

> I'm looking at head_32.S and head_64.s to try and figure
> out what's involved in making sparc32 relocatable but I'm
> not sure what to look for. Any hints?

You'll have to learn how to load kernel TLB entries for about 4 or 5
different major TLB/cache types on sun4c, sun4m, and sun4d systems.

This is what you need to do to relocate the kernel into a new location
then jump to it.
