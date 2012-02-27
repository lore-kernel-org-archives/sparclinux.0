From: Meelis Roos <mroos@linux.ee>
Date: Mon, 27 Feb 2012 21:25:11 +0000
Subject: Re: OF-related boot crash in 3.3.0-rc3-00188-g3ec1e88
Message-Id: <alpine.SOC.1.00.1202272316280.15067@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1202201109260.467@math.ut.ee> <20120220170603.GC7836@mtj.dyndns.org> <alpine.SOC.1.00.1202210030530.11350@math.ut.ee> <20120221010537.GA15898@dhcp-172-17-108-109.mtv.corp.google.com> <alpine.SOC.1.00.1202220213180.4171@math.ut.ee>
 <20120222174825.GA32694@google.com> <alpine.SOC.1.00.1202222025120.20496@math.ut.ee> <20120223185503.GI22536@google.com> <alpine.SOC.1.00.1202241120300.1227@math.ut.ee> <alpine.SOC.1.00.1202271914310.15067@math.ut.ee>
 <20120227194341.GA1448@merkur.ravnborg.org>
In-Reply-To: <20120227194341.GA1448@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Tejun Heo <tj@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, sparclinux@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>

> Could you try to give this a quick spin and see if something
> turns up. I you have time it would be good to try on a box
> that worked before and one that was fixed by the patch from Tejun.

Neither of the machines - already working one and "fixed with the 
rounding patch" one emit any prot: messages.

-- 
Meelis Roos (mroos@linux.ee)
