From: David Miller <davem@davemloft.net>
Date: Thu, 23 Aug 2012 16:20:43 +0000
Subject: Re: [PATCH] sparc64: Add CRC32C driver making use of the new crc32c opcode.
Message-Id: <20120823.092043.1156875617277157051.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120822.143111.2226960299830142976.davem@davemloft.net>
	<20120822.205231.113785660704668571.davem@davemloft.net>
	<20120823083654.GA13395@gondor.apana.org.au>
In-Reply-To: <20120823083654.GA13395@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: herbert@gondor.apana.org.au
Cc: sparclinux@vger.kernel.org, linux-crypto@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 23 Aug 2012 16:36:54 +0800

> On Wed, Aug 22, 2012 at 08:52:31PM -0700, David Miller wrote:
>> 
>> Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> Looks good to me.

Thanks for reviewing.

>> This was largely straightforward, except for two things.
>> 
>> 1) The tests assume that the 32-bit crc is stored in the context in
>>    cpu endian.  The sparc64 crc32c opcode wants to work with a little
>>    endian mode, but sparc64 is big-endian.
> 
> We can still change this as nothing outside the kernel relies
> on the format of the context.  For the time being all that's
> required is that it be identical between software and hardware
> implementations.

Ok, let's just leave it alone for now :-)
