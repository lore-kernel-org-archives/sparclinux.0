From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Thu, 07 Jan 2016 20:14:45 +0000
Subject: Re: Recent spontaneous reboots on multiple machines
Message-Id: <20160107201445.GF23579@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1601061716510.27880@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1601061716510.27880@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On (01/07/16 21:46), Meelis Roos wrote:
> So far I have made sure that 4.2.0 works fine on V240 overnight with the 
> following command to find any other errors too.
> while true; do make clean; make -j2 || break; done

let me restart a loop with your .config on my v440 and let this run
overnight, to see if I can reproduce your case.

--Sowmini
