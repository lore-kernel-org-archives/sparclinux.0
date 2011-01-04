From: David Miller <davem@davemloft.net>
Date: Tue, 04 Jan 2011 17:50:24 +0000
Subject: Re: [RFC 1/8] sparc: prom: Sanitize return value from
Message-Id: <20110104.095024.112587676.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4CF9BBC6.3080809@julian.is-a-geek.org>
In-Reply-To: <4CF9BBC6.3080809@julian.is-a-geek.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 04 Jan 2011 15:42:45 +0100

> David Miller wrote:
> 
>>From: Julian Calaby <jcalaby@julian.is-a-geek.org>
>>Date: Sat, 04 Dec 2010 14:55:50 +1100
>>
>>  
>>>Signed-off-by: Julian Calaby <julian.calaby@gmail.com>
>>>    
>>
>>Applied.
>>  
> 
> I think this patch breaks the backwards compatability...

Backwards compatability for who?  There is one and only one caller
of this function, and it is marked static and not exported to any
other piece of code in the tree.

