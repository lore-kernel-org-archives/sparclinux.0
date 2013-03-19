From: David Miller <davem@davemloft.net>
Date: Tue, 19 Mar 2013 20:23:24 +0000
Subject: Re: [PATCH] sparc: remove unused "config BITS"
Message-Id: <20130319.162324.1623264491858670284.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20130319.123306.1709006318806942163.davem@davemloft.net>
	<1363712807.1390.26.camel@x61.thuisdomein>
	<20130319201454.GA25072@merkur.ravnborg.org>
In-Reply-To: <20130319201454.GA25072@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org
Cc: pebolle@tiscali.nl, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 19 Mar 2013 21:14:54 +0100

> On Tue, Mar 19, 2013 at 06:06:47PM +0100, Paul Bolle wrote:
>> On Tue, 2013-03-19 at 12:33 -0400, David Miller wrote:
>> > We use this in the Makefile fragments, you cannot remove it.
>> 
>> >From arch/sparc/Makefile:
>>     ifeq ($(CONFIG_SPARC32),y)
>>     [...]
>> 
>>     [...]
>>     export BITS    := 32
>>     [...]
>> 
>>     else
>>     [...]
>> 
>>     [...]
>>     export BITS   := 64
>>     [...]
>> 
>> So $(BITS) is set depending on whether CONFIG_SPARC32 is set or not.
>> Using $(BITS) in sparc's Makefiles is not using CONFIG_BITS. That
>> doesn't count as usage of "config BITS". 
> Just double checked - you are right.
> Maybe send a v2 with this info in changelog and add my:
> 
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

No need, I'll fix up the commit message.
