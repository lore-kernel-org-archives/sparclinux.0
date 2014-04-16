From: David Miller <davem@davemloft.net>
Date: Wed, 16 Apr 2014 18:58:22 +0000
Subject: Re: sparc64 WARNING: at mm/mmap.c:2757 exit_mmap+0x13c/0x160()
Message-Id: <20140416.145822.1317931249717152474.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20131022174612.GC24448@blackmetal.musicnaut.iki.fi>
	<20131022.135442.1072093301788210177.davem@davemloft.net>
	<20140414184353.GA5630@drone.musicnaut.iki.fi>
In-Reply-To: <20140414184353.GA5630@drone.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: aaro.koskinen@iki.fi
Cc: mroos@linux.ee, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, hughd@google.com

From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 14 Apr 2014 21:43:53 +0300

> Just for the archives, I got one of these again with 3.14:

Meelis and Aaro, thanks again for all of your reports.

After pouring over a lot of the data and auditing some code I'm
suspecting it's a problem with transparent huge pages.

One thing you two can do to help me further confirm this is to run
with THP disabled for a while and see if you still get the log
messages.

Simply, as root:

bash# echo "never" >/sys/kernel/mm/transparent_hugepage/enabled

And then do your gcc bootstraps or whatever else seems to usually
run when you trigger this problem.

Thanks!
