From: Meelis Roos <mroos@linux.ee>
Date: Fri, 18 Nov 2005 08:45:44 +0000
Subject: Re: Still some serial console corruption on sunsab
Message-Id: <Pine.SOC.4.61.0511181044060.5308@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0510121223230.29862@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0510121223230.29862@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Additional data point: Debian package linux-image-2.6.14-2-sparc64 
2.6.14-3 corrupts more than standard kernel - there are several strings 
corrupted.

Hmm, it might be because of CONFIG_PROM_CONSOLE=y.

-- 
Meelis Roos (mroos@linux.ee)
