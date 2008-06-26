From: David Miller <davem@davemloft.net>
Date: Thu, 26 Jun 2008 09:06:21 +0000
Subject: Re: [10 PATCHES] inline functions to avoid stack overflow
Message-Id: <20080626.020621.45250426.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806250843460.20379@engineering.redhat.com>
	<20080625.150931.182895076.davem@davemloft.net>
	<e2e108260806252332k3ffe3c63o29556f5b9d89c4a3@mail.gmail.com>
In-Reply-To: <e2e108260806252332k3ffe3c63o29556f5b9d89c4a3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bart.vanassche@gmail.com
Cc: mpatocka@redhat.com, helge.hafting@aitel.hist.no, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, gcc@gcc.gnu.org

From: "Bart Van Assche" <bart.vanassche@gmail.com>
Date: Thu, 26 Jun 2008 08:32:35 +0200

> On Thu, Jun 26, 2008 at 12:09 AM, David Miller <davem@davemloft.net> wrote:
> > The extra 16 bytes of space allocated is so that GCC can perform a
> > secondary reload of a quad floating point value.  It always has to be
> > present, because we can't satisfy a secondary reload by emitting yet
> > another reload, it's the end of the possible level of recursions
> > allowed by the reload pass.
> 
> Is there any floating-point code present in the Linux kernel ?

Yes, but not coming from C compiled code.  Floating point is
used in most of the memcpy/memset implementations of the
sparc64 kernel.

> Would it be a good idea to add an option to gcc that tells gcc that
> the compiled code does not contain floating-point instructions, such
> that gcc knows that no space has to be provided for a quad floating
> point value ?

I think it exists already, it's called -mno-fpu :-)
