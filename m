From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 08 Jan 2016 17:20:22 +0000
Subject: Re: Recent spontaneous reboots on multiple machines
Message-Id: <20160108172022.GA3398@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1601061716510.27880@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1601061716510.27880@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On (01/07/16 15:14), Sowmini Varadhan wrote:
> 
> On (01/07/16 21:46), Meelis Roos wrote:
> > So far I have made sure that 4.2.0 works fine on V240 overnight with the 
> > following command to find any other errors too.
> > while true; do make clean; make -j2 || break; done
> 
> let me restart a loop with your .config on my v440 and let this run
> overnight, to see if I can reproduce your case.

Hmm. I've rebooted my v440 with a kernel built with your .config,
I've been able to do the above make loop for several hours now. 

perhaps it is some service/module that you have enabled/loaded
that I dont? Would you like to compare output of lsmod and/or 
chkconfig and/or service--status-all? (let me know which one).

Other thing is, there is nothing in the console/logs to 
give a hint why it rebooted?

--Sowmini

