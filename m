From: David Miller <davem@davemloft.net>
Date: Wed, 16 Apr 2014 22:49:22 +0000
Subject: Re: sparc64 WARNING: at mm/mmap.c:2757 exit_mmap+0x13c/0x160()
Message-Id: <20140416.184922.850531879281945129.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140414184353.GA5630@drone.musicnaut.iki.fi>
	<20140416.145822.1317931249717152474.davem@davemloft.net>
	<alpine.SOC.1.00.1404170119550.20193@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1404170119550.20193@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: aaro.koskinen@iki.fi, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, hughd@google.com

From: mroos@linux.ee
Date: Thu, 17 Apr 2014 01:22:17 +0300 (EEST)

>> > Just for the archives, I got one of these again with 3.14:
>> 
>> Meelis and Aaro, thanks again for all of your reports.
>> 
>> After pouring over a lot of the data and auditing some code I'm
>> suspecting it's a problem with transparent huge pages.
>> 
>> One thing you two can do to help me further confirm this is to run
>> with THP disabled for a while and see if you still get the log
>> messages.
> 
> I have snice turned off CONFIG_TRANSPARENT_HUGEPAGE on 3 of 4 servers 
> that had this problem (actually most of my sparc64 machines) and the 4th 
> has
 ...
> and also has not had this problem since then. All 4 machines have been 
> running through most -rc's of every kernel.

Thanks this is a very useful datapoint.
