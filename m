From: Bastian Blank <waldi@debian.org>
Date: Mon, 17 Jan 2011 14:37:56 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <20110117143755.GA1119@wavehammer.waldi.eu.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4D3074FE.3030707@oldelvet.org.uk>
 <20110115.211722.39173519.davem@davemloft.net>
 <1295187469.22527.13.camel@duncow>
 <20110116.113944.48514452.davem@davemloft.net>
 <1295273486.16479.15.camel@gandalf.stny.rr.com>
In-Reply-To: <1295273486.16479.15.camel@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>, 609371@bugs.debian.org
Cc: David Miller <davem@davemloft.net>, richm@oldelvet.org.uk, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@redhat.com, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

On Mon, Jan 17, 2011 at 09:11:26AM -0500, Steven Rostedt wrote:
> The problem comes when the linker puts these sections together. We read
> all the sections as one big array. If the linker puts in holes, then
> this breaks the array, and the kernel crashes while reading the section.

I think this are still bugs in the linker script. #537862[1] was the
first occurance, but I don't find further information.

Bastian

[1]: http://bugs.debian.org/537862
-- 
What kind of love is that?  Not to be loved; never to have shown love.
		-- Commissioner Nancy Hedford, "Metamorphosis",
		   stardate 3219.8
