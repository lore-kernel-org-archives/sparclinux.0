From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 12 Jan 2017 20:25:33 +0000
Subject: Re: [PATCH] tcp: fix tcp_fastopen unaligned access complaints on sparc
Message-Id: <1484252733.13165.1.camel@edumazet-glaptop3.roam.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1484251157-245538-1-git-send-email-shannon.nelson@oracle.com>
         <1484252011.13165.0.camel@edumazet-glaptop3.roam.corp.google.com>
         <cd152a9f-4855-a552-2b45-bd619436a628@oracle.com>
In-Reply-To: <cd152a9f-4855-a552-2b45-bd619436a628@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Gardner <rob.gardner@oracle.com>
Cc: Shannon Nelson <shannon.nelson@oracle.com>, netdev@vger.kernel.org, davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2017-01-12 at 13:15 -0700, Rob Gardner wrote:

> 
> I suspect that someplace, somebody is casting val to an int * or 
> something like that.

Then that would be the bug. Can we root cause this please ?


