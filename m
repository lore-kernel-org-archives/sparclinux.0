From: David Miller <davem@davemloft.net>
Date: Wed, 13 Nov 2013 20:26:30 +0000
Subject: Re: [PATCH v3 9/9] sparc64: Encode huge PMDs using PTE encoding.
Message-Id: <20131113.152630.506086473688877632.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20131113.021856.1528152135184652144.davem@davemloft.net>
In-Reply-To: <20131113.021856.1528152135184652144.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 13 Nov 2013 15:25:36 -0500 (EST)

> From: Bob Picco <bpicco@meloft.net>
> Date: Wed, 13 Nov 2013 09:42:47 -0500
> 
>>>  		addr &= HPAGE_MASK;
>>> -		if (pmd_val(orig) & PMD_ISHUGE) {
>> 						^^
>> 					The left curly bracket was dropped.
> 
> I can't believe it, but it compiles with the brace both present, and removed.
> I don't know how this is possible.

Nevermind, my config lacked TRANSPARENT_HUGEPAGE, ignore me :-)
