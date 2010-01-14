From: David Miller <davem@davemloft.net>
Date: Thu, 14 Jan 2010 10:01:00 +0000
Subject: Re: [patch 1/1] sparc: convert to arch_gettimeoffset()
Message-Id: <20100114.020100.257423911.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200912220028.nBM0S5uX005437@imap1.linux-foundation.org>
In-Reply-To: <200912220028.nBM0S5uX005437@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: john stultz <johnstul@us.ibm.com>
Date: Tue, 12 Jan 2010 18:00:57 -0800

> On Tue, 2010-01-12 at 00:42 -0800, David Miller wrote:
>> From: akpm@linux-foundation.org
>> Date: Mon, 21 Dec 2009 16:28:05 -0800
>> 
>> > +extern u32 (*do_arch_gettimeoffset)(void);
>> > +
>> 
>> Please put this declaration into a header file that both
>> pcic.c and time_32.c can include, rather than pcic.c
>> 
>> Otherwise sparse will complain, time_32.c's definition
>> can get out of sync, etc.
> 
> 
> Would this do it? 

Yes, but you need to fully respin your original patch,
incorporating this change.

Thanks.
