From: David Miller <davem@davemloft.net>
Date: Tue, 29 Aug 2006 21:53:32 +0000
Subject: Re: Sparc termios.h
Message-Id: <20060829.145332.118949580.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1156885191.6271.133.camel@localhost.localdomain>
In-Reply-To: <1156885191.6271.133.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 29 Aug 2006 21:59:50 +0100

> Can someone explain to me the somewhat strange termios structure stuff
> going on in both sparc32 and sparc64. I'm adding c_ispeed/c_ospeed to
> termios and updating ports/adding new ioctls when neccessary but I'm not
> clear what the sparc folks are trying to achieve.

Some of the c_cc[] array entries (specifically entries 4 and 5) are
aliased, and their meaning is determined by whether ICANON is set.
