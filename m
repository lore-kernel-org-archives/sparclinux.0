From: David Miller <davem@davemloft.net>
Date: Wed, 12 Jul 2017 16:09:02 +0000
Subject: Re: in:imklog segfault in 4.12+git on most sparc64's
Message-Id: <20170712.090902.869068317463454420.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170712035945.GA13102@ZenIV.linux.org.uk>
        <20170711.210902.2170111857155619221.davem@davemloft.net>
        <alpine.LRH.2.20.1707120905530.18096@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1707120905530.18096@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: viro@ZenIV.linux.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 12 Jul 2017 10:09:50 +0300 (EEST)

>> From: Al Viro <viro@ZenIV.linux.org.uk>
>> Date: Wed, 12 Jul 2017 04:59:45 +0100
>> 
>> > Again, my apologies for format of that all - I'm almost completely
>> > off-net and while typing an ed script is feasible, context diff is
>> > too far over the top.  Usimg mutt in ssh session from android is
>> > not fun, to put it mildly...  
>> 
>> Yes, that might be it.
>> 
>> Meelis, please test this:
>> 
>> ==========
>> fix a braino in compat_sys_getrlimit()
>> 
>> Fixes: commit d9e968cb9f84 "getrlimit()/setrlimit(): move compat to native"
>> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>> Acked-by: David S. Miller <davem@davemloft.net>
> 
> Yes, it works right on top of 4.12.0-rc1-00007-gd9e968c and on top of 
> todays git as well. 

Al, please push this to Linus soon.

Thanks.

