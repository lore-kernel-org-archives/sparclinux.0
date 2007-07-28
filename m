From: Meelis Roos <mroos@linux.ee>
Date: Sat, 28 Jul 2007 07:58:53 +0000
Subject: Re: autoloading snd_sun_cs4231?
Message-Id: <Pine.SOC.4.64.0707281056380.11637@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0705171123520.18408@math>
In-Reply-To: <Pine.SOC.4.64.0705171123520.18408@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> The mechanism it uses is incredibly simple, it's nothing
> more than a shell script that runs "/usr/sbin/prtconv -pv"
> and greps for node names, and based upon those node names
> it loads the appropriate module.
> 
> Perhaps you're not turning on the openprom driver that
> prtconf needs to operate.

On the machine in question, prtconf -pv works and displays a long list.
However, sbus modules sunlance, qlogicpti, parport_sunbpp were not 
autoloaded and previously I have had problems with sunhme too (I have it 
in /etc/modules now).

-- 
Meelis Roos (mroos@linux.ee)
