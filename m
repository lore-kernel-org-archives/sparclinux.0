From: Meelis Roos <mroos@linux.ee>
Date: Fri, 16 Dec 2005 13:16:38 +0000
Subject: Re: 2.6.15.rc5+git fails to boot on Ultra 5
Message-Id: <Pine.SOC.4.61.0512161515030.5734@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0512141730370.26778@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0512141730370.26778@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I reverted locally applied IRQ stack patch and compiled todays git and 
it boots fine.

Maybe something was botched in my tree, or maybe irqstacks do not wor 
with current git snapshot.

-- 
Meelis Roos (mroos@linux.ee)
