From: Meelis Roos <mroos@linux.ee>
Date: Fri, 29 Nov 2013 07:31:52 +0000
Subject: Re: RED state exception (trap type 0x64) on U5 reboot
Message-Id: <alpine.SOC.1.00.1311290930450.2368@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > > > First I compared the configurations of working and nonworking machines
> > > > (there were 2 different machines from the same era with problem), then
> > > > did some conf bisecting and found that CONFIG_SUN_OPENPROMFS causes the
> > > > RED problem in 3.12-rc5 when compiled modular and module loaded. It did
> > > > not happen when it was compiled statically, or modular but module was
> > > > not loaded. Reduced minimalistic configuration that causes this on Ultra
> > > > 5 is attached to this mail.
> 
> Is the problem unique to these 2 machines given this configuration, or is
> the problem reproduceable on other machines using this configuration?

Tried it on Sun E3500 with the same minimal config modified to boot 
there (scsi + console differences), did not trigger. I did get some 
other warning with all the lockdep config enabled, will investigate them 
separately.

-- 
Meelis Roos (mroos@linux.ee)
