From: David Miller <davem@davemloft.net>
Date: Sun, 12 Jun 2011 00:58:34 +0000
Subject: Re: [PATCH] sparc, exec: remove redundant addr_limit assignment
Message-Id: <20110611.175834.1802167158365693401.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1307711453-17412-1-git-send-email-minipli@googlemail.com>
	<20110611.160842.2135350880385482648.davem@davemloft.net>
	<20110611234415.GE11521@ZenIV.linux.org.uk>
In-Reply-To: <20110611234415.GE11521@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: viro@ZenIV.linux.org.uk
Cc: minipli@googlemail.com, akpm@linux-foundation.org, torvalds@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Sun, 12 Jun 2011 00:44:15 +0100

> On Sat, Jun 11, 2011 at 04:08:42PM -0700, David Miller wrote:
>> From: Mathias Krause <minipli@googlemail.com>
>> Date: Fri, 10 Jun 2011 15:10:53 +0200
>> 
>> > @@ -368,9 +368,6 @@ void flush_thread(void)
>> >  
>> >  	/* Clear FPU register state. */
>> >  	t->fpsaved[0] = 0;
>> > -	
>> > -	if (get_thread_current_ds() != ASI_AIUS)
>> > -		set_fs(USER_DS);
>> >  }
>> 
>> Yeah but now you're doing it unconditionally, the guard is here
>> because the %asi register write which set_fs() does is extremely
>> expensive on sparc64 and %99.99999 of the time we can avoid it.
> 
> OTOH, get_thread_current_ds() is cheap and moving that into set_fs()
> itself wouldn't be particulary bad idea...

The reason the test is only in this specific spot, is that's the only
place where the optimization makes any sense.

The rest of the time it's in compat layer code or similar, where we
know the set_fs() is actually necessary.

Therefore, expanding the test into every set_fs() call would be
wasteful.
