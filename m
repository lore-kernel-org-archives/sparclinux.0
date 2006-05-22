From: Meelis Roos <mroos@linux.ee>
Date: Mon, 22 May 2006 22:15:48 +0000
Subject: Re: 2.6.17-rc3+git seems to corrupt dpkg databases
Message-Id: <Pine.SOC.4.61.0605230114340.743@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0605151108040.27015@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0605151108040.27015@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Some further testing has narrowed it down to
> 2.6.17-rc1-g676165a8 probably OK (debian apt-get upgrade succeeded)
> 2.6.17-rc2 bad (first package broke dpkg status file)

2.6.17-rc1-gc19f7a9e from Apr 17 seems also OK,
2.6.17-rc2 from Apr 19 is bad.

Enough testing for today.

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
