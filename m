From: David Miller <davem@davemloft.net>
Date: Fri, 19 May 2017 19:35:09 +0000
Subject: Re: [PATCH 4/6] arch/sparc: Enable queued rwlocks for SPARC
Message-Id: <20170519.153509.2070245733064513776.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170519090302.ph6jnqzlxxqzrvnu@hirez.programming.kicks-ass.net>
        <20170519.151553.928484900690074462.davem@davemloft.net>
        <20170519193126.vd52mhacekkhq342@hirez.programming.kicks-ass.net>
In-Reply-To: <20170519193126.vd52mhacekkhq342@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: babu.moger@oracle.com, mingo@redhat.com, arnd@arndb.de, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 19 May 2017 21:31:26 +0200

> On Fri, May 19, 2017 at 03:15:53PM -0400, David Miller wrote:
>> However, I don't see what any of this has to do with the feedback
>> I was giving the patch author :-)
> 
> Uhm,... I think my morning brain read things like you having doubts
> about making it sparc64 only. But I could have easily misread things.
> Ignore my ramblings :-)

He was editing a sparc64-specific header, adding "queued locks" ifdefs,
which makes no sense if for SPARC64 the queued locks will always be
enabled.
