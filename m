From: David Miller <davem@davemloft.net>
Date: Mon, 27 Feb 2012 21:30:44 +0000
Subject: Re: OF-related boot crash in 3.3.0-rc3-00188-g3ec1e88
Message-Id: <20120227.163044.2168482307021109001.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1202271914310.15067@math.ut.ee>
	<20120227194341.GA1448@merkur.ravnborg.org>
	<alpine.SOC.1.00.1202272316280.15067@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1202272316280.15067@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: sam@ravnborg.org, tj@kernel.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Mon, 27 Feb 2012 23:25:11 +0200 (EET)

>> Could you try to give this a quick spin and see if something
>> turns up. I you have time it would be good to try on a box
>> that worked before and one that was fixed by the patch from Tejun.
> 
> Neither of the machines - already working one and "fixed with the 
> rounding patch" one emit any prot: messages.

I think the issue is that OF writes past the end of the buffer even
though the length it reports is smaller than what it writes.

That's why we really need to fill the memblock memory with magic
numbers and scan every allocation for free memory with corrupted
magic values.
