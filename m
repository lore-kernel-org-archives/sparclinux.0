From: Bernd Zeimetz <bernd@bzed.de>
Date: Thu, 13 Dec 2007 20:54:42 +0000
Subject: Re: Fix for sparc64 cpu hangs.
Message-Id: <47619C12.6030806@bzed.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20071106.203433.144763156.davem@davemloft.net>
In-Reply-To: <20071106.203433.144763156.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


> Thanks for testing, let me know if any more issues trigger.


The machine had some random processes (ssh, ping and aptitude) being
stuck today, but they went away after hitting them with kill -9. They
also didn't eat CPU time - they were just doing nothing.
Unfortunately I didn't have the time for a closer look, I'll try to
gather some more informations the next time it happens.



-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>
