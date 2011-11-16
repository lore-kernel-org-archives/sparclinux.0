From: David Miller <davem@davemloft.net>
Date: Wed, 16 Nov 2011 18:27:20 +0000
Subject: Re: [PATCH] sparc: sigutil: Include <linux/errno.h>
Message-Id: <20111116.132720.2002125894413192894.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1321168804.18929.277.camel@deadeye>
In-Reply-To: <1321168804.18929.277.camel@deadeye>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Greg KH <greg@kroah.com>
Date: Wed, 16 Nov 2011 08:41:25 -0800

> On Mon, Nov 14, 2011 at 12:03:39AM -0500, David Miller wrote:
>> From: Ben Hutchings <ben@decadent.org.uk>
>> Date: Sun, 13 Nov 2011 07:20:04 +0000
>> 
>> > This file introduced in 2.6.32.47 currently fails to compile:
>> > 
>> > arch/sparc/kernel/sigutil_64.c: In function 'save_fpu_state':
>> > arch/sparc/kernel/sigutil_64.c:25: error: 'EFAULT' undeclared (first use in this function)
>> > 
>> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
>> > ---
>> > I assume this works in 3.1 due to indirect inclusion of <linux/errno.h>,
>> > but it doesn't in 2.6.32.  It might be worth applying this in mainline
>> > anyway, to avoid that assumption.
>> 
>> Applied, thanks Ben.
> 
> David, should I queue this up in the .32-stable tree now to fix the
> build problem that we have at the moment?

Yes, please do.  Thanks Greg.
