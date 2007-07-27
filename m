From: David Miller <davem@davemloft.net>
Date: Fri, 27 Jul 2007 21:36:23 +0000
Subject: Re: autoloading snd_sun_cs4231?
Message-Id: <20070727.143623.13769353.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0705171123520.18408@math>
In-Reply-To: <Pine.SOC.4.64.0705171123520.18408@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Fri, 27 Jul 2007 19:06:50 +0300 (EEST)

> Does the same method provide sbus autoloading? sbus module autoloading 
> seems to be broken currently - neither my owrn nor Debian 2.6.22-1 
> kernels do sbus autoloading and so Debian's initrd does not even load 
> sun_esp and fails to boot. It used to function somehow before (not 
> of_device autoloading) - I do not know how it worked for initrd, but it 
> seemed to use discover for the rest of the modules. discover too has 
> stopped finding sbus modules :(

The mechanism it uses is incredibly simple, it's nothing
more than a shell script that runs "/usr/sbin/prtconv -pv"
and greps for node names, and based upon those node names
it loads the appropriate module.

Perhaps you're not turning on the openprom driver that
prtconf needs to operate.
