From: David Miller <davem@davemloft.net>
Date: Thu, 19 Apr 2012 17:36:06 +0000
Subject: Re: failing kthread_create_on_node()
Message-Id: <20120419.133606.625830542453036203.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4F8BED36.7000304@gaisler.com>
In-Reply-To: <4F8BED36.7000304@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This is still mysterious, because no other platform sees this problem.

You need to first determine why other platforms bootup properly on SMP
and only sparc32 does not.

This is the first question every scheduler hacker is going to ask
you when you propose that strange patch you just posted.
