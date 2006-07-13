From: Jima <jima@beer.tclug.org>
Date: Thu, 13 Jul 2006 13:38:28 +0000
Subject: Re: 2.6.18-rc1 fails to boot on Ultra 5
Message-Id: <Pine.LNX.4.64.0607130836140.13948@beer.tclug.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200607131218.k6DCIX3Y025756@harpo.it.uu.se>
In-Reply-To: <200607131218.k6DCIX3Y025756@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Thu, 13 Jul 2006, Mikael Pettersson wrote:
> So ttyS0 became ttyS1, and the serial port at 0x1fff1400040
> disappeared. OTOH, my Ultra5 only has a single serial port
> connector so perhaps the old kernel was wrong in reporting
> two serial ports.

  I don't know about you, but my Ultra 5 has two: the DB25 female connector 
on the board ("A"), and the DB9 male connector on a ribbon cable ("B"). 
This is going off memory, but I'm fairly confident of this.

      Jima
