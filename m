From: Meelis Roos <mroos@linux.ee>
Date: Fri, 28 May 2004 11:08:55 +0000
Subject: Re: 2.6.6: compile error with spinlock debugging
Message-Id: <Pine.GSO.4.44.0405281407100.12976-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0405121404550.3243-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0405121404550.3243-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Oh yes, have to export the thing to modules too of course :-)

To confirm: this patch works fine. Thanks.

SO I can now turn on most kernel debugging options to help debug my hme
SMP problem, excapt stack overflow debugging (hangs very early on boot).
Not that they have helped anything yet.

-- 
Meelis Roos (mroos@linux.ee)

