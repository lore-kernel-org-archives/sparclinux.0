From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Wed, 08 Feb 2017 16:34:51 +0000
Subject: Re: [PATCH v2 net-next 6/9] sunvnet: straighten up message event handling logic
Message-Id: <20170208163451.GF30741@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1486505582-76823-1-git-send-email-shannon.nelson@oracle.com>
 <1486505582-76823-7-git-send-email-shannon.nelson@oracle.com>
 <20170208155947.GE30741@oracle.com>
 <792566dd-8f05-ed1b-50ad-d40f958aa2c7@oracle.com>
In-Reply-To: <792566dd-8f05-ed1b-50ad-d40f958aa2c7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Shannon Nelson <shannon.nelson@oracle.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On (02/08/17 08:28), Shannon Nelson wrote:
> The existing code does this as well - if it first finds a RESET, it handles
> it then hits the return 0.  Next if it finds the UP, it does the goto back
> to the ldc_ctrl: to process, and hits the same return 0.  Only if neither of
> these bits have been seen does the code move on to process the DATA_READY
> event.
> 
> If we're seeing cases of both UP and DATA_READY, then yes we'll wnat to look
> at changing this logic.  I think that should be a separate patch.
> 

Ok. probably we just make one redundant loop out and back into the function.

Other than that, the patchset looks good to me.

--Sowmini

