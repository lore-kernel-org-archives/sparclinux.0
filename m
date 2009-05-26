From: David Miller <davem@davemloft.net>
Date: Tue, 26 May 2009 09:23:48 +0000
Subject: Re: [bbc_i2c] howto read CPU temp ?
Message-Id: <20090526.022348.156314847.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4A1BA00E.9070204@systella.fr>
In-Reply-To: <4A1BA00E.9070204@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND Jo=EBl <joel.bertrand@systella.fr>
Date: Tue, 26 May 2009 10:48:09 +0200

> 	Thanks a lot for your answer. I shall add a /proc/bbc_i2c that only
> 	exports CPU, ambiant values and fan speed.

Ok.

I didn't persue this because long ranger I want to move all of
the BBC stuff over to proper I2C layer and HW monitor layer
drivers.

I even did this work, but the I2C maintainer didn't like how
I implemented I2C bus selection support for these BBC I2C
chips.  So I need to redo that work at some point to finish
things off

See the patches under:

	http://vger.kernel.org/~davem/i2c/

some of which are already in the tree.
=09
