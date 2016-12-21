From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 21 Dec 2016 18:17:51 +0000
Subject: Re: [RFC PATCH 04/14] sparc64: load shared id into context register 1
Message-Id: <20161221181751.GE3311@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1481913337-9331-1-git-send-email-mike.kravetz@oracle.com>
 <1481913337-9331-5-git-send-email-mike.kravetz@oracle.com>
 <20161217.221442.430708127662119954.davem@davemloft.net>
 <62091365-2797-ed99-847f-7281f4666633@oracle.com>
In-Reply-To: <62091365-2797-ed99-847f-7281f4666633@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, bob.picco@oracle.com, nitin.m.gupta@oracle.com, vijay.ac.kumar@oracle.com, julian.calaby@gmail.com, adam.buchbinder@gmail.com, kirill.shutemov@linux.intel.com, mhocko@suse.com, akpm@linux-foundation.org

Hi Mike.

> Or, perhaps we only enable
> the shared context ID feature on processors which have the ability to work
> around the backwards compatibility feature.

Start out like this, and then see if it is really needed with the older processors.
This should keep the code logic simpler - which is always good for this complicated stuff.

	Sam
