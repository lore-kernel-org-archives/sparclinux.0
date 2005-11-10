From: Meelis Roos <mroos@linux.ee>
Date: Thu, 10 Nov 2005 21:08:35 +0000
Subject: Re: Still some serial console corruption on sunsab
Message-Id: <Pine.SOC.4.61.0511102305280.26442@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0510121223230.29862@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0510121223230.29862@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> So at least it's not a 2.4.x --> 2.6.x regression :-)

One thing I have noticed that may or may not be known is that it looks 
like it's changing between "online" and "offline" mode as seen from 
remote minicom when the garbage happens. It's normally offline during 
work and when I start reboot, it switches online and garbles first 
line or two.

There seem to be only a couple of terminal setting touchings in init but 
they tell nothing to me.

-- 
Meelis Roos (mroos@linux.ee)
