From: "John Stoffel" <john@stoffel.org>
Date: Mon, 23 Mar 2015 19:56:02 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <21776.28626.30072.920618@quad.stoffel.home>
List-Id: <sparclinux.vger.kernel.org>
References: <20150322.221906.1670737065885267482.davem@davemloft.net>
	<20150323.122530.812870422534676208.davem@davemloft.net>
	<21776.17527.912997.355420@quad.stoffel.home>
	<20150323.151613.1149103262130397921.davem@davemloft.net>
In-Reply-To: <20150323.151613.1149103262130397921.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: john@stoffel.org, david.ahern@oracle.com, torvalds@linux-foundation.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpicco@meloft.net

>>>>> "David" = David Miller <davem@davemloft.net> writes:

David> From: "John Stoffel" <john@stoffel.org>
David> Date: Mon, 23 Mar 2015 12:51:03 -0400

>> Would it make sense to have some memmove()/memcopy() tests on bootup
>> to catch problems like this?  I know this is a strange case, and
>> probably not too common, but how hard would it be to wire up tests
>> that go through 1 to 128 byte memmove() on bootup to make sure things
>> work properly?
>> 
>> This seems like one of those critical, but subtle things to be
>> checked.  And doing it only on bootup wouldn't slow anything down and
>> would (ideally) automatically get us coverage when people add new
>> archs or update the code.

David> One of two things is already happening.

David> There have been assembler memcpy/memset development test harnesses
David> around that most arch developers are using, and those test things
David> rather extensively.

David> Also, the memcpy/memset routines on sparc in particular are completely
David> shared with glibc, we use the same exact code in both trees.  So it's
David> getting tested there too.

Thats' good to know.   I wasn't sure.

David> memmove() is just not handled this way.

Bummers.  So why isn't this covered by the glibc tests too?  Not
accusing, not at all!  Just wondering.  

Thanks for all your work David, I've been amazed at your energy here!
