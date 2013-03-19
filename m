From: David Miller <davem@davemloft.net>
Date: Tue, 19 Mar 2013 20:30:21 +0000
Subject: Re: [PATCH] sparc: remove unused "config BITS"
Message-Id: <20130319.163021.554696658570846637.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1363712807.1390.26.camel@x61.thuisdomein>
	<20130319201454.GA25072@merkur.ravnborg.org>
	<1363724768.1390.36.camel@x61.thuisdomein>
In-Reply-To: <1363724768.1390.36.camel@x61.thuisdomein>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: pebolle@tiscali.nl
Cc: sam@ravnborg.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Paul Bolle <pebolle@tiscali.nl>
Date: Tue, 19 Mar 2013 21:26:08 +0100

> On Tue, 2013-03-19 at 21:14 +0100, Sam Ravnborg wrote:
>> On Tue, Mar 19, 2013 at 06:06:47PM +0100, Paul Bolle wrote:
>> > So $(BITS) is set depending on whether CONFIG_SPARC32 is set or not.
>> > Using $(BITS) in sparc's Makefiles is not using CONFIG_BITS. That
>> > doesn't count as usage of "config BITS". 
>> Just double checked - you are right.
> 
> Thanks.
> 
>> Maybe send a v2 with this info in changelog and add my:
>> 
>> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> 
> David: should I send a second version with a line or two on the
> (non-related) use of BITS in the Makefiles and Sam's ACK?

Like I replied to Sam, no need, I took care of this.
