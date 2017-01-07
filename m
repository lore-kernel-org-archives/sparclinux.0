From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Sat, 07 Jan 2017 13:30:36 +0000
Subject: Re: console noise after commit c1e9b3b0eea
Message-Id: <20170107133036.GC10956@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20160419223325.GA15852@oracle.com>
In-Reply-To: <20160419223325.GA15852@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On (01/07/17 15:51), Anatoly Pugachev wrote:
> Sowmini ,
> 
> what is your linux sysctl value for kernel.printk ?
> 
> mine is :
> kernel.printk = 7       4       1       7

I also have that:
# cat /proc/sys/kernel/printk
7       4       1       7

But that's not the point- I have different levels of printks
at various times to help me debug things at verious levels,
(as our customers do) and this noise is a hindrance.
We should really be getting to the bottom of this, and 
solving the real issue here.

I think Shannon has made some good pregress with this, he 
should be sharing it on the list soon.

(suppressing the printk is like asking me to remove the
batteries from my fire-alarm- that's not the answer)

--Sowmini


