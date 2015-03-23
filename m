From: David Miller <davem@davemloft.net>
Date: Mon, 23 Mar 2015 19:10:12 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20150323.151012.864173599849398929.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20150323.125537.767987027704780801.davem@davemloft.net>
	<CA+55aFx0Sw4xWGNdVhcOqH2XN=Q=CNgCLS7Ru3m2Lf_T88nKHA@mail.gmail.com>
In-Reply-To: <CA+55aFx0Sw4xWGNdVhcOqH2XN=Q=CNgCLS7Ru3m2Lf_T88nKHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Mar 2015 10:05:10 -0700

> On Mon, Mar 23, 2015 at 9:55 AM, David Miller <davem@davemloft.net> wrote:
>>
>> Some perf bug fixes from David Ahern, and the fix for that nasty
>> memmove() bug.
> 
> That doesn't seem to be marked for stable? Or do you do the same thing
> as for networking, and just collect stable patches manually?

Yes, I do sparc stuff manually and queue it up at:

	http://patchwork.ozlabs.org/bundle/davem/stable/?state=*
