From: David Miller <davem@davemloft.net>
Date: Sun, 27 Feb 2011 23:24:33 +0000
Subject: Re: [PATCH] sparc64: fix unused-but-set-variable warnings
Message-Id: <20110227.152433.179928285.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110226085151.GA23117@merkur.ravnborg.org>
In-Reply-To: <20110226085151.GA23117@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 27 Feb 2011 14:12:19 +0100

> On Sat, Feb 26, 2011 at 11:41:12PM -0800, David Miller wrote:
>> +	/* We should probably check for hypervisor errors here and
>> +	 * reset the LDC channel if we get one.
>> +	 */
> 
> Coding style purist would say that the comment should look like this:

Not in my coding style.  That initial comment line is wasted space.

And a coding style purist would understand why that very rule
goes aginst the proported reasoning behind the coding style
rules (eliminating wasted space so more real information fits on
the screen at once) and would thus have the rules fixed.

:-)

I will reject any future changes from you which add wasted vertical
space like this, so please don't get into the habit of trying to inject
this folly into either sparc or the networking, thanks.
