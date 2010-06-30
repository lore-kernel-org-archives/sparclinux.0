From: Meelis Roos <mroos@linux.ee>
Date: Wed, 30 Jun 2010 09:13:47 +0000
Subject: Re: bootcup crash in prom tree building with specific PCI card
Message-Id: <alpine.SOC.1.00.1006301211180.11844@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1006071233090.4132@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1006071233090.4132@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> What devices sit underneath "Grappler_906F@2"?  Provide ".properties"
> output for those please.

There are no devices underneath it.

> Frankly, I'm surprised the machine even powers on to the firmware
> prompt with these MAC cards in the PCI slots :-)

Well, I have occasionally tried quite some of them and it has always 
been the same - OF sees the name but of course does not run the code, 
but never have I see OF crash on them.

-- 
Meelis Roos (mroos@linux.ee)
