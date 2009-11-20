From: David Miller <davem@davemloft.net>
Date: Fri, 20 Nov 2009 23:58:16 +0000
Subject: Re: 2.6.31.6 freezes on v210
Message-Id: <20091120.155816.164283058.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20091120210249.A20906@linux.karinthy.hu>
In-Reply-To: <20091120210249.A20906@linux.karinthy.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Sat, 21 Nov 2009 00:48:56 +0100

> On Fri, Nov 20, 2009 at 02:49:51PM -0800, David Miller wrote:
>> It's a well known issue we've been trying to track down for some time
>> now.  We still have no real idea what the exact problem is.
>> 
>> Somone has a remote console setup for me to diagnose this remotely
>> since none of my own systems trigger this behavior.
> 
> Is this the same NMI watchdog issue that I reported with v240?

No, it's the one where the system hangs in the middle of firing
a uevent after the first device registers.

> Is that last sentence incomplete (s/has/has to do/)?

No it is not, Hermann Lauer is the person who has set this
up for me.
