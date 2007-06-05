From: David Miller <davem@davemloft.net>
Date: Tue, 05 Jun 2007 06:58:28 +0000
Subject: Re: section mismatches from sun4v*_patch in trampoline.S
Message-Id: <20070604.235828.61504499.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070602203206.GA13700@uranus.ravnborg.org>
In-Reply-To: <20070602203206.GA13700@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 2 Jun 2007 22:32:06 +0200

> I do not know if it is OK to use .init.text??
> I would assume that CONFIG_HOTPLUG_CPU had impact here.

The __INIT and __INITDATA assembler macros in linux/init.h for a while
would select the section properly based upon whether CPU hotplug was
enabled or not, but that got reverted by:

838c41184fee5e151c09972f2ba90c16493af614

I guess it's much better to put the ugly ifdefs into the assembler
code by someone's estimation :-( That's how the x86 trampoline.S, for
example, is handling this.

The sparc64 trampoline.S should definitely use .init.foo when
CPU hotplug is enabled.
