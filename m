From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Sat, 27 Sep 2014 21:19:58 +0000
Subject: Re: [PATCH] sparc64: Add vio_set_intr() to enable/disable Rx interrupts
Message-Id: <20140927211958.GB13270@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20140923153744.GB11042@oracle.com>
In-Reply-To: <20140923153744.GB11042@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> On 09/23/2014 09:37 AM, Sowmini Varadhan wrote:
> >
> >The vio_set_intr() API should be used by VIO consumers to enable/disable
> >Rx interrupts to facilitate deferred processing in softirq/bottom-half
> >context.

Hello,

what was the feedback on this patch?  

Some context for these new functions: I wanted to add these functions
so that they could later be used by other enhancements in sunvnet that
would be targetted at netdev.  I wasn't sure how inter-dependant changes
to separate repos/lists are orchestrated so I figured it would be safer
to get these basic functions sorted out first. 

--Sowmini

