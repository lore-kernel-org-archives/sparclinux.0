From: David Miller <davem@davemloft.net>
Date: Sun, 23 Oct 2011 20:35:12 +0000
Subject: Re: longjmp question
Message-Id: <20111023.163512.647802693869570811.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111007232209.GA11892@wooyd.org>
In-Reply-To: <20111007232209.GA11892@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 23 Oct 2011 14:47:27 +0100

> On Sat, Oct 22, 2011 at 06:54:05PM -0400, David Miller wrote:
>>
>> Just let the compiler do it for you, please... the compiler absolutely cannot
>> optimize away a function that uses a volatile asm statement.  And it absolutely
>> cannot make a function that clobbers %o7 a leaf function.
> 
> That's not what I see. I tried writing up a patch for Ruby using this, 
> and here's what I get:
> 
> 1. Preprocessed source of cont.c contains flush_register_windows 
> definition:
> 
> # 219 "./include/ruby/defines.h"
> static void
> flush_register_windows(void)
> {
>     asm __volatile__ ("flushw" : : : "o7");
> }

You can't put it in a header file, GCC will inline it.  You have to
put it in a function in a seperate C file, and this is what I said to
do the other week in my original email.

You're only other option is to explicitly mark this
__attribute__((__noinline__))
