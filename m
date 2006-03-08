From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 08 Mar 2006 00:35:54 +0000
Subject: Re: Best bet for SPARC SMP and Sunfire V240
Message-Id: <20060307.163554.127023798.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
In-Reply-To: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josh Grebe <josh@brokedown.net>
Date: Tue, 07 Mar 2006 18:27:02 -0600

> If you have 2G and you have 1G per cpu bank, you'll see about 1.5 gig. 
> If you put 2G in one cpu bank, about 1.8G (by memory).  Mine also used 
> to crash when them split, although these days it doesn't do it any more.

I don't understand what is going on with this, Linux doesn't
do anything special in this area.

Whatever is provided in the "available" property of the
"/memory" OBP device tree node, we will use.

So you need to double check what's going on here.  Because
the only sensible explanation is that OBP isn't providing
all of your ram in that property when it should, but that
does not jive with Solaris doing the right thing because
Solaris gets the available memory information the same
exact way.
