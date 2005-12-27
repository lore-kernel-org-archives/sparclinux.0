From: Meelis Roos <mroos@linux.ee>
Date: Tue, 27 Dec 2005 13:59:36 +0000
Subject: Re: 2.6.15-rc7+git: sparc64 compile failure in cdc_subset
Message-Id: <Pine.SOC.4.61.0512271558350.7835@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0512261156590.10687@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0512261156590.10687@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> How reproducable is this and what build options are you using?
> If you type make again, does it complete successfully on the
> second try?  That can mean some kind of corruption.

It was reproducible when I reported, tried make 2 times.

But today I did cg-update, make clean, make && make image and the error 
is gone. Go figure.

-- 
Meelis Roos (mroos@linux.ee)
