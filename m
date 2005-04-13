From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 13 Apr 2005 19:29:53 +0000
Subject: Re: SMP on virtually indexed/tagged cache
Message-Id: <20050413122953.4e15eb13.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <737167738@web.de>
In-Reply-To: <737167738@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 13 Apr 2005 11:26:33 +0200
"Konrad Eisele" <eiselekd@web.de> wrote:

> "David S. Miller" <davem@davemloft.net> schrieb am 12.04.05 21:28:47:
> > 
> > On Tue, 12 Apr 2005 14:50:54 +0200
> > "Konrad Eisele" <eiselekd@web.de> wrote:
> > 
> > > I trying to get sparc32-smp run on a Leon3 sparc,
> > > it uses a  virtually indexed/tagged cache. Is it possible
> > > to run smp on such a processor?
> > 
> > Yes, it's just painful.  Model your cache flushing on the
> > sun4c code.
> > -
> 
> It's difficult to understand how smp works when cache coherency isn't
> done by hardware. 

Oh nevermind, yes that is next to impossible.  If the cpus aren't
doing any cache coherency protocol on the system bus, you're basically
out of luck.

I forgot that physical indexing was necessary for a cache coherency
protocol since the system bus works with physical addresses.
