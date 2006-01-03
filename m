From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 03 Jan 2006 22:08:28 +0000
Subject: Re: SILO 1.4.10
Message-Id: <20060103.140828.98009037.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1136175018.27583.50.camel@grayson>
In-Reply-To: <1136175018.27583.50.camel@grayson>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Tue, 03 Jan 2006 21:52:07 +0000

> I just took at quick look at the Debian elftoaout sources and the a.out
> Exec header definition uses unsigned long to hold the values. These will
> have the wrong size when compiled 64 bit. I tried changing it to
> unsigned int and the 64 bit version now produces the same output as the
> 32 bit one when tested against a vmlinux that I had hanging around.
> 
> Patch below.

Right, I just posted a similar patch using u_int{8,16,32,64}_t and
friends.
